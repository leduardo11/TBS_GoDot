extends SceneTree
func _init():
	for path in ["res://assets/levels/level2/level2.tmx", "res://assets/levels/level5/level5.tmx"]:
		print("==== ", path, " ====")
		var ps = load(path)
		if ps == null:
			print("  LOAD FAILED")
			continue
		var inst = ps.instantiate()
		print("  root: ", inst.name, " type=", inst.get_class())
		print("  root meta keys: ", inst.get_meta_list())
		if inst.has_meta("height"): print("  height=", inst.get_meta("height"), " width=", inst.get_meta("width"), " Victory=", inst.get_meta("Victory_Condition"))
		for child in inst.get_children():
			var info = "  child: %s (%s)" % [child.name, child.get_class()]
			if child.has_method("get_used_cells"):
				info += " tiles=%d tileset=%s" % [child.get_used_cells(0).size(), str(child.tile_set != null)]
			else:
				info += " children=%d" % child.get_child_count()
				if child.get_child_count() > 0:
					var c0 = child.get_child(0)
					info += " first=(%s, %s) pos=%s meta=%s" % [c0.name, c0.get_class(), str(c0.position), str(c0.get_meta_list())]
			print(info)
		inst.free()
	quit()
