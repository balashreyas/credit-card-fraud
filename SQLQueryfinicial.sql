select * from cards_data;
--Clean Data
--Remove Nulls
update cards_data
set credit_limit=0
where credit_limit IS NULL;
--Standardize card brand
update cards_data
set card_brand='Visa'
where card_brand IN ('visa', 'VISA');

--Fraud Customers
select client_id, count(*) as fraud_count
from cards_data
where card_on_dark_web = 'Yes'
group by client_id
order by fraud_count Desc

--Credit Limit Risk
select 
	CASE
		WHEN credit_limit < 20000 THEN 'Low'
		WHEN credit_limit < 50000 THEN 'Medium'
		ELSE 'High'
	END as credit_category
	from cards_data
	group by credit_limit;
