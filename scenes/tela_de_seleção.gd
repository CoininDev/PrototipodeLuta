extends Control

var base_path = "res://rsrc/chars/"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var chars: Array
	var dir = DirAccess.open(base_path)
	if dir:
		dir.list_dir_begin()
		var folder_name = dir.get_next()
		
		while folder_name != "":
			if folder_name == "." or folder_name == ".." or !dir.current_is_dir():
				continue
			
			var char_res_file = base_path + folder_name + "/char.tres"
			if FileAccess.file_exists(char_res_file):
				var res = ResourceLoader.load(char_res_file)
				if res:
					chars.append(res)
				else:
					printerr("Item não encontrado: " + char_res_file)
			folder_name = dir.get_next()
		
		print(chars)
		for char:CharResource in chars:
			var btn: Button = Button.new()
			btn.text = char.name
			btn.icon = char.icon
			btn.pressed.connect(_on_pressed.bind(char))
			$CenterContainer/GridContainer.add_child(btn)

func _on_pressed(char: CharResource) -> void:
	$CenterContainer.visible = false
	var scene = load("res://scenes/DebugRoom.tscn").instantiate()
	scene.apply_char(char)
	add_child(scene)
