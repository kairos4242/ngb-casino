/// @description Insert description here
// You can write your code in this editor
draw_set_halign(fa_middle)
draw_set_valign(fa_center)
//draw_self()
//instead of drawing ourself, see which self to draw
if (alive)
{
	draw_sprite(spr_Slave, 0, x, y)
}
else
{
	draw_sprite(spr_DeadPlayer, 0, x, y)
}
draw_text(x, y - sprite_height, username)