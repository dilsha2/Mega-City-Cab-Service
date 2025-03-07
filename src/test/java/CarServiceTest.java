import com.megacitycab.megacitycab.dao.CarDAO;
import com.megacitycab.megacitycab.model.Car;
import com.megacitycab.megacitycab.service.CarService;
import org.junit.jupiter.api.*;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
public class CarServiceTest {

    private static CarService carService;

    @BeforeAll
    static void setUp() throws SQLException {
        Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/megacity_cab_test", "root", "1234"); // Use your test DB credentials
        CarDAO carDAO = new CarDAO(connection);
        carService = new CarService(carDAO);
    }

    @Test
    @Order(1)
    void testRegisterCar() throws SQLException {
        System.out.println("Running testRegisterCar...");

        Car car = new Car();
        car.setCarId("1");
        car.setModel("BMW");
        car.setPrice(1200.00);
        car.setLicensePlate("12");
        carService.addCar(car);

        Car car1 = carService.getCarById("1");
        assertNotNull(car1);
        assertEquals("BMW", car1.getModel());
        System.out.println("testCustomer passed!");
    }

    @Test
    @Order(2)
    void testGetAllCars() throws SQLException {
        System.out.println("Running testGetAllCars...");
        List<Car> cars = carService.getAllCars();
        assertFalse(cars.isEmpty());
        System.out.println("testGetAllCars passed!");
    }

    @Test
    @Order(3)
    void testUpdateCar() throws SQLException {
        System.out.println("Running testUpdateCar...");

        Car car = new Car();
        car.setModel("BMW_updated");
        car.setPrice(1200.00);
        car.setLicensePlate("12");

        carService.updateCar(car);
        Car carById = carService.getCarById("1");
        assertNotNull(carById);
        assertEquals("BMW_updated", carById.getModel());
        System.out.println("testUpdateCar passed!");
    }

    @Test
    @Order(4)
    void testDeletecar() throws SQLException {
        System.out.println("Running testDeleteCar...");
        carService.deleteCar("1");
        Car carById = carService.getCarById("1");
        assertNull(carById);
        System.out.println("testDeleteCar passed!");
    }

}
