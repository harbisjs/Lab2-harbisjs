module sample

pred p{}
pred q{}
pred r{}

fact Premises {
	p implies (q implies r)
	p and not r
}

assert Conclusion{
	not q
}

check Conclusion for 4
