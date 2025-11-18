extends StaticBody3D

func handle_interaction(object_name: String):
	match object_name:
		"2":
			print(2)
			if $wall3/Door.disabled:
				$AnimationPlayer.play("close")
		"1":
			print(1)
			if $wall3/Door.disabled:
				$AnimationPlayer.play("close")
		"0":
			print(0)
			if $wall3/Door.disabled:
				$AnimationPlayer.play("close")
		"open":
			if !$wall3/Door.disabled:
				$AnimationPlayer.play("open")
			else:
				$AnimationPlayer.play("close")
