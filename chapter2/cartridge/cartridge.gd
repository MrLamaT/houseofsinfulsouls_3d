extends Area3D

func trigger_interaction():
	if Global.game_settings["ShootGun_cartridge"] < 2 and Global.game_settings["Item"] == "shotgun":
		Global.game_settings["ShootGun_cartridge"] += 1
		queue_free()

func _on_mouse_entered() -> void:
	pass

func _on_mouse_exited() -> void:
	pass
