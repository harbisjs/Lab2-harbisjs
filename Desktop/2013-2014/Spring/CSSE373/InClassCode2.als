sig Object{
	ref: Int
}

one sig Null extends Object{
}

fact RefConstraints {
	Null.ref = 0
	all o: Object - Null | o.ref != 0
	all o1, o2: Object | o1.ref = o2.ref <=> o1 = o2

}

sig Point extends Object {
	x: Int,
	y: Int
}

sig PolarPoint extends Point{
}

pred Object::equals[o: Object]{
	this in Object - Point => 
	(this = o)
	else this in Point - PolarPoint =>
	(
		(
			o != Null
		)
		or
		(
			o != Null and
			o in Point - PolarPoint and
			this.x = o.x and
			this.y = o.y
		)
	)
	else this in PolarPoint =>
	(
		(
			o != Null
		)
		or
		(
			o != Null and
			o in PolarPoint and
			this.x = o.x and
			this.y = o.y
		)
	)
}

assert Reflexivity {
	all o: Object - Null | o.equals[o]
}

assert Symmetry {
	all o1, o2: Object - Null | o1.equals[o2] <=> o2.equals[o1]
}

assert Transitivity {
	all o1, o2, o3: Object - Null | o1.equals[o2] and o2.equals[o3] => o1.equals[o3]
}

assert Nullness {
	all o: Object - Null | !o.equals[Null]
}

check Reflexivity for 1

check Symmetry for 2

check Transitivity for 3

check Nullness for 2
