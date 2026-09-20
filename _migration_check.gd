extends SceneTree

func _init():
	var scripts = []
	var scenes = []
	_collect("res://", scripts, scenes)
	scripts.sort()
	scenes.sort()

	print("=== SCRIPT CHECK (", scripts.size(), ") ===")
	var script_fail = 0
	for s in scripts:
		var res = load(s)
		if res == null:
			print("SCRIPT FAIL: ", s)
			script_fail += 1
	print("=== SCRIPT FAILURES: ", script_fail, " ===")

	print("=== SCENE CHECK (", scenes.size(), ") ===")
	var scene_fail = 0
	for p in scenes:
		var packed = load(p)
		if packed == null:
			print("SCENE LOAD FAIL: ", p)
			scene_fail += 1
			continue
		if not (packed is PackedScene):
			continue
		var inst = packed.instantiate()
		if inst == null:
			print("SCENE INSTANTIATE FAIL: ", p)
			scene_fail += 1
		else:
			inst.free()
	print("=== SCENE FAILURES: ", scene_fail, " ===")
	quit()

func _collect(dir_path, scripts, scenes):
	var dir = DirAccess.open(dir_path)
	if dir == null:
		return
	dir.list_dir_begin()
	var name = dir.get_next()
	while name != "":
		if name.begins_with("."):
			name = dir.get_next()
			continue
		var full = dir_path.path_join(name)
		if dir.current_is_dir():
			_collect(full, scripts, scenes)
		else:
			if name.ends_with(".gd") and name != "_migration_check.gd":
				scripts.append(full)
			elif name.ends_with(".tscn"):
				scenes.append(full)
		name = dir.get_next()
	dir.list_dir_end()
