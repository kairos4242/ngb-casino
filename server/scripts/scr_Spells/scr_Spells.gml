// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

//Target is an array of [x, y] ao target[0] will get target xpos and target[1] will get target ypos

function spell_fireball(caster, target){
	//create server representation
	cast_direction = point_direction(caster.x, caster.y, mouse_x, mouse_y)
	var fireball = instance_create_layer(caster.x + lengthdir_x(caster.sprite_width / 2, cast_direction), caster.y + lengthdir_y(caster.sprite_height / 2, cast_direction), "Instances", obj_Fireball)
	with fireball {
		network_id = new_network_id()
		image_angle = other.cast_direction
	}
	//send packet to all players to create a fireball object
	for (i = 0; i < ds_list_size(socket_list); i++)
	{
		var curr_socket = ds_list_find_value(socket_list, i)
		buffer_seek(server_buffer, buffer_seek_start, 0);
		buffer_write(server_buffer, buffer_u8, network.move);
		buffer_write(server_buffer, buffer_u8, socket);
		buffer_write(server_buffer, buffer_u16, move_x);
		buffer_write(server_buffer, buffer_u16, move_y);
		network_send_packet(curr_socket, server_buffer, buffer_tell(server_buffer))
	}
}

function spell_refresh_jumps(caster, target){
	caster.jumps = caster.max_jumps
}

function spell_swap_places(caster, target){
	target_object = collision_point(mouse_x, mouse_y, obj_Unit, false, true)
	if target_object = noone exit
	else
	{
		var temp_x = target_object.x
		var temp_y = target_object.y
		target_object.x = caster.x
		target_object.y = caster.y
		caster.x = temp_x
		caster.y = temp_y
	}
}

function spell_wall(caster, target){
	cast_direction = point_direction(caster.x, caster.y, mouse_x, mouse_y)
	cast_direction = round(cast_direction / 90) * 90 //round to the nearest 90 degrees
	var wall = instance_create_layer(caster.x + 2 * lengthdir_x(caster.sprite_width, cast_direction), caster.y + 2 * lengthdir_y(caster.sprite_height, cast_direction), "Instances", obj_Wall)
	with wall {
		image_angle = other.cast_direction
		image_yscale = 3
	}
}

function spell_passive_jump_height_increase(caster, target){
	jump_passive = {
		passive_id: "0000",
		name: "Antigravity Passive",
		type: "Subtract",
		unique: true,
		passive_target: caster,
		passive_source: caster,
		passive_target_variable: "grav"
	}
	create_effect(jump_passive, caster, target)
}