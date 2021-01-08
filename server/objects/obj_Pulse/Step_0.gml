/// @description Insert description here
// You can write your code in this editor

image_xscale += 0.008;
image_yscale += 0.008;


with obj_Server
{
	network_modify_property(other.network_id, "image_xscale", "f32", other.image_xscale);
	network_modify_property(other.network_id, "image_yscale", "f32", other.image_yscale);
}

ds_list_clear(collision_list);
num_collisions = collision_rectangle_list(x - sprite_width/2, y - sprite_height/2, x + sprite_width/2, y + sprite_height/2, obj_Player, false, false, collision_list, false);

for (i = 0; i < num_collisions; i++)
{
	//for each player we are colliding with, damage them
	var current_player = ds_list_find_value(collision_list, i);
	if (current_player != owner)
	{
		current_player.hp -= 5;
		
		with obj_Server
			network_modify_player_property(current_player.socket, "hp", "u16", current_player.hp);
		
	}
}