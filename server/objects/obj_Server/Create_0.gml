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



port = 25565
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