extends StaticBody3D

@export var elevator_id: String = "main_floor"
@export var destination_floors = {
	"0": "basement",
	"1": "main_floor", 
	"2": "attic"
}
var IsTeleporting = false

func handle_interaction(object_name: String):
	match object_name:
		"0", "1", "2":
			if !IsTeleporting:
				IsTeleporting = true
				if $wall3/Door.disabled:
					$AnimationPlayer.play("close")
				animate_button(object_name)
				teleport_player(object_name)
		"open":
			animate_button(object_name)
			if !$wall3/Door.disabled:
				$AnimationPlayer.play("open")
			else:
				$AnimationPlayer.play("close")

func animate_button(button_name: String):
	match button_name:
		"0":
			$board/MeshInstance3D6.position.y = 0.349
			await get_tree().create_timer(1.0).timeout
			$board/MeshInstance3D6.position.y = 0.589
		"1":
			$board/MeshInstance3D5.position.y = 0.349
			await get_tree().create_timer(1.0).timeout
			$board/MeshInstance3D5.position.y = 0.589
		"2":
			$board/MeshInstance3D4.position.y = 0.349
			await get_tree().create_timer(1.0).timeout
			$board/MeshInstance3D4.position.y = 0.589
		"open":
			$board2/MeshInstance3D5.position.y = 0.349
			$board3/MeshInstance3D5.position.y = 0.349
			await get_tree().create_timer(1.0).timeout
			$board2/MeshInstance3D5.position.y = 0.589
			$board3/MeshInstance3D5.position.y = 0.589

func teleport_player(floor_number: String):
	var player = get_tree().get_first_node_in_group("player")
	if player and destination_floors.has(floor_number):
		await get_tree().create_timer(1).timeout
		player.AnimationPlayPlayer("BlackOut")
		await get_tree().create_timer(0.25).timeout
		var target_elevator_id = destination_floors[floor_number]
		var target_elevator = find_elevator_by_id(target_elevator_id)
		if target_elevator and target_elevator.has_node("Marker3D"):
			var target_marker = target_elevator.get_node("Marker3D")
			player.global_position = target_marker.global_position
			IsTeleporting = false
			print("Телепортация к лифту: ", target_elevator_id)
		else:
			print("Ошибка: лифт с ID '", target_elevator_id, "' не найден!")
		
func find_elevator_by_id(target_id: String) -> StaticBody3D:
	var elevators = get_tree().get_nodes_in_group("elevators")
	for elevator in elevators:
		if elevator.elevator_id == target_id:
			return elevator
	return null
