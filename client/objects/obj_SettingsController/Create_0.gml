/// @description Insert description here
// You can write your code in this editor
//create buttons
button_count = 1//only for buttons in a row horizontally
padding = 80
increment = (display_get_gui_width()  / (button_count + 1))//amount to increase x button pos by to get even distribution
for (i = 0; i < button_count; i++)
{
	buttons[i][0] = instance_create_layer((i + 1) * increment, display_get_gui_height() / 2, "Instances", obj_UIButton2)
}

buttons[button_count][0] = instance_create_layer(128, display_get_gui_height() - 128, "Instances", obj_UIButton2)
buttons[button_count][1] = 0

//manually do text
buttons[0][2] = "Toggle Fullscreen"
buttons[1][2] = "Back"


for (i = 0; i < button_count + 1; i++)
{
	with buttons[i][0]
	{
		owner = other.id
		i = other.i
	}
}