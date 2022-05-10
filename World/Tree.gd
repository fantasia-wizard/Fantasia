extends StaticBody2D
export var Textures: Array

var tree1 = preload('res://World/tree3.png')
var tree2 = preload('res://World/tree4.png')
var tree3 = preload('res://World/tree5.png')

func explode(_variable):
	pass

func _ready() -> void:
	match randi() % 2:
		0:
			$Tree.texture = tree1
		1:
			$Tree.texture = tree2
		2:
			$Tree.texture = tree3
