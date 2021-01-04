/// @description Insert description here
// You can write your code in this editor

//kill voodoo doll
with obj_Server
{
	network_destroy_object(other.network_id)
}

instance_destroy()