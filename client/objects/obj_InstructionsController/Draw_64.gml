/// @description Insert description here
// You can write your code in this editor
draw_set_colour(c_white)
draw_set_halign(fa_center)
draw_set_valign(fa_middle)
draw_set_font(fnt_Anonymous_24)
for (i = 0; i < button_count; i++)
{
	draw_text(128, window_get_height() - 256, buttons[i][2])
}

//draw instruction text
draw_text(window_get_width() / 2, window_get_height() / 2, "After the server host starts the game, \nplay a round of poker, then find out who wins the \nhand by fighting with the spells you were dealt! Winner takes the pot.")