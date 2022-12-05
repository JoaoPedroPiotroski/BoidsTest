extends KinematicBody2D

var local_boids := []
var local_positions = []
var local_range := 55.0
var speed = 300
var separation_bias = 0.7
var alignment_bias = 0.3
var cohesion_bias = 0.1
var randomness = 0.2

var color : Color = Color.white

var center_of_weight : Vector2
var move_direction : Vector2

func _ready():
	add_to_group("boids")
	rotation_degrees = rand_range(0, 360)
	color = Color(
		rand_range(0, 1),
		rand_range(0, 1),
		rand_range(0, 1)
	)
	$Polygon2D.color = color
	$Polygon2D2. color = color
	
	$Polygon2D3. color = color
	
	$Polygon2D4. color = color
	
func _draw():
	return
	draw_circle(Vector2.ZERO,
	local_range,
	Color(1, 1, 1, 0.2))

func snap_to_limits(limit_x, limit_y):
	if global_position.x < 0:
		global_position.x = limit_x
	elif global_position.x > limit_x:
		global_position.x = 0
	if global_position.y < 0:
		global_position.y = limit_y
	elif global_position.y > limit_y:
		global_position.y = 0
		
func dir_from_angle():
	return Vector2(
	cos(rotation),
	sin(rotation))

func setup():
	local_boids = []
	var sum_x = 0
	var sum_y = 0
	var positions = 0
	for boid in get_parent().boids:
		if global_position.distance_to(boid.global_position) < local_range:
			local_boids.append(boid)
			local_positions.append(boid.global_position)
			sum_x += boid.global_position.x
			sum_y += boid.global_position.y
			positions += 1
	var average_x = sum_x / positions
	var average_y = sum_y / positions
	center_of_weight = Vector2(average_x, average_y)
	
func separation():
	for boid in local_boids:
		rotation = lerp_angle(
			rotation,
			get_angle_to(boid.global_position),
			- separation_bias / local_boids.size() #(local_range - global_position.distance_to(boid.global_position) / separation_dampening)
		)

func alignment():
	for boid in local_boids:
		rotation = lerp_angle(
			rotation,
			boid.rotation,
			alignment_bias / local_boids.size()
		)

func cohesion():
	for boid in local_boids:
		rotation = lerp_angle(
			rotation,
			get_angle_to(center_of_weight),
			cohesion_bias / local_boids.size() #(local_range - global_position.distance_to(boid.global_position) / separation_dampening)
		)
	
	
func move():
	rotation += rand_range(-randomness, randomness)
	move_and_slide(dir_from_angle() * speed)

