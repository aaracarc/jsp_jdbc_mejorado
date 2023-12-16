<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.util.Objects" %><%--
  Created by IntelliJ IDEA.
  User: DAW
  Date: 29/11/2023
  Time: 18:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>

    <%
        //CÓDIGO DE VALIDACIÓN
        boolean valida = true;
        int idEntrenamiento = -1;
        int idSocio = -1;
        String tipo = null;
        String ubicacion = null;
        String fecha = null;

        boolean flagValidaIdEntrenamiento = false;
        boolean flagValidaIdSocio = false;
        boolean flagValidaTipoNull = false;
        boolean flagValidaTipoBlank = false;
        boolean flagValidaUbicacionNull = false;
        boolean flagValidaUbicacionBlank = false;
        boolean flagValidaFechaNull = false;
        boolean flagValidaFechaBlank = false;

        try {
            idEntrenamiento = Integer.parseInt(request.getParameter("entrenamientoID"));
            flagValidaIdEntrenamiento = true;

            idSocio = Integer.parseInt(request.getParameter("socioID"));
            flagValidaIdSocio = true;

            Objects.requireNonNull(request.getParameter("tipo"));
            flagValidaTipoNull = true;
            if (request.getParameter("tipo").isBlank()) throw new RuntimeException("Parámetro vacío o todo espacios blancos.");
            flagValidaTipoBlank = true;
            tipo = request.getParameter("tipo");

            Objects.requireNonNull(request.getParameter("ubicacion"));
            flagValidaUbicacionNull = true;
            if (request.getParameter("ubicacion").isBlank()) throw new RuntimeException("Parámetro vacío o todo espacios blancos.");
            flagValidaUbicacionBlank = true;
            ubicacion = request.getParameter("ubicacion");

            Objects.requireNonNull(request.getParameter("fecha"));
            flagValidaFechaNull = true;
            if (request.getParameter("fecha").isBlank()) throw new RuntimeException("Parámetro vacío o todo espacios blancos.");
            flagValidaFechaBlank = true;
            fecha = request.getParameter("fecha");

        } catch (Exception ex) {
            ex.printStackTrace();

            if (!flagValidaIdEntrenamiento) {
                session.setAttribute("error", "Error en idEntrenamiento.");
            } else if (!flagValidaIdSocio){
                session.setAttribute("error", "Error en idSocio.");
            }else if (!flagValidaTipoNull || !flagValidaTipoBlank) {
                session.setAttribute("error", "Error en Tipo.");
            } else if (!flagValidaUbicacionNull || !flagValidaUbicacionBlank) {
                session.setAttribute("error", "Error en Ubicacion.");
            } else if (!flagValidaFechaNull || !flagValidaFechaBlank) {
                session.setAttribute("error", "Error en Fecha.");
            }
            valida = false;
        }
        //FIN CÓDIGO DE VALIDACIÓN

        if (valida) {
            Connection conn = null;
            PreparedStatement ps = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/baloncesto", "root", "user");

                String sql = "INSERT INTO entrenamiento VALUES ( " +
                        "?, " + //entrenamientoID
                        "?, " + //socioID
                        "?, " + //tipo de entrenamiento
                        "?, " + //ubicacion
                        "?)"; //fecha de realización

                ps = conn.prepareStatement(sql);
                int idx = 1;
                ps.setInt(idx++, idEntrenamiento);
                ps.setInt(idx++, idSocio);
                ps.setString(idx++, tipo);
                ps.setString(idx++, ubicacion);
                ps.setString(idx++, fecha);

                int filasAfectadas = ps.executeUpdate();
                System.out.println("ENTRENAMIENTOS GRABADOS:  " + filasAfectadas);


            } catch (Exception ex) {
                ex.printStackTrace();
            } finally {
                try {
                    ps.close();
                } catch (Exception e) { /* Ignored */ }
                try {
                    conn.close();
                } catch (Exception e) { /* Ignored */ }
            }

            session.setAttribute("entrenamientoIDAdestacar", idEntrenamiento);
            response.sendRedirect("listadoEntrenamientos.jsp");

        } else {
            response.sendRedirect("formularioEntrenamientoSocio.jsp");
        }
    %>

</body>
</html>
