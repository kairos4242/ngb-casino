/// @description Insert description here
// You can write your code in this editor

//if outside room, send off destruction packets and then destroy self
event_inherited()
if (x < 0) or (y < 0) or (x > room_width) or (y > room_height)
{
	//destroy
	with obj_Server
	{
		network_destroy_object(other.network_id)
	}
	instance_destroy()
}

//if colliding with wall, destroy self
if place_meeting(x, y, obj_Wall)
{
	with obj_Server
	{
		network_destroy_object(other.network_id)
	}
	instance_destroy()
}

//if colliding with player, damage said player
collision = instance_place(x, y, obj_Player)
if (collision != noone) and (collision != owner)
{
	//deal damage to said player
	deal_damage(damage, id, collision)
	
	with obj_Server
	{
		//send network message to deal damage to said player
		network_modify_player_property(other.collision.socket, "hp", "u16", other.collision.hp)
		//send network message to destroy this projectile
		network_destroy_object(other.network_id)
	}
	//destroy self now that job complete
	instance_destroy()
}
//if colliding with object, damage said object
collision = instance_place(x, y, obj_GameObject)
if (collision != noone) and (collision != owner)
{
	//deal damage to said player
	deal_damage(damage, id, collision)
	
	with obj_Server
	{
		//send network message to deal damage to said player
		network_modify_property(other.collision.network_id, "hp", "u16", other.collision.hp)
		//send network message to destroy this projectile
		network_destroy_object(other.network_id)
	}
	//destroy self now that job complete
	instance_destroy()
	exit;
}