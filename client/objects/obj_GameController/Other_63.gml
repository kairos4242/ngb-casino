/// @description Insert description here
// You can write your code in this editor
/*if (ds_map_find_value(async_load, "id") != username_callback)
{
	exit;
}

username_rough = ds_map_find_value(async_load, "result")
username = string_delete(username_rough, 20, string_length(username_rough) - 19)

//unfortunately I think it is necessary to have this file_exists structure twice here
//because first one needs to come before the two lines in the middle
//so we cant put it in an if/else construction
//could save in a variable but thats only marginally cleaner

if (!(file_exists("preferences.ini")))
{
	//write the username
	ini_open("preferences.ini")
	ini_write_string("user", "last_username", username)
	ini_close()
}*/