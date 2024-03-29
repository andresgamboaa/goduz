class_name BaseRootComponent
extends Component

@export
var show_reload_button = true

@onready
var reload_b_scene = load("res://addons/goduz/reload_components_button.tscn")

var vbx
var root_control:Control
var presets_path

func _ready():
	vbx = VBoxContainer.new()
	vbx.name ="VBoxContainer"
	if show_reload_button:
		var reload_b = reload_b_scene.instantiate() as Button
		vbx.add_child(reload_b)
	util_nodes_container = Control.new()
	util_nodes_container.visible = false
	vbx.add_child(util_nodes_container)
	vbx.set_anchors_preset(Control.PRESET_FULL_RECT)
	call_deferred("add_sibling", vbx)
	mount()

func mount():
	Gui.initialize_presets(presets_path)
	var rc = Control.new()
	root_control = rc
	vbx.add_child(rc)
	rc.size_flags_vertical = rc.SIZE_EXPAND_FILL
	await get_tree().process_frame
	Goduz.render(rc, self, null)

func update_view():
	var next = view()
	Goduz.diff(self.get_view(), next)
	next.free()
	await get_tree().process_frame
	component_updated()
