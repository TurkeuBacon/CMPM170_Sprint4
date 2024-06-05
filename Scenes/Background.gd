extends Sprite2D


# Called when the node enters the scene tree for the first time.
const backgroundPaths: Dictionary = {
	"bookstore" : "res://Textures/background/bookstore.jpg",
	"boardwalk" : "res://Textures/background/boardwalk.jpg",
	"icecream" : "res://Textures/background/icecream.jpg",
	"movies" : "res://Textures/background/movies.jpg",
	"dorm" : "res://Textures/background/cowell-triple-photo.jpg",
	"mchenry" : "res://Textures/background/bora_UCSC_McHenryLibrary_09.jpg",
	"beach" : "res://Textures/background/california-santa-cruz-top-rated-beaches-main-beach.jpg",
	"antartica" : "res://Textures/background/meltwater pool courtesy alison banwell 1380px.png",
	"class" :"res://Textures/background/IMG_4347.jpg"
	
};

var sprite: Sprite2D;

func _ready():
	sprite = $"."

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_background(image: String):
	if(!backgroundPaths.has(image)):
		printerr("EXPRESSION DOES NOT EXIST");
		return;
	sprite.texture = load(backgroundPaths[image]);
