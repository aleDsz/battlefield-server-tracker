# frozen_string_literal: true

# The PersistServerDetails use cases endpoint
module PersistServerDetails
  include Caze

  has_use_case :persist_for_bf4, PersistServerDetails::Battlefield4, transactional: true

  def self.transaction_handler
    ActiveRecord::Base
  end
end
