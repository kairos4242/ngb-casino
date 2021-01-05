/// @description Insert description here
// You can write your code in this editor
if (owner != -1)
{
	//our socket has been modified by the server, check if it corresponds to a valid instance
	if (converted_owner == false)
	{
		//convert the owner from socket to instance
		converted_owner = true
		var socket_to_change = owner
		owner = ds_map_find_value(obj_Client.socket_to_instanceid, socket_to_change)
	}
}