extends Node3D
class_name StobAndFiddle

@onready var animator:=$"AnimationPlayer" 
var mouse_vel:=0.0

@export var sens_min:=400.0
@export var sens_max:=600.0
var sensitivity:=0.0
var sens_percentage:=0.0

var anim_point:=0.0 #current point on animation track
@export var anim_thresh:=1.0 #minimum degree of movement to trigger effect

signal stob_struck
var active:=false

# Called when the node enters the scene tree for the first time.
func _ready():
	animator.play("FiddleAction")
	set_sensitivity()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	##stob and fiddle animation control
	if(abs(mouse_vel)>anim_thresh):	
		animator.play("FiddleAction", -1, mouse_vel)
	else:
		animator.pause()
	
	#stopping the animation at the "bottom end point"
	if(animator.current_animation_position==animator.current_animation_length
		and animator.get_playing_speed()>0
	):
		animator.pause()

	#same as above but reversed
	elif (animator.current_animation_position==0
		and animator.get_playing_speed()<0):
			animator.pause()

func _input(event):
	if event is InputEventMouseMotion:
		mouse_vel = event.velocity.y*(1/sensitivity)#recip chosen for readability
		#print(mouse_vel)

##function called whenever the stob would create a noise
func strike():
	if(is_visible_in_tree()): #stop strike from triggering if not vis
		stob_struck.emit()

#coming from gameplay_controlls' slider
func _on_h_slider_value_changed(value):
	sens_percentage = value/100
	set_sensitivity()

##helper function to caluclate sensitivity of fiddle
func set_sensitivity():
	sensitivity = sens_min + (sens_max - sens_min)*sens_percentage
