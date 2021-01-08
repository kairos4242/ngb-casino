/// @description Insert description here
// You can write your code in this editor
//create buttons
button_count = 1
//padding = 80
//increment = ((display_get_gui_width() - (2 * padding))  / button_count)//amount to increase x button pos by to get even distribution
for (i = 0; i < button_count; i++)
{
	buttons[i][0] = instance_create_layer(128, display_get_gui_height() - 128, "Instances", obj_UIButton2)
	buttons[i][1] = 0
}
for (i = 0; i < button_count; i++)
{
	with buttons[i][0]
	{
		owner = other.id
		i = other.i
	}
}

//manually do text
buttons[0][2] = "Back"