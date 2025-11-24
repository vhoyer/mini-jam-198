extends Node3D


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed('buy'):
		var img = get_viewport().get_texture().get_image()
		var basedir = OS.get_system_dir(OS.SYSTEM_DIR_PICTURES)
		var dir = "%s/ymart" % basedir
		var timestring = Time.get_datetime_string_from_system().replace(':', '-')
		var filename = "ymart-%s.png" % timestring
		var filepath = "%s/%s" % [dir, filename]
		DirAccess.make_dir_recursive_absolute(dir)
		img.save_png(filepath)
		DvkLogger.scope('Cheat').info('Screenshot saved to path "%s"' % filepath)
