#region Component boilerplate
@export var actor: Node
@onready var __discard = __cmp_onready()
const _cmp_key = &"ClassName"
func __cmp_onready():
	if not actor: actor = get_parent()
	attach(actor)
	return actor
func attach(n: Node):
	n.set_meta(_cmp_key, self)
static func from(n: Node) -> ClassName:
	if n.has_meta(_cmp_key):
		return n.get_meta(_cmp_key)
	return null
static func try(n: Node, f: Callable):
	if n.has_meta(_cmp_key):
		return f.call(n.get_meta(_cmp_key))
	return null
#endregion