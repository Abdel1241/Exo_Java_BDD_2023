<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Connexion à MariaDB via JSP</title>
</head>
<body>
    <h1>Exemple de connexion à MariaDB avec JSP</h1>

    <h2>Exercice 1 : Les films entre deux années spécifiées</h2>
    <form method="get">
        <label for="anneeDebut">Année de début :</label>
        <input type="number" id="anneeDebut" name="anneeDebut" required>
        <label for="anneeFin">Année de fin :</label>
        <input type="number" id="anneeFin" name="anneeFin" required>
        <input type="submit" value="Rechercher">
    </form>

    <% 
    // Variables pour les années spécifiées par l'utilisateur
    String anneeDebut = request.getParameter("anneeDebut");
    String anneeFin = request.getParameter("anneeFin");
    if (anneeDebut != null && anneeFin != null) {
        try {
            String url = "jdbc:mariadb://localhost:3306/films";
            String user = "mysql";
            String password = "mysql";
            Class.forName("org.mariadb.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, user, password);

            String sql = "SELECT idFilm, titre, année FROM Film WHERE année >= ? AND année <= ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(anneeDebut));
            pstmt.setInt(2, Integer.parseInt(anneeFin));
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
    }
    %>

    <!-- Les autres exercices doivent être traités dans leurs fichiers JSP respectifs -->
    <!-- Exercice 2 : Année de recherche -->
    <h2>Exercice 2 : Année de recherche</h2>
    <h1>Résultats de Recherche pour l'Année Spécifiée</h1>
    <%
    String annee = request.getParameter("annee");
    if (annee != null) {
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
    }
    %>

    <!-- Exercice 3 : Modification du titre du film -->
    <h2>Exercice 3 : Modification du titre du film</h2>
    <%
    String idFilm = request.getParameter("idFilm");
    String nouveauTitre = request.getParameter("nouveauTitre");
    if (idFilm != null && nouveauTitre != null) {
        try {
            String url = "jdbc:mariadb://localhost:3306/films";
            String user = "mysql";
            String password = "mysql";
            Class.forName("org.mariadb.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, user, password);

            String sql = "UPDATE Film SET titre = ? WHERE idFilm = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, nouveauTitre);
            pstmt.setInt(2, Integer.parseInt(idFilm));
            int affectedRows = pstmt.executeUpdate();

            out.println(affectedRows + " ligne(s) mise(s) à jour.");
            pstmt.close();
            conn.close();
        } catch (Exception e) {
            out.println("Erreur: " + e.getMessage());
        }
    }
    %>

    <!-- Exercice 4 : La valeur maximum -->
    <h2>Exercice 4 : La valeur maximum</h2>
     <%
    String titre = request.getParameter("titre");
    String annee = request.getParameter("annee");
    if (titre != null && annee != null) {
        try {
            String url = "jdbc:mariadb://localhost:3306/films";
            String user = "mysql";
            String password = "mysql";
            Class.forName("org.mariadb.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, user, password);

            String sql = "INSERT INTO Film (titre, année) VALUES (?, ?)";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, titre);
            pstmt.setInt(2, Integer.parseInt(annee));
            int affectedRows = pstmt.executeUpdate();

            out.println(affectedRows + " film ajouté.");
            pstmt.close();
            conn.close();
        } catch (Exception e) {
            out.println("Erreur: " + e.getMessage());
        }
    }
    %>
</body>
</html>
