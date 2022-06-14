extends Node

const CONTROLLER_ASSIGNMENT_BUTTONS = [JOY_BUTTON_0, JOY_START]
const CONTROLLER_UNASSIGNMENT_BUTTONS = [JOY_BUTTON_1]

onready var input = get_parent()

func assign_controllers():
	for controller_id in input.controller_ids:
		if not controller_id in input.assigned_controller_ids:
			for assignment_button in CONTROLLER_ASSIGNMENT_BUTTONS:
				if Input.is_joy_button_pressed(controller_id, assignment_button):
					input.assigned_controller_ids.append(controller_id)

					print("controller ", controller_id, " assigned to player array ", input.assigned_controller_ids)

func unassign_controllers():
	for controller_id in input.assigned_controller_ids:
		for unassignment_button in CONTROLLER_UNASSIGNMENT_BUTTONS:
			if Input.is_joy_button_pressed(controller_id, unassignment_button):
				input.assigned_controller_ids.erase(controller_id)

				print("controller ", controller_id, " removed from player array ", input.assigned_controller_ids)
