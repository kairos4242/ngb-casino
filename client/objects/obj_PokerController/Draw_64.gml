/// @description Insert description here
// You can write your code in this editor

//draw box for current pot
var window_width = window_get_width()
var window_height = window_get_height()
draw_set_halign(fa_center)
draw_set_colour(c_black)
draw_set_alpha(0.5)
draw_rectangle(window_width / 4, window_height - 100, 3 * window_width / 4, window_height, false)
draw_set_alpha(1)
draw_set_color(c_white)
draw_text(window_width, window_height - 50, "Pot: " + string(pot))