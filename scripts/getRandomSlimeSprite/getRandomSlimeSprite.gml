// Les actifs du script ont changé pour v2.3.0 Voir
// https://help.yoyogames.com/hc/en-us/articles/360005277377 pour plus d’informations

function getRandomSlimeSprite(){
	var	_blueSlime = [spr_blue_slime_idle, spr_blue_slime_up, spr_blue_slime_right, spr_blue_slime_down, spr_blue_slime_left, spr_blue_slime_eat_up, spr_blue_slime_eat_right, spr_blue_slime_eat_down, spr_blue_slime_eat_left];
	var	_redSlime = [spr_red_slime_idle, spr_red_slime_up, spr_red_slime_right, spr_red_slime_down, spr_red_slime_left, spr_red_slime_eat_up, spr_red_slime_eat_right, spr_red_slime_eat_down, spr_red_slime_eat_left];
	var	_greenSlime = [spr_green_slime_idle, spr_green_slime_up, spr_green_slime_right, spr_green_slime_down, spr_green_slime_left, spr_green_slime_eat_up, spr_green_slime_eat_right, spr_green_slime_eat_down, spr_green_slime_eat_left];

	var	_slimesArr = [_blueSlime, _redSlime, _greenSlime];
	var _i = irandom_range(0, 2);
	return _slimesArr[_i];
}