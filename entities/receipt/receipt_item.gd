extends HBoxContainer


signal _model_updated()


var label: String:
	set(value):
		label = value
		_model_updated.emit()


var price: int:
	set(value):
		price = value
		_model_updated.emit()


@onready
var label_label: Label = %Label


@onready
var price_label: Label = %Price


func _ready() -> void:
	_model_updated.connect(_update_view)
	_model_updated.emit()


func _update_view() -> void:
	label_label.text = label
	price_label.text = '$ %d' % price
