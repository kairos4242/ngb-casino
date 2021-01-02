/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();
if (x < 0) or (y < 0) or (x > room_width) or (y > room_height)
{
	//destroy
	with obj_Server
	{
		network_destroy_object(other.network_id)
	}
	instance_destroy()
	exit;
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
	exit;
}
x_speed -= x_dir
y_speed -= y_dir
if ((sign(x_speed) != sign(x_dir)) and (damage_increased == false))
{
	damage_increased = true
	damage = 10
}
image_angle -= 18
with obj_Server
{
	network_modify_property(other.network_id, "x_speed", "f32", other.x_speed)
	network_modify_property(other.network_id, "y_speed", "f32", other.y_speed)
	network_modify_property(other.network_id, "image_angle", "f32", other.image_angle)
}