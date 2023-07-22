extends CanvasLayer

export var MainGameScene : PackedScene
export var OptionGameScene : PackedScene
export var MenuGameScene : PackedScene


func _on_Resume_buton_button_up():
	get_tree().change_scene(MainGameScene.resource_path)

func _on_Quit_buton_button_up():
	get_tree().quit()


func _on_Option_button_pressed():
	get_tree().change_scene(OptionGameScene.resource_path)


func _on_Menu_buton_button_up():
	get_tree().change_scene(MenuGameScene.resource_path)
