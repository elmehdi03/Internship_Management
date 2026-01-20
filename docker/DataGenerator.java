import java.sql.*;
import java.time.LocalDate;
import java.util.Random;

public class DataGenerator {
    private static final String DB_URL = "jdbc:mysql://" +
        System.getenv().getOrDefault("DB_HOST", "mysql") + ":" +
        System.getenv().getOrDefault("DB_PORT", "3306") + "/" +
        System.getenv().getOrDefault("DB_NAME", "internship_management") +
        "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    private static final String DB_USER = System.getenv().getOrDefault("DB_USER", "root");
    private static final String DB_PASSWORD = System.getenv().getOrDefault("DB_PASSWORD", "rootpassword");

    private static final Random random = new Random();

    // Données de test
    private static final String[] FIRST_NAMES = {
        "Alice", "Bob", "Charlie", "Diana", "Ethan", "Fiona", "George", "Hannah",
        "Ivan", "Julia", "Kevin", "Laura", "Michael", "Nina", "Oscar", "Paula"
    };

    private static final String[] LAST_NAMES = {
        "Martin", "Bernard", "Dubois", "Thomas", "Robert", "Richard", "Petit", "Durand",
        "Leroy", "Moreau", "Simon", "Laurent", "Lefebvre", "Michel", "Garcia", "David"
    };

    private static final String[] PROMOTIONS = {
        "2023", "2024", "2025", "2026"
    };

    private static final String[] COMPANY_NAMES = {
        "TechCorp", "InnovateSoft", "DataSystems", "CloudServices", "AI Solutions",
        "WebDev Inc", "Mobile First", "Cyber Security Co", "FinTech Group", "GameStudio",
        "E-Commerce Plus", "Analytics Pro", "DevOps Masters", "Blockchain Tech", "IoT Innovations"
    };

    private static final String[] SECTORS = {
        "Technologie", "Finance", "Santé", "Éducation", "Commerce",
        "Industrie", "Services", "Télécommunications", "Médias", "Transport"
    };

    private static final String[] CITIES = {
        "Paris", "Lyon", "Marseille", "Toulouse", "Nice", "Nantes",
        "Strasbourg", "Montpellier", "Bordeaux", "Lille", "Rennes", "Reims"
    };

    private static final String[] INTERNSHIP_TITLES = {
        "Stage Développeur Full Stack", "Stage Data Analyst", "Stage DevOps",
        "Stage Développeur Mobile", "Stage Cybersécurité", "Stage UI/UX Designer",
        "Stage Chef de Projet", "Stage Business Analyst", "Stage Marketing Digital",
        "Stage Développeur Backend", "Stage Développeur Frontend", "Stage QA Engineer"
    };

    public static void main(String[] args) {
        System.out.println("=== Démarrage du générateur de données ===");

        // Attendre que la base de données soit prête
        waitForDatabase();

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            System.out.println("Connexion à la base de données réussie!");

            // Vérifier si des données existent déjà
            if (dataExists(conn)) {
                System.out.println("Des données existent déjà dans la base. Génération annulée.");
                return;
            }

            // Générer les données
            System.out.println("Génération des étudiants...");
            generateStudents(conn, 20);

            System.out.println("Génération des entreprises...");
            generateCompanies(conn, 15);

            System.out.println("Génération des stages...");
            generateInternships(conn, 30);

            System.out.println("=== Génération terminée avec succès! ===");

        } catch (SQLException e) {
            System.err.println("Erreur lors de la génération des données: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private static void waitForDatabase() {
        int maxRetries = 30;
        int retryCount = 0;

        while (retryCount < maxRetries) {
            try {
                System.out.println("Tentative de connexion à la base de données... (" + (retryCount + 1) + "/" + maxRetries + ")");
                Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                conn.close();
                System.out.println("Base de données prête!");
                return;
            } catch (SQLException e) {
                retryCount++;
                try {
                    Thread.sleep(2000);
                } catch (InterruptedException ie) {
                    Thread.currentThread().interrupt();
                }
            }
        }

        System.err.println("Impossible de se connecter à la base de données après " + maxRetries + " tentatives.");
        System.exit(1);
    }

    private static boolean dataExists(Connection conn) throws SQLException {
        String query = "SELECT COUNT(*) FROM student";
        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        }
        return false;
    }

    private static void generateStudents(Connection conn, int count) throws SQLException {
        String sql = "INSERT INTO student (first_name, last_name, email, promotion) VALUES (?, ?, ?, ?)";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            for (int i = 0; i < count; i++) {
                String firstName = FIRST_NAMES[random.nextInt(FIRST_NAMES.length)];
                String lastName = LAST_NAMES[random.nextInt(LAST_NAMES.length)];
                String email = firstName.toLowerCase() + "." + lastName.toLowerCase() + i + "@university.com";
                String promotion = PROMOTIONS[random.nextInt(PROMOTIONS.length)];

                pstmt.setString(1, firstName);
                pstmt.setString(2, lastName);
                pstmt.setString(3, email);
                pstmt.setString(4, promotion);
                pstmt.executeUpdate();
            }
        }
        System.out.println(count + " étudiants générés.");
    }

    private static void generateCompanies(Connection conn, int count) throws SQLException {
        String sql = "INSERT INTO company (name, sector, city) VALUES (?, ?, ?)";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            for (int i = 0; i < count; i++) {
                String name = COMPANY_NAMES[i % COMPANY_NAMES.length] + (i >= COMPANY_NAMES.length ? " " + (i / COMPANY_NAMES.length) : "");
                String sector = SECTORS[random.nextInt(SECTORS.length)];
                String city = CITIES[random.nextInt(CITIES.length)];

                pstmt.setString(1, name);
                pstmt.setString(2, sector);
                pstmt.setString(3, city);
                pstmt.executeUpdate();
            }
        }
        System.out.println(count + " entreprises générées.");
    }

    private static void generateInternships(Connection conn, int count) throws SQLException {
        String sql = "INSERT INTO internship (title, start_date, end_date, description, student_id, company_id) VALUES (?, ?, ?, ?, ?, ?)";

        // Récupérer les IDs des étudiants et entreprises
        int maxStudentId = getMaxId(conn, "student");
        int maxCompanyId = getMaxId(conn, "company");

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            for (int i = 0; i < count; i++) {
                String title = INTERNSHIP_TITLES[random.nextInt(INTERNSHIP_TITLES.length)];
                LocalDate startDate = LocalDate.now().minusMonths(random.nextInt(24)).plusDays(random.nextInt(30));
                LocalDate endDate = startDate.plusMonths(3 + random.nextInt(3));
                String description = "Description du stage: " + title + ". Expérience enrichissante dans le domaine.";
                int studentId = random.nextInt(maxStudentId) + 1;
                int companyId = random.nextInt(maxCompanyId) + 1;

                pstmt.setString(1, title);
                pstmt.setDate(2, Date.valueOf(startDate));
                pstmt.setDate(3, Date.valueOf(endDate));
                pstmt.setString(4, description);
                pstmt.setInt(5, studentId);
                pstmt.setInt(6, companyId);
                pstmt.executeUpdate();
            }
        }
        System.out.println(count + " stages générés.");
    }

    private static int getMaxId(Connection conn, String tableName) throws SQLException {
        String query = "SELECT MAX(id) FROM " + tableName;
        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }
}

