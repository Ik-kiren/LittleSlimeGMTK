/// @description Insérez la description ici
// Vous pouvez écrire votre code dans cet éditeur
if (sprite_index == spriteEatRight || sprite_index == spriteEatLeft || sprite_index == spriteEatUp || sprite_index == spriteEatDown){
	animationPlaying = false;
	sprite_index = spriteIdle;
	image_xscale += 0.1;
	image_yscale += 0.1;
}