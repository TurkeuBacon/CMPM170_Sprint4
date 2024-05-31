extends Node

class_name DialogueManager

var test_dialogue: Dialogue;
var textbox: TextBox;
var frankie: Frankie;

func _ready():
	textbox = $"../Textbox";
	frankie = $"../Frankie";
	test_dialogue = Dialogue.new(
		["This is the first line of dialogue", "This is the second line of dialogue", "This is the third line of dialogue"],
		[0.1, 0.1, 0.1],
		["happy", "sad", "mad"]);
	test_dialogue.start_dialogue(textbox, frankie);

func _input(event):
	if event.is_action_pressed("Click"):
		test_dialogue.advance_dialogue();
