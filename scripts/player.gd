extends Sprite

const UNASSIGNED_CONTROLLER = -1

export (int) var player_id = 0

var controller_id = UNASSIGNED_CONTROLLER
var controller
var move_input = Vector2.ZERO
var move_speed = 5

onready var engine = get_node("../../")
onready var input = engine.get_node("input")

func _process(delta):
	if input.assigned_controller_ids.size() - 1 >= player_id:
		controller_id = input.assigned_controller_ids[player_id]
		controller = input.controllers[controller_id]
	else:
		controller_id = UNASSIGNED_CONTROLLER
	
	get_input()
	
	position += move_input * move_speed
	
	update_labels()

func get_input():
	get_jump_input()
	get_move_input()

func get_jump_input():
	if controller_id != UNASSIGNED_CONTROLLER:
		if controller.x_button.just_pressed:
			position.y -= 50

func get_move_input():
	if controller_id == UNASSIGNED_CONTROLLER:
		move_input = Vector2.ZERO
	else:
		move_input = add_deadzone(controller.axis_left, 0.4)

func add_deadzone(vector, margin):
	if sqrt(pow(vector.x, 2) + pow(vector.y, 2)) < margin:
		return Vector2.ZERO
	else:
		return vector

func update_labels():
	$player_label.text = "Player " + str(player_id)
	if controller_id != UNASSIGNED_CONTROLLER:
		$controller_label.text = "Controller " + str(controller_id)
	else:
		$controller_label.text = ""
