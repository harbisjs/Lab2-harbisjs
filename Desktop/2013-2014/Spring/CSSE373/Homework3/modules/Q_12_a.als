module sample

pred p{}
pred q{}
pred r{}
pred s{}
pred t{}

fact Premises {
	((p and q) and r)
	s and t
}

assert Conclusion{
	q and s
}

check Conclusion for 4
