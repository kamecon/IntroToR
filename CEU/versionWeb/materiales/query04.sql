
SELECT clientes.FirstName,
        clientes.LastName,
        productos.Category,
        COUNT(ordenes.OrderID) AS ordenes,
        SUM(ordenes.TotalAmount) AS total
FROM clientes
JOIN ordenes ON clientes.CustomerID = ordenes.CustomerID
JOIN productos ON ordenes.OrderID = productos.ProductID
GROUP BY clientes.CustomerID, productos.Category
LIMIT 10;