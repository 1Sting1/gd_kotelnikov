extends Node2D

var velocity: Vector2 = Vector2(0, 0)
var angular_speed: float = 0.1
@onready var size = get_node("AsteroidSprite2D").texture.get_size()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	velocity = Vector2(randi_range(-100, 100), randi_range(-100, 100))
	
	angular_speed = randf_range(0.1, 0.5)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var field = get_viewport_rect().size
	position += velocity * delta
	rotation += angular_speed * delta
	if position.x < size.x / 2 and velocity.x < 0:
		velocity.x *= -1
	elif position.x > field.x - size.x / 2 and velocity.x > 0:
		velocity.x *= -1
	if position.y < size.y / 2 and velocity.y < 0:
		velocity.y *= -1
	elif position.y > field.y - size.y / 2 and velocity.y > 0:
		velocity.y *= -1
