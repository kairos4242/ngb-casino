/// @description Insert description here
// You can write your code in this editor

if keyboard_check_pressed(vk_right) or keyboard_check_pressed(ord("D"))
{
	//move charselect right by one and wrap
	selected_class++
	if (selected_class > array_length(classes) - 1) selected_class = 0
}
if keyboard_check_pressed(vk_left) or keyboard_check_pressed(ord("A"))
{
	//move charselect right by one and wrap
	selected_class--
	if (selected_class < 0) selected_class = array_length(classes) - 1
}

//checks for move card ability list
if keyboard_check_pressed(vk_down) or keyboard_check_pressed(ord("S"))
{
	//move cards down by one
	with obj_Card
	{
		y -= sprite_height
	}
}
if keyboard_check_pressed(vk_up) or keyboard_check_pressed(ord("W"))
{
	//move cards down by one
	with obj_Card
	{
		y += sprite_height
	}
}