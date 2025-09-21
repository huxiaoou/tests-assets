class_name HurtBox extends Area2D

# when a area enters HurtBox, and it is a hit box, this area will get hurt

@export var damage: float = 2
@export var re_enter_threshold: int = 1000 # in milli-seconds
var area_enter_records: Dictionary[int, int] = {}

signal hurt_something(damage: float)

func _ready() -> void:
	area_entered.connect(hurt_box_entered)

func hurt_box_entered(area: Area2D) -> void:
	if area is HitBox:
		var hitbox_id: int = area.get_instance_id()
		var this_time: int = Time.get_ticks_msec()
		var prev_time: int = area_enter_records.get(hitbox_id, 0)
		if (this_time - prev_time) > re_enter_threshold:
			area.take_damage(damage)
			hurt_something.emit(damage)
		else:
			print("hit box " + str(hitbox_id) + " re-entered")
		area_enter_records[hitbox_id] = this_time
