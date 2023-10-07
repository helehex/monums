from monums.eisint import EisInt_rewo, EisInt_wovo

fn main():
    let rewo: EisInt_rewo = EisInt_rewo(1,-3)
    print(rewo.str_po())
    print((rewo * rewo).str_po(), "=", ((rewo * rewo * rewo) // rewo).str_po())
    print((rewo * rewo * rewo).str_po())

    print()

    let wovo: EisInt_wovo = EisInt_wovo(-4,-1)
    print(wovo.str_po())
    print((wovo * wovo).str_po(), "=", ((wovo * wovo * wovo) // wovo).str_po())
    print((wovo * wovo * wovo).str_po())