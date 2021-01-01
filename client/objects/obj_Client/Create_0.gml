/// @description Insert description here
// You can write your code in this editor

enum network {
	player_establish,
	player_connect,
	player_joined,
	player_disconnect,
	move,
	add_object,
	cast_spell,
	modify_property,
	destroy_object,
	modify_player_property,
	kill_player,
	declare_victory,
	refresh_room,
	request_objects,
	poker_bet
}

address = get_string_async("Enter the IP of the server to connect to", "10.0.1.49")
