/// @description Insérez la description ici
// Vous pouvez écrire votre code dans cet éditeur

if (other.image_xscale + other.image_yscale < image_xscale + image_yscale) {
	animationPlaying = true;
	eatAnimation();
	instance_destroy(other);
} else if (other.image_xscale + other.image_yscale > image_xscale + image_yscale){
	global.pause = true;
	instance_destroy(self);
	show_debug_message("Game Over");
	instance_create_layer(camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]) / 2, camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]) / 2, "UI_instances", obj_button_retry);
}
augmentStep();