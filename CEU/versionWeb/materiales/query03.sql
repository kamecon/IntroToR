
SELECT
  ordenes.OrderID AS Pedido,
  ordenes.CustomerID AS Cliente,
  clientes.Email AS Correo,
  clientes.Country AS Pais,
  clientes.Gender AS Genero
FROM ordenes
LEFT JOIN clientes
  ON ordenes.CustomerID = clientes.CustomerID
WHERE clientes.Country = 'China'
LIMIT 5