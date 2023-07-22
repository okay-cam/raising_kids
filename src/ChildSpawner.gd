extends Node2D


export var ChildResource : Resource


func spawn_child():
	# add child
	var child = ChildResource.instance()
	child.init()
	get_parent().add_child(child)
