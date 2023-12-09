extends Control

@onready var wave_label = $MarginContainer/TopBar/WaveLabel
@onready var money_label = $MarginContainer/TopBar/MoneyLabel
@onready var canon_button = $MarginContainer/BottomBar/CanonButton

const BUILDING_POPUP = preload("res://scenes/gui/BuildingPopup.tscn")

func _ready():
	Game.wave_number_signal.connect(_wave_signal)
	Game.money_update.connect(_money_update)
	GuiEvents.create_building_popup.connect(_create_building_popup)
	GuiEvents.add_to_game_ui.connect(_add_to_game_ui)
	canon_button.text = "Canon\n" + str(Game.NORMAL_COSTS.building_costs["Canon"]) + " Gold"

func _on_button_pressed():
	var cost: int = Game.NORMAL_COSTS.building_costs["Canon"]  # TODO find a generic way to get this
	if Game.money >= cost:
		GuiEvents.create_canon.emit()
		Game.money -= cost

func _wave_signal(new: int):
	wave_label.text = "Wave " + str(new + 1)

func _money_update(new: int):
	money_label.text = "Money: " + str(new)
	# TODO find a generic way to get this
	canon_button.disabled = new < Game.NORMAL_COSTS.building_costs["Canon"]

func _create_building_popup(building: Building):
	if get_tree().get_nodes_in_group("popup").size() == 0:
		var popup := BUILDING_POPUP.instantiate()
		popup.parent = building
		popup.position = building.get_global_mouse_position()
		_add_to_game_ui(popup)

func _add_to_game_ui(node: Node):
	self.add_child(node)
