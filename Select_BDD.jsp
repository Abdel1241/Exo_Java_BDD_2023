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
    <% 
    String url = "jdbc:mariadb://localhost:3306/films";
    String user = "mysql";
    String password = "mysql";
    try {
        // Charger le pilote JDBC
        Class.forName("org.mariadb.jdbc.Driver");

        // Établir la connexion
        Connection conn = DriverManager.getConnection(url, user, password);

        // Exemple de requête SQL
        String sql = "SELECT idFilm, titre, année FROM Film WHERE année >= 2000 AND année <= 2015";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        ResultSet rs = pstmt.executeQuery();

        // Afficher les résultats
        while (rs.next()) {
            String idFilm = rs.getString("idFilm");
            String titre = rs.getString("titre");
            int annee = rs.getInt("année");
            out.println("ID: " + idFilm + ", Titre: " + titre + ", Année: " + annee + "<br>");
        }

        // Fermer les ressources
        rs.close();
        pstmt.close();
        conn.close();
    } catch (Exception e) {
        out.println("Erreur: " + e.getMessage());
    }
    %>

    <h2>Exercice 1 : Les films entre deux années spécifiées</h2>
    <form method="get">
        <label for="anneeDebut">Année de début :</label>
        <input type="number" id="anneeDebut" name="anneeDebut" required>
        <label for="anneeFin">Année de fin :</label>
        <input type="number" id="anneeFin" name="anneeFin" required>
        <input type="submit" value="Rechercher">
    </form>

    <h2>Exercice 2 : Année de recherche</h2>
<form action="rechercheAnnee.jsp" method="get">
    <label for="annee">Entrez une année pour la recherche:</label>
    <input type="number" id="annee" name="annee" required>
    <input type="submit" value="Rechercher">
</form>

<h2>Exercice 3 : Modification du titre du film</h2>
<form action="modifierTitre.jsp" method="post">
    <label for="idFilm">ID du film:</label>
    <input type="text" id="idFilm" name="idFilm" required>
    <label for="nouveauTitre">Nouveau titre:</label>
    <input type="text" id="nouveauTitre" name="nouveauTitre" required>
    <input type="submit" value="Modifier le titre">
</form>

<h2>Exercice 4 : La valeur maximum</h2>
<form action="ajouterFilm.jsp" method="post">
    <label for="titre">Titre du film:</label>
    <input type="text" id="titre" name="titre" required>
    <label for="annee">Année:</label>
    <input type="number" id="annee" name="annee" required>
    <input type="submit" value="Ajouter un film">
</form>

</body>
</html>
