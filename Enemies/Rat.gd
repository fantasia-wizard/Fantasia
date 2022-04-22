extends KinematicBody2D

enum{
	MOVE
	CHASE
	IDLE
}

onready var animation_tree = $AnimationTree
onready var animation_state = animation_tree.get('parameters/playback')
onready var state_timer = $StateTimer
onready var soft_collision = $SoftCollision
onready var sprite_timer = $SpriteTimer
onready var explosion = preload('res://Environment Effects/explosion.tscn')
onready var hurt_box = $Hurtbox

export var MAX_SPEED = 50
export var ACCELERATION = 500
export var wander_distance = 5
export var max_health = 2
export var exp_on_kill = 5

var shield_effect = preload('res://Environment Effects/ShieldBlast.tscn')
var state = MOVE
var player = null
var velocity = Vector2.ZERO
var start_location = get_transform()
var target_location = get_transform()
var health = max_health
var last_seen_pos = Vector2.ZERO

func _ready():
	animation_state.travel('Direction')
	start_location = global_position
	target_location = global_position
	new_state()
	$DeathSound.volume_db = -20

func move_state(delta):
	if global_position.distance_to(target_location) < 15 or is_on_wall():
		target_location = global_position + Vector2(rand_range(-wander_distance, wander_distance) * 2, rand_range(-wander_distance, wander_distance) * 2)
	if global_position.distance_to(start_location) > 100:
		target_location = start_location + Vector2(rand_range(-wander_distance, wander_distance) * 2, rand_range(-wander_distance, wander_distance) * 2)
	move(delta)


func chase_state(delta):
	MAX_SPEED = 75
	target_location = player.global_position
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
	match state:
		MOVE:
			move_state(delta)
		CHASE:
			chase_state(delta)
		IDLE:
			idle_state(delta)

func move(delta):
	velocity = velocity.move_toward(global_position.direction_to(target_location).normalized() * MAX_SPEED, ACCELERATION * delta)
	velocity += soft_collision.push_vector()
	velocity = move_and_slide(velocity)
	hurt_box.knockback_vector = velocity

func _on_StateTimer_timeout():
	if state != CHASE:
		new_state()


func _on_Sight_area_entered(area):
	player = area
	state = CHASE

func _on_Sight_area_exited(_area):
	new_state()
	MAX_SPEED = 50



func _on_SpriteTimer_timeout():
	animation_tree.set('parameters/Direction/blend_position', velocity)
	sprite_timer.start(0.1)

func _on_Hitbox_area_entered(area):
	health -= area.damage
	$Blink.play('play')
	velocity = move_and_slide(area.knockback_vector * 100.0)
	if health <= 0:
		var Explosion = explosion.instance()
		get_parent().add_child(Explosion)
		Explosion.global_position = global_position
		$DeathSound.play()
		$Hurtbox/CollisionShape2D.set_deferred('disabled', true)
		visible = false
		PlayerStats.experience += exp_on_kill
		PlayerStats.rats_killed += 1

func explode(_variable):
	var Explosion = explosion.instance()
	get_parent().add_child(Explosion)
	Explosion.global_position = global_position

func shield_blast():
	var effect = shield_effect.instance()
	get_parent().add_child(effect)
	effect.global_position = global_position


func _on_DeathSound_finished():
	queue_free()
