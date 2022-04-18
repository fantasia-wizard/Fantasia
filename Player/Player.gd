extends KinematicBody2D

const ACCELERATION = 700
const MAX_SPEED = 100
const FRICTION = 500

enum{
	MOVE
	ATTACK
	SPELL
}
enum{
	EXPLODE
	SHIELD
}
var velocity = Vector2.ZERO
var input_vector = Vector2.DOWN
var speed = MAX_SPEED
var accel = ACCELERATION
var state = MOVE
var damage_effect = preload('res://Environment Effects/DamageEffect.tscn')
var rolled = false

onready var animation_tree = $AnimationTree
onready var animation_state = animation_tree.get('parameters/playback')
onready var sprite = $Sprite
onready var hurtbox = $Rotate/Hurtbox
onready var hitbox = $Hitbox
onready var timer = $Timer
onready var blink = $BlinkPlayer
onready var animation_player = $AnimationPlayer

signal death

func _ready():
	animation_tree.set('parameters/Move/blend_position', input_vector)
	animation_tree.set('parameters/Idle/blend_position', input_vector)
	animation_tree.set('parameters/Attack/blend_position', input_vector)
	global_position = PlayerStats.start_location
	PlayerStats.start_location = Vector2.ZERO
	randomize()
	blink.play('stop')

func _process(delta):
	hurtbox.damage = 1 + PlayerStats.strength
	PlayerStats.location = global_position
	PlayerStats.velocity = velocity
	if PlayerStats.health <= 0:
		emit_signal('death')
		PlayerStats.health = 1.0
		PlayerStats.stamina = 0.0
	match(state):
		MOVE:
			move_state(delta)
		ATTACK:
			attack_state(delta)
		SPELL:
			match(PlayerStats.selected_spell):
				0.0:
					animation_state.travel('Explosion')
					velocity = Vector2.ZERO
					animation_tree.set('parameters/Idle/blend_position', Vector2.DOWN)
					animation_tree.set('parameters/Attack/blend_position', Vector2.DOWN)
				1.0:
					animation_state.travel('ShieldSpell')
					velocity = Vector2.ZERO
					animation_tree.set('parameters/Idle/blend_position', Vector2.DOWN)
					animation_tree.set('parameters/Attack/blend_position', Vector2.DOWN)
	velocity = move_and_slide(velocity)
	if Input.is_action_just_pressed('attack'):
		state = ATTACK
	if Input.is_action_just_pressed('spell'):
		state = SPELL

func move_state(delta):
	if Input.is_action_pressed('run') and PlayerStats.stamina > 0:
		accel = ACCELERATION + 50 + (PlayerStats.speed * 25)
		speed = MAX_SPEED + 50 + (PlayerStats.speed * 25)
		PlayerStats.stamina -= delta*0.15*Vector2.ZERO.distance_to(velocity)/(PlayerStats.speed+1)
		PlayerStats.running = true
	else:
		PlayerStats.running = false
		accel = ACCELERATION
		speed = MAX_SPEED
		speed*=(PlayerStats.stamina_percent+1.0)/2.0
	input_vector.x = Input.get_axis('left', 'right')
	input_vector.y = Input.get_axis('up', 'down')
	if input_vector:
		velocity = velocity.move_toward(speed * input_vector.normalized(), accel * delta)
		animation_tree.set('parameters/Move/blend_position', input_vector)
		animation_tree.set('parameters/Idle/blend_position', input_vector)
		animation_tree.set('parameters/Attack/blend_position', input_vector)
		hitbox.knockback_vector = velocity*MAX_SPEED
		animation_state.travel('Move')
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta*abs(sqrt(Vector2.ZERO.distance_to(velocity))+1)/10)
		animation_state.travel('Idle')

func attack_state(delta):
	if hurtbox.get_overlapping_areas().size() > 0 and not rolled:
		var roll = randi() %20
		if roll == 19:
			hurtbox.damage = round(2*PlayerStats.strength+1)
			text_effect('Critical Hit!')
		elif roll == 0:
			hurtbox.damage = round(0.5*PlayerStats.strength+1)
			text_effect('Critical Miss')
		rolled = true
	animation_state.travel('Attack')
	velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

func _on_Hitbox_area_entered(area):
	blink.play('start')
	PlayerStats.health -= area.damage
	velocity = move_and_slide(area.knockback_vector * area.damage)
	timer.start(0.5)
	hitbox.set_deferred('monitoring', false)

func _on_Timer_timeout():
	blink.play('stop')
	hitbox.monitoring = true

func attack_ended():
	rolled = false
	set('state', MOVE)

func text_effect(value):
	var effect = damage_effect.instance()
	get_parent().add_child(effect)
	effect.global_position = global_position+Vector2(0, 5)
	effect.value = value
