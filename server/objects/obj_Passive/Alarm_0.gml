/// @description Insert description here
// You can write your code in this editor
//eventually should have stuff for modifying object properties too
if (target_socket != -1)
{
	with obj_Server
	{
		network_modify_player_property(other.target_socket, other.target_variable, other.target_variable_type, other.target_value)
	}
}