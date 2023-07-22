extends CanvasLayer


export var MainGameScene : PackedScene
export var OptionGameScene : PackedScene

func _on_Start_Button_button_up():
	get_tree().change_scene(MainGameScene.resource_path)


func _on_Quit_buton_button_up():
	get_tree().quit()


func _on_Option_button_button_up():
	get_tree().change_scene(OptionGameScene.resource_path)
