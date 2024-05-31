class_name Dialogue

var text_segments: Array;
var text_speeds: Array;
var in_progress: bool;
var typing_text: bool;
var current_textbox: TextBox;
var dialogue_index: int;
var line_finish_callback = Callable(self, "line_finish");

func _init(text_segments, text_speeds):
	self.text_segments = text_segments;
	self.text_speeds = text_speeds;
	self.in_progress = false;
	self.typing_text = false;

func start_dialogue(textbox: TextBox):
	dialogue_index = 0;
	current_textbox = textbox;
	textbox.type_text(text_segments[dialogue_index], text_speeds[dialogue_index], line_finish_callback);
	typing_text = true;

func advance_dialogue():
	if(typing_text):
		current_textbox.force_text(text_segments[dialogue_index]);
		typing_text = false;
	else:
		dialogue_index += 1;
		if(dialogue_index < text_segments.size()):
			typing_text = true;
			current_textbox.type_text(text_segments[dialogue_index], text_speeds[dialogue_index], line_finish_callback);
		else:
			in_progress = false;

func line_finish():
	typing_text = false;
