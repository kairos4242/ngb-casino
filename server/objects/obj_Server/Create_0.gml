enum network {
	player_establish,
	player_connect,
	player_joined,
	player_disconnect,
	move,
	add_object
}



port = 25565
max_clients = 6

network_create_server(network_socket_tcp, port, max_clients)

server_buffer = buffer_create(1024, buffer_fixed, 1)
socket_list = ds_list_create()
socket_to_instanceid = ds_map_create();

player_spawn_x = 100
player_spawn_y = 100