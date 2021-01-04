/// @description Insert description here
// You can write your code in this editor
if mouse_check_button_pressed(mb_left)
{
	if point_in_rectangle(window_mouse_get_x(), window_mouse_get_y(), x, y, x + x_width, y + y_height)
	{
		//clicked on textbox
		selected = true
		keyboard_string = ""
	}
	else
	{
		selected = false
	}
}
if keyboard_check(vk_anykey)// and (selected = true)
{
	text_string = keyboard_string
}