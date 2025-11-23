class_name MemoryData
extends RefCounted

signal saved()
signal changed(what: String)

var _short_term: InMemoryStorage
var _long_term: JSONStorage

func _init(index: int) -> void:
	var save_id = 'save%s' % index
	_long_term = JSONStorage.new('', save_id)
	_short_term = InMemoryStorage.new('', save_id)
	_short_term._override_with(_long_term)


func consolidate_memory() -> void:
	_long_term._override_with(_short_term)
	saved.emit()


func remember() -> void:
	_short_term._override_with(_long_term)
	changed.emit('')


func amnesia() -> void:
	_long_term.erase_storage()
	_short_term.erase_storage()
	changed.emit('')
	saved.emit()


func empty() -> bool:
	return _short_term._list_item_keys().size() == 0
