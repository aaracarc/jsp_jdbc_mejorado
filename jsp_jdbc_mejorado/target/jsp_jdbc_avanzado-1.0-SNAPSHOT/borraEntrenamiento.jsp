<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.DriverManager" %><%--
  Created by IntelliJ IDEA.
  User: DAW
  Date: 29/11/2023
  Time: 18:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>

    <%
        boolean valida = true;
        int codigo = -1;
        try {
            codigo = Integer.parseInt(request.getParameter("codigo"));
        } catch (NumberFormatException nfe) {
            nfe.printStackTrace();
            valida = false;
        }

        if (valida) {
            Connection conn = null;
            PreparedStatement ps = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/baloncesto","root", "user");

                //UTILIZAR PreparedStatement SIEMPRE EN QUERIES PARAMETRIZADAS
                //NÓTESE QUE EL PARÁMETRO SE INTRODUCE CON UN CARÁCTER ?
                String sql = "DELETE FROM entrenamiento WHERE entrenamientoID = ?";
                ps = conn.prepareStatement(sql);

                //A LA HORA DE ESTABLECER EL VALOR DEL PARÁMETRO PARA PODER EJECUTAR
                //LA QUERY DEBEMOS INDICAR LA POSICIÓN Y UTILIZAR EL SETTER DE TIPO ADECUADO
                ps.setInt(1, codigo);

                //CUANDO EJECUTAS SENTENCIAS DML, INSERT, UPDATE, DELETE SE EMPLEA ps.executeUpdate()
                int filasAfectadas = ps.executeUpdate();

                System.out.println("ENTRENAMIENTOS BORRADOS:  " + filasAfectadas);
            } catch (Exception ex) {
                ex.printStackTrace();
            } finally {
                //BLOQUE FINALLY PARA CERRAR LA CONEXIÓN CON PROTECCIÓN DE try-catch
                //SIEMPRE HAY QUE CERRAR LOS ELEMENTOS DE LA  CONEXIÓN DESPUÉS DE UTILIZARLOS
                try { ps.close(); } catch (Exception e) { /* Ignored */ }
                try { conn.close(); } catch (Exception e) { /* Ignored */ }
            }
        }
    %>

    <!-- REDIRECCIÓN POR JavaScript EN EL CLIENTE  -->
    <script>document.location = "listadoEntrenamientos.jsp"</script>

</body>
</html>
