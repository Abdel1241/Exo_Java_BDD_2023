<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Résultats de Recherche</title>
</head>
<body>
    <h1>Résultats de Recherche pour l'Année Spécifiée</h1>
    <%
    String annee = request.getParameter("annee");
    if (annee != null && !annee.trim().isEmpty()) {
        try {
            String url = "jdbc:mariadb://localhost:3306/films";
            String user = "mysql";
            String password = "mysql";
            Class.forName("org.mariadb.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, user, password);

            String sql = "SELECT idFilm, titre, année FROM Film WHERE année = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(annee));
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                out.println("ID: " + rs.getString("idFilm") + ", Titre: " + rs.getString("titre") + ", Année: " + rs.getInt("année") + "<br>");
            }
            rs.close();
            pstmt.close();
            conn.close();
        } catch (Exception e) {
            out.println("Erreur: " + e.getMessage());
        }
    } else {
        out.println("Aucune année spécifiée.");
    }
    %>
</body>
</html>
