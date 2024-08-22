/// @description Insérez la description ici
// Vous pouvez écrire votre code dans cet éditeur

x = camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]) / 2;
y = camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]) / 2;

buttonYes.x = x - 200;
buttonYes.y = y + 60;

buttonNo.x = x + 100;
buttonNo.y = y + 60;