/// @description Insérez la description ici
// Vous pouvez écrire votre code dans cet éditeur
draw_self();

for (var _i = 0; _i  < array_length(path) - 1; _i++;){
	draw_line(path[_i].point.x1, path[_i].point.y1, path[_i + 1].point.x1, path[_i + 1].point.y1);
}