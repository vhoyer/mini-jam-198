class_name Shelf
extends StaticBody3D

@export
var product_scene: PackedScene


@onready
var product_place_marker: Marker3D = %ProductPlace



## product: { 'name': string, 'price': int, 'rarity': int }
func place_product(product: Dictionary) -> void:
	var inst: ProductBox = product_scene.instantiate()
	inst.label = product.get('name', 'undefined')
	inst.price = product.get('price', 0)
	inst.rarity = product.get('rarity', 0)
	product_place_marker.add_child(inst)
