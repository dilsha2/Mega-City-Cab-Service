import com.megacitycab.megacitycab.dao.BookingDAO;
import com.megacitycab.megacitycab.model.Booking;
import com.megacitycab.megacitycab.model.Car;
import com.megacitycab.megacitycab.model.Customer;
import com.megacitycab.megacitycab.model.Driver;
import com.megacitycab.megacitycab.service.BookingService;
import org.junit.jupiter.api.*;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
class BookingServiceTest {
    private static BookingService bookingService;

    @BeforeAll
    static void setUp() throws SQLException {
        Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/megacity_cab_test", "root", "1234"); // Use your test DB credentials
        BookingDAO bookingDAO = new BookingDAO(connection);
        bookingService = new BookingService(bookingDAO);
    }

    @Test
    @Order(1)
    void testAddBooking() throws SQLException {
        System.out.println("Running testAddBooking...");
        Customer customer = new Customer("C001");
        Car car = new Car("1");
        Driver driver = new Driver("1");
        Booking booking = new Booking("B001", customer, "Destination A", 15.5, 200.0, car, driver);
        bookingService.addBooking(booking);

        List<Booking> bookings = bookingService.getAllBookings();
        assertFalse(bookings.isEmpty());
        assertEquals("Destination A", bookings.get(0).getDestination());
        System.out.println("testAddBooking passed!");
    }

    @Test
    @Order(2)
    void testGetAllBookings() throws SQLException {
        System.out.println("Running testGetAllBookings...");
        List<Booking> bookings = bookingService.getAllBookings();
        assertFalse(bookings.isEmpty());
        System.out.println("testGetAllBookings passed!");
    }

    @Test
    @Order(3)
    void testUpdateBooking() throws SQLException {
        System.out.println("Running testUpdateBooking...");
        Customer customer = new Customer("C001");
        Car car = new Car("1"); // Updating car
        Driver driver = new Driver("1"); // Updating car
        Booking booking = new Booking("B001", customer, "Updated Destination", 20.0, 250.0, car, driver);
        bookingService.updateBooking(booking);

        List<Booking> bookings = bookingService.getAllBookings();
        Booking updatedBooking = bookings.stream().filter(b -> b.getBookingNumber().equals("B001")).findFirst().orElse(null);

        assertNotNull(updatedBooking);
        assertEquals("Updated Destination", updatedBooking.getDestination());
        System.out.println("testUpdateBooking passed!");
    }

    @Test
    @Order(4)
    void testDeleteBooking() throws SQLException {
        System.out.println("Running testDeleteBooking...");
        bookingService.deleteBooking("B001");
        List<Booking> bookings = bookingService.getAllBookings();

        boolean isDeleted = bookings.stream().noneMatch(b -> b.getBookingNumber().equals("B001"));
        assertTrue(isDeleted);
        System.out.println("testDeleteBooking passed!");
    }
}
