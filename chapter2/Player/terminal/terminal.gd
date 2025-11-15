extends Node2D

var messages := []
var command_args := {}

var system_color := Color("e6d91aff")
var user_color := Color("00ef00")

@onready var chat_panel = $Panel
@onready var chat_text = $Panel/RichTextLabel
@onready var input_box = $LineEdit
@onready var send_button = $Button

var player: CharacterBody3D
var cheat_mod: bool = false

func _ready():
	SystemPrint("The system is running")


func SystemPrint(text: String):
	chat_text.push_color(system_color)
	chat_text.add_text("[SYSTEM] " + text + "\n")
	chat_text.pop()


func UserPrint(text: String):
	chat_text.push_color(user_color)
	chat_text.add_text("[YOU] " + text + "\n")
	chat_text.pop()


func _on_send_pressed(_arg = null):
	var text = input_box.text.strip_edges()

	if text == "":
		return

	input_box.text = ""
	UserPrint(text)

	parse_command(text)


func parse_command(text: String):
	var parts = text.split(" ")
	var command = parts[0].to_lower()
	var argument = ""
	if parts.size() > 1:
		argument = parts[1]

	command_args[command] = argument

	match command:
		"cheat":
			if argument != "":
				if argument == "ON":
					SystemPrint("Cheats included")
					SystemPrint("Available commands:")
					SystemPrint("• ghost - Walk through walls")
					SystemPrint("• teleport - Teleport to coordinates 0 0 0")
					SystemPrint("• give [item] - Get item (specify item name)")
					SystemPrint("• godmode - Enable immortality")
				player = get_tree().get_first_node_in_group("player")
				player.cheat_check()
				cheat_mod = true
			else:
				SystemPrint("Enter an argument")
		"ghost":
			if cheat_mod:
				SystemPrint("Ghost mode has been changed")
				player = get_tree().get_first_node_in_group("player")
				player.ghost_cheat()
			else:
				SystemPrint("No rights")
		"teleport":
			if cheat_mod:
				player = get_tree().get_first_node_in_group("player")
				player.global_position = Vector3(0, 0, 0)
			else:
				SystemPrint("No rights")
		_:
			SystemPrint("Unknown command: " + command)
