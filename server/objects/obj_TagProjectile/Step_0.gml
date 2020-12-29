/// @description Insert description here
// You can write your code in this editor

//if outside room, send off destruction packets and then destroy self
event_inherited()
if (x < 0) or (y < 0) or (x > room_width) or (y > room_height)
{
	//destroy
	with owner
	{
		//no tag active now
		tag_active = 0
	}
	with obj_Server
	{
		network_destroy_object(other.network_id)
	}
	instance_destroy()
}