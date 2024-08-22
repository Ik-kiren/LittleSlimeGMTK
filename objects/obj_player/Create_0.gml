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



startNode = new Node(x, y);
targetNode = new Node(1200, 700);

getH = function(_pointToGo){
	return abs((_pointToGo.x1 - targetNode.point.x1)) + abs((_pointToGo.y1  - targetNode.point.y1));
	//return power(_pointToGo.x1 - targetNode.point.x1, 2) + power(_pointToGo.y1  - targetNode.point.y1, 2);
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
		array_delete(openArray, array_get_index(openArray, currentNode), 1);
		array_push(closeArray, currentNode);
	
		if (currentNode.point.x1 == targetNode.point.x1 && currentNode.point.y1 == targetNode.point.y1){
			var _currentNodePath = currentNode;
			var _path = [];
			while (_currentNodePath.point.x1 != startNode.point.x1 || _currentNodePath.point.y1 != startNode.point.y1){
				array_push(_path, _currentNodePath);
				_currentNodePath = _currentNodePath.connection;
			}
			return _path;
		}
		for(var _i = 0; _i < array_length(currentNode.closePoint); _i++;){
			closeNode = new Node(currentNode.closePoint[_i].x1, currentNode.closePoint[_i].y1);
			var _costNext = currentNode.g + 1;
			if (!array_get_index(openArray, closeNode) || _costNext < closeNode.g){
				closeNode.g = _costNext;
				closeNode.connection = currentNode;
				if (!array_get_index(openArray, closeNode)) {
					closeNode.h = getH(closeNode.point);
					array_push(openArray, closeNode);
				}
			}
		}
	}
	return 0;
}

path = aStar();
show_debug_message(array_length(path));