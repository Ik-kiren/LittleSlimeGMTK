/// @description Insérez la description ici
// Vous pouvez écrire votre code dans cet éditeur
checkPointTimer += delta_time / 10000;
if (step < STEP.MEDIUM){
	if (other.x > self.x){
		self.x -= 2;
	} else {
		self.x += 2;
	}
	if (other.y > self.y){
		self.y -= 2;
	} else {
		self.y += 2;
	}
} else {
	instance_destroy(other);
}
