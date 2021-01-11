enum network {
	player_establish,
	player_connect,
	player_joined,
	player_disconnect,
	move,
	add_object,
	cast_spell,
	modify_property,
	destroy_object,
	modify_player_property,
	kill_player,
	declare_victory,
	refresh_room,
	request_objects,
	poker_bet
}

//randomise()//sets random seed to a truly random value

port = 25566
max_clients = 6

network_create_server(network_socket_tcp, port, max_clients)

server_buffer = buffer_create(1024, buffer_fixed, 1)
socket_list = ds_list_create()
socket_to_instanceid = ds_map_create();

player_spawn_x = 100
player_spawn_y = 100
//hardcode positions for players going into poker
poker_spawns[0][0] = 672
poker_spawns[0][1] = 352
poker_spawns[1][0] = 1056
poker_spawns[1][1] = 352
poker_spawns[2][0] = 1440
poker_spawns[2][1] = 352
poker_spawns[3][0] = 672
poker_spawns[3][1] = 736
poker_spawns[4][0] = 1056
poker_spawns[4][1] = 736
poker_spawns[5][0] = 1440
poker_spawns[5][1] = 736

pot = 0//server handles giving pot to winning player as pokercontroller is destroyed each round

//Initialize Class Array
//0 name, 1 HP, 2 base mana, 3 mana regen, 4 speed, 5 jumps
//going to try hardcoding attack into spell_basic_attack
//6 is attack type, 7 is attack speed
//8 is attack damage
classes[0][0] = "Null"
classes[0][1] = 100
classes[0][2] = 100
classes[0][3] = 5
classes[0][4] = 8
classes[0][5] = 2
classes[0][6] = "Ranged"
classes[0][7] = "Slow"
classes[0][8] = 5
classes[1][0] = "Typhoon"
classes[1][1] = 250
classes[1][2] = 100
classes[1][3] = 5
classes[1][4] = 5
classes[1][5] = 2
classes[1][6] = "Melee"
classes[1][7] = "Slow"
classes[1][8] = 5
classes[2][0] = "Akimbo"
classes[2][1] = 50
classes[2][2] = 75
classes[2][3] = 5
classes[2][4] = 10
classes[2][5] = 3
classes[2][6] = "Ranged"
classes[2][7] = "Fast"
classes[2][8] = 5
classes[3][0] = "Oracle"
classes[3][1] = 75
classes[3][2] = 150
classes[3][3] = 10
classes[3][4] = 8
classes[3][5] = 2
classes[3][6] = "Ranged"
classes[3][7] = "Slow"
classes[3][8] = 5
classes[4][0] = "Wraith"
classes[4][1] = 80
classes[4][2] = 0
classes[4][3] = 0
classes[4][4] = 10
classes[4][5] = 3
classes[4][6] = "Melee"
classes[4][7] = "Slow"
classes[4][8] = 15
classes[5][0] = "Guerilla"
classes[5][1] = 50
classes[5][2] = 60
classes[5][3] = 15
classes[5][4] = 8
classes[5][5] = 3
classes[5][6] = "Ranged"
classes[5][7] = "Slow"
classes[5][8] = 5
classes[6][0] = "Redline"
classes[6][1] = 150
classes[6][2] = 100
classes[6][3] = 5
classes[6][4] = 11
classes[6][5] = 1
classes[6][6] = "Melee"
classes[6][7] = "Slow"
classes[6][8] = 10
classes[7][0] = "Sentinel"
classes[7][1] = 150
classes[7][2] = 100
classes[7][3] = 5
classes[7][4] = 3
classes[7][5] = 6
classes[7][6] = "Ranged"
classes[7][7] = "Slow"
classes[7][8] = 5

alarm[1] = 150//2.5 seconds