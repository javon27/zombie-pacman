extends Node2D

# Draw a 16x16 grid in the editor for debugging purposes
func _draw() -> void:
	var grid_size: int = 16
	var width: int = get_viewport_rect().size.x
	var height: int = get_viewport_rect().size.y
	
	for x in range(0, width, grid_size):
		draw_line(Vector2(x, 0), Vector2(x, height), Color(1, 1, 1, 0.15))
	
	for y in range(0, height, grid_size):
		draw_line(Vector2(0, y), Vector2(width, y), Color(1, 1, 1, 0.15))