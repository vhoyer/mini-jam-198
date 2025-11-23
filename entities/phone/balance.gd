extends Label


func _ready() -> void:
	SaveManager.data.changed.connect(_on_save_data_changed)
	_on_save_data_changed('')


func _on_save_data_changed(what: String) -> void:
	if not what or what == 'balance':
		self.text = '$ %d' % SaveManager.data.balance
	pass
