<%--
  Created by IntelliJ IDEA.
  User: DAW
  Date: 29/11/2023
  Time: 18:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="estilos.css" />
    <title>Formulario Entrenamiento de Socios</title>
</head>
<body>

    <h1>Entrenamiento</h1>
    <form method="get" action="grabaEntrenamiento.jsp">

        <label>ID de Entrenamiento</label>
        <input type="text" name="entrenamientoID" required/>
        <br>

        <label>ID de Socio</label>
        <input type="text" name="socioID" required/>
        <br>

        <label>Tipo de Entrenamiento</label>
        <select name="tipo">
            <option>Físico</option>
            <option>Técnico</option>
        </select>
        <br>

        <label>Ubicación</label>
        <input type="text" name="ubicacion"/>
        <br>

        <label>Fecha de Realizacion</label>
        <input type="date" name="fecha"/>
        <br>

        <input type="submit" value="Enviar">
    </form>

</body>
</html>