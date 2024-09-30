extends Resource
class_name Attack

@export var animation: String
@export var trigger: String
@export var hidden: bool #se o ataque for escondido só pode ser acionado como sequência de outro ataque. E não no Idle ou Move
@export var sequence: Array
