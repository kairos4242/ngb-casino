/// @description Insert description here
// You can write your code in this editor
if point_in_rectangle(window_mouse_get_x(), window_mouse_get_y(), bbox_left, bbox_top, bbox_right, bbox_bottom)
{
	mouse_on = true
}
else
{
	mouse_on = false
}
if (mouse_on)
{
	image_angle += 0.05
	if mouse_check_button(mb_left)
	{
		image_index = 1//so that always lit up when mouse on
	}
	if mouse_check_button_released(mb_left)
	{
		owner.buttons[i][1] = 1
	}
}
else
{
	//catches edge cases like pressing on button and then releasing elsewhere on screen
	image_index = 0
}