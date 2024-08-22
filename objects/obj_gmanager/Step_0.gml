/// @description Insérez la description ici
// Vous pouvez écrire votre code dans cet éditeur
resizeGame();

if (keyboard_check_released(ord("T")))
	camera_set_view_size(view_camera[0], room_width, room_height);
	
if (global.pause)
	return;


if(obj_player.step == STEP.BIG){
	global.pause = true;
	instance_create_layer(camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]) / 2, camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]) / 2, "UI_instances", obj_ui_won);
}