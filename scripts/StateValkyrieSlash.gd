class_name StateValkyrieSlash extends StateValkyrie

var is_attacking: bool = false
@export_range(1, 20, 0.5) var decelerate_speed: float = 1.8
@export var slash_sound: AudioStream

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var audio: AudioStreamPlayer2D = $"../../Audio/AudioStreamPlayer2D"
@onready var idle: StateValkyrie = $"../Idle"
@onready var walk: StateValkyrie = $"../Walk"
@onready var sprite_2d_slash: Sprite2D = $"../../Sprite2DSlash"
@onready var sprite_2d_direction_arrow: DirectionArrow = $"../../Sprite2DDirectionArrow"


func enter() -> void:
	sprite_2d_slash.visible = true
	sprite_2d_slash.scale.x = valkyrie.anim_scale_x
	valkyrie.update_animation("slash")
	animation_player.animation_finished.connect(end_attack)
	is_attacking = true
	await get_tree().create_timer(0.4).timeout # play animation a little then do things
	sprite_2d_direction_arrow.start_monitor()
	audio.stream = slash_sound
	audio.play()
	

func exit() -> void:
	sprite_2d_slash.visible = false
	animation_player.animation_finished.disconnect(end_attack)
	is_attacking = false
	sprite_2d_direction_arrow.stop_monitor()

func process(delta: float) -> StateValkyrie:
	valkyrie.velocity -= valkyrie.velocity * decelerate_speed * delta
	if not is_attacking:
		return idle if valkyrie.direction_mov == Vector2.ZERO else walk
	return null

func end_attack(_new_anim_name: String) -> void:
	is_attacking = false
