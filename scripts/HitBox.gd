class_name HitBox extends Area2D

# when a node gets hit, means this node is hurted by other people

signal Damaged(damage: int)

func take_damage(damage: int) -> void:
	Damaged.emit(damage)
