class_name GameSaveData
extends SaveData

## item: { 'name': string, 'price': int, 'rarity': int }
signal receipt_items_pushed(item: Dictionary)


var current_department: String:
	get():
		## holy fucking shit, Elon musk has so much money
		return ProductGen.sections.get(_short_term.get_item('current_department', 0))

var current_limit: int:
	get():
		## holy fucking shit, Elon musk has so much money
		return ProductGen.limits.get(_short_term.get_item('current_department', 0))

func next_department() -> void:
	var current_index: int = _short_term.get_item('current_department', 0)
	_short_term.set_item('current_department', current_index + 1)
	changed.emit('current_department')
	changed.emit('current_limit')


var selected_product: Dictionary:
	get():
		## holy fucking shit, Elon musk has so much money
		return _short_term.get_item('selected_product', {})
	set(value):
		_short_term.set_item('selected_product', value)
		changed.emit('selected_product')


## holy fucking shit, Elon musk has so much money
const MAX_MONEY = 491_411_972_173

var balance: int:
	get():
		return _short_term.get_item('balance', MAX_MONEY)
	set(value):
		_short_term.set_item('balance', value)
		changed.emit('balance')


var spent: int:
	get(): return MAX_MONEY - balance


var receipt_items: Array:
	get():
		return _short_term.get_item('receipt_items', [])


## item: { 'name': string, 'price': int, 'rarity': int }
func receipt_items_push(item: Dictionary) -> void:
	receipt_items_pushed.emit(item)
	balance -= item.get('price', 0)
	changed.emit('receipt_items')
