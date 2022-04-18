extends CanvasLayer
onready var minimap = $UI/TabContainer/Minimap/Image
var visible = false
func _process(_delta):
	visible = $UI.visible
