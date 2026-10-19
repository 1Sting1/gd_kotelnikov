extends Node2D

var speed: float = 0
var max_speed: float = 500
var velocity: Vector2 = Vector2(0,0)
var lifetime: float = 0
@onready var speedLabel: Label = get_node ("Speedometer")
@onready var sprite: Node2D = get_node("shipArea2D/ShipCollisionShape")
var shield_restoration: float=0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("shipArea2D").area_entered.connect(_on_area_entered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	lifetime += delta

	if Input.is_action_pressed("ui_up"):
		speed += 500 * delta
		if speed > max_speed:
			speed = max_speed
			
	if Input.is_action_pressed("ui_down"):
		speed -= 500 * delta
		if speed < 0:
			speed = 0
			
	if Input.is_action_pressed("ui_left"):
		rotation -= 5 * delta
			
	if Input.is_action_pressed("ui_right"):
		rotation += 5 * delta
	
	velocity = speed * Vector2(cos(rotation + PI/2), sin(rotation + PI/2))
	speedLabel.text = "%d" % velocity.length()
	speedLabel.rotation = -rotation
	position += velocity * delta
	var field = get_viewport_rect().size
	position = Vector2(wrapf(position.x, 0, field.x), wrapf(position.y, 0, field.y))
	
	if shield_restoration > 0:
		shield_restoration -= delta
	if shield_restoration <= 0:
		sprite.visible = true
	
func damaged():
	sprite.visible = false
	shield_restoration = 1.0

func _on_area_entered(_area: Area2D) -> void:
	lifetime = 0
	damaged()
