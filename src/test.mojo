from monums import LitIntE_rewo, LitIntE_wovo, ESIMD_rewo, ESIMD_wovo

fn main():
    test_LitIntE_rewo()
    test_LitIntE_wovo()
    test_ESIMD_rewo()
    test_ESIMD_wovo()

    test_seq()


fn test_seq():
    from monums.sequences import factorial, factorial_gamma, factorial_stirling, factorial_slow, fibonacci
    print(factorial(10))
    print(factorial_gamma(10))
    print(factorial_stirling(10))
    print(factorial_slow(10))

    # surprised this works, very nice
    for i in range(10):
        print(fibonacci(i))


fn test_LitIntE_rewo():
    alias a: LitIntE_rewo = LitIntE_rewo(4,0,20)
    alias b: LitIntE_rewo = LitIntE_rewo(2,0,4)
    alias c: LitIntE_rewo = LitIntE_rewo(0,0, (1<<50) + 1)

    print("a = " + a.str_po())
    print("b = " + b.str_po())
    print()
    print("a+b = " + (a+b).str_po())
    print("a-b = " + (a-b).str_po())
    print("a*b = " + (a*b).str_po())
    print("a//b = " + (a//b).str_po())
    print((a*a).str_po() + "=" + (a*a*b // b).str_po())
    print("c*c // c = " + ((c*c) // c).str_po() + " = " + c.str_po())
    print()


fn test_LitIntE_wovo():
    alias a: LitIntE_wovo = LitIntE_wovo(4,0,20)
    alias b: LitIntE_wovo = LitIntE_wovo(2,0,4)
    
    print("a = " + a.str_po())
    print("b = " + b.str_po())
    print()
    print("a+b = " + (a+b).str_po())
    print("a-b = " + (a-b).str_po())
    print("a*b = " + (a*b).str_po())
    print("a//b = " + (a//b).str_po())
    print((a*a).str_po() + "=" + (a*a*b // b).str_po())
    print()


fn test_ESIMD_rewo():
    let a: ESIMD_rewo[DType.index,2] = ESIMD_rewo[DType.index,2](4,0,20)
    let b: ESIMD_rewo[DType.index,2] = ESIMD_rewo[DType.index,2](2,0,4)
    let c: ESIMD_rewo[DType.index,2] = ESIMD_rewo[DType.index,2](0,0, (1<<50) + 1)

    print("a = " + a.str_po[" "]())
    print("b = " + b.str_po[" "]())
    print()
    print("a+b = " + (a+b).str_po[" "]())
    print("a-b = " + (a-b).str_po[" "]())
    print("a*b = " + (a*b).str_po[" "]())
    print("a//b = " + (a//b).str_po[" "]())
    print((a*a).str_po[" "](), "=", (a*a*b // b).str_po[" "]())
    print("c*c // c = " + ((c*c) // c).str_po[" "]() + " != " + c.str_po[" "]())
    print()


fn test_ESIMD_wovo():
    let a: ESIMD_wovo[DType.index,2] = ESIMD_wovo[DType.index,2](4,0,20)
    let b: ESIMD_wovo[DType.index,2] = ESIMD_wovo[DType.index,2](2,0,4)

    print("a = " + a.str_po[" "]())
    print("b = " + b.str_po[" "]())
    print()
    print("a+b = " + (a+b).str_po[" "]())
    print("a-b = " + (a-b).str_po[" "]())
    print("a*b = " + (a*b).str_po[" "]())
    print("a//b = " + (a//b).str_po[" "]())
    print((a*a).str_po[" "](), "=", (a*a*b // b).str_po[" "]())
    print()
