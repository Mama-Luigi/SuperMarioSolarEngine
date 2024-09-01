extends PanelContainer

@export var property_list: VBoxContainer

var selected_items: Array[PreviewItem]


func _on_ui_selection_changed(items: Array[PreviewItem]) -> void:
	selected_items = items
	for child in property_list.get_children():
		child.queue_free()
	if items.size() == 0:
		return

	var first_item = items[0]
	var first_data = first_item.item_data
	var shared_properties: Array[Property] = first_data.properties.duplicate()
	for item in items:
		if item == first_item:
			continue
		var data = item.item_data
		for property in shared_properties:
			if property not in data.properties:
				shared_properties.erase(property)

	for property in shared_properties:
		var inst = property.inspector_entry.instantiate()
		var prop_name = property.name
		inst.set_label(prop_name)
		inst.value_changed.connect(_on_property_value_changed.bind(prop_name))
		property_list.add_child(inst)
		inst.set_value(first_item.property_values[prop_name])


func _on_property_value_changed(value: Variant, prop_name: StringName) -> void:
	for item in selected_items:
		item.set_property(value, prop_name)
