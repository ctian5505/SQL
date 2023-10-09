-- Calculate the total sales of each resellers and Rank it.
SELECT 
	FRS.ResellerKey,  DR.ResellerName, SUM(FRS.ExtendedAmount) Total_Sales, RANK() OVER (ORDER BY SUM(FRS.ExtendedAmount) DESC) AS Total_Sales_Rank
 FROM 
	FactResellerSales AS FRS
LEFT JOIN
	DimReseller AS DR
ON
	FRS.ResellerKey = DR.ResellerKey
GROUP BY 
	FRS.ResellerKey, DR.ResellerName
