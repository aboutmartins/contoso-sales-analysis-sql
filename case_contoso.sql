WITH cte_contoso
as
(
SELECT StoreKey, 
     SUM(UnitPrice * SalesQuantity) as Faturamento,
     COUNT(SalesKey) as Qtd_Vendida,
     SUM(UnitPrice * SalesQuantity) / COUNT(SalesKey) as Ticket_Medio
FROM FactSales
GROUP BY StoreKey
)
SELECT *, SUM(Faturamento) OVER() as Faturamento_Total, 
          Faturamento / 
          SUM(Faturamento) OVER() *100 as Porcentagem, 
          DENSE_RANK() OVER(ORDER BY Ticket_Medio DESC) as Posicao
FROM cte_contoso;
