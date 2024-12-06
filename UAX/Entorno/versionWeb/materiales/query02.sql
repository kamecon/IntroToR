
SELECT CustomerID AS IDCliente,
       Email AS Correo,
       Country AS Pais,
       Gender AS Genero
FROM clientes
WHERE Country = 'China'
  AND Gender = 'Male'
LIMIT 5
