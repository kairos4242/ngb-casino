/// @description Insert description here
// You can write your code in this editor
draw_set_color(c_black)
draw_rectangle(x, y, x + x_width, y + y_height, false)
draw_set_color(c_white)
draw_rectangle(x, y, x + x_width, y + y_height, true)
if (text_string == "")
{
	draw_text(x + x_width / 2, y + y_height / 2, default_string)
}
else
{
	draw_text(x + x_width / 2, y + y_height / 2, text_string)
}