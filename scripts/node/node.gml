// Les actifs du script ont changé pour v2.3.0 Voir
// https://help.yoyogames.com/hc/en-us/articles/360005277377 pour plus d’informations
function Node(_x, _y) constructor{
	point = new Vector2(_x, _y);
	closePoint = [new Vector2(_x + 1, _y + 1), new Vector2(_x - 1, _y - 1), new Vector2(_x + 1, _y), new Vector2(_x, _y + 1), new Vector2(_x - 1, _y), new Vector2(_x, _y - 1), new Vector2(_x - 1, _y + 1), new Vector2(_x + 1, _y - 1)];
	g = 0;
	h = 0;
	connection = 0;
	
	f = function(){
		return (g + 100 * h);
	}
}