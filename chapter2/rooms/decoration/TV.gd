extends Area3D

@onready var TV = false

func trigger_interaction():
	if !TV:
		TV = true
		$AudioStreamPlayer.play()
		$StaticBody3D/Sprite3D.visible = true
		var targets = get_tree().get_nodes_in_group("enemy_targets2")
		if targets.size() > 0:
			var current_target = targets[0]
			current_target.global_position = global_position
			current_target.timeStart()
		await get_tree().create_timer(6).timeout
		$StaticBody3D/Sprite3D.visible = false
		$AudioStreamPlayer.stop()
		TV = false

func _on_mouse_entered() -> void:
	if !TV:
		$Label3D.visible = true
		$DoorE.visible = true


func _on_mouse_exited() -> void:
	$Label3D.visible = false
	$DoorE.visible = false
