# frozen_string_literal: true

FactoryBot.define do
  factory :game_tools_server, class: Hash do
    prefix { 'Battlefield da Depressao - LOCKER 24/7 50Hz - i3D.net' }
    playerAmount { 48 }
    maxPlayers { 64 }
    inQue { 0 }
    serverInfo { '48/64' }
    url do
      'https://eaassets-a.akamaihd.net/battlelog/battlebinary/gamedata/Bf4/37/104/Operation_Locker-db6831d7.jpg'
    end
    mode { 'Obliteration' }
    currentMap { 'Operation Locker' }
    ownerId { nil }
    region { 'SAm' }
    platform { 'pc' }
    smallMode { 'OR' }
    teams { nil }
    serverLink do
      'https://battlelog.battlefield.com/bf4/servers/show/pc/bd860787-4163-4467-9d4f-cd468a520fd5'
    end
    official { false }
    battlelogId { 'bd860787-4163-4467-9d4f-cd468a520fd5' }
    gameId { '36028797038202314' }

    initialize_with { attributes.stringify_keys }
  end

  factory :game_tools_servers, class: Hash do
    servers { build_list :game_tools_server, 1 }

    initialize_with { attributes.stringify_keys }
  end

  factory :game_tools_map_rotation, class: Hash do
    mapname { 'Operation Locker' }
    image do
      'https://eaassets-a.akamaihd.net/battlelog/battlebinary/gamedata/Bf4/37/104/Operation_Locker-db6831d7.jpg'
    end
    mode { 'Obliteration' }

    initialize_with { attributes.stringify_keys }
  end

  factory :game_tools_player, class: Hash do
    name { 'aleDsz' }
    tag { '' }
    rank { 140 }
    score { 0 }
    kills { 0 }
    deaths { 0 }
    squad { 0 }
    role { 1 }

    initialize_with { attributes.stringify_keys }
  end

  factory :game_tools_server_all_settings, class: Hash do
    vmin { 'on' }
    gmwp { '1' }
    vrtl { '100' }
    aasl { 'off' }
    vtbr { '100' }
    vrlc { '15' }
    vcmd { 'on' }
    vgmc { '175' }
    vvsd { '100' }
    vnip { '22' }
    osls { 'off' }
    vbdm { '100' }
    vprc { '0' }
    aaro { 'off' }
    vmst { '0' }
    vtkc { '5' }
    vvsa { 'on' }
    vshe { '100' }
    vprb { '180' }
    vaba { 'on' }
    vmsp { 'on' }
    vinb { 'off' }
    vfrm { 'off' }
    vmpl { '64' }
    vhit { 'on' }
    vhud { 'on' }
    vprt { '100' }
    vrsp { '4' }
    v3ca { 'on' }
    vrhe { 'on' }
    vprp { '0' }
    vkca { 'on' }
    vffi { 'off' }
    v3sp { 'on' }
    vsbb { 'on' }
    vnit { '300' }
    vicc { 'off' }
    vtkk { '3' }
    vnta { 'on' }

    initialize_with { attributes.stringify_keys }
  end

  factory :game_tools_server_settings, class: Hash do
    all { build :game_tools_server_all_settings }

    initialize_with { attributes.stringify_keys }
  end

  factory :game_tools_server_details, class: Hash do
    smallmode { '' }
    playerAmount { 52 }
    maxPlayerAmount { 64 }
    inQueue { 0 }
    prefix { 'Battlefield da Depressao - LOCKER 24/7 50Hz - i3D.net' }
    currentMap { 'Operation Locker' }
    currentMapImage do
      'https://eaassets-a.akamaihd.net/battlelog/battlebinary/gamedata/Bf4/37/104/Operation_Locker-db6831d7.jpg'
    end
    serverLink do
      'https://battlelog.battlefield.com/bf4/servers/show/pc/bd860787-4163-4467-9d4f-cd468a520fd5'
    end
    region { 'SAm' }
    country { 'BR' }
    mode { 'Conquest small' }
    gameId { '36028797038202314' }
    favorites { '18809' }
    noBotsPlayerAmount { 51 }
    settings { build :game_tools_server_settings }
    rotation { build_list :game_tools_map_rotation, 3 }
    players { build_list :game_tools_player, 51 }

    initialize_with { attributes.stringify_keys }
  end
end
