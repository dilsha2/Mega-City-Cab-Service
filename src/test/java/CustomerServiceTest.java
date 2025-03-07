import com.megacitycab.megacitycab.dao.CustomerDAO;
import com.megacitycab.megacitycab.model.Customer;
import com.megacitycab.megacitycab.service.CustomerService;
import org.junit.jupiter.api.*;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
class CustomerServiceTest {
    private static CustomerService customerService;

    @BeforeAll
    static void setUp() throws SQLException {
        Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/megacity_cab_test", "root", "1234"); // Use your test DB credentials
        CustomerDAO customerDAO = new CustomerDAO(connection);
        customerService = new CustomerService(customerDAO);
    }

    @Test
    @Order(1)
    void testRegisterCustomer() throws SQLException {
        System.out.println("Running testRegisterCustomer...");
        customerService.registerCustomer("C001", "John Doe", "123 Main St", "987654321V", "0771234567");
        Customer customer = customerService.getCustomerByRegistrationNumber("C001");
        assertNotNull(customer);
        assertEquals("John Doe", customer.getName());
        System.out.println("testRegisterCustomer passed!");
    }

    @Test
    @Order(2)
    void testGetAllCustomers() throws SQLException {
        System.out.println("Running testGetAllCustomers...");
        List<Customer> customers = customerService.getAllCustomers();
        assertFalse(customers.isEmpty());
        System.out.println("testGetAllCustomers passed!");
    }

    @Test
    @Order(3)
    void testUpdateCustomer() throws SQLException {
        System.out.println("Running testUpdateCustomer...");
        customerService.updateCustomer("C001", "John Updated", "456 Updated St", "987654321V", "0777654321");
        Customer updatedCustomer = customerService.getCustomerByRegistrationNumber("C001");
        assertNotNull(updatedCustomer);
        assertEquals("John Updated", updatedCustomer.getName());
        System.out.println("testUpdateCustomer passed!");
    }

    @Test
    @Order(4)
    void testDeleteCustomer() throws SQLException {
        System.out.println("Running testDeleteCustomer...");
        customerService.deleteCustomer("C001");
        Customer deletedCustomer = customerService.getCustomerByRegistrationNumber("C001");
        assertNull(deletedCustomer);
        System.out.println("testDeleteCustomer passed!");
    }
}