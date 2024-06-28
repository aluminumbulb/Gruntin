extends Node3D

@onready var animator:=$"AnimationPlayer"
var mouse_vel:=0.0

@export var sens_min:=400.0
@export var sens_max:=600.0
var sensitivity:=0.0
var sens_percentage:=0.0

var anim_point:=0.0
@export var anim_thresh:=1.0
	
# Called when the node enters the scene tree for the first time.
func _ready():
	animator.play("FiddleAction")
	set_sensitivity()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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
		print(mouse_vel)

func strike():
	pass

#coming from gameplay_controlls' slider
func _on_h_slider_value_changed(value):
	sens_percentage = value/100
	set_sensitivity()
	

func set_sensitivity():
	sensitivity = sens_min + (sens_max - sens_min)*sens_percentage
	print("new sensitivity: %s" % sensitivity)
	
