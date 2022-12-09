<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>BCWS Product Information</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<%@ include file="header.jsp" %>

<%
// Get product name to search for
String productId = request.getParameter("id");

String sql = "SELECT productId, productName, productPrice, productImageURL, productImage FROM Product P  WHERE productId = ?";
String sql2 = "SELECT reviewRating, reviewDate, customerId, productId, reviewComment FROM review WHERE productId = ?";

NumberFormat currFormat = NumberFormat.getCurrencyInstance();

try 
{
	getConnection();
	Statement stmt = con.createStatement(); 			
	stmt.execute("USE orders");
	
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setInt(1, Integer.parseInt(productId));			
	
	ResultSet rst = pstmt.executeQuery();

	PreparedStatement pstmt2 = con.prepareStatement(sql2);
	pstmt2.setInt(1, Integer.parseInt(productId));			
	
	ResultSet rst2 = pstmt2.executeQuery();
			
	if (!rst.next())
	{
		out.println("Invalid product");
	}
	else
	{		
		out.println("<h2>"+rst.getString(2)+"</h2>");
		
		int prodId = rst.getInt(1);
		out.println("<table><tr>");
		out.println("<th>Id</th><td>" + prodId + "</td></tr>"				
				+ "<tr><th>Price</th><td>" + currFormat.format(rst.getDouble(3)) + "</td></tr>");
		
		//  Retrieve any image with a URL
		String imageLoc = rst.getString(4);
		if (imageLoc != null)
			out.println("<img src=\""+imageLoc+"\">");
		
		// Retrieve any image stored directly in database
		String imageBinary = rst.getString(5);
		if (imageBinary != null)
			out.println("<img src=\"displayImage.jsp?id="+prodId+"\">");	
		out.println("</table>");

		out.println("<h3><a href=\"addcart.jsp?id="+prodId+ "&name=" + rst.getString(2)
			+ "&price=" + rst.getDouble(3)+"\">Add to Cart</a></h3>");		

		out.println("<h3><a href=\"listprod.jsp\">Continue Shopping</a>");

		out.println();
		out.println("<h3>Reviews</h3>");
			
		out.println("<table class=\"table\" border=\"1\">");
		out.println("<tr><th>Review Rating</th><th>Date</th><th>Customer Id</th><th>Comments</th>");

		while(rst2.next())
		{
			out.println("<tr><td>"+rst2.getString(1)+"</td><td>"+rst2.getString(2)+"</td><td>"+rst2.getString(3)+"</td><td>"+rst2.getString(5)+"</td></tr>");
		}
		out.println("</table>");
	
}
} 
catch (SQLException ex) {
	out.println(ex);
}
finally
{
	closeConnection();
}
%>

</body>
</html>

