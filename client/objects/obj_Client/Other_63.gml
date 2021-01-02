/// @description Insert description here
// You can write your code in this editor
address = ds_map_find_value(async_load, "result")
client = network_create_socket(network_socket_tcp)
network_connect(client, address, 25566)

client_buffer = buffer_create(1024, buffer_fixed, 1)

socket_to_instanceid = ds_map_create();
network_id_to_instanceid = ds_map_create()