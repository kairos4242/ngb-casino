/// @description Insert description here
// You can write your code in this editor

//reset all players to full health
for (j = 0; j < ds_list_size(socket_list); j++)
{
	//send a message to restore this player to full health
	var curr_socket = ds_list_find_value(socket_list, j)
	var curr_instance = ds_map_find_value(socket_to_instanceid, curr_socket)
	with curr_instance
	{
		hp = max_hp
		alive = true
	}
	network_modify_player_property(curr_socket, "hp", "u16", curr_instance.hp)
	network_modify_player_property(curr_socket, "alive", "u16", 1)
}

//go to poker room
room_goto(rm_Poker)
list_size = ds_list_size(socket_list)
for (j = 0; j < list_size; j++)//using j because our function on the inside uses i
{
	//move each player into their poker spawn position if we are in poker
	var spawn_x = poker_spawns[j][0]
	var spawn_y = poker_spawns[j][1]
	instance_find(obj_Player, j).x = spawn_x
	instance_find(obj_Player, j).y = spawn_y
	var curr_socket = ds_list_find_value(socket_list, j)
	network_modify_player_property(curr_socket, "x", "u16", spawn_x)
	network_modify_player_property(curr_socket, "y", "u16", spawn_y)
}

//tell all clients to refresh their room
for (i = 0; i < ds_list_size(socket_list); i++)
{
	//send packet to create object
	var curr_socket = ds_list_find_value(socket_list, i)
	buffer_seek(server_buffer, buffer_seek_start, 0);
	buffer_write(server_buffer, buffer_u8, network.refresh_room);
	network_send_packet(curr_socket, server_buffer, buffer_tell(server_buffer))
}


//create a poker controller and give a copy to all players
//NOTE we should already have a poker controller id so no need to generate a new one
//but lets check just in case
if (!variable_instance_exists(id, "poker_controller_id"))
{
	poker_controller_id = new_network_id()
}
network_create_object("obj_PokerController", poker_controller_id, 0, 0)
poker_controller = instance_create_layer(0, 0, "Instances", obj_PokerController)
with poker_controller {
	network_id = other.poker_controller_id
}