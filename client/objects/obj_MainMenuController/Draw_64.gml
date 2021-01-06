/// @description Insert description here
// You can write your code in this editor
draw_set_colour(c_white)
draw_set_halign(fa_center)
draw_set_valign(fa_middle)
draw_set_font(fnt_Anonymous_24)
for (i = 0; i < button_count; i++)
{
	draw_text(padding + (152) + (i * increment), window_get_height() / 2 - 128, buttons[i][2])
}
//draw title
draw_set_font(fnt_Anonymous_72)
draw_text(window_get_width() / 2, 144, "NGB Casino")
draw_set_font(fnt_Anonymous_24)