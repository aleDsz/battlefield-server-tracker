# frozen_string_literal: true

# The main job to schedule jobs to search servers
# from given game and given page
class ScheduleGameServerSearchJob < ApplicationJob
  ENQUEUE_DELAY = 30.minutes

  queue_as :default

  def perform(scheduled_to:, first_run: false)
    @scheduled_to = scheduled_to
    return schedule_jobs if first_run

    schedule_games
  end

  private

  attr_reader :scheduled_to

  def runnable?
    datetime = DateTime.now

    actual_datetime = format_datetime(datetime)
    expected_datetime = format_datetime(scheduled_to)

    actual_datetime == expected_datetime
  end

  def next_scheduled_to
    scheduled_to + ENQUEUE_DELAY
  end

  def reschedule
    ScheduleGameServerSearchJob.perform_later(scheduled_to: scheduled_to)
  end

  def schedule_games
    return reschedule unless runnable?

    schedule_jobs
  end

  def schedule_jobs
    Game.all.each { |game| schedule_job(game) }

    ScheduleGameServerSearchJob.perform_later(scheduled_to: next_scheduled_to)
  end

  def schedule_job(game)
    SearchGameServersJob.perform_later(game, 1)
  end

  def format_datetime(datetime)
    "#{datetime.hour}:#{datetime.minute}:#{datetime.second}"
  end
end
