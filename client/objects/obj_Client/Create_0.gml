/// @description Insert description here
// You can write your code in this editor

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
	declare_victory
}

address = get_string("Enter the IP of the server to connect to", "10.0.1.49")
client = network_create_socket(network_socket_tcp)
network_connect(client, address, 25565)

client_buffer = buffer_create(1024, buffer_fixed, 1)

socket_to_instanceid = ds_map_create();
network_id_to_instanceid = ds_map_create()