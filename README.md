## Route Structure

This section describes the route structure used in the application, defined with `GoRouter`.

### Main Routes

- `/` - **Default Page (Reservation Page for Now)**
- `/order` - **Waiter Ordering Page**
  - `/order/table` - **Waiter Table Selection Page**
  - `/order/itemTypes` - **Waiter Item Category Selection Page**
    - `/order/itemTypes/menuItems` - **Waiter Menu Item Selection Page**
  - `/order/overview` - **Waiter Order Overview Page**
  - `/order/confirmation` - **Waiter Order Confirmation Page**
- `/kitchen` - **Kitchen Page for Displaying Orders**

### Overview

| Route                        | Description                                 |
|------------------------------|---------------------------------------------|
| `/`                          | Default Page (Reservation Page)             |
| `/order`                     | Waiter Ordering Page                        |
| `/order/table`               | Waiter Table Selection Page                 |
| `/order/overview`            | Waiter Order Overview Page                  |
| `/order/confirmation`        | Waiter Order Confirmation Page              |
| `/order/itemTypes`           | Waiter Item Category Selection Page         |
| `/order/itemTypes/menuItems` | Waiter Menu Item Selection Page             |
| `/kitchen`                   | Kitchen Page for Displaying Orders          |

## Features

This section describes the features of the application. 
A feature is a part of the application that has a specific functionality and lives inside a features folder.

* **User** - Used for user authentication and authorization, as well as user data and profile management.
* **Order** - Used for managing orders, including creating, updating, and deleting orders. 
* **DisplayMenuItems** - Used for fetching and displaying menu items in the waiter ordering page. 
* **SelectTableForOrder** - Used for selecting a table for a new order. It displays a list of tables or reservations and allows the user to select multible tables for a new order.
* **OrderCart** - Used for managing the menu items in the waiter ordering page. It allows the user to add, remove, and update items in the cart before they are sent to the server.



    