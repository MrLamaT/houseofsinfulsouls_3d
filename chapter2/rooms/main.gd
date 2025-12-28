extends Node3D

var password_option = {
		1: "0746",
		2: "1825",
		3: "2391",
		4: "3650", 
		5: "4907",
		6: "5014",
		7: "6128",
		8: "7843",
		9: "8439",
		10: "9276"
	}

func _ready() -> void:
	Global.game_settings["ModSkin"] = false
	Global.game_settings["ModEye"] = false
	Global.game_settings["ModScar"] = false
	Global.game_settings["ModTraps"] = false
	Global.game_settings["ModHard"] = false
	Global.game_settings["ModSeason"] = false
	Global.game_settings["HP"] = 6
	Global.game_settings["preset"] = randi() % 5 + 1
	print("Preset: ", Global.game_settings["preset"])
	var password_key = Global.game_settings["preset"] * (randi() % 2 + 1)
	Global.game_settings["password"] = password_option[password_key]
	print("Password: ", Global.game_settings["password"])

func handle_interaction(object_name: String):
	match object_name:
		"skin":
			if !Global.game_settings["ModSkin"]: 
				$ModSkin/Node3D/Sprite3D.texture = preload("res://chapter2/assets/ModIcon/Mod1_1.png")
			else:
				$ModSkin/Node3D/Sprite3D.texture = preload("res://chapter2/assets/ModIcon/Mod1_0.png")
			Global.game_settings["ModSkin"] = !Global.game_settings["ModSkin"]
		"season":
			if !Global.game_settings["ModSeason"]: 
				$ModEye/Node3D/Sprite3D.texture = preload("res://chapter2/assets/ModIcon/Mod2_1.png")
			else:
				$ModEye/Node3D/Sprite3D.texture = preload("res://chapter2/assets/ModIcon/Mod2_0.png")
			Global.game_settings["ModSeason"] = !Global.game_settings["ModSeason"]
		"enemy":
			if !Global.game_settings["ModScar"]: 
				$ModScar/Node3D/Sprite3D.texture = preload("res://chapter2/assets/ModIcon/Mod3_1.png")
			else:
				$ModScar/Node3D/Sprite3D.texture = preload("res://chapter2/assets/ModIcon/Mod3_0.png")
			Global.game_settings["ModScar"] = !Global.game_settings["ModScar"]
			Global.game_settings["ModEye"] = Global.game_settings["ModScar"]
		"Traps":
			if !Global.game_settings["ModTraps"]: 
				$ModTraps/Node3D/Sprite3D.texture = preload("res://chapter2/assets/ModIcon/Mod6_1.png")
			else:
				$ModTraps/Node3D/Sprite3D.texture = preload("res://chapter2/assets/ModIcon/Mod6_0.png")
			Global.game_settings["ModTraps"] = !Global.game_settings["ModTraps"]
		"hard":
			if !Global.game_settings["ModHard"]: 
				$Modhard/Node3D/Sprite3D.texture = preload("res://chapter2/assets/ModIcon/Mod7_1.png")
				$Player.DarkHardMod(true)
			else:
				$Modhard/Node3D/Sprite3D.texture = preload("res://chapter2/assets/ModIcon/Mod7_0.png")
				$Player.DarkHardMod(false)
			Global.game_settings["ModHard"] = !Global.game_settings["ModHard"]
		_:
			print("Unknown interaction: ", object_name)


func _on_kill_zona_body_entered(body: Node3D) -> void:
	print("item killZona!!!")
	print(body)
	body.global_position = Vector3(0, 0, 0)
