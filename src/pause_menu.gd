extends CanvasLayer

export var MainGameScene : PackedScene



func _on_Resume_buton_button_up():
	get_tree().change_scene(MainGameScene.resource_path)

func _on_Quit_buton_button_up():
	get_tree().quit()
