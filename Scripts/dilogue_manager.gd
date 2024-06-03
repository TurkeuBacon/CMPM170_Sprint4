extends Node

class_name DialogueManager

@export var dialogue_json: JSON;

var dialogues: Dictionary;
var current_dialogue: Dialogue;
var textbox: TextBox;
var frankie: Frankie;

func _ready():
	textbox = $"../Textbox";
	frankie = $"../Frankie";
	current_dialogue = load_dialogue_json(dialogue_json);
	if(current_dialogue != null):
		current_dialogue.start_dialogue(textbox, frankie);

func _input(event):
	if event.is_action_pressed("Click"):
		if(current_dialogue != null):
			current_dialogue.advance_dialogue();

func load_dialogue_json(json: JSON) -> Dialogue:
	dialogues = {};
	var initial_dialogue_name = json.data.initial_dialogue;
	add_dialogue(initial_dialogue_name, json.data);
	return dialogues[initial_dialogue_name];

func add_dialogue(key: String, json_data):
	if(key.substr(0, 3).to_lower() == "end"):
		return;
	var entry = json_data[key];
	var next_dialogues = entry.next_dialogue;
	dialogues[key] = Dialogue.new(
		entry.lines,
		entry.speeds,
		entry.expressions,
		entry.options,
		next_dialogues
	);
	for next_dialogue in next_dialogues:
		if(!dialogues.has(next_dialogue)):
			add_dialogue(next_dialogue, json_data);
