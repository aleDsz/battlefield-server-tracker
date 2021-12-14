# frozen_string_literal: true

module PersistServerDetails
  # The BF4 use case to persist server details
  # :reek:UncommunicativeModuleName
  class Battlefield4
    include Caze

    export :persist, as: :persist_for_bf4

    SETTINGS_FIELD_MAPPER = {
      show_minimap: 'vmin',
      minimap_spotting: 'vmsp',
      nametags: 'vnta',
      hud: 'vhud',
      third_person_spotting: 'v3sp',
      aim_assit_slowdown: 'aasl',
      friendly_fire: 'vffi',
      kill_cam: 'vkca',
      only_squad_leader_spawn: 'osls',
      aim_assit_auto_rotation: 'aaro',
      disable_team_balancer: 'vaba',
      regenerate_health: 'vrhe',
      vehicle_third_person_camera: 'v3ca',
      reload_full_mags: 'vfrm',
      vehicle_respawn_time: 'vvsd',
      round_time_limit: 'vrtl',
      bullet_damage: 'vbdm',
      ticket_count: 'vtkc',
      team_ticket_count: 'vgmc',
      respawn_time: 'vprt',
      player_health: 'vshe',
      teammate_kills_before_kick: 'vtkc',
      ban_player_after_kicks: 'vtkk',
      kick_player_after_seconds: 'vnit'
    }.freeze

    def initialize(params)
      @body = params.fetch(:body)
      @game = params.fetch(:game)
      @server = params.fetch(:server)
      @server_details = params.fetch(:server_details)
      @server_details_settings = server_details.fetch('settings')
                                               .fetch('all')
    end

    def persist
      server_detail = ServerDetail.create!(server_details_attrs)
      ServerSetting.create!(server_settings_attrs(server_detail))
    end

    private

    attr_reader :body, :game, :server, :server_details, :server_details_settings

    def server_details_attrs # rubocop:disable Metrics/MethodLength,Metrics/AbcSize
      {
        server_id: body['guid'],
        name: body['name'],
        ip: body['ip'],
        port: body['port'],
        current_map: body['mapLabel'],
        max_players: body['maxPlayers'],
        current_players: body['numPlayers'],
        players_in_queue: server['inQue'],
        total_rounds: body['roundsTotal'],
        rounds_played: body['roundsPlayed'],
        game_type: server['mode'],
        is_ranked: body['ranked'],
        has_punkbuster: body['punkbuster'],
        is_official_server: server['official'],
        country: body['country'],
        battlelog_game_id: server['gameId'],
        favorites: server_details['favorites'],
        server_link: server['serverLink']
      }
    end

    def server_settings_attrs(server_detail)
      attrs = { server_detail_id: server_detail.id }

      SETTINGS_FIELD_MAPPER.each do |field, key|
        attrs[field] = server_details_settings[key]
      end

      attrs
    end
  end
end
