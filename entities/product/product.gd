@tool
class_name ProductBox
extends RigidBody3D

signal _model_updated()

@export
var label: String = 'Incredible Product':
	set(value):
		label = value
		_model_updated.emit()

@export
var price: int = 10:
	set(value):
		price = max(value, 0)
		_model_updated.emit()

@export
var rarity: int = 0:
	set(value):
		rarity = value
		_model_updated.emit()



@export_group('private', '_')

@export
var _rarity1: PackedScene

@export
var _rarity2: PackedScene

@export
var _rarity3: PackedScene



@onready
var label_label: Label3D = %Label

@onready
var price_label: Label3D = %Price

@onready
var box_model_placement: Marker3D = %BoxModelPlacement


func _ready() -> void:
	_model_updated.connect(_update_view)
	_model_updated.emit()


func _update_view() -> void:
	label_label.text = label
	price_label.text = '$%d' % price

	var box_model: PackedScene
	if rarity < 70:
		box_model = _rarity3
	elif rarity < 120:
		box_model = _rarity2
	else:
		box_model = _rarity1

	Util.remove_children(%BoxModelPlacement)
	%BoxModelPlacement.add_child(box_model.instantiate())
