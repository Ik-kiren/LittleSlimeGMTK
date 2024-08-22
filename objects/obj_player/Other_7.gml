/// @description Insérez la description ici
// Vous pouvez écrire votre code dans cet éditeur
if (sprite_index == spr_slime_eat_right || sprite_index == spr_slime_eat_left || sprite_index == spr_slime_eat_up || sprite_index == spr_slime_eat_down){
	animationPlaying = false;
	sprite_index = spr_slime_idle;
	if (step == STEP.SMALL){
		image_xscale += 0.3;
		image_yscale += 0.3;
	}
	else {
		image_xscale += 0.5;
		image_yscale += 0.5;
	}
}