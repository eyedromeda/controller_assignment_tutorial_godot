extends Node

const INPUT_AXIS_LEFT = Vector2(JOY_ANALOG_LX, JOY_ANALOG_LY)

var id = -1
var axis_left = Vector2.ZERO

var x_button_pressed = false
var x_button_just_pressed = false

func _process(delta):
	axis_left = Vector2(Input.get_joy_axis(id, INPUT_AXIS_LEFT.x),\
			Input.get_joy_axis(id, INPUT_AXIS_LEFT.y))
	
	update_buttons()

func update_buttons():
	update_x_button()

func update_x_button():
	var x_button_pressed_new = Input.is_joy_button_pressed(id, JOY_BUTTON_2)
	
	x_button_just_pressed = false
	if x_button_pressed_new && not x_button_pressed:
		x_button_just_pressed = true
	
	x_button_pressed = x_button_pressed_new
