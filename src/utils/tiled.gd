extends Node

func setOwner(scene, node):
	node.set_owner(scene)
	for child in node.get_children():
		setOwner(scene, child)

func reparent(scene, node, parent):
	var oldParent = node.get_parent()
	print(oldParent.name, " => ", parent.name, ": ", node.name)
	oldParent.remove_child(node)
	parent.add_child(node)
	setOwner(scene, node)

func post_import(scene):
	var main = scene.get_node("main")

	for layer in scene.get_children():
		if layer is TileMap: continue

		# draw object sprites
		for child in layer.get_children():
			reparent(scene, child, main)

		layer.free()

	return scene
