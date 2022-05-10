extends Area2D

var target = Vector2.ZERO
var state = null
var coordinate = false

func _on_Coordination_area_entered(area):
	if area.state == get_parent().CHASE and not area.coordinate and get_parent().state != get_parent().CHASE:
		coordinate = true
		target = area.target

func _process(delta):
	state = get_parent().state
	if not coordinate:
		target = Vector2.ZERO
	else:
		get_parent().target_location = target

func _on_Coordination_area_exited(area):
	coordinate = false
