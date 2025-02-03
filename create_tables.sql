--Create table Users
CREATE TABLE Users (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    UserName TEXT NOT NULL,
    Email TEXT UNIQUE NOT NULL,
    Password TEXT NOT NULL,
    Role TEXT NOT NULL CHECK (Role IN ('Admin', 'Customer'))
);

--Create table Products
CREATE TABLE Products (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    Name TEXT NOT NULL,
    Description TEXT,
    Price REAL NOT NULL,
    StockQuantity INTEGER NOT NULL CHECK (StockQuantity >= 0),
    CategoryId INTEGER,
    FOREIGN KEY (CategoryId) REFERENCES Categories(Id)
);

--Create table Categories
CREATE TABLE Categories (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    Name TEXT NOT NULL
);

--Create table reservations
CREATE TABLE reservations (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    UserId INTEGER NOT NULL,
    ProductId INTEGER NOT NULL,
    ReservationDate DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    Quantity INTEGER NOT NULL CHECK (Quantity > 0),
    Status TEXT NOT NULL CHECK (Status IN ('Pending', 'Confirmed', 'Cancelled')),
    FOREIGN KEY (UserId) REFERENCES Users(Id),
    FOREIGN KEY (ProductId) REFERENCES Products(Id)
    
);
   
-- Creazione tabella Orders
CREATE TABLE Orders (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    UserId INTEGER NOT NULL,
    OrderDate DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    TotalPrice REAL NOT NULL,
    Status TEXT NOT NULL CHECK (Status IN ('Pending', 'Shipped', 'Delivered', 'Cancelled')),
    FOREIGN KEY (UserId) REFERENCES Users(Id)
);

-- Creazione tabella OrderItems
CREATE TABLE OrderItems (
    --Id INTEGER PRIMARY KEY AUTOINCREMENT,
    OrderId INTEGER NOT NULL,
    ProductId INTEGER NOT NULL,
    Quantity INTEGER NOT NULL CHECK (Quantity > 0),
    Price REAL NOT NULL,
    PRIMARY KEY (OrderId, ProductId),
    -- Aggiunta chiave esterna per il riferimento a Orders e Products
    FOREIGN KEY (OrderId) REFERENCES Orders(Id),
    FOREIGN KEY (ProductId) REFERENCES Products(Id)
    );

    --Creazione tabella Payments
    CREATE TABLE Payments (
        Id INTEGER PRIMARY KEY AUTOINCREMENT,
        UserId INTEGER NOT NULL,
        OrderId INTEGER NOT NULL,
        PaymentDate DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
        Amount REAL NOT NULL,
        PaymentMethod TEXT NOT NULL CHECK (PaymentMethod IN ('Credit Card', 'PayPal', 'Cash On Delivery')),
        Status Text NOT NULL CHECK(Status IN ('Pending', 'Completed', 'Failed')),
        FOREIGN KEY (UserId) REFERENCES Users(Id),
        FOREIGN KEY (OrderId) REFERENCES Orders(Id)
    );

    -- Creazione tabella ShippingAddresses
    CREATE TABLE ShippingAddresses (
        Id INTEGER PRIMARY KEY AUTOINCREMENT,
        UserId INTEGER NOT NULL,
        Address TEXT NOT NULL,
        City TEXT NOT NULL,
        PostalCode TEXT NOT NULL,
        Country TEXT NOT NULL,
        FOREIGN KEY (UserId) REFERENCES Users(Id)
    );

    -- Creazione tabella Reviews
    CREATE TABLE Reviews (
        Id INTEGER PRIMARY KEY AUTOINCREMENT,
        UserId INTEGER NOT NULL,
        ProductId INTEGER NOT NULL,
        -- Rating INTEGER NOT NULL CHECK (Rating >= 1 AND Rating <= 5),
        Rating INTEGER NOT NULL CHECK (Rating BETWEEN 1 AND 5),
        Comment TEXT,
        ReviewDate DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL, 
        FOREIGN KEY (UserId) REFERENCES Users(Id),
        FOREIGN KEY (ProductId) REFERENCES Products(Id)
    );

    -- Creazione tabella ActivityLogs 
    CREATE TABLE ActivityLogs (
        Id INTEGER PRIMARY KEY AUTOINCREMENT,
        UserId INTEGER NOT NULL,
        Activity TEXT NOT NULL,
        ActivityDate DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL, --Timestamp
        FOREIGN KEY (UserId) REFERENCES Users(Id)
        );
