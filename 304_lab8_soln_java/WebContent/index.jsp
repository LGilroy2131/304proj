<!DOCTYPE html>
<html>
<head>
        <title>BCWS Tool Shed Main Page</title>
</head>
<body>
<h1 align="center">Welcome to the BCWS Tool Shed</h1>

<h2 align="center"><a href="login.jsp">Login</a></h2>

<h2 align="center"><a href="createuser.jsp">Create User</a></h2>

<h2 align="center"><a href="listprod.jsp">Begin Shopping</a></h2>

<h2 align="center"><a href="listorder.jsp">List All Orders</a></h2>

<h2 align="center"><a href="customer.jsp">Customer Info</a></h2>

<h2 align="center"><a href="admin.jsp">Administrators</a></h2>

<h2 align="center"><a href="logout.jsp">Log out</a></h2>


<%
	String userName = (String) session.getAttribute("authenticatedUser");
	if (userName != null)
		out.println("<h3 align=\"center\">Signed in as: "+userName+"</h3>");
%>
</body>
</head>


