tool
extends Node2D

export(int) var x_size = 300
export(int) var y_size = 300
export(int) var boid_amount = 400

var boids : Array = []

func _ready():
	for i in range(boid_amount):
		var b = load("res://Boid.tscn")
		var boid = b.instance()
		add_child(boid)
		boid.position = Vector2(
			rand_range(0, x_size),
			rand_range(0, y_size)
		)

func _draw():
	if Engine.editor_hint:
		draw_line(Vector2.ZERO, Vector2(x_size, 0), Color.blue, 4)
		draw_line(Vector2.ZERO, Vector2(0, y_size), Color.blue, 4)
		draw_line(Vector2(x_size, 0), Vector2(x_size, y_size), Color.blue, 4)
		draw_line(Vector2(0, y_size), Vector2(x_size, y_size), Color.blue, 4)

func _physics_process(delta):
	if not Engine.editor_hint:
		boids = get_tree().get_nodes_in_group('boids')
		get_tree().call_group('boids', 'setup')
		get_tree().call_group('boids', 'separation')
		get_tree().call_group('boids', 'alignment')
		get_tree().call_group('boids', 'cohesion')
		get_tree().call_group('boids', 'move')
		get_tree().call_group('boids', 'snap_to_limits', x_size, y_size)
	else:
		update()
