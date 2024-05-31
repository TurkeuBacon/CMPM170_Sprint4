extends Node

class_name DialogueManager

var test_dialogue: Dialogue;
var textbox: TextBox;

func _ready():
	textbox = $"../Textbox";
	test_dialogue = Dialogue.new(["This is the first line of dialogue", "This is the second line of dialogue", "This is the third line of dialogue"], [0.1, 0.1, 0.1]);
	test_dialogue.start_dialogue(textbox);
	
func _input(event):
	if event.is_action_pressed("Click"):
		test_dialogue.advance_dialogue();
