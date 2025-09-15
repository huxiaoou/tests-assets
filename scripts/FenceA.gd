class_name FenceA extends Node2D

@export var hp: float = 12

func _ready() -> void:
	$HitBox.Damaged.connect(take_damage)
	$EffectShake.initialize($Sprite2D)

func take_damage(damage: float) -> void:
	hp -= damage
	print("fence A take damage: " + str(damage) + ", remaining hp: " + str(hp))
	$EffectShake.start()
	if hp <= 1e-4:
		queue_free()
