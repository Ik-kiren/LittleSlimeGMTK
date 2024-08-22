/// @description Insérez la description ici
// Vous pouvez écrire votre code dans cet éditeur
if (step > STEP.SMALL) {
	animationPlaying = true;
	eatAnimation();
	instance_destroy(other);
}
augmentStep();