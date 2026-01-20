<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Liste des Stages - Gestion des Stages</title>
            <style>
                body {
                    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                    background: linear-gradient(135deg, #3754dd 0%, #040f2e 100%);
                    min-height: 100vh;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    padding: 20px;
                }

                .container {
                    background: white;
                    border-radius: 20px;
                    box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
                    max-width: 1000px;
                    width: 100%;
                    padding: 40px;
                }

                h1 {
                    color: #667eea;
                    text-align: center;
                    margin-bottom: 30px;
                }

                table {
                    width: 100%;
                    border-collapse: collapse;
                    margin-top: 20px;
                }

                th,
                td {
                    padding: 15px;
                    text-align: left;
                    border-bottom: 1px solid #ddd;
                }

                th {
                    background-color: #f8f9fa;
                    color: #333;
                    font-weight: bold;
                }

                tr:hover {
                    background-color: #f1f1f1;
                }

                .actions {
                    display: flex;
                    gap: 10px;
                }

                .btn {
                    text-decoration: none;
                    padding: 8px 15px;
                    border-radius: 5px;
                    color: white;
                    font-size: 0.9em;
                    transition: background 0.3s;
                }

                .btn-delete {
                    background-color: #f44336;
                }

                .btn-back {
                    display: inline-block;
                    margin-bottom: 20px;
                    background-color: #667eea;
                    color: white;
                    padding: 10px 20px;
                    text-decoration: none;
                    border-radius: 5px;
                }
            </style>
        </head>

        <body>
            <div class="container">
                <a href="index.html" class="btn-back">← Retour à l'accueil</a>
                <h1>💼 Liste des Stages</h1>

                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Titre</th>
                            <th>Entreprise</th>
                            <th>Étudiant</th>
                            <th>Dates</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="internship" items="${internships}">
                            <tr>
                                <td>${internship.id}</td>
                                <td>${internship.title}</td>
                                <td>${internship.company.name}</td>
                                <td>${internship.student.firstName} ${internship.student.lastName}</td>
                                <td>${internship.startDate} - ${internship.endDate}</td>
                                <td class="actions">
                                    <a href="#" class="btn btn-delete">Supprimer</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </body>

        </html>