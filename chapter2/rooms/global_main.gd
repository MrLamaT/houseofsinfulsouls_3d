extends Node3D

var painting = 0

func _ready() -> void:
	$Player.startSpreedrun()
	$Player.PlayerDeath(-1)
	$NavigationRegion3D/Living/Label3D.text = Global.game_settings["password"].substr(0, 2) + "??"
	setup_seasonal_materials()
	var env_scene = preload("res://chapter2/sky/skybox.tscn")
	var env_instance = env_scene.instantiate()
	add_child(env_instance)

func setup_seasonal_materials():
	# Получаем текущую дату
	var now = Time.get_datetime_dict_from_system()
	var month = now["month"]
	var day = now["day"]
	var material = StandardMaterial3D.new()
	if (month == 12 and day >= 10) or (month == 1 and day <= 10):
		material.albedo_color = Color("c2c4d0")
	else:
		material.albedo_color = Color("323f18")
		$NavigationRegion3D/outdoors/GPUParticles3D.queue_free()
		$NavigationRegion3D/outdoors/GPUParticles3D2.queue_free()
		$NavigationRegion3D/outdoors/GPUParticles3D3.queue_free()
		$NavigationRegion3D/outdoors2/GPUParticles3D4.queue_free()
	material.roughness = 0.8  
	material.metallic = 0.0   
	if $NavigationRegion3D/floor_ceiling/dirt/CSGCombiner3D/CSGBox3D:
		$NavigationRegion3D/floor_ceiling/dirt/CSGCombiner3D/CSGBox3D.material = material
	else:
		push_error("CSGBox3D не найден!")
	if $NavigationRegion3D/floor_ceiling/dirt2/CSGCombiner3D/CSGBox3D:
		$NavigationRegion3D/floor_ceiling/dirt2/CSGCombiner3D/CSGBox3D.material = material
	else:
		push_error("CSGBox3D не найден!")

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
		"SpiderDoor":
			if Global.game_settings["Item"] == "battery":
				$Player.clear_item()
				$NavigationRegion3D2/basement/SpiderDoor/Sprite3D.visible = true
				$NavigationRegion3D2/basement/SpiderDoor/InteractableObject2.queue_free()
				$NavigationRegion3D2/basement/SpiderDoor/StaticBody3D/CollisionShape3D.queue_free()
				$NavigationRegion3D2/basement/SpiderDoor/AnimationPlayer.play("spider")
		"book":
			if Global.game_settings["Item"] == "book":
				$Player.clear_item()
				$NavigationRegion3D/barn/BookTable/Sprite3D.visible = true
				$NavigationRegion3D/barn/InteractableObject.queue_free()
				$NavigationRegion3D/barn/StaticBody3D/CollisionShape3D.queue_free()
				$NavigationRegion3D/barn/AnimationPlayer.play("book")
