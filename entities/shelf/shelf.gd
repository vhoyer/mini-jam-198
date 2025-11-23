class_name Shelf
extends StaticBody3D

@export
var product_scene: PackedScene


@onready
var product_place_marker: Marker3D = %ProductPlace



## product: { 'name': string, 'price': int, 'rarity': int }
func place_product(product: Dictionary) -> void:
	var inst: ProductBox = product_scene.instantiate()
	inst.product_dict = product
	product_place_marker.add_child(inst)
