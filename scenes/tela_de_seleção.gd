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
		
		for char:CharResource in chars:
			$CenterContainer/ItemList.add_item(char.name, char.icon, true)
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
