extends Control

@export_group('private', '_')
var _receipt_item: PackedScene


@onready
var items_container: VBoxContainer = %Items

@onready
var panel_container: PanelContainer = %PanelContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SaveManager.data.receipt_items_pushed.connect(_on_receipt_item_pushed)


## item: { 'name': string, 'price': int, 'rarity': int }
func _on_receipt_item_pushed(item: Dictionary) -> void:
	var item_display:= _receipt_item.instantiate()
	item_display.label = item.get('name', 'undefined')
	item_display.price = item.get('price', 0)
	items_container.add_child(item_display)

	panel_container.pivot_offset.y = panel_container.size.y
