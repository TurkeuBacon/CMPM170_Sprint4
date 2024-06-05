extends Node

class_name DialogueManager

@export var dialogue_json: JSON;

var dialogues: Dictionary;
var current_dialogue: Dialogue;
var showing_options: bool;
var current_options: Array;
var textbox: TextBox;
var textDisplay: Label;
var optionsScroll: ScrollContainer;
var optionsArea: VBoxContainer;
var frankie: Frankie;

func _ready():
	textbox = $"../Textbox";
	frankie = $"../Frankie";
	textDisplay = $"../Textbox/TextBackground/TextDisplay";
	optionsScroll = $"../Textbox/TextBackground/OptionsScrollArea";
	optionsArea = $"../Textbox/TextBackground/OptionsScrollArea/OptionsLayout";
	current_dialogue = load_dialogue_json(dialogue_json);
	showing_options = false;
	if(current_dialogue != null):
		current_dialogue.start_dialogue(textbox, frankie);

func _input(event):
	if event.is_action_pressed("Click"):
		if(current_dialogue != null):
			current_dialogue.advance_dialogue();
			if(!current_dialogue.in_progress && !showing_options):
				show_options();

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

func show_options():
	if(current_dialogue.options.size() == 0):
		current_dialogue = dialogues.get(current_dialogue.next_dialogue[0]);
		current_dialogue.start_dialogue(textbox, frankie);
		return;
	showing_options = true;
	textDisplay.visible = false;
	optionsScroll.visible = true;
	for i in range(current_dialogue.options.size()):
		var optionText = current_dialogue.options[i];
		var optionNext = current_dialogue.next_dialogue[i];
		var optionButton = Button.new();
		current_options.push_back(optionButton);
		optionButton.text = optionText;
		optionButton.pressed.connect(func selectOption():
			current_dialogue = dialogues.get(optionNext);
			showing_options = false;
			textDisplay.visible = true;
			optionsScroll.visible = false;
			current_dialogue.start_dialogue(textbox, frankie);
			for button in current_options:
				button.queue_free();
		);
		optionsArea.add_child(optionButton);

func clear_options():
	if(current_options != null):
		current_options.clear();
