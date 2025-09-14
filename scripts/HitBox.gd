class_name HitBox extends Area2D

# when a node gets hit, means this node is hurted by other people
@onready var effect_player: AnimatedSprite2D = $EffectPlayer


signal Damaged(damage: float)

func take_damage(damage: float) -> void:
	Damaged.emit(damage)
	var sn = randi() % 2
	if sn == 0:
		effect_player.play("slash01")
	elif sn == 1:
		effect_player.play("slash08")
