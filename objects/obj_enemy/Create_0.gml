/// @description Insérez la description ici
// Vous pouvez écrire votre code dans cet éditeur

enum STATE {
	IDLE,
	FEEDING,
	CHASING,
	FLEEING
}

moveSpeed = 1;

slimeSprite = getRandomSlimeSprite();
spriteIdle = slimeSprite[0];
spriteUp = slimeSprite[1];
spriteRight = slimeSprite[2];
spriteDown = slimeSprite[3];
spriteLeft = slimeSprite[4];
spriteEatUp = slimeSprite[5];
spriteEatRight = slimeSprite[6];
spriteEatDown = slimeSprite[7];
spriteEatLeft = slimeSprite[8];
sprite_index = spriteIdle;


currentState = STATE.IDLE;

isBeingChased = false; 
chaser = noone;

collisionWidth = 500;
collisionHeight = 500;
objChasing = noone;
pointToGo = {
	getNewPoint : true,
	x1 : x,
	y1 : y,
};

tmpPoint = {
	x1 : self.x,
	y1 : self.y
};


startNode = new Node(x, y);
targetNode = new Node(1200, 700);

currentPath = [];

animationPlaying = false;

eatAnimation = function(){
	animationPlaying = true;
	image_index = 0;
	if (sprite_index == spriteDown)
		sprite_index = spriteEatDown;
	else if (sprite_index == spriteUp)
		sprite_index = spriteEatUp;
	else if (sprite_index == spriteLeft)
		sprite_index = spriteEatLeft;
	else if (sprite_index == spriteRight)
		sprite_index = spriteEatRight;
	else
		sprite_index = spriteEatDown;
}

checkPointTimer = 0;

step = STEP.SMALL;
initialSize = sprite_get_width(spr_slime_down) + sprite_get_height(spr_slime_down);
currentSize = sprite_get_width(spr_slime_down) + sprite_get_height(spr_slime_down);

augmentStep = function(){
	if (initialSize * 4 <= sprite_height + sprite_width && step < STEP.BIG){
		step++;
		initialSize = currentSize;
	}
}


moveToPoint = function(_x, _y){
	if (pointToGo.x1 < 0 || pointToGo.y1 < 0){
		show_debug_message(string(id) + " : " + string(currentState) + " = " + string(x) + " / " + string(y) + "  :  " + string(pointToGo.x1) + " / " + string(pointToGo.y1));
		show_debug_message(string(vspeed) + " / " + string(hspeed));
	}
	if(self.y < _y){
		vspeed = moveSpeed * (delta_time / 10000);
		if (!animationPlaying)
			sprite_index = spriteDown;
	} else {
		vspeed = -moveSpeed * (delta_time / 10000);
		if (!animationPlaying)
			sprite_index = spriteUp;
	}
	if(self.x < _x){
		hspeed = moveSpeed * (delta_time / 10000);
		if (!animationPlaying)
			sprite_index = spriteRight;
	} else {
		hspeed = -moveSpeed * (delta_time / 10000);
		if (!animationPlaying)
			sprite_index = spriteDown;
	}
}

checkThreePoints = function() {
	if ((pointToGo.x1 > self.x && pointToGo.y1 > self.y) || (pointToGo.x1 < self.x && pointToGo.y1 < self.y)){
		if (collision_line(self.x + hspeed, self.y + vspeed, pointToGo.x1, pointToGo.y1, obj_tree, false, true) != noone || collision_line(self.x, self.y, pointToGo.x1 + 10, pointToGo.y1 - 10, obj_tree, false, true) != noone || collision_line(self.x, self.y, pointToGo.x1 - 10, pointToGo.y1 + 10, obj_tree, false, true) != noone)
			return true;
		//if (currentState != STATE.CHASING && collision_line(self.x, self.y, pointToGo.x1, pointToGo.y1, obj_enemy, false, true) || collision_line(self.x, self.y, pointToGo.x1 + 10, pointToGo.y1 - 10, obj_enemy, false, true) || collision_line(self.x, self.y, pointToGo.x1 - 10, pointToGo.y1 + 10, obj_enemy, false, true))
			//return true;
	} else {
		if (collision_line(self.x + hspeed, self.y + vspeed, pointToGo.x1, pointToGo.y1, obj_tree, false, true) != noone || collision_line(self.x, self.y, pointToGo.x1 + 10, pointToGo.y1 + 10, obj_tree, false, true) != noone || collision_line(self.x, self.y, pointToGo.x1 - 10, pointToGo.y1 - 10, obj_tree, false, true) != noone)
			return true;
		//if (currentState != STATE.CHASING && collision_line(self.x, self.y, pointToGo.x1, pointToGo.y1, obj_enemy, false, true) || collision_line(self.x, self.y, pointToGo.x1 + 10, pointToGo.y1 - 10, obj_enemy, false, true) || collision_line(self.x, self.y, pointToGo.x1 - 10, pointToGo.y1 + 10, obj_enemy, false, true))
			//return true;
	}
	return false;
}

idleState = function(){
	if(pointToGo.getNewPoint){
		do {
			pointToGo.x1 = irandom_range(x - 150, x + 150);
			pointToGo.y1 = irandom_range(y - 150, y + 150);
		} until ((pointToGo.x1 > 5  && pointToGo.x1 < room_width - 5) && (pointToGo.y1 > 5 && pointToGo.y1 < room_height - 5) && !place_meeting(pointToGo.x1, pointToGo.y1, obj_tree));
		startNode = new Node(round(x), round(y));
		targetNode = new Node(pointToGo.x1, pointToGo.y1);
		//show_debug_message(string(id) + " / " + string(pointToGo)+ " / " + string([round(x), round(y)]));
		currentPath = aStar();
		if (array_length(currentPath) > 0){
			pointToGo.x1 = currentPath[array_length(currentPath) - 1].point.x1;
			pointToGo.y1 = currentPath[array_length(currentPath) - 1].point.y1;
		}
		pointToGo.getNewPoint = false;
	} else {
		/*if ((self.y > pointToGo.y1 - 1 && self.y < pointToGo.y1 + 2) && (self.x > pointToGo.x1 - 2 && self.x < pointToGo.x1 + 1)){
			pointToGo.getNewPoint = true;
		}*/
	}
}

feedingState = function(){
	if (objChasing != noone && instance_exists(objChasing)){
		pointToGo.x1 = objChasing.x;
		pointToGo.y1 = objChasing.y;
	} else if (objChasing != noone && !instance_exists(objChasing)){
		objChasing = noone;
		currentState = STATE.IDLE;
	}
}

chasingState = function(){
	if (objChasing != noone && instance_exists(objChasing)){
		pointToGo.x1 = objChasing.x;
		pointToGo.y1 = objChasing.y;
		if(checkThreePoints()){
			currentState = STATE.IDLE;
			return;
		}
	} else {
		objChasing = noone;
		currentState = STATE.IDLE;
	}
}

getPointFlee1 = function(){
	if(self.y < chaser.y){
		pointToGo.y1 = irandom_range(self.y - 5, self.y - 50);
	} else {
		pointToGo.y1 = irandom_range(self.y + 5, self.y + 50);
	}
	if(self.x < chaser.x){
		pointToGo.x1 = irandom_range(self.x - 5, self.x - 50);
	} else {
		pointToGo.x1 = irandom_range(self.x + 5, self.x + 50);
	}
}

getPointFlee2 = function(){
	if(self.y > chaser.y){
			pointToGo.y1 = irandom_range(self.y - 5, self.y - 50);
		} else {
			pointToGo.y1 = irandom_range(self.y + 5, self.y + 50);
		}
		if(self.x < chaser.x){
			pointToGo.x1 = irandom_range(self.x - 5, self.x - 50);
		} else {
			pointToGo.x1 = irandom_range(self.x + 5, self.x + 50);
		}
}

getPointFlee3 = function(){
	if(self.y < chaser.y){
			pointToGo.y1 = irandom_range(self.y - 5, self.y - 50);
		} else {
			pointToGo.y1 = irandom_range(self.y + 5, self.y + 50);
		}
		if(self.x > chaser.x){
			pointToGo.x1 = irandom_range(self.x - 5, self.x - 50);
		} else {
			pointToGo.x1 = irandom_range(self.x + 5, self.x + 50);
		}
}

getPointFlee4 = function(){
	if(self.y > chaser.y){
		pointToGo.y1 = irandom_range(self.y - 5, self.y - 50);
	} else {
		pointToGo.y1 = irandom_range(self.y + 5, self.y + 50);
	}
	if(self.x > chaser.x){
		pointToGo.x1 = irandom_range(self.x - 5, self.x - 50);
	} else {
		pointToGo.x1 = irandom_range(self.x + 5, self.x + 50);
	}
}

fleeingState = function(){
	if (chaser == noone || !instance_exists(chaser) || chaser.currentState != STATE.CHASING) {
		chaser = noone;
		currentState = STATE.IDLE;
		return;
	} else {
		if (pointToGo.getNewPoint == true){
			var _arr = [getPointFlee1, getPointFlee2, getPointFlee3, getPointFlee4];
			for (var _i = 0; _i < array_length(_arr); _i++;){
				_arr[_i]();
				if (((pointToGo.x1 > camera_get_view_x(view_camera[0]) + 5  && pointToGo.x1 < camera_get_view_width(view_camera[0]) - 5) && (pointToGo.y1 > camera_get_view_y(view_camera[0]) + 5 && pointToGo.y1 < camera_get_view_height(view_camera[0]) - 5))){
					pointToGo.getNewPoint = false;
					break;
				}
			}
		}
		if ((self.y > pointToGo.y1 - 1 && self.y < pointToGo.y1 + 2) && (self.x > pointToGo.x1 - 2 && self.x < pointToGo.x1 + 1)){
			pointToGo.getNewPoint = true;
		}
	}
}

getH = function(_pointToGo){
	return abs((_pointToGo.x1 - targetNode.point.x1)) + abs((_pointToGo.y1  - targetNode.point.y1));
	//return power(_pointToGo.x1 - targetNode.point.x1, 2) + power(_pointToGo.y1  - targetNode.point.y1, 2);
}

find = function(_array, _node){
	for (var _i = 0; _i < array_length(_array); _i++;){
		if (_array[_i].point.x1 == _node.point.x1 && _array[_i].point.y1 == _node.point.y1)
			return true;
	}
	return false;
}

findIndex = function(_array, _node){
	for (var _i = 0; _i < array_length(_array); _i++;){
		if (_array[_i].point.x1 == _node.point.x1 && _array[_i].point.y1 == _node.point.y1)
			return _i;
	}
	return -1;
}


aStar = function(){
	openArray = [startNode];
	closeArray = [];
	while(array_length(openArray) > 0){
		currentNode = openArray[0];
		for(var _i = 0; _i < array_length(openArray); _i++){
			if (currentNode.f() > openArray[_i].f() || (currentNode.f() == openArray[_i].f() && currentNode.h > openArray[_i].h)){
				currentNode = openArray[_i];
			}
		}
		array_push(closeArray, currentNode);
		array_delete(openArray, findIndex(openArray, currentNode), 1);
		if ((currentNode.point.x1 > targetNode.point.x1 - 2 && currentNode.point.x1 < targetNode.point.x1 + 2) && (currentNode.point.y1 > targetNode.point.y1 - 2 && currentNode.point.y1 < targetNode.point.y1 + 2)){
			var _currentNodePath = currentNode;
			var _path = [];
			while (_currentNodePath.point.x1 != startNode.point.x1 || _currentNodePath.point.y1 != startNode.point.y1){
				array_push(_path, _currentNodePath);
				_currentNodePath = _currentNodePath.connection;
			}
			return _path;
		}
		for(var _i = 0; _i < array_length(currentNode.closePoint) && (currentNode.closePoint[_i].x1 > 0 && currentNode.closePoint[_i].x1 < room_width) && (currentNode.closePoint[_i].y1 > 0 && currentNode.closePoint[_i].y1 < room_height) && !place_meeting(currentNode.closePoint[_i].x1, currentNode.closePoint[_i].y1, obj_tree); _i++;){
			closeNode = new Node(currentNode.closePoint[_i].x1, currentNode.closePoint[_i].y1);
			if (find(closeArray, closeNode))
				continue;
			var _costNext = currentNode.g + 1;
			if (currentNode.point.x1 != closeNode.point.x1 && currentNode.point.y1 != closeNode.point.y1)
				_costNext = currentNode.g + 1.4;
			if (!find(openArray, closeNode) || _costNext < openArray[findIndex(openArray, closeNode)].g){
				closeNode.g = _costNext;
				closeNode.connection = currentNode;
				if (!find(openArray, closeNode)) {
					closeNode.h = getH(closeNode.point);
					array_push(openArray, closeNode);
				}
			}
		}
	}
	return [];
}
