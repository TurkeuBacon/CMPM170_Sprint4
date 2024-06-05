extends Node

class_name Frankie

var sprite: Sprite2D;
const expression_paths: Dictionary = {
	"happy": "res://Textures/sprites/happy.png",
	"sad": "res://Textures/sprites/upset.png",
	"mad": "res://Textures/sprites/angry.png",
	"bored": "res://Textures/sprites/bored.png",
	"crying": "res://Textures/sprites/crying.png",
	"embarrassed": "res://Textures/sprites/embarrassed.png",
	"excited": "res://Textures/sprites/excited.png",
	"thinking": "res://Textures/sprites/thinking.png",
	"suprised": "res://Textures/sprites/suprised.png",
	"upset": "res://Textures/sprites/upset.png",
	"upsetTalk": "res://Textures/sprites/superTalk.png",
	"waving": "res://Textures/sprites/waving.png",
	"blushing": "res://Textures/sprites/blushing.png"
};

func _ready():
	sprite = $Sprite;

func set_expression(expression: String):
	if(!expression_paths.has(expression)):
		printerr("EXPRESSION DOES NOT EXIST");
		return;
	sprite.texture = load(expression_paths[expression]);
