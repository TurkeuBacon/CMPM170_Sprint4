extends Node

class_name TextBox

var cancel_typing_flag: bool;
var backing: Sprite2D;
var text_display: Label;

func _ready():
	cancel_typing_flag = false;
	backing = $TextBackground;
	text_display = $TextBackground/TextDisplay;
	
func type_text(text, speed, completion_callback: Callable) -> void:
	text_display.text = "";
	if(speed <= 0):
		speed = 0.000001;
	for character in text:
		if(cancel_typing_flag):
			cancel_typing_flag = false;
			return;
		text_display.text += character;
		if(character != " "):
			await get_tree().create_timer(1/speed).timeout
	completion_callback.call();

func force_text(text) -> void:
	cancel_typing_flag = true;
	text_display.text = text;


