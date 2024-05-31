extends Node

class_name Frankie

var sprite: Sprite2D;
const expression_paths: Dictionary = {
	"happy": "res://Textures/happy.png",
	"sad": "res://Textures/sad.png",
	"mad": "res://Textures/mad.png"
};

func _ready():
	sprite = $Sprite;

func set_expression(expression: String):
	if(!expression_paths.has(expression)):
		printerr("EXPRESSION DOES NOT EXIST");
		return;
	sprite.texture = load(expression_paths[expression]);
