extends Area2D

var damage_effect = preload('res://Environment Effects/DamageEffect.tscn')
var blood_effect = preload('res://Environment Effects/BloodSplatter.tscn')

export var bleed = true

func _ready():
	$'Hit Sound'.volume_db = -20

func explode(area):
	get_parent().explode(area)

func _on_Hitbox_area_entered(area):
	$'Hit Sound'.play()
	call_deferred('number_effect', area)
	if bleed:
		var effect = blood_effect.instance()
		get_parent().get_parent().add_child(effect)
		effect.emitting = true
		effect.global_position = global_position +Vector2(rand_range(-3, 3), rand_range(-3, 3))

func number_effect(area):
	var effect = damage_effect.instance()
	get_parent().get_parent().add_child(effect)
	effect.global_position = global_position
	effect.set_value(area.damage)

