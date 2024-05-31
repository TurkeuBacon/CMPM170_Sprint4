class_name Dialogue

var text_segments: Array;
var text_speeds: Array;
var in_progress: bool;
var displaying_dialogue: bool;

func _init(text_segments, text_speeds):
	self.text_segments = text_segments;
	self.text_speeds = text_speeds;
	self.in_progress = false;

func start_dialogue(textbox: TextBox, speed: float):
	textbox.display_text(text_segments[0], speed);

func advance_dialogue():
	if(displaying_dialogue):
		pass
	else:
		pass
