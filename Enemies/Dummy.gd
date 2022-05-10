extends KinematicBody2D

enum{
	MOVE
	CHASE
	IDLE
}


var explosion = preload('res://Environment Effects/explosion.tscn')
var _shield_blast = preload('res://Environment Effects/ShieldBlast.tscn')

var health = 1

func _ready():
	$DeathSound.volume_db = -20

func _on_Hitbox_area_entered(area):
	$Blink.play('play')
	explode(area)
	visible = false
	$DeathSound.play()

func explode(_variable):
	var Explosion = explosion.instance()
	get_parent().add_child(Explosion)
	Explosion.global_position = global_position

func shield_blast():
	var ShieldBlast = _shield_blast.instance()
	get_parent().add_child(ShieldBlast)
	ShieldBlast.global_position = global_position

func _on_DeathSound_finished():
	queue_free()
