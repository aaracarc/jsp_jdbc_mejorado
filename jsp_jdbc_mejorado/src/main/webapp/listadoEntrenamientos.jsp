<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.DriverManager" %><%--
  Created by IntelliJ IDEA.
  User: DAW
  Date: 29/11/2023
  Time: 18:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="../estilos.css" />
    <title>Listado Entrenamiento de Socios</title>
</head>
<body>

    <h1>Listado de Entrenamientos</h1>
    <%
        Connection conexion = null;
        Statement s = null;
        ResultSet listado = null;

        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/baloncesto","root", "user");
            s = conexion.createStatement();
            listado = s.executeQuery ("SELECT entrenamiento.*, nombre FROM entrenamiento NATURAL JOIN socio");
    %>

    <table>
        <tr><th>Codigo</th><th>Socio</th><th>Tipo</th><th>Ubicacion</th><th>Fecha</th><th><a href="formularioEntrenamientoSocio.jsp">+</a></th></tr>
        <%
            while (listado.next()) {
                out.println("<tr><td>"+listado.getString("entrenamientoID") + "</td>");
                out.println("<td>" + listado.getString("nombre") + "</td>");
                out.println("<td>" + listado.getString("tipo_entrenamiento") + "</td>");
                out.println("<td>" + listado.getString("ubicacion") + "</td>");
                out.println("<td>" + listado.getString("fecha_realizacion") + "</td>");
        %>

        <td>
            <form method="get" action="borraEntrenamiento.jsp">
                <input type="hidden" name="codigo" value="<%=listado.getString("entrenamientoID") %>"/>
                <input type="submit" value="borrar">
            </form>
        </td></tr>

        <%
                }
            // Cierre de recursos.
                conexion.close();
                s.close();
                listado.close();

            }catch (Exception e){
                out.println("Error");
            }  finally {
                try {
                    conexion.close();
                } catch (Exception e) { /* Ignored */ }
                try {
                    s.close();
                } catch (Exception e) { /* Ignored */ }
                try {
                    listado.close();
                } catch (Exception e) { /* Ignored */ }
            }
        %>
    </table>
    <a href="index.jsp">Volver</a>
</body>
</html>
