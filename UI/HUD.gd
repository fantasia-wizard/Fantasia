extends CanvasLayer

export var health = 3 setget set_health
export var max_health = 3 setget set_max_health
var checked = null
var stamina = 100.0
var max_stamina = 100.0
var stamina_percent = 1.0
var last_health = 3
var loading = false

onready var heartBlink = $Full/AnimationPlayer
onready var heartsEmpty = $Empty
onready var heartsFull = $Full
onready var staminaBar = $StaminaFull
onready var vignette = $Vignette
onready var blinkTimer = $Full/Timer

var TouchControls = preload('res://UI/Touch Controls.tscn')

func _ready():
	heartBlink.play('stop')

func _process(_delta):

	if loading:
		var touch_controls = TouchControls.instance()
		add_child(touch_controls)
		loading = false
		if not PlayerStats.touch_controls:
			touch_controls.queue_free()
			loading = false
	for i in range(get_children().size()):
		get_children()[i].visible = not get_tree().current_scene.name == 'Main Menu'
	staminaBar.rect_size.x = 90.0*stamina_percent
	heartsEmpty.rect_size.x = max_health * 8
	heartsFull.rect_size.x = health * 8
	last_health = health
	self.health = PlayerStats.health
	max_health = PlayerStats.max_health
	stamina = PlayerStats.stamina
	max_stamina = PlayerStats.max_stamina
	stamina_percent = PlayerStats.stamina_percent
	staminaBar.material.set_shader_param('length', stamina_percent)
	vignette.material.set_shader_param('alpha_percent', PlayerStats.health_percent)

func set_health(value):
	health = value
	if health != last_health:
		heartBlink.play('start')
		blinkTimer.start(0.3)

func set_max_health(value):
	max_health = value


func _on_Timer_timeout():
	heartBlink.play('stop')
