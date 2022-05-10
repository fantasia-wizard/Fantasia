extends StaticBody2D

var tex1 = preload('res://Cave-1/stalacmite_1.png')
var tex2 = preload('res://Cave-1/stalacmite_2.png')

func _ready() -> void:
	match randi() %1:
		0:
			$Stalacmite1.texture = tex1
		1:
			$Stalacmite1.texture = tex2
