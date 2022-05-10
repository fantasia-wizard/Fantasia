extends KinematicBody2D

var direction = Vector2.ZERO

var explosion = preload('res://Environment Effects/explosion.tscn')

func _ready():
	modulate.h = rand_range(70, 200)
	modulate.h = rand_range(70, 200)
	direction = direction.normalized()
	$Hurtbox.damage = 3

func _process(delta):
	rotation_degrees = rad2deg(direction.angle())
# warning-ignore:return_value_discarded
	move_and_slide(direction*delta*7000)
	if is_on_wall():
		queue_free()
		var effect = explosion.instance()
		get_parent().add_child(effect)
		effect.global_position = global_position

func _on_Hurtbox_area_entered(area):
	queue_free()
	var effect = explosion.instance()
	get_parent().add_child(effect)
	effect.global_position = global_position
