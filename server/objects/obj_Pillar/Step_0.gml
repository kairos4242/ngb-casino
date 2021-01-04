/// @description Insert description here
// You can write your code in this editor
//alarm[1] = 100;

collision_list = ds_list_create();
num_collisions = collision_circle_list(x, y, 32 * image_xscale, obj_Player, true, false, collision_list, false)

for (i = 0; i < num_collisions; i++)
{
	//for each player we are colliding with, damage them
	var current_player = ds_list_find_value(collision_list, i)
	if (current_player == owner)
	{
		current_player.hp -= 30
		with obj_Server
		{
			network_modify_player_property(current_player.socket, "hp", "u16", current_player.hp)
		}
	}
}