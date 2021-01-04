/// @description Insert description here
// You can write your code in this editor

spell_immolate(obj_Pillar, target);

network.destroy_object(obj_Immolate);

image_xscale += 0.008
image_yscale += 0.008

x = owner.x
y = owner.y

with obj_Server
{
	network_modify_property(other.network_id, "image_xscale", "f32", other.image_xscale)
	network_modify_property(other.network_id, "image_yscale", "f32", other.image_yscale)
	network_modify_property(other.network_id, "x", "u16", other.x)
	network_modify_property(other.network_id, "y", "u16", other.y)
}

collision_list = ds_list_create()
num_collisions = collision_circle_list(x, y, 32 * image_xscale, obj_Player, true, false, collision_list, false)
for (i = 0; i < num_collisions; i++)
{
	//for each player we are colliding with, damage them
	var current_player = ds_list_find_value(collision_list, i)
	if (current_player != owner)
	{
		current_player.hp -= 30
		with obj_Server
		{
			network_modify_player_property(current_player.socket, "hp", "u16", current_player.hp)
		}
		spell_knockback(owner, [current_player.x, current_player.y])
	}
}


life_step++
if (life_step == max_life_step)
{
	with obj_Server
	{
		network_destroy_object(other.network_id)
	}
	instance_destroy()
}

