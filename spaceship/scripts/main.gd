extends Node2D

const ENEMY_COUNT: int = 10
const ORBIT_RADIUS: float = 150

@export var enemy_scene: PackedScene
@onready var ship: Node2D = get_node("Node2D")
@onready var lifetime_label: Label = get_node("LifetimeLabel")


func _ready() -> void:
	for i in ENEMY_COUNT:
		var enemy = enemy_scene.instantiate()
		enemy.position = Vector2(randf_range(0, 1024), randf_range(0, 768))
		enemy.target = ship
		if i == 0:
			enemy.orbit_radius = ORBIT_RADIUS
		else:
			enemy.max_speed = randf_range(100, 250)
		add_child(enemy)


func _process(_delta: float) -> void:
	lifetime_label.text = "Lifetime: %.1f" % ship.lifetime
