extends KinematicBody


var vel = Vector3(0,0,0)
var accel = 0
var last_trans = translation
const sp = 300
const leg_force= 500
const forward_jump = 300

const gravity = -981



func get_translation_delta():
	var delta = last_trans - translation
	last_trans = translation
	return delta

func _ready():
	pass

func _process(delta):
	move_and_slide(vel*delta, Vector3(0, 1, 0), false, 4, 0.785398, true)
	
func _physics_process(delta):
	if Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_left"):
		vel.x = 0
	elif Input.is_action_pressed("ui_right"):
		vel.x = sp
		$walking.play("walking")
	elif Input.is_action_pressed("ui_left"):
		vel.x = -sp
	else:
		vel.x = lerp(vel.x,0,0.1)
	
	if Input.is_action_pressed("ui_up") and Input.is_action_pressed("ui_down"):
		vel.y=0
	elif Input.is_action_pressed("ui_up") and is_on_floor():
		accel = leg_force
	else:
		vel.y = lerp(vel.z,0,0.1)
	
	if get_translation_delta().y == 0:
		accel = 0
	 
	accel += gravity*delta
	vel.y += accel

