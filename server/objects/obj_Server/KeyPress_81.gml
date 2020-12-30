/// @description Insert description here
// You can write your code in this editor

//switch between poker and regular room

if (room = rm_Poker)
{
	//go to game room
	room_goto(RoomViewTest)
}
else
{
	//go to poker room
	room_goto(rm_Poker)
	for (i = 0; i < ds_list_size(socket_list); i++)
	{
		//move each player into their poker spawn position if we are in poker
		var spawn_x = poker_spawns[i][0]
		var spawn_y = poker_spawns[i][1]
		instance_find(obj_Player, i).x = spawn_x
		instance_find(obj_Player, i).y = spawn_y
		var curr_socket = ds_list_find_value(socket_list, i)
		network_modify_player_property(curr_socket, "x", "u16", spawn_x)
		network_modify_player_property(curr_socket, "y", "u16", spawn_y)
	}
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