extends Node

const INPUT_AXIS_LEFT = Vector2(JOY_ANALOG_LX, JOY_ANALOG_LY)
const INPUT_BUTTON_X = JOY_BUTTON_2

var id = -1
var axis_left = Vector2.ZERO

var x_button = {"pressed":false, "just_pressed":false}

func _process(delta):
	axis_left = Vector2(Input.get_joy_axis(id, INPUT_AXIS_LEFT.x),\
			Input.get_joy_axis(id, INPUT_AXIS_LEFT.y))
	
	x_button = update_button(x_button, INPUT_BUTTON_X)

func update_button(button, BUTTON):
	var pressed_new = Input.is_joy_button_pressed(id, BUTTON)
	
	var just_pressed = false
	if pressed_new and not button.pressed:
		just_pressed = true
	
	return {"pressed":pressed_new, "just_pressed":just_pressed}
