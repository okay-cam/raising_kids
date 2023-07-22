extends Node2D


const ChildResource = preload("res://src/Child.tscn")

func spawn_child():
	# add child
	var child = ChildResource.instance()
	get_parent().add_child(child)
	pass
