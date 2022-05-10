tool
extends Area2D

var damage_effect = preload('res://Environment Effects/DamageEffect.tscn')
var blood_effect = preload('res://Environment Effects/BloodSplatter.tscn')
export var shape: Shape2D
export var bleed = true

func _ready():
	$CollisionShape2D.shape = shape
	$'Hit Sound'.volume_db = -20

func explode(area):
	get_parent().explode(area)

func _on_Hitbox_area_entered(area):
	$CollisionShape2D.set_deferred('disabled', true)
	$Invincibility.start(0.5)
	$'Hit Sound'.play()
	call_deferred('number_effect', area)
	if bleed:
		var effect = blood_effect.instance()
		get_parent().get_parent().add_child(effect)
		effect.emitting = true
		effect.global_position = global_position+global_position.direction_to(area.global_position)*2.0

func number_effect(area):
	var effect = damage_effect.instance()
	get_parent().get_parent().add_child(effect)
	effect.global_position = global_position
	effect.set_value(area.damage)

func _process(delta: float) -> void:
	if Engine.editor_hint:
		$CollisionShape2D.shape = shape

func _on_Invincibility_timeout() -> void:
	$CollisionShape2D.set_deferred('disabled', false)

