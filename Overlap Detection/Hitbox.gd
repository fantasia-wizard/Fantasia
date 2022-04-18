extends Area2D

var knockback_vector = Vector2.ZERO
var damage_effect = preload('res://Environment Effects/DamageEffect.tscn')

func _ready():
	$'Hit Sound'.volume_db = -20

func explode():
	get_parent().explode()

func _on_Hitbox_area_entered(area):
	$'Hit Sound'.play()
	call_deferred('number_effect', area)

func number_effect(area):
	var effect = damage_effect.instance()
	get_parent().get_parent().add_child(effect)
	effect.global_position = global_position
	effect.set_value(area.damage)

