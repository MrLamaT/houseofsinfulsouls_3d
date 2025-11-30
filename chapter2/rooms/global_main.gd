extends Node3D

var painting = 0

func _ready() -> void:
	$Player.startSpreedrun()
	$Player.PlayerDeath(-1)
	$NavigationRegion3D/Living/Label3D.text = Global.game_settings["password"].substr(0, 2) + "??"

func _on_kill_zona_body_entered(body: Node3D) -> void:
	print("item killZona!!!")
	print(body)
	body.global_position = Vector3(0, 1, 0)

func handle_interaction(object_name: String):
	match object_name:
		"painting":
			$NavigationRegion3D/PlayerRoom/board.queue_free()
			$NavigationRegion3D/PlayerRoom/InteractableObject.queue_free()
			$Player.interaction_manager.pick_up_item($NavigationRegion3D/PlayerRoom/Item1)
		"painting2":
			$NavigationRegion3D/Living/board5.queue_free()
			$NavigationRegion3D/Living/InteractableObject.queue_free()
			$Player.interaction_manager.pick_up_item($NavigationRegion3D/Living/Item)
		"GIVEpainting":
			if Global.game_settings["Item"] == "painting2":
				$Player.clear_item()
				$NavigationRegion3D/cabinet/board2.visible = true
				$NavigationRegion3D/cabinet/InteractableObject2.queue_free()
				painting += 1
				if painting > 1:
					$NavigationRegion3D/cabinet/Opendoors2.trigger_interaction()
		"GIVEpainting2":
			if Global.game_settings["Item"] == "painting":
				$Player.clear_item()
				$NavigationRegion3D/cabinet/board3.visible = true
				$NavigationRegion3D/cabinet/InteractableObject.queue_free()
				painting += 1
				if painting > 1:
					$NavigationRegion3D/cabinet/Opendoors2.trigger_interaction()
		"basementDoorExit":
			$Player.AnimationPlayPlayer("BlackOut")
			await get_tree().create_timer(0.25).timeout
			$Player.global_position = Vector3(0, 0, 2)
		"SpiderDoor":
			if Global.game_settings["Item"] == "battery":
				$Player.clear_item()
				$NavigationRegion3D2/basement/SpiderDoor/Sprite3D.visible = true
				$NavigationRegion3D2/basement/SpiderDoor/InteractableObject2.queue_free()
				$NavigationRegion3D2/basement/SpiderDoor/StaticBody3D/CollisionShape3D.queue_free()
				$NavigationRegion3D2/basement/SpiderDoor/AnimationPlayer.play("spider")
