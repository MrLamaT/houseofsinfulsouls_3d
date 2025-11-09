extends Area3D

func _ready():
	$MeshInstance3D.visible = false
	visible = false
	
	monitoring = true
	monitorable = false

func _on_body_entered(body):
	if body.is_in_group("player"):  # Убедитесь, что ваш игрок добавлен в группу "player"
		Global.game_settings["HidePlayer"] = true
		print("HidePlayer установлен в true")

func _on_body_exited(body):
	if body.is_in_group("player"):
		if !Global.game_settings["GodMod"]:
			Global.game_settings["HidePlayer"] = false
			print("HidePlayer установлен в false")
		else:
			print("HidePlayer GodMode")


func _on_mouse_entered() -> void:
	pass # Replace with function body.


func _on_mouse_exited() -> void:
	pass # Replace with function body.
