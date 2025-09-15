class_name HitBox extends Area2D

# when a node gets hit, means this node is hurted by other people
@onready var effect_player: AnimatedSprite2D = $EffectPlayer


signal Damaged(damage: float)

func take_damage(damage: float) -> void:
	Damaged.emit(damage)
	var sn = randi() % 2
	effect_player.position = Vector2(
			randf_range(-5, 5),
			randf_range(-2, 2),
		)
	effect_player.rotation = randf() * 2 * PI
	if sn == 0:
		effect_player.play("slash01")
	elif sn == 1:
		effect_player.position.x += 24
		effect_player.play("slash08")
