module sample

pred p{}
pred q{}

fact Premises {
	not q implies not p
}

assert Conclusion{
	p implies q
}

check Conclusion for 4
