/// @description Insérez la description ici
// Vous pouvez écrire votre code dans cet éditeur
checkPointTimer += delta_time / 10000;
if (other.sprite_width + other.sprite_height < sprite_width + sprite_height) {
	instance_destroy(other);
	objChasing = noone;
	eatAnimation();
	augmentStep();
}

