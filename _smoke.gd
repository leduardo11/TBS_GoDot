extends Node

func _ready():
	call_deferred("run_smoke")

func run_smoke():
	var intro = load("res://Scenes/Intro Screen/Intro Screen.tscn").instantiate()
	get_tree().root.add_child(intro)
	get_tree().current_scene = intro
	await get_tree().create_timer(0.5).timeout
	intro.current_option = "New Game"
	intro.process_selection()

	# Wait for world map event to start showing dialogue
	await get_tree().create_timer(3.0).timeout
	print("SMOKE: world map visible = ", WorldMapScreen.visible)

	# Advance the dialogue by feeding accept presses
	for i in range(30):
		await get_tree().create_timer(0.5).timeout
		var ev = InputEventAction.new()
		ev.action = "ui_accept"
		ev.pressed = true
		Input.parse_input_event(ev)
		await get_tree().process_frame
		var ev2 = InputEventAction.new()
		ev2.action = "ui_accept"
		ev2.pressed = false
		Input.parse_input_event(ev2)
		if get_tree().current_scene != null and get_tree().current_scene.name != "Intro Screen":
			print("SMOKE: scene changed to ", get_tree().current_scene.name, " at press ", i)
			break

	await get_tree().create_timer(6.0).timeout
	print("SMOKE: current scene = ", get_tree().current_scene)
	print("SMOKE: level_container = ", BattlefieldInfo.level_container)
	print("SMOKE: current_level = ", BattlefieldInfo.current_level)
	print("SMOKE: ally units = ", BattlefieldInfo.ally_units.keys())
	print("SMOKE: enemy units count = ", BattlefieldInfo.enemy_units.size())
	get_tree().quit()
