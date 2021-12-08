# frozen_string_literal: true

# The main application ORM connection
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
