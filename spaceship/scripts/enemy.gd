extends Node2D

var acceleration: Vector2 = Vector2(0, 0)
var velocity: Vector2 = Vector2(0, 0)
var max_force: float = 1000
var max_speed: float = 400
var target: Node2D
var orbit_radius: float = 0
var orbit_speed: float = 1.5
var orbit_angle: float = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	apply_force(Vector2(100, 50))
	if orbit_radius > 0 and target:
		orbit_angle = (position - target.position).angle()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if target:
		if orbit_radius > 0:
			orbit_angle += orbit_speed * delta
			seek(target.position + Vector2.from_angle(orbit_angle) * orbit_radius)
		else:
			seek(target.position)
	velocity += acceleration * delta
	velocity = velocity.limit_length(max_speed)
	position += velocity * delta
	var field = get_viewport_rect().size
	position = Vector2(wrapf(position.x, 0, field.x), wrapf(position.y, 0, field.y))
	acceleration *= 0
	rotation = velocity.angle() - PI/2
	
func apply_force(force: Vector2):
	acceleration = force
	
func seek(target_pos: Vector2):
	var direction = target_pos - position
	var desired_velocity = direction.normalized() * min(max_speed, direction.length() * 3)
	apply_force((desired_velocity - velocity).limit_length(max_force))
