extends KinematicBody2D

enum{ #state
	MOVE
	CHASE
	IDLE
	ATTACK
}
enum{ #Attack stage
	DODGE
	SHOOT
}

onready var animation_tree = $AnimationTree
onready var animation_state = animation_tree.get('parameters/playback')
onready var state_timer = $StateTimer
onready var soft_collision = $SoftCollision

var MAX_SPEED = 50
var ACCELERATION = 500
var wander_distance = 50
var max_health = 10
var exp_on_kill = 100
var shield_effect = preload('res://Environment Effects/ShieldBlast.tscn')
var bullet = preload('res://Objects/Bullet.tscn')
var explosion = preload('res://Environment Effects/explosion.tscn')
var state = MOVE
var player = null
var velocity = Vector2.ZERO
var start_location = get_transform()
var target_location = get_transform()
var health = max_health
var attack_stage = SHOOT

func _ready():
	animation_state.travel('Idle')
	start_location = global_position
	target_location = global_position
	new_state()
	$DeathSound.volume_db = -20

func shoot():
	var target = $AttackRange.player.global_position
	var new_bullet = bullet.instance()
	get_parent().add_child(new_bullet)
	new_bullet.direction = global_position.direction_to(target)
	new_bullet.global_position = global_position
	for _x in range(0, (randi()%4)+2):
		var new_bullets = bullet.instance()
		get_parent().add_child(new_bullets)
		new_bullet.direction = global_position.direction_to(target+ Vector2(rand_range(-5, 5), rand_range(-5, 5)))
		new_bullet.global_position = global_position

func move_state(delta):
# warning-ignore:return_value_discarded
	move_and_slide(Vector2.ZERO)
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
	if velocity.is_equal_approx(Vector2.ZERO):
		animation_state.travel('Idle')
	velocity = velocity.move_toward(Vector2.ZERO, ACCELERATION * delta * 0.1)
	velocity += soft_collision.push_vector()
	velocity = move_and_slide(velocity)

func attack_state(delta):
	match attack_stage:
		SHOOT:
			shoot()
			target_location = global_position + Vector2(rand_range(-wander_distance, wander_distance) * 2, rand_range(-wander_distance, wander_distance) * 2)
			attack_stage = DODGE
		DODGE:
			move(delta)
			if global_position.distance_to(target_location) < 15:
				$AttackStateTimer.start(0.2)
# warning-ignore:return_value_discarded
			move_and_slide(Vector2.ZERO)
			if is_on_wall():
				target_location = global_position + Vector2(rand_range(-wander_distance, wander_distance) * 2, rand_range(-wander_distance, wander_distance) * 2)
			if player.global_position.distance_to(global_position) < 100:
				target_location += player.global_position.direction_to(global_position)
				MAX_SPEED = 100
			else:
				MAX_SPEED = 50

func new_state():
	var rand_num = randi() %2
	match rand_num:
		0:
			state = MOVE
		1:
			state = IDLE
	state_timer.start(rand_range(1, 3))

func _process(delta):
	animation_tree.set('parameters/Idle/blend_position', velocity)
	animation_tree.set('parameters/Attack/blend_position', velocity)
	animation_tree.set('parameters/Roll/blend_position', velocity)

	match state:
		MOVE:
			move_state(delta)
		CHASE:
			chase_state(delta)
		IDLE:
			idle_state(delta)
		ATTACK:
			attack_state(delta)

func move(delta):
	animation_state.travel('Roll')
	velocity = velocity.move_toward(global_position.direction_to(target_location).normalized() * MAX_SPEED, ACCELERATION * delta)
	velocity += soft_collision.push_vector()
	velocity = move_and_slide(velocity)

func _on_StateTimer_timeout():
	if state != CHASE and state != ATTACK:
		new_state()


func _on_Sight_area_entered(area):
	player = area
	state = CHASE

func _on_Sight_area_exited(_area):
	new_state()
	MAX_SPEED = 50

func _on_Hitbox_area_entered(area):
	health -= area.damage
	$Blink.play('play')
	velocity = move_and_slide(area.global_position.direction_to(global_position)* area.knockback_strength)
	if health <= 0:
		var Explosion = explosion.instance()
		get_parent().add_child(Explosion)
		Explosion.global_position = global_position
		$DeathSound.play()
		visible = false
		PlayerStats.experience += exp_on_kill
		PlayerStats.bosses_killed += 1

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


func _on_AttackRange_area_entered(area):
	state = ATTACK
	attack_stage = SHOOT



func _on_AttackStateTimer_timeout():
	attack_stage = SHOOT
