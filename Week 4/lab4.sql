/*
     Assignment: Lab-04
     Due: 2-22-2021 11:59pm
     Points: 5 pts each = 25
     Author: John Doll
*/
/*======================================================== ProductOrders */
USE ProductOrders;
GO

/* ---------------------------------------------------------------------- Q1
    Write a query that returns list of items each customer has purchased.
    Return CustID, OrderID, Quantity, Title, and UnitPrice. Order the list
    by custID and then OrderID

    First 5 Rows:
    -----------------------------------------------------------------
    1    19    1    On The Road With Burt Ruggles                   17.50
    1    479   1    More Songs About Structures and Comestibles     17.95
    1    479   2    Umami In Concert                                17.95
    1    824   2    Rude Noises                                     13.00
    1    824   1    No Rest For The Weary                           16.95

*/


SELECT  o.CustID, 
        o.OrderID, 
        od.Quantity, 
        i.Title, 
        i.UnitPrice
FROM Orders o        
    JOIN OrderDetails od    ON o.OrderID = od.OrderID
    JOIN Items i            ON od.ItemID = i.ItemID
ORDER BY o.CustID, o.OrderID



/* ---------------------------------------------------------------------- Q2
    Write a query that returns list of customers and how much they have
    spent in orders and how many orders they have. Return the CustID, a 
    field called TotalAmountPaid, and a field called TotalOrders. Order 
    the list by the CustID.

        First 5 Rows:
        -------------
        1    114.30   3
        2    76.90    4
        3    34.90    2
        4    13.00    1
        5    17.95    1


*/


SELECT  o.CustID,
        [TotalAmountPaid] = SUM(od.Quantity * i.UnitPrice),
        [TotalOrders] = COUNT(DISTINCT o.OrderID)
FROM Orders o           
    JOIN OrderDetails od    ON o.OrderID = od.OrderID
    JOIN Items i            ON i.ItemID = od.ItemID
GROUP BY o.CustID
ORDER BY o.CustID

--orders that dont have items
SELECT o.*
FROM Orders o
WHERE o.OrderID NOT IN (SELECT OrderID FROM OrderDetails)

--better version
SELECT *
FROM Orders o
    LEFT JOIN OrderDetails od ON o.OrderID = od.OrderID --if take out LEFT returns 1 less row, the null row
WHERE od.OrderID IS NULL




/* ---------------------------------------------------------------------- Q3
    Write a query that returns a list of Customers that have not ordered

    0 Rows returned
*/

SELECT c.custID
FROM Customers c
    LEFT JOIN Orders o ON c.CustID = o.CustID
WHERE o.OrderID IS NULL





/*============================================================= Examples */
USE Examples;
GO

/* ---------------------------------------------------------------------- Q4
    Write a query that retuns the top 3 sales reps with the most total 
    sales Return first name, last name and the total sales called TotalSales

    Result:
    ----------------------------------
    Jonathon    Thomas        3196940.69
    Sonja       Martinez      2841015.55
    Andrew       Markasian    2165620.04
*/

SELECT TOP(3) 
        sr.RepFirstName, 
        sr.RepLastName, 
        [TotalSales] = SUM(st.SalesTotal)
FROM SalesReps sr
    JOIN SalesTotals st ON sr.RepID = st.RepID
GROUP BY sr.RepID, sr.RepFirstName, sr.RepLastName
ORDER BY SUM(st.SalesTotal) DESC







/* ---------------------------------------------------------------------- Q5
    Write a query that retuns the total sales per year. Return the year
    and a field called TotalSales. Sort the list from the highest sales
    to the lowest


    Result:
    ------------------
    2015    4109980.00
    2014    3286197.85
    2016    2003659.02
*/

SELECT  st.SalesYear,
        [TotalSales] = SUM(st.SalesTotal)
FROM SalesTotals st
GROUP BY st.SalesYear
ORDER BY SUM(st.SalesTotal) DESC