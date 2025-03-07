import com.megacitycab.megacitycab.dao.DriverDAO;
import com.megacitycab.megacitycab.model.Driver;
import com.megacitycab.megacitycab.service.DriverService;
import org.junit.jupiter.api.*;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
class DriverServiceTest {
    private static DriverService driverService;

    @BeforeAll
    static void setUp() throws SQLException {
        Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/megacity_cab_test", "root", "1234"); // Use your test DB credentials
        DriverDAO driverDAO = new DriverDAO(connection);
        driverService = new DriverService(driverDAO);
    }

    @Test
    @Order(1)
    void testAddDriver() throws SQLException {
        System.out.println("Running testAddDriver...");
        Driver driver = new Driver("D001", "Alice Brown", "0123456789");
        driverService.addDriver(driver);
        Driver retrievedDriver = driverService.getAllDrivers().stream()
                .filter(d -> d.getDriverId().equals("D001"))
                .findFirst()
                .orElse(null);
        assertNotNull(retrievedDriver);
        assertEquals("Alice Brown", retrievedDriver.getName());
        System.out.println("testAddDriver passed!");
    }

    @Test
    @Order(2)
    void testGetAllDrivers() throws SQLException {
        System.out.println("Running testGetAllDrivers...");
        List<Driver> drivers = driverService.getAllDrivers();
        assertFalse(drivers.isEmpty());
        System.out.println("testGetAllDrivers passed!");
    }

    @Test
    @Order(3)
    void testUpdateDriver() throws SQLException {
        System.out.println("Running testUpdateDriver...");
        Driver driver = new Driver("D001", "Alice Updated", "0987654321");
        driverService.updateDriver(driver);
        Driver updatedDriver = driverService.getAllDrivers().stream()
                .filter(d -> d.getDriverId().equals("D001"))
                .findFirst()
                .orElse(null);
        assertNotNull(updatedDriver);
        assertEquals("Alice Updated", updatedDriver.getName());
        System.out.println("testUpdateDriver passed!");
    }

    @Test
    @Order(4)
    void testDeleteDriver() throws SQLException {
        System.out.println("Running testDeleteDriver...");
        driverService.deleteDriver("D001");
        Driver deletedDriver = driverService.getAllDrivers().stream()
                .filter(d -> d.getDriverId().equals("D001"))
                .findFirst()
                .orElse(null);
        assertNull(deletedDriver);
        System.out.println("testDeleteDriver passed!");
    }
}
