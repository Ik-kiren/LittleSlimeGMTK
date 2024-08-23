/// @description Insérez la description ici
// Vous pouvez écrire votre code dans cet éditeur
if (global.pause){
	vspeed = 0;
	hspeed = 0;
	return;
}

if (currentState == STATE.CHASING){
	moveSpeed = 1.2;
} else {
	moveSpeed = 1;
}

if (array_length(currentPath) > 0){
	pointToGo.x1 = currentPath[array_length(currentPath) - 1].point.x1;
	pointToGo.y1 = currentPath[array_length(currentPath) - 1].point.y1;
	array_pop(currentPath);
}
if (array_length(currentPath) == 0)
	pointToGo.getNewPoint = true;

moveToPoint(pointToGo.x1, pointToGo.y1);
//move_towards_point(pointToGo.x1, pointToGo.y1, moveSpeed);

if (x < 0 || x > room_width || y < 0 || y > room_height)
	show_debug_message(id);

currentSize = sprite_width + sprite_height;

var _enemyList = ds_list_create();
var _enemyNum = collision_rectangle_list(x - collisionWidth, y - collisionHeight, x + collisionWidth, y + collisionHeight, obj_enemy, false, true, _enemyList, true);
if (_enemyNum > 0 && currentState != STATE.FLEEING) {
	for (var _i = 0; _i < _enemyNum; _i++;){
		var _enemyColID = _enemyList[| _i];
		if (collision_line(self.x, self.y, _enemyColID.x, _enemyColID.y, obj_tree, false, true) == noone && _enemyColID.currentSize < currentSize && (_enemyColID.x > 0 && _enemyColID.y > 0) && (_enemyColID.x < room_width && _enemyColID.y < room_height) && _enemyColID.currentSize > currentSize / 3){
			objChasing = _enemyColID;
			objChasing.chaser = self;
			objChasing.currentState = STATE.FLEEING;
			currentState = STATE.CHASING;
			break;
		}
	}
}

var _list = ds_list_create();
var _num = collision_rectangle_list(x - collisionWidth, y - collisionHeight, x + collisionWidth, y + collisionHeight, obj_food, false, true, _list, true);
if (_num > 0 && currentState == STATE.IDLE){
	for (var _i = 0; _i < _num; _i++;) {
		var _foodColId = _list[| _i];
		if (collision_line(self.x, self.y, _foodColId.x, _foodColId.y, obj_tree, false, true) == noone && (_foodColId.x > 0 && _foodColId.y > 0) && (_foodColId.x < room_width && _foodColId.y < room_height) && !collision_line(self.x, self.y, _foodColId.x, _foodColId.y, obj_tree, false, true)) {
			_foodColId.isBeingPreyedOn = id;
			objChasing = _foodColId;
			currentState = STATE.FEEDING;
			break;
		}
	}
}

if (objChasing == noone && chaser == noone && currentState != STATE.FLEEING){
	currentState = STATE.IDLE;
}

if(currentState == STATE.IDLE){
	idleState();
} else if (currentState == STATE.FEEDING){
	feedingState();
} else if (currentState == STATE.CHASING) {
	chasingState();
} else if (currentState == STATE.FLEEING) {
	fleeingState();
}

ds_list_clear(_list);
ds_list_clear(_enemyList);

if (checkPointTimer >= 10){
	if (tmpPoint.x1 == self.x && tmpPoint.y1 == self.y){
		pointToGo.getNewPoint = true;
	} else {
		tmpPoint.x1 = self.x;
		tmpPoint.y1 = self.y;
	}
	checkPointTimer = 0;
}

/*if (pointToGo.x1 < 0 || pointToGo.y1 < 0 || pointToGo.x1 > room_width || pointToGo.y1 > room_height) {
	pointToGo.getNewPoint = true;
}*/