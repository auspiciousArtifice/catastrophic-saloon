class_name Bar
extends Node2D

@onready var fsm = $StateMachine as FSM
@onready var prepare_drink_state = $StateMachine/PrepareDrinkState as PrepareDrinkState
@onready var shooting_shaker_state = $StateMachine/ShootingShakerState as ShootingShakerState
@onready var serve_drink_state = $StateMachine/ServeDrinkState as ServeDrinkState

# Called when the node enters the scene tree for the first time.
func _ready():
	prepare_drink_state.drink_prepped.connect(fsm.change_state.bind(shooting_shaker_state))
	shooting_shaker_state.finished_shooting.connect(fsm.change_state.bind(serve_drink_state))
	serve_drink_state.drink_served.connect(fsm.change_state.bind(prepare_drink_state))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
