class_name ProductGen
extends Object

var item_csv: CSVFile
var adjectives_csv: CSVFile
var color_csv: CSVFile


const sections = [
	'House',
	'Travel',
	'Real State',
	'Territories',
	'Investiments',
]

const limits = [
	60_000,
	120_000,
	50_000_000,
	150_000_000,
	491_411_972_174,
]

var products_sum: Dictionary[String, int] = {}
var products_base: Dictionary[String, Array] = {}

var adjective_sum: int = 0
var adjectives: Array = []

func _init(items: CSVFile, adjs: CSVFile, colors: CSVFile) -> void:
	item_csv = items
	adjectives_csv = adjs
	color_csv = colors

	while item_csv.next():
		var section: String = item_csv.current['section']
		var rarity:= int(item_csv.current['rarity'])
		products_base.get_or_add(section, []).push_back({
			'name': item_csv.current['name'],
			'price': int(item_csv.current['price']),
			'rarity': rarity,
		})
		products_sum.set(section, products_sum.get(section, 0) + rarity)

	while adjectives_csv.next():
		var rarity:= int(adjectives_csv.current['rarity'])
		adjectives.push_back({
			'name': adjectives_csv.current['name'],
			'price_mod': int(adjectives_csv.current['price_mod']),
			'rarity': rarity,
		})
		adjective_sum += rarity
	pass


## {'name', 'price', 'rarity'}
func generate_section_product(section_name: String) -> Dictionary:
	## base
	var rarity_total: int = products_sum.get(section_name, 0)
	var rarity_list: Array = products_base.get(section_name, [])
	var item:= _loot_pick(rarity_list, rarity_total)

	## adjective
	var adj:= _loot_pick(adjectives, adjective_sum)

	return {
		'name': '%s %s' % [adj.name, item.name],
		'price': item.price * adj.price_mod,
		'rarity': item.rarity + adj.rarity,
	}


## T - { rarity: int }
## table - T[]
## return T
func _loot_pick(rarity_table: Array, rarity_total: int) -> Dictionary:
	var rand_rarity:= randi() % rarity_total + 1

	var return_item: Dictionary

	for item: Dictionary in rarity_table:
		return_item = item

		rand_rarity -= item.rarity
		if rand_rarity < 0: break

	return return_item
