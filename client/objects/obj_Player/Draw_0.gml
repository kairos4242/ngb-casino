/// @description Insert description here
// You can write your code in this editor
draw_set_halign(fa_middle)
draw_set_valign(fa_center)
draw_self()
draw_text(x, y - sprite_height, username)
draw_text(x, y - 1.5 * sprite_height, string(hp) + " / " + string(max_hp))