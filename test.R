
# Load package
devtools::load_all()

library(stockscreen)

# Set urlkey
set_urlkey('urlkey.json')

# test
a <- screen(market_cap = list(50, 6389800000000000), 
            pe_ratio = list(0, 1500),
            dividend_yield = list(0, 273300),
            price_change_52week = list(-101, 10640000),
            price_to_book = list(0, 1500),
            current_assets_to_liabilities_ratio_year = list(1.5, 17854),
            longterm_debt_to_equity_year = list(-3.46, 0.5),
            return_on_equity_5years = list(8, 22420),
            net_income_growth_rate_5years = list(5, 497),
            revenue_growth_rate_10years = list(5, 197),
            eps_growth_rate_10years = list(5, 90.84),
            interest_coverage_year = list(6, 278514)
            
            )