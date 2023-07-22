extends CanvasLayer

export var MainGameScene : PackedScene
export var MenuGameScene : PackedScene
export var PauseGameScene : PackedScene

func _on_Resume_buton_button_up():
	get_tree().change_scene(MainGameScene.resource_path)
#	get_tree().paused = false;

func _on_Quit_buton_button_up():
	get_tree().quit()

func _on_Menu_buton_button_up():
	get_tree().change_scene(MenuGameScene.resource_path)

#func pause():
#	get_tree().paused = true;
#	get_tree().change_scene(PauseGameScene.resource_path)

