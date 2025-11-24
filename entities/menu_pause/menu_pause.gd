extends Control


func _ready() -> void:
	self.hide()


func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed('pause'):
		var tree = get_tree()
		if not tree.paused:
			tree.paused = true
			self.show()



func _on_resume_pressed() -> void:
	get_tree().paused = false
	self.hide()


func _on_main_menu_pressed() -> void:
	get_tree().paused = false
	StageManager.go_to_start()
