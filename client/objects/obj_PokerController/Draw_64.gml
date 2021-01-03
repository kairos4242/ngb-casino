/// @description Insert description here
// You can write your code in this editor

//draw box for current pot
var window_width = window_get_width()
var window_height = window_get_height()
draw_set_halign(fa_center)
draw_set_colour(c_black)
draw_set_alpha(0.5)

//draw rectangles

var bet_buttons_left_edge = 3 * window_width / 4
draw_rectangle(window_width / 4, window_height - 100, 3 * window_width / 4, window_height, false)
draw_set_color(c_honeydew)
draw_rectangle(bet_buttons_left_edge, window_height - 100, window_width, window_height, false)

//draw info text
draw_set_alpha(1)
draw_set_color(c_white)
draw_set_font(fnt_Anonymous_24)
draw_text(window_width / 2, window_height - 75, "Pot: " + string(obj_Player.pot))
draw_text(window_width / 2, window_height - 50, "Current Bet: " + string(obj_Player.current_max_bet))
draw_text(window_width / 2, window_height - 25, "My Bet: " + string(obj_Player.round_bet))

//draw button text
draw_text(window_width - 50, window_height - 75, "Call")
draw_text(window_width - 150, window_height - 75, "Bet Pot")
draw_text(window_width - 250, window_height - 75, "Bet 1/2 Pot")