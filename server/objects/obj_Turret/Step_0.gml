/// @description Insert description here
// You can write your code in this editor

//acquire potential targets if no target
if target == -1
{
	var targets = ds_list_create()
	target_count = collision_circle_list(x, y, range, obj_Player, false, true, targets, true)
	if target_count > 0
	{
		target = -1
		//while (ds_list_find_value()
		//from here iterate through list and designate target as the first non-controller object found
		for (i = 0; i < ds_list_size(targets); i++)
		{
			//if valid target, acquire target
			if (ds_list_find_value(targets, i) != owner)
			{
				target = ds_list_find_value(targets, i)
			}
				
		}
	}
}
else
{
	//make sure target hasn't gone out of range
	if (distance_to_object(target) > range)
	{
		target = -1
	}
	//check cooldown
	else if alarm[0] <= 0//catches -1 not running case as well as 0 done case
	{
		//fire at targets
		alarm[0] = 30
		turret_projectile_speed = 10
		cast_direction = point_direction(x, y, target.x, target.y)
		turret_projectile = instance_create_layer(x + lengthdir_x(sprite_width, cast_direction), y + lengthdir_y(sprite_height, cast_direction), "Instances", obj_BasicProjectile)
		with turret_projectile {
			owner = other.id//for purposes of checking hit
			network_id = new_network_id()
			image_angle = other.cast_direction
			x_speed = lengthdir_x(other.turret_projectile_speed, other.cast_direction)
			y_speed = lengthdir_y(other.turret_projectile_speed, other.cast_direction)
		}
		//send packet to all players to create a fireball object then send a packet to change fireball angle
		with obj_Server
		{
			network_create_object("obj_BasicProjectile", other.turret_projectile.network_id, other.turret_projectile.x, other.turret_projectile.y)
			network_modify_property(other.turret_projectile.network_id, "image_angle", "u16", other.cast_direction)
			network_modify_property(other.turret_projectile.network_id, "x_speed", "s16", lengthdir_x(other.turret_projectile_speed, other.cast_direction))
			network_modify_property(other.turret_projectile.network_id, "y_speed", "s16", lengthdir_y(other.turret_projectile_speed, other.cast_direction))
		}
	}
}