#import "@preview/ilm:1.4.1": *
#import "@preview/physica:0.9.5": *
#import "@preview/thmbox:0.2.0": *
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge, shapes

#set page(margin: (
  top: 0.5in,
  bottom: 0.5in,
  x: 0.5in
))

#show: thmbox-init(counter-level: 2)
#set text(lang: "en")
#set figure(numbering: none)

#let definition-counter = counter("definition")
#show: sectioned-counter(definition-counter, level: 2)
#let definition = definition.with(counter: definition-counter)

#show: ilm.with(
  title: [Financial Engineering],
  author: "Amita Sharma",
  abstract: [],
)

= Introduction to Financial Instruments, Interest Rates and Pricing of Bonds

#definition[Financial Systems][
  It refers to the system that enables the exchange of funds between lenders, investors and borrowers. It comprises of financial institutions, financial markets, financial instruments and financial services. It serves the following purposes:
  #columns(2)[
  - Channel savings into investments
  - Provide risk management through insurance and hedging
  #colbreak()
  - Enable liquidity and price discovery
  - Facilitate efficient allocation of resources
  ]
]

#definition[Financial Markets][
  These are platforms for buying and selling financial instruments. There are multiple types of financial markets like capital market (equity/stocks market and debt/bonds market), money market (short-term dept instruments), derivative market (futures, options, swaps), forex market (trading of currencies) and commodities market (trading of physical goods). There are also primary markets where securities are issued and secondary markets where previously issued securities are traded.
]

== Financial Instruments

The different types of financial instruments are:
- *Stocks/Equity:* represent ownership in a company. The shareholders may earn a dividend (part of profit) or capital gains (price appreciation). The two types of stocks are common and preferred stocks.
- *Bonds (Debt Instruments):* are loans made by an investor to a borrower (typically corporate/government). The borrower then pays periodic interest (coupon) and returns principal at maturity. The types of bonds are corporate, government, municipal and zero-coupon.
- *Derivatives:* are financial contracts whose value is derived from an underlying asset. These are used for hedging, speculation and arbitrage#footnote[Practice of exploiting price differences of the same asset in different markets to make a risk-free profit]. The types of derivatives are futures (obligation to buy/sell at a fixed price in future), options (right (not obligation) to buy/sell) and swaps (exchange of cash flows, e.g. interest rate swap).
- *Mutual Funds:* are investment vehicle that pools funds from investors to purchase a diversified portfolio. These are managed by professional fund managers. The types of mutual funds are equity funds, debt funds, hybrid funds and index funds. $ "Net Asset Value" = ("Total value of assets" - "Liabilites")/"Total units" $
- *Interest Rates:* The types of interest rates are nominal interest rate, real interest rate and effective interest rate.
- *Bond and Bond Pricing*

== Time Value of Money

Let the principal amount at $t=0$ be $P$ and the future value at time $t=t_n$ be $V$. Let the interest rate be $r%$ given annually.
=== Simple Interest

Here, 
$ V_n = P(1 + n r) $
Thus, the growth rate#footnote[We can also define a discount factor $1/gamma$ which can be used to go back from $V$ to $P$] is $gamma = (1 + n r)$ which is linear.

=== Compound Interest

Here,
$ V_n &= V_(n-1)(1 + r) \
V_n/V_(n-1)&= 1 + r $
Thus, this forms a geometric progression such that $V_0=P$,
$ therefore V_n = P(1 + r)^n $
The growth rate is $gamma = (1 + r)^n$ which is exponential.

However, if the interest is compounded $m$ times in an interval, then,
$ V_n = P(1 + r/m)^(n m) $


