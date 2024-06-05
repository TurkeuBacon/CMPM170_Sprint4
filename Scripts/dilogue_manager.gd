extends Node

class_name DialogueManager

@export var json_folder_path: String;
@export var initial_scene: String;
var dialogue_jsons: Dictionary;

var dialogues: Dictionary;
var current_dialogue: Dialogue;
var showing_options: bool;
var current_options: Array;
var textbox: TextBox;
var textDisplay: Label;
var optionsScroll: ScrollContainer;
var optionsArea: VBoxContainer;
var frankie: Frankie;
var background: Sprite2D;

func _ready():
	textbox = $"../Textbox";
	frankie = $"../Frankie";
	background = $"../background";
	textDisplay = $"../Textbox/TextBackground/TextDisplay";
	optionsScroll = $"../Textbox/TextBackground/OptionsScrollArea";
	optionsArea = $"../Textbox/TextBackground/OptionsScrollArea/OptionsLayout";
	
	dialogue_jsons = {};
	for json_name in DirAccess.get_files_at(json_folder_path):
		var json_path = json_folder_path + json_name;
		var file = FileAccess.open(json_path, FileAccess.READ);
		var json_string = file.get_as_text();
		var json = JSON.new()
		json.parse(json_string);
		var json_key = json_name.substr(0, json_name.length()-5);
		print(json_key);
		dialogue_jsons[json_key] = json;
	
	current_dialogue = load_dialogue_json(dialogue_jsons.get(initial_scene));
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
	if(key.substr(0, 7).to_lower() == "scene: " || key.to_lower() == "end"):
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
		var next_name = current_dialogue.next_dialogue[0];
		goto_next(next_name);
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
			showing_options = false;
			textDisplay.visible = true;
			optionsScroll.visible = false;
			clear_options();
			goto_next(optionNext);
		);
		optionsArea.add_child(optionButton);

func goto_next(next: String):
	if(next.to_lower() == "end"):
		return;
	if(next.substr(0, 7).to_lower() == "scene: "):
		current_dialogue = load_dialogue_json(dialogue_jsons[next.substr(7)]);
	else:
		current_dialogue = dialogues.get(next);
	current_dialogue.start_dialogue(textbox, frankie);

func clear_options():
	if(current_options != null):
		for button in current_options:
			button.queue_free();
		current_options.clear();
