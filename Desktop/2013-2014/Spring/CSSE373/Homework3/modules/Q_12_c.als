module sample

pred p{}
pred q{}

fact Premises {
	p implies (not q)
	q
}

assert Conclusion{
	not p
}

check Conclusion for 4
