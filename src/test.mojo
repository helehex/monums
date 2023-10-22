from monums import LitIntE_rewo, LitIntE_wovo, ESIMD_rewo, ESIMD_wovo, max

fn main():
    test_LitIntE_rewo()
    test_LitIntE_wovo()
    test_ESIMD_rewo()
    test_ESIMD_wovo()

    print(max(IntLiteral(5), IntLiteral(6)))
    print(max(IntLiteral(5), IntLiteral(6)))


@always_inline
fn test_LitIntE_rewo():
    alias a: LitIntE_rewo = LitIntE_rewo(4,0,20)
    alias b: LitIntE_rewo = LitIntE_rewo(2,0,4)

    print("a = " + a.str_po()) # <------ Works when str is only called once
    
    print("b = " + b.str_po())
    print()
    print("a+b = " + (a+b).str_po())
    print("a-b = " + (a-b).str_po())
    print("a*b = " + (a*b).str_po())
    print("a//b = " + (a//b).str_po())
    print((a*a).str_po() + "=" + (a*a*b // b).str_po())
    print()


@always_inline
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

    print("a = " + a.str_po[" "]())
    print("b = " + b.str_po[" "]())
    print()
    print("a+b = " + (a+b).str_po[" "]())
    print("a-b = " + (a-b).str_po[" "]())
    print("a*b = " + (a*b).str_po[" "]())
    print("a//b = " + (a//b).str_po[" "]())
    print((a*a).str_po[" "](), "=", (a*a*b // b).str_po[" "]())
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
