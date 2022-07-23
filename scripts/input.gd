extends Node

const CONTROLLER = preload("../scenes/controller.tscn")

const CONTROLLER_ASSIGNMENT_BUTTONS = [JOY_BUTTON_0, JOY_START]
const CONTROLLER_UNASSIGNMENT_BUTTONS = [JOY_BUTTON_1]

var controllers = []
var controller_ids = []
# 
var assigned_controller_ids = []

func _process(delta):
	update_connected_controllers()
	
	assign_controllers()
	unassign_controllers()

func update_connected_controllers():
	if controller_ids != Input.get_connected_joypads():
		var new_controller_ids = Input.get_connected_joypads()
		
		var index = 0
		
		# add controllers
		for controller_id in new_controller_ids:
			if not controller_id in controller_ids:
				controller_ids.insert(index, controller_id)
				
				var new_controller = CONTROLLER.instance()
				add_child(new_controller)
				new_controller.id = controller_id
				
				if controllers.size() - 1 < new_controller_ids.back():
					controllers.append(new_controller)
				else:
					controllers[index] = new_controller
				
				print("new controller id ", controller_id, " in array ", controller_ids, ", node ", new_controller, " in array ", controllers)
			index += 1
		
		index = 0
		
		# remove controllers
		for controller_id in controller_ids:
			if not controller_id in new_controller_ids:
				if controller_id in assigned_controller_ids:
					assigned_controller_ids.erase(controller_id)
					print("removed controller ", controller_id, " from player array ", assigned_controller_ids)
				
				controller_ids.erase(controller_id)
				
				var removed_controller = controllers[index]
				controllers[index] = null
				removed_controller.queue_free()
				
				print("removed controller id ", controller_id, " from array ", controller_ids, ", node ", removed_controller, " from array ", controllers)
			index += 1

func assign_controllers():
	for controller_id in controller_ids:
		if not controller_id in assigned_controller_ids:
			for assignment_button in CONTROLLER_ASSIGNMENT_BUTTONS:
				if Input.is_joy_button_pressed(controller_id, assignment_button):
					assigned_controller_ids.append(controller_id)
					
					print("assigned controller ", controller_id, " to player array ", assigned_controller_ids)

func unassign_controllers():
	for controller_id in assigned_controller_ids:
		for unassignment_button in CONTROLLER_UNASSIGNMENT_BUTTONS:
			if Input.is_joy_button_pressed(controller_id, unassignment_button):
				assigned_controller_ids.erase(controller_id)
				
				print("removed controller ", controller_id, " from player array ", assigned_controller_ids)
