/// @description Insert description here
// You can write your code in this editor
draw_set_colour(c_white)
draw_set_halign(fa_center)
draw_set_valign(fa_middle)
draw_set_font(fnt_Anonymous_24)
for (i = 0; i < button_count; i++)
{
	draw_text(padding + 152 + (i * increment), display_get_gui_height() / 2 - (display_get_gui_height() / 6), buttons[i][2])
}
draw_text(128, display_get_gui_height() - 256, buttons[1][2])

//draw instruction text
//draw_text(display_get_gui_width() / 2, display_get_gui_height() / 2, "No settings here yet...")