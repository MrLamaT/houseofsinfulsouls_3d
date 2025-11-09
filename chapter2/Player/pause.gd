extends Panel

func toggle_setting(setting_key: String, display_text: String, button_node: Node) -> void:
	# Переключаем настройку
	Global.game_settings["gui_settings"][setting_key] = !Global.game_settings["gui_settings"][setting_key]
	
	# Обновляем текст через метод кнопки
	var state = "[ON]" if Global.game_settings["gui_settings"][setting_key] else "[OFF]"
	button_node.newLabel(display_text + " " + state)

func _on_button_coords_pressed() -> void:
	toggle_setting("coordinates", "Coords", $LabelButton2)
	$AudioStreamPlayer.play()

func _on_button_timer_pressed() -> void:
	toggle_setting("timer", "Timer", $LabelButton3)
	$AudioStreamPlayer.play()

func _on_button_fps_pressed() -> void:
	toggle_setting("fps", "FPS", $LabelButton)
	$AudioStreamPlayer.play()
