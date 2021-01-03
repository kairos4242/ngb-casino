/// @description Insert description here
// You can write your code in this editor
//gotta do this here because anywhere I try in pokercontroller we are still in the old room
if room == rm_Poker exit;
for (j = 0; j < ds_list_size(socket_list); j++)
	{
		//move all xpos and ypos to room's spawn positions
		var curr_socket = ds_list_find_value(socket_list, j)
		var spawn_marker = instance_find(obj_PlayerSpawnMarker, j)
		var x_to_set = spawn_marker.x
		var y_to_set = spawn_marker.y
		network_modify_player_property(curr_socket, "x", "u16", x_to_set)
		network_modify_player_property(curr_socket, "y", "u16", y_to_set)
	}