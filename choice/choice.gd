extends Node2D

func _ready() -> void:
	$AudioStreamPlayer.play()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://chapter2/rooms/main.tscn")
