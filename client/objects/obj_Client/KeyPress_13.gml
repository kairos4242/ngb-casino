/// @description Insert description here
// You can write your code in this editor
//if we havent already grabbed the ip to connect to, send the ip to connect to
if instance_exists(buttons[0][0])
{
	address = buttons[0][0].text_string
	client = network_create_socket(network_socket_tcp)
	network_connect(client, address, 25566)

	client_buffer = buffer_create(1024, buffer_fixed, 1)

	socket_to_instanceid = ds_map_create();
	network_id_to_instanceid = ds_map_create()
	with buttons[0][0]
	{
		instance_destroy()
	}
}