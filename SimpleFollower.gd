extends PathFollow3D
class_name MainCharacter

@export var follow_speed:=10.0
@export var rel_stick_loc: Vector3

@onready var stick = $"GruntingStick"
#@onready var cam  = $"Camera3D"

var is_grunting:=false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("crawl") and not is_grunting:
		progress += delta * follow_speed
		
	if Input.is_action_just_pressed("grunt_activation"):
		#begin grunting
		is_grunting = true
		#place grunting stick on location (decided in export)
		stick.position = rel_stick_loc
		#camera should focus on stick, saving that for way later
		stick.visible = true
		

	if Input.is_action_just_released("grunt_activation"):
		is_grunting = false
		stick.visible = false
		#remove grunting stick
