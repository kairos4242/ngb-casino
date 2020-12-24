// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function new_network_id(){
	//if we havent made any network IDs yet, make the first one zero
	if !variable_global_exists("network_id_count")
	{
		global.network_id_count = 0
	}
	//otherwise make the new one one more than the previous one so they will always be unique
	else
	{
		global.network_id_count++
	}
	//make sure we don't go over the size limit of a u16
	//this assumes there will never be more than 65 thousand active objects but I think
	//that is a fairly safe assumption
	if (global.network_id_count == 65536)
	{
		global.network_id_count = 0
	}
	return global.network_id_count
}