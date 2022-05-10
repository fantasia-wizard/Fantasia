extends KinematicBody2D

enum{
	MOVE
	IDLE
}

onready var animated_sprite = $AnimatedSprite
onready var state_timer = $StateTimer
onready var soft_collision = $SoftCollision
onready var explosion = preload('res://Environment Effects/explosion.tscn')

var MAX_SPEED = 50
var ACCELERATION = 700
var wander_distance = 100
var max_health = 2
var exp_on_kill = 0
var shield_effect = preload('res://Environment Effects/ShieldBlast.tscn')
var state = MOVE
var player = null
var velocity = Vector2.ZERO
var start_location = get_transform()
var target_location = get_transform()
var modifier_vector = Vector2.ZERO
var health = max_health
var recently_collided = false
var feathers = preload('res://Environment Effects/Feathers.tscn')

func _ready():
	animated_sprite.frame = rand_range(0, 3)
	start_location = global_position
	target_location = global_position
	new_state()
	$DeathSound.volume_db = -20

func move_state(delta):
	if abs(velocity.x) < 25:
		target_location.x += rand_range(-75, 75)
	if global_position.distance_to(target_location) < 50 or is_on_wall():
		target_location = target_location.move_toward(global_position + Vector2(rand_range(-wander_distance, wander_distance) * 2, rand_range(-wander_distance, wander_distance) * 2), 5)
		modifier_vector = Vector2(0, rand_range(-1, 1))
		if randi() %4 == 0 and not recently_collided:
			new_state()
			recently_collided = true
			$CollisionTimer.start(1)
	if global_position.distance_to(start_location) > 100:
		target_location = start_location + Vector2(rand_range(-wander_distance, wander_distance) * 2, rand_range(-wander_distance, wander_distance) * 2)
	move(delta)

func idle_state(delta):
	velocity = velocity.move_toward(Vector2.ZERO, ACCELERATION * delta * 0.1)
	velocity += soft_collision.push_vector()
	velocity = move_and_slide(velocity)

func new_state():
	var rand_num = randi() %2
	match rand_num:
		0:
			state = MOVE
		1:
			state = IDLE
	state_timer.start(rand_range(1, 3))

func _process(delta):
	$AnimatedSprite.flip_h = velocity.x > 0
	match state:
		MOVE:
			move_state(delta)
			animated_sprite.play()
		IDLE:
			idle_state(delta)
			if Vector2.ZERO.distance_to(velocity) < 25 and animated_sprite.frame == 0:
				animated_sprite.stop()

func move(delta):
	target_location += modifier_vector
	velocity = velocity.move_toward(global_position.direction_to(target_location).normalized() * MAX_SPEED, ACCELERATION * delta)
	velocity += soft_collision.push_vector()
	velocity = move_and_slide(velocity)

func _on_StateTimer_timeout():
	new_state()

func _on_Hitbox_area_entered(area):
	health -= area.damage
	var effect = feathers.instance()
	get_parent().add_child(effect)
	effect.emitting = true
	effect.global_position = global_position
	$Blink.play('play')
	velocity = move_and_slide(area.global_position.direction_to(global_position)* area.knockback_strength)
	if health <= 0:
		var Explosion = explosion.instance()
		get_parent().add_child(Explosion)
		Explosion.global_position = global_position
		$DeathSound.play()
		visible = false
		PlayerStats.experience += exp_on_kill
	else:
		target_location = global_position + area.global_position.direction_to(global_position)*500
		state = MOVE

func explode(_area):
	var Explosion = explosion.instance()
	get_parent().add_child(Explosion)
	Explosion.global_position = global_position

func shield_blast():
	var effect = shield_effect.instance()
	get_parent().add_child(effect)
	effect.global_position = global_position

func _on_DeathSound_finished():
	queue_free()


func _on_CollisionTimer_timeout() -> void:
	recently_collided = false
