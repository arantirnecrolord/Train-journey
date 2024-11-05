@tool
extends Path3D

@export_range(0, 1000) var item_count = 1:
	set (value):
		item_count = value
		spawn_item()
	get:
		return item_count
		
func spawn_item():
	var offsets = []
	var points = curve.get_baked_points()
	var upvectors = curve.get_baked_up_vectors()
	
	for child in $Spawn_road.get_children():
		child.free()
		
	for i in range(item_count):
		offsets.append(float(i)/float(item_count+1))
		
	for offset_idx in range(offsets.size()):
		var idx = clamp(int(points.size()*(offsets[offset_idx])), 0, points.size()-1)
		var point = points[idx]
		var upVector = upvectors[idx]
		
		var item_ = Node3D.new()
		item_.name = "item_"
		$Spawn_road.add_child(item_)
		item_.translate(point)
		# spale шпала
		#var spale = preload("res://World/spale.tscn").instantiate()
		#spale.name = "spale"
		#item_.add_child(spale)
		
		#spale.translate(Vector3(0.05,0.0,0.0))
		
		if idx+1 > points.size()-1:
			item_.look_at(points[0], upVector)
		else:
			item_.look_at(points[idx+1], upVector)
			
		item_.set_owner(get_tree().get_edited_scene_root())
		#spale.set_owner(get_tree().get_edited_scene_root())
