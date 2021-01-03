/// @description Insert description here
// You can write your code in this editor

//handles what the player sees and allows for the send of data if it is their turn
card_1 = -1
card_2 = -1
map = "?"
card_3 = "?"
card_4 = "?"
card_5 = "?"
my_turn = 0
abilities_sent = false
pot = 0

c_oxford_blue = make_color_rgb(15, 32, 55)
c_flame = make_color_rgb(229, 61, 0)
c_honeydew = make_color_rgb(223, 248, 235)

//create buttons
buttons[0][0] = instance_create_layer(window_get_width() - 50, window_get_height() - 50, "Instances", obj_UIButton1)
buttons[0][1] = 0//check for if button activated
buttons[1][0] = instance_create_layer(window_get_width() - 150, window_get_height() - 50, "Instances", obj_UIButton1)
buttons[1][1] = 0
buttons[2][0] = instance_create_layer(window_get_width() - 250, window_get_height() - 50, "Instances", obj_UIButton1)
buttons[2][1] = 0

with buttons[0][0]
{
	owner = other.id
	i = 0
}