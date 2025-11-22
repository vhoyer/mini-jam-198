extends Node3D


var product_list_csv: CSVFile
@export_file
var product_list_file: String:
	set(value):
		product_list_file = value
		product_list_csv = CSVFile.new(value, '\t')


var product_adjectives_csv: CSVFile
@export_file
var product_adjective_file: String:
	set(value):
		product_adjective_file = value
		product_adjectives_csv = CSVFile.new(value, '\t')


var product_color_csv: CSVFile
@export_file
var product_color_file: String:
	set(value):
		product_color_file = value
		product_color_csv = CSVFile.new(value, '\t')


@export_enum('House', 'Travel', 'Real State', 'Investiments', 'Territories')
var section: String = 'House'


var shelves: Array
var product_gen: ProductGen


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	shelves = self.find_children('*', 'Shelf')
	product_gen = ProductGen.new(product_list_csv, product_adjectives_csv, product_color_csv)

	for shelf: Shelf in shelves:
		shelf.place_product(product_gen.generate_section_product(section))
