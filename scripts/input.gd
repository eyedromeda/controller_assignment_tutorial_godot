extends Node

const CONTROLLER = preload("../scenes/controller.tscn")

var controllers = []
var controller_ids = []

var assigned_controller_ids = []

func _process(delta):
	update_connected_controllers()
	
	$controller_assignment.assign_controllers()
	$controller_assignment.unassign_controllers()

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
					print("controller ", controller_id, " removed from player array ", assigned_controller_ids)
				
				controller_ids.erase(controller_id)
				
				var removed_controller = controllers[index]
				controllers[index] = null
				removed_controller.queue_free()
				
				print("removed controller index ", index, " from array ", controller_ids, ", node ", removed_controller, " from array ", controllers)
			index += 1
