return {
  -- Define ticker snippet for ticker symbols
  s(
    { trig = "ticker", desc = "Portfolio details" },
    fmta(
      [[
  - symbol: "<>"
    quantity: <>
    unit_cost: <>
  <>
      ]],
      { i(1), i(2), i(3), i(4) }
    )
  ),
}
