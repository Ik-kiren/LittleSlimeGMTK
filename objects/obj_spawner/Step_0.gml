/// @description Insérez la description ici
// Vous pouvez écrire votre code dans cet éditeur
if (global.pause)
	return;
foodTimer += delta_time / 100000;
enemiesTimer += delta_time / 100000;
enemyCount = instance_number(obj_enemy);
foodCount = instance_number(obj_food);
//spawnEntities();