/// @description Insert description here
// You can write your code in this editor
//create buttons
button_count = 4
padding = 80
increment = ((display_get_gui_width() - (2 * padding))  / button_count)//amount to increase x button pos by to get even distribution
for (i = 0; i < button_count; i++)
{
	buttons[i][0] = instance_create_layer(padding + (152) + (i * increment), display_get_gui_height() / 2, "Instances", obj_UIButton2)
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
buttons[0][2] = "Play!"
buttons[1][2] = "Instructions"
buttons[2][2] = "Settings"
buttons[3][2] = "About"

//play menu music
if !audio_is_playing(snd_MenuMusic)
{
	audio_play_sound(snd_MenuMusic, 1, 1)
}