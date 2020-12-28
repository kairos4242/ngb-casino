/// @description Insert description here
// You can write your code in this editor

//acquire potential targets
var targets = ds_list_create()
target_count = collision_circle_list(x, y, range, obj_Player, false, true, targets, true)
if target_count > 0
{
	i = 0
	//while (ds_list_find_value()
	//from here iterate through list and designate target as the first non-controller object found
}