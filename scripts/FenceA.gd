class_name FenceA extends Node2D

@export var hp: float = 12

func _ready() -> void:
	$HitBox.Damaged.connect(take_damage)

func take_damage(damage: float) -> void:
	hp -= damage
	print("fence A take damage: " + str(damage) + ", remaining hp: " + str(hp))
	if hp <= 1e-4:
		queue_free()
