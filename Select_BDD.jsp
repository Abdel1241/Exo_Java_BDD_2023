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
    <form method="get" action="#">
        <label for="rechercheAnnee">Entrez une année pour la recherche:</label>
        <input type="number" id="rechercheAnnee" name="rechercheAnnee" required>
        <input type="submit" value="Rechercher">
    </form>

    <% 
    String rechercheAnnee = request.getParameter("rechercheAnnee");
    if (rechercheAnnee != null && !rechercheAnnee.trim().isEmpty()) {
        try {
            String url = "jdbc:mariadb://localhost:3306/films";
            String user = "mysql";
            String password = "mysql";
            Class.forName("org.mariadb.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, user, password);

            String sql = "SELECT idFilm, titre, année FROM Film WHERE année = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(rechercheAnnee));
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
<form method="post" action="#">
    <label for="idFilm">ID du film:</label>
    <input type="text" id="idFilm" name="idFilm" required>
    <label for="nouveauTitre">Nouveau titre:</label>
    <input type="text" id="nouveauTitre" name="nouveauTitre" required>
    <input type="submit" value="Modifier le titre">
</form>

<% 
String idFilm = request.getParameter("idFilm");
String nouveauTitre = request.getParameter("nouveauTitre");
if (idFilm != null && nouveauTitre != null && !idFilm.trim().isEmpty() && !nouveauTitre.trim().isEmpty()) {
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

    <!-- Votre code existant pour les Exercices 1, 2 et 3 -->

<!-- Exercice 4 : La valeur maximum -->
<h2>Exercice 4 : Ajout d'un nouveau film</h2>
<form method="post" action="#">
    <label for="titre">Titre du film:</label>
    <input type="text" id="titre" name="titre" required>
    <label for="nouvelleAnneeFilm">Année:</label>
    <input type="number" id="nouvelleAnneeFilm" name="nouvelleAnneeFilm" required>
    <input type="submit" value="Ajouter un film">
</form>

<% 
String titre = request.getParameter("titre");
String nouvelleAnneeFilm = request.getParameter("nouvelleAnneeFilm");
if (titre != null && nouvelleAnneeFilm != null && !titre.trim().isEmpty() && !nouvelleAnneeFilm.trim().isEmpty()) {
    try {
        String url = "jdbc:mariadb://localhost:3306/films";
        String user = "mysql";
        String password = "mysql";
        Class.forName("org.mariadb.jdbc.Driver");
        Connection conn = DriverManager.getConnection(url, user, password);

        String sql = "INSERT INTO Film (titre, année) VALUES (?, ?)";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, titre);
        pstmt.setInt(2, Integer.parseInt(nouvelleAnneeFilm));
        int affectedRows = pstmt.executeUpdate();

        out.println(affectedRows + " film(s) ajouté(s).");
        pstmt.close();
        conn.close();
    } catch (Exception e) {
        out.println("Erreur: " + e.getMessage());
    }
}
%>

</body>
</html>
