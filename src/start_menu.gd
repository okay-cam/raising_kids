extends CanvasLayer

#export var MainGameScene : PackedScene
#export var OptionGameScene : PackedScene

const MainGame = "res://src/Level.tscn"

func _on_Start_Button_button_up():
# warning-ignore:return_value_discarded
	get_tree().change_scene(MainGame)


func _on_Quit_buton_button_up():
	get_tree().quit()


#func _on_Option_button_button_up():
#	get_tree().change_scene(OptionGameScene.resource_path)
