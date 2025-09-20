class_name StateValkyrieSlash extends StateValkyrie

var is_attacking: bool = false
@export_range(1, 20, 0.5) var decelerate_speed: float = 1.8
@export var slash_sound: AudioStream


@onready var audio: AudioStreamPlayer2D = $"../../Audio/AudioStreamPlayer2D"
@onready var idle: StateValkyrie = $"../Idle"
@onready var walk: StateValkyrie = $"../Walk"
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var direction_arrow: DirectionArrow = $"../../AnimatedSprite2D/Sprite2DDirectionArrow"


func enter() -> void:
	valkyrie.update_animation("slash")
	animated_sprite_2d.animation_finished.connect(end_attack)
	is_attacking = true
	await get_tree().create_timer(0.4).timeout # play animation a little then do things
	direction_arrow.start_monitor()
	audio.stream = slash_sound
	audio.play()
	

func exit() -> void:
	is_attacking = false
	direction_arrow.stop_monitor()
	animated_sprite_2d.animation_finished.disconnect(end_attack)

func process(delta: float) -> StateValkyrie:
	valkyrie.velocity -= valkyrie.velocity * decelerate_speed * delta
	if not is_attacking:
		return idle if valkyrie.direction_mov == Vector2.ZERO else walk
	return null

func end_attack() -> void:
	is_attacking = false
