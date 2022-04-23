extends Node2D

onready var bomb_sprite = $AnimatedSprite
onready var bomb_explosion = $BombExplosion/CollisionShape2D
onready var collision = $CollisionShape2D

var explosion_res = preload('res://Environment Effects/explosion.tscn')
var scorch_res = preload('res://Environment Effects/Scorch.tscn')

func _ready():
	bomb_sprite.playing = false
	bomb_explosion.disabled = true

func fire():
	bomb_sprite.playing = true

func _on_AnimatedSprite_animation_finished():
	PlayerStats.camera_shaking = true
	PlayerStats.shake_type = 0
	$Area2D.queue_free()
	bomb_sprite.queue_free()
	bomb_explosion.disabled = false
	collision.disabled = true
	$SfxrStreamPlayer.play()
	for _x in range(20):
		var explode = explosion_res.instance()
		get_parent().add_child(explode)
		explode.global_position = global_position + Vector2(rand_range(-20.0, 20.0), rand_range(-20.0, 20.0)).clamped(20)
		for _y in range(2):
			var scorch = scorch_res.instance()
			get_parent().add_child(scorch)
			scorch.global_position = global_position + Vector2(rand_range(-20.0, 20.0), rand_range(-20.0, 20.0)).clamped(20)
	$Timer.start(0.5)

func _on_Area2D_area_entered(_area):
	fire()


func _on_Timer_timeout():
	bomb_explosion.disabled = true
	queue_free()

