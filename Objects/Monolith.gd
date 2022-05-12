extends YSort

export var id = 0
var active = false
var active_tex = preload('res://Objects/monolith_active.png')
signal fight_finished

func _ready() -> void:
	if id in PlayerStats.active_monoliths:
		activate()

func activate():
	$Monolith.texture = active_tex
	if not id in PlayerStats.active_monoliths:
		PlayerStats.active_monoliths.append(id)
		PlayerStats.achievement('Monolith activated.', 'You have activated a monolith.', 'Activated!')

func _process(delta: float) -> void:
	if get_child_count() < 4 and not active:
		activate()
		active = true
		emit_signal('fight_finished')
	$Light2D.visible = active
