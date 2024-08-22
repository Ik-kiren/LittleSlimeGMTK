/// @description Insérez la description ici
// Vous pouvez écrire votre code dans cet éditeur
if(global.pause){
	vspeed = 0;
	hspeed = 0;
	return;
}

currentSize = sprite_width + sprite_height;

if (keyboard_check(ord(obj_gmanager.keyUp)) || keyboard_check(vk_up)){
	vspeed = -moveSpeed * (delta_time / 10000);
	if (!animationPlaying)
		sprite_index = spr_slime_up;
	if (y <= 5)
		y -= vspeed;
} 
if (keyboard_check(ord(obj_gmanager.keyDown)) || keyboard_check(vk_down)){
	vspeed = moveSpeed * (delta_time / 10000);
	if (!animationPlaying)
		sprite_index = spr_slime_down;
	if (y >= room_height - 5)
		y -= vspeed;
}
if (keyboard_check(ord(obj_gmanager.keyLeft)) || keyboard_check(vk_left)){
	hspeed = -moveSpeed * (delta_time / 10000);
	if (!animationPlaying)
		sprite_index = spr_slime_left;
	if (x <= 5)
		x -= hspeed;
}
if (keyboard_check(ord(obj_gmanager.keyRight)) || keyboard_check(vk_right)){
	hspeed = moveSpeed * (delta_time / 10000);
	if (!animationPlaying)
		sprite_index = spr_slime_right;
	if (x >= room_width - 5)
		x -= hspeed;
}
if ((!keyboard_check(ord(obj_gmanager.keyUp)) && !keyboard_check(vk_up)) && (!keyboard_check(ord(obj_gmanager.keyDown)) && !keyboard_check(vk_down)))
	vspeed = 0;
if ((!keyboard_check(ord(obj_gmanager.keyLeft)) && !keyboard_check(vk_left)) && (!keyboard_check(ord(obj_gmanager.keyRight)) && !keyboard_check(vk_right)))
	hspeed = 0;
