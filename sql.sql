CREATE TABLE Usuarios (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    NombreUsuario VARCHAR(50) NOT NULL,
    Contraseña VARCHAR(50) NOT NULL,
    Rol ENUM('vendedor', 'cobrador', 'cliente', 'administrador') NOT NULL
);

CREATE TABLE Clientes (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    NumeroCedula VARCHAR(20) NOT NULL,
    Telefono VARCHAR(20),
    CorreoElectronico VARCHAR(50),
    Direccion VARCHAR(100),
    CategoriaCliente VARCHAR(50)
);

CREATE TABLE Productos (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    NombreProducto VARCHAR(50) NOT NULL,
    Descripcion TEXT,
    Precio DECIMAL(10, 2) NOT NULL,
    CantidadInventario INT NOT NULL
);

CREATE TABLE Ventas (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    FechaVenta DATETIME NOT NULL,
    ClienteID INT,
    VendedorID INT,
    TotalVenta DECIMAL(10, 2) NOT NULL,
    Descuento DECIMAL(5, 2),
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ID),
    FOREIGN KEY (VendedorID) REFERENCES Usuarios(ID)
);

CREATE TABLE Cobranzas (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    FechaCobranza DATETIME NOT NULL,
    ClienteID INT,
    CobradorID INT,
    MontoCobrado DECIMAL(10, 2) NOT NULL,
    DetallesAdicionales TEXT,
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ID),
    FOREIGN KEY (CobradorID) REFERENCES Usuarios(ID)
);

CREATE TABLE CuentasPorCobrar (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    ClienteID INT,
    MontoPendiente DECIMAL(10, 2) NOT NULL,
    FechaVencimiento DATE,
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ID)
);

CREATE TABLE Sectores (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    NombreSector VARCHAR(50) NOT NULL
);

CREATE TABLE Barrios (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    NombreBarrio VARCHAR(50) NOT NULL,
    SectorID INT,
    FOREIGN KEY (SectorID) REFERENCES Sectores(ID)
);

CREATE TABLE IndicadoresGestion (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    VendedorID INT,
    DevolucionesVentas INT,
    CarteraPerdida DECIMAL(10, 2),
    CarteraIncobrable DECIMAL(10, 2),
    FOREIGN KEY (VendedorID) REFERENCES Usuarios(ID)
);

CREATE TABLE PlanesPagos (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    VentaID INT,
    FechaAcuerdo DATE,
    DetallesPlanPagos TEXT,
    FOREIGN KEY (VentaID) REFERENCES Ventas(ID)
);

CREATE TABLE RutasEntrega (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    ClienteID INT,
    VendedorID INT,
    DetallesRuta TEXT,
    UbicacionEntrega VARCHAR(100),
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ID),
    FOREIGN KEY (VendedorID) REFERENCES Usuarios(ID)
);
