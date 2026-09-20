extends "res://Scenes/Events/Event Base.gd"

class_name L3_Event_Part30

# Dialogue between the characters
var dialogue = [
	"Mage@assets/units/enemyPortrait/red soldier portrait.png@Shut up you dumb pirates!",
	"Mage@assets/units/enemyPortrait/red soldier portrait.png@You better capture her alive!"
]

func _init():
	event_name = "Level 4 Before battle"
	event_part = "Part 3"
	path = "res://Scenes/Events/Level 3/L3 Event Part 30.gd"

func start():
	# Register to the dialogue system
	BattlefieldInfo.message_system.connect("no_more_text", Callable(self, "move_camera_2"))
	
	BattlefieldInfo.message_system.set_position(Messaging_System.TOP)
	
	move_camera()

func move_camera():
	# New Position
	var new_position_for_camera = Vector2(0, 192)
	
	# Move Camera and Remove old camera
	var tween = BattlefieldInfo.main_game_camera.create_tween()
	tween.tween_property(BattlefieldInfo.main_game_camera, "position", new_position_for_camera, 1.0).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.finished.connect(Callable(self, "enable_text_no_array"))

func move_camera_2():
	# New Position
	var new_position_for_camera = Vector2(128, 0)
	
	# Move Camera and Remove old camera
	var tween = BattlefieldInfo.main_game_camera.create_tween()
	tween.tween_property(BattlefieldInfo.main_game_camera, "position", new_position_for_camera, 1.0).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.finished.connect(Callable(self, "event_complete"))

func enable_text_no_array():
	BattlefieldInfo.message_system.start(dialogue)
