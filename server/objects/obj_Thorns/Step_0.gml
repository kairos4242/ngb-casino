/// @description Check for collisions & deal damage
// You can write your code in this editor

ds_list_clear(collision_list);

//This collision checking is lowkey pretty ghetto and shit
num_collisions = collision_rectangle_list(x - sprite_width/2 - 1, y - sprite_height/2 - 1 , x + sprite_width/2 + 1, y + sprite_height/2 + 1, obj_Player, false, false, collision_list, false);

for (i = 0; i < num_collisions; i++)
{
	//for each player we are colliding with, damage them
	var current_player = ds_list_find_value(collision_list, i);

	deal_damage(1, owner, current_player);
	
	with obj_Server
		network_modify_player_property(current_player.socket, "hp", "u16", current_player.hp);
}