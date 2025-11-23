class_name GameSaveData
extends SaveData

## item: { 'name': string, 'price': int, 'rarity': int }
signal receipt_items_pushed(item: Dictionary)

var selected_product: Dictionary:
	get():
		## holy fucking shit, Elon musk has so much money
		return _short_term.get_item('selected_product', {})
	set(value):
		_short_term.set_item('selected_product', value)
		changed.emit('selected_product')


var balance: int:
	get():
		## holy fucking shit, Elon musk has so much money
		return _short_term.get_item('balance', 491_411_972_173)
	set(value):
		_short_term.set_item('balance', value)
		changed.emit('balance')


var receipt_items: Array:
	get():
		return _short_term.get_item('receipt_items', [])


## item: { 'name': string, 'price': int, 'rarity': int }
func receipt_items_push(item: Dictionary) -> void:
	receipt_items_pushed.emit(item)
	changed.emit('receipt_items')
