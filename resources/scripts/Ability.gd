extends Resource
class_name Ability


@export var manager: PackedScene
@export var ability_scene: PackedScene

@export var name: String
@export var icon: Texture2D

@export var damage: int
@export var speed: int
@export var cooldown: float
@export var mana_cost: int

var is_ready: bool

