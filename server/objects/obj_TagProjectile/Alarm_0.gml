/// @description Insert description here
// You can write your code in this editor


with owner
{
	tag_active = 0
}
with obj_Server
{
	network_destroy_object(other.network_id)
}
instance_destroy()