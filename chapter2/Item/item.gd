extends RigidBody3D

@export var item_texture: Texture2D
@export var item_preset: int = 0
@onready var audio_player = $AudioStreamPlayer3D

func _ready():
	if item_preset != 0 and item_preset != Global.game_settings["preset"]:
		queue_free()
	$MeshInstance3D.queue_free()
	create_item_mesh()

func create_item_mesh():
	# Основной меш
	var mesh_instance = MeshInstance3D.new()
	var plane_mesh = PlaneMesh.new()
	plane_mesh.size = Vector2(1, 1)
	var material = StandardMaterial3D.new()
	material.albedo_texture = item_texture
	material.flags_transparent = true
	material.params_cull_mode = StandardMaterial3D.CULL_DISABLED
	material.texture_filter = BaseMaterial3D.TEXTURE_FILTER_NEAREST
	mesh_instance.mesh = plane_mesh
	mesh_instance.material_override = material
	add_child(mesh_instance)

func _on_body_entered(body):
	if (body is StaticBody3D or body is RigidBody3D or body is CharacterBody3D) and linear_velocity.length() > 1:
		play_collision_sound()

func play_collision_sound():
	var targets = get_tree().get_nodes_in_group("enemy_targets1")
	if targets.size() > 0:
		var current_target = targets[0]
		current_target.global_position = global_position
		current_target.timeStart()
	audio_player.pitch_scale = randf_range(0.9, 1.1)
	audio_player.play()

func _on_mouse_entered() -> void:
	pass # Replace with function body.

func _on_mouse_exited() -> void:
	pass # Replace with function body.
