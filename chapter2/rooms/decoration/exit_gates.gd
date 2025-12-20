extends Node3D

func handle_interaction(object_name: String):
	match object_name:
		"boards":
			if $Sprite3D.visible == true:
				if Global.game_settings["Item"] == "scrap":
					$InteractableObject.remove_from_group("progressive_interactive")
					$Sprite3D.visible = false
					get_node("/root/GlobalMain/NavigationRegion3D/outdoors/StreetWall/InteractableObject").position = Vector3(1.187, 2.793, 2.37)
		"scute":
			if Global.game_settings["Item"] == "WireCutters":
				$scute.queue_free()
				$scute2.visible = true
				Global.game_settings["doorExit"] += 1
				$InteractableObject2.queue_free()
