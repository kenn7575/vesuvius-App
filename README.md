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