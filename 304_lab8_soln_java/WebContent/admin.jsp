<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
</head>
<body>

<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>

<%
	String userName = (String) session.getAttribute("authenticatedUser");
%>

<%

// Print out total order amount by day
String sql = "select year(orderDate), month(orderDate), day(orderDate), SUM(totalAmount) FROM OrderSummary GROUP BY year(orderDate), month(orderDate), day(orderDate)";
String sql2 = "select userid, firstName, lastName from customer";
String sql3 = "select productName, productInventory.productId, quantity from productInventory join product on productInventory.productId = product.productId ";
NumberFormat currFormat = NumberFormat.getCurrencyInstance();

try 
{	
	out.println("<h3>Administrator Sales Report by Day</h3>");
	
	getConnection();
	Statement stmt = con.createStatement(); 
	stmt.execute("USE orders");

	// Display Order Summary
	ResultSet rst = con.createStatement().executeQuery(sql);		
	out.println("<table class=\"table\" border=\"1\">");
	out.println("<tr><th>Order Date</th><th>Total Order Amount</th>");	

	while (rst.next())
	{
		out.println("<tr><td>"+rst.getString(1)+"-"+rst.getString(2)+"-"+rst.getString(3)+"</td><td>"+currFormat.format(rst.getDouble(4))+"</td></tr>");
	}
	out.println("</table>");
	out.println();
	
	out.println("<h3>Customer List</h3>");

	// Display Customer List
	ResultSet rst2 = con.createStatement().executeQuery(sql2);
	out.println("<table class=\"table\" border=\"1\">");
	out.println("<tr><th>Customer ID</th><th>Customer Name</th>");

	while (rst2.next())
	{
		out.println("<tr><td>"+rst2.getString(1)+"</td><td>"+rst2.getString(2)+" "+rst2.getString(3)+"</td></tr>");
	}
	out.println("</table>");

	out.println("<h3>Warehouse Inventory</h3>");

	// Display warehouse inventory
	ResultSet rst3 = con.createStatement().executeQuery(sql3);
	out.println("<table class=\"table\" border=\"1\">");
	out.println("<tr><th>Product Name</th><th>Product ID</th><th>Inventory Quantity</th>");

	while (rst3.next())
	{
		out.println("<tr><td>"+rst3.getString(1)+"</td><td>"+rst3.getString(2)+"</td><td>"+rst3.getString(3)+"</td></tr>");
	}
	out.println("</table>");
}
catch (SQLException ex) 
{ 	out.println(ex); 
}
finally
{	
	closeConnection();	
}
%>

</body>
</html>

