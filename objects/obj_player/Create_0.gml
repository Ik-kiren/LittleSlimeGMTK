/// @description Insérez la description ici
// Vous pouvez écrire votre code dans cet éditeur

enum STEP {
	SMALL,
	MEDIUM,
	BIG
}

moveSpeed = 1.2;

initalPlayerSize = sprite_get_width(spr_slime_idle) + sprite_get_height(spr_slime_idle);
currentSize = sprite_width + sprite_height;
step = STEP.SMALL;
animationPlaying = false;

eatAnimation = function(){
	image_index = 0;
	if (sprite_index == spr_slime_down)
		sprite_index = spr_slime_eat_down;
	else if (sprite_index == spr_slime_up)
		sprite_index = spr_slime_eat_up;
	else if (sprite_index == spr_slime_left)
		sprite_index = spr_slime_eat_left;
	else if (sprite_index == spr_slime_right)
		sprite_index = spr_slime_eat_right;
	else if (hspeed > 0)
		sprite_index = spr_slime_eat_right;
	else
		sprite_index = spr_slime_eat_left;
}

augmentStep = function(){
	if (initalPlayerSize * 4 <= sprite_height + sprite_width && step < STEP.BIG){
		if (step == STEP.SMALL)
			camera_set_view_size(view_camera[0], camera_get_view_width(view_camera[0]) * 1.5, camera_get_view_height(view_camera[0]) * 1.5);
		step++;
		moveSpeed += 0.2;
		initalPlayerSize = currentSize;
	}
}
