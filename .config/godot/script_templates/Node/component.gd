class_name ClassName
extends Node

#region Component boilerplate
const _cmp_key = &"ClassName"
func attach(actor: Node):
	actor.set_meta(_cmp_key, self)
static func from(n: Node) -> ClassName:
	if n.has_meta(_cmp_key):
		return n.get_meta(_cmp_key)
	return null
static func try(n: Node, f: Callable):
	if n.has_meta(_cmp_key):
		return f.call(n.get_meta(_cmp_key))
	return null
#endregion