extends HBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SaveManager.data.changed.connect(_on_save_data_changed)
	_on_save_data_changed('')


func _on_save_data_changed(what: String) -> void:
	if not what or what == 'selected_product':
		self.visible = !!SaveManager.data.selected_product
		$Label.text = 'Buy %s' % SaveManager.data.selected_product.get('name', 'undefined')
	pass
