/// @description Destroy Pillar after alarm/timer
// You can write your code in this editor

//destroy pillar
with obj_Server
{
	network_destroy_object(other.network_id);
}

instance_destroy();