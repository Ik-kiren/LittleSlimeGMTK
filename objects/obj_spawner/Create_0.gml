/// @description Insérez la description ici
// Vous pouvez écrire votre code dans cet éditeur
foodTimer = 0;
enemiesTimer = 0;
spawnTime = 0.5;
enemyCount = instance_number(obj_enemy);
enemyCountTotal = 32;
foodCount = instance_number(obj_food);
foodCountTotal = 64;

spawnEntities = function(){
	var _x1 = 0;
	var _y1 = 0;
	_x1 = random_range(5, room_width - 5);
	_y1 = random_range(5, room_height - 5);
	if (foodTimer >= spawnTime && foodCount < foodCountTotal) {
		instance_create_layer(_x1, _y1, "Instances", obj_food);
		foodTimer = 0;
	}
	if (enemiesTimer >= spawnTime && enemyCount < enemyCountTotal){
		instance_create_layer(_x1, _y1, "Instances", obj_enemy);
		enemiesTimer = 0;
	}
}