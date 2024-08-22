/// @description Insérez la description ici
// Vous pouvez écrire votre code dans cet éditeur
global.pause = true;

window = instance_create_layer(camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]) / 2, camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]) / 2, "UI_instances", obj_ui_keyboard)

randomise();

keyUp = "W";
keyDown = "S";
keyLeft = "A";
keyRight = "D";

bw = browser_width;
bh = browser_height;
resizeGame = function(){
	bw = browser_width;
	bh = browser_height;
	surface_resize(application_surface, bw, bh);
	window_set_size(bw, bh);
	window_center();
}
