class_name HitBox extends Area2D

# when a node gets hit, means this node is hurted by other people

signal Damaged(damage: float)

func take_damage(damage: float) -> void:
	Damaged.emit(damage)
