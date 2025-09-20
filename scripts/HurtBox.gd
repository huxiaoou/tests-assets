class_name HurtBox extends Area2D

# when a area enters HurtBox, and it is a hit box, this area will get hurt

@export var damage: float = 2

signal hurt_something(damage: float)

func _ready() -> void:
	area_entered.connect(hurt_box_entered)

func hurt_box_entered(area: Area2D) -> void:
	if area is HitBox:
		print("hit box enter hurtbox")
		area.take_damage(damage)
		hurt_something.emit(damage)
