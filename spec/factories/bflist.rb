# frozen_string_literal: true

FactoryBot.define do
  factory :bflist_team, class: Hash do
    tickets { 800 }

    initialize_with { attributes.stringify_keys }
  end

  factory :bflist_player, class: Hash do
    name { 'GuiksOfficial' }
    team { '0' }
    squad { 0 }
    squadLabel { 'No squad' }
    kills { 0 }
    deaths { 0 }
    score { 0 }
    rank { 10 }
    rankLabel { 'Lance Corporal V' }
    ping { -1 }
    type { 0 }
    typeLabel { 'Player' }

    initialize_with { attributes.stringify_keys }
  end

  factory :bflist_server, class: Hash do
    guid { '6cb7a1df-40f5-41b7-bf59-8219fbe868e4' }
    ip { '94.250.199.75' }
    port { 25_200 }
    name { '[LFT] x [ATS] Serveur Les Francs-Tireurs' }
    numPlayers { 9 }
    maxPlayers { 32 }
    map { 'XP4_Arctic' }
    mapLabel { 'Operation Whiteout' }
    gameType { 'RushLarge' }
    roundsPlayed { 1 }
    roundsTotal { 2 }
    targetScore { 0 }
    password { false }
    ranked { true }
    punkbuster { true }
    punkbusterVersion { 'v1.905 | A1390 C2.351' }
    joinQueue { true }
    uptime { 557_547 }
    roundTime { 875 }
    region { 'EU' }
    version { '179665' }
    quickmatch { false }
    country { 'FR' }
    pingSite { 'ams' }
    teams { build_list :bflist_team, 2 }
    players { build_list :bflist_player, 4 }
    _completeInfo { true }

    initialize_with { attributes.stringify_keys }
  end
end
