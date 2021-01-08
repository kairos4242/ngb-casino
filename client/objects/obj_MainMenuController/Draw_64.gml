/// @description Insert description here
// You can write your code in this editor
draw_set_colour(c_white)
draw_set_halign(fa_center)
draw_set_valign(fa_middle)
draw_set_font(fnt_Anonymous_24)
var width = display_get_gui_width()
for (i = 0; i < button_count; i++)
{
	draw_text(padding + (152) + (i * increment), display_get_gui_height() / 2 - 128, buttons[i][2])
}
//draw title
draw_set_font(fnt_Anonymous_72)
draw_text(display_get_gui_width() / 2, 144, "NGB Casino")
draw_set_font(fnt_Anonymous_24)