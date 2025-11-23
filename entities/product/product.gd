@tool
class_name ProductBox
extends RigidBody3D

signal _model_updated()


static var current_selected: ProductBox = null

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

@export_range(0, 200)
var rarity: int = 200:
	set(value):
		rarity = value
		_model_updated.emit()



@export_group('private', '_')

@export
var _highlight_material: Material

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


var product_dict: Dictionary:
	set(value):
		product_dict = value
		label = value.get('name', 'undefined')
		price = value.get('price', 0)
		rarity = value.get('rarity', 0)
	get():
		return product_dict if product_dict else {
			'name': label,
			'price': price,
			'rarity': rarity,
			}


var current_box: Node3D
var current_box_meshs: Array


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

	current_box = box_model.instantiate()
	current_box_meshs = current_box.find_children('*', 'MeshInstance3D')
	Util.remove_children(%BoxModelPlacement)
	%BoxModelPlacement.add_child(current_box)


func _process(_delta: float) -> void:
	_set_hightlight_shader()


func _set_hightlight_shader() -> void:
	if !current_box: return

	var selected = product_dict == SaveManager.data.selected_product

	var new_material = _highlight_material if selected else null

	for mesh: MeshInstance3D in current_box_meshs:
		mesh.material_overlay = new_material
