@tool
extends Node

#const ROUNDS : int = 15
#const INITIAL_MONEY : int = 1500
#
#const PROJECT_MIN_PROFIT: float = 1.2
#const PROJECT_MAX_PROFIT: float = 1.8

enum BOX_TYPES {
	RED = 0,
	YELLOW = 1,
	GREEN = 2,
	AQUA = 3,
	BLUE = 4,
	PURPLE = 7,
	PINK = 8
}

enum BENEFITS{
	NONE = 10,
	STAMINA = 11,
	MENTAL = 12,
	FUEL = 13
}

const COLORS = {
	BOX_TYPES.RED : Color("FF0303"),
	BOX_TYPES.YELLOW : Color("D9FF03"),
	BOX_TYPES.GREEN : Color("03FF5B"),
	BOX_TYPES.AQUA : Color("03BCFF"),
	BOX_TYPES.BLUE : Color("035FFF"),
	BOX_TYPES.PURPLE : Color("5F03FF"),
	BOX_TYPES.PINK : Color("FF03F2")
}

#const _price_factor: int = 20
#const _external_multiplier = 1.3
#const _basic_price: int = 100

#func get_price(level:int, external: bool = false)-> int:
	#var factor = _price_factor * _external_multiplier if external else _price_factor
	#return _basic_price + factor * level
