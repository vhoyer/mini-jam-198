extends Panel


var data: GameSaveData:
	get(): return SaveManager.data


func _ready() -> void:
	SaveManager.data.changed.connect(_on_save_data_changed)
	_on_save_data_changed('')
	self.hide()


func _on_save_data_changed(what: String) -> void:
	if not what or what == 'balance':
		if data.spent >= data.current_limit:
			get_tree().paused = true
			self.show()


func _on_button_pressed() -> void:
	SaveManager.data.next_department()
