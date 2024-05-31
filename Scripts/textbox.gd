extends Node

class_name TextBox

var backing: Sprite2D;
var text_display: Label;

# Called when the node enters the scene tree for the first time.
func _ready():
	backing = $TextBackground;
	text_display = $TextBackground/TextDisplay;
	display_text("This is sample text", 0.1);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func display_text(text, speed) -> void:
	text_display.text = "";
	for character in text:
		text_display.text += character;
		if(character != " "):
			await get_tree().create_timer(speed).timeout
