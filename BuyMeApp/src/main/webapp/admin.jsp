<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import = "com.dbhelper.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>BuyMe</title>
    </head>
<body>

    <%
        DBHelper dbhelper = new DBHelper();
        Connection connection = dbhelper.getConnection();
        try{
            Statement statement = connection.createStatement();

            ///////////////////////////////////////////////////
            // Sales report
            ///////////////////////////////////////////////////


            // Total Earnings
            out.println("Total Earnings<br>");
            String sql = "SELECT COUNT('bidPrice') as ct FROM bidding WHERE didWin=1";
            ResultSet rs = statement.executeQuery(sql);
            while(rs.next()){
                String total_sales = rs.getString("ct");
                out.println(total_sales);
                out.println("<br>");
            }
            out.println("<br>");
            out.println("<br>");

            // Earnings per item
            out.println("Earnings per item<br>");
            sql = "WITH T1 AS ( SELECT P.productName as productName, B.bidPrice as price FROM product as P natural join auction as A natural join bidding as B where B.didWin = 1 ) SELECT T1.productName as product, sum(T1.price) as price FROM T1 GROUP BY T1.productName ORDER BY sum(T1.price) DESC";
            rs = statement.executeQuery(sql);
            while(rs.next()){
                String product_name = rs.getString("product");
                int earnings = rs.getInt("price");
                out.println(product_name + " " + earnings);
                out.println("<br>");
            }
            out.println("<br>");
            out.println("<br>");



            // Earnings per Item Type
            out.println("Earnings per Item Type<br>");
            sql = "WITH T1 as ( select C.categoryName, B.bidPrice from category as C natural join product as P natural join auction as A natural join bidding as B where didWin = 1 ) SELECT T1.categoryName as category, sum(T1.bidPrice) as earnings FROM T1 GROUP BY T1.categoryName ORDER BY sum(T1.bidPrice) DESC";
            rs = statement.executeQuery(sql);
            while(rs.next()){
                String category_name = rs.getString("category");
                int earnings = rs.getInt("earnings");
                out.println(category_name + " " + earnings);
                out.println("<br>");
            }
            out.println("<br>");
            out.println("<br>");



            // Earnings per Seller
            out.println("Earnings per Seller<br>");
            sql = "WITH T1 AS ( SELECT A.username as username, B.bidPrice as price from auction as A natural join bidding as B where B.didWin = 1 ) SELECT T1.username, sum(T1.price) as earnings FROM T1 GROUP BY T1.username ORDER BY sum(T1.price) DESC;";
            rs = statement.executeQuery(sql);
            while(rs.next()){
                String username = rs.getString("username");
                int earnings = rs.getInt("earnings");
                out.println(username + " " + earnings);
                out.println("<br>");
            }
            out.println("<br>");
            out.println("<br>");



            // Best Selling Item
            out.println("Best Selling Item<br>");
            sql = "WITH T1 as ( SELECT P.productName as productName, B.bidPrice as price FROM bidding as B NATURAL JOIN auction as A NATURAL JOIN product as P WHERE B.didWin=1 ) SELECT T1.productName as product, sum(T1.price) as earnings FROM T1 GROUP BY T1.productName ORDER BY sum(T1.price) DESC";
            rs = statement.executeQuery(sql);
            while(rs.next()){
                String product_name = rs.getString("product");
                int maxCount = rs.getInt("earnings");
                out.println(product_name + " " + maxCount);
                out.println("<br>");
            }
            out.println("<br>");
            out.println("<br>");




            // Best Buyers
            out.println("Best Buyers<br>");
            sql = "WITH T1 as ( SELECT A.username, B.bidPrice as price FROM auction as A NATURAL JOIN bidding as B WHERE B.didWin = 1 ) SELECT T1.username as username, sum(T1.price) as earnings FROM T1 group by T1.username ORDER BY sum(T1.price) DESC LIMIT 5";
            rs = statement.executeQuery(sql);
            while(rs.next()){
                String username = rs.getString("username");
                int earnings = rs.getInt("earnings");
                out.println(username + " " + earnings);
                out.println("<br>");
            }
            out.println("<br>");
            out.println("<br>");
            

        }catch(Exception e){
 		    out.println(e.getMessage());
 	    }
    %>
</body>
</html>