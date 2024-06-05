extends Node

class_name pauseMenu

var pauseOverlay: Panel;
var pausedMenu: Panel;
var paused: bool;

# Called when the node enters the scene tree for the first time.
func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS;
	pauseOverlay = get_node("PauseOverlay");
	pausedMenu = get_node("PauseMenu");
	paused = false;
	pauseOverlay.visible = false;
	pausedMenu.visible = false;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	pass # Replace with function body.


func _on_texture_button_pressed():
	get_tree().paused = !paused;
	paused = !paused;
	pauseOverlay.visible = !pauseOverlay.visible;
	pausedMenu.visible = !pausedMenu.visible;


func _on_button_pressed():
	get_tree().paused = false;
	get_tree().change_scene_to_file("res://Scenes/menu_scene.tscn");
