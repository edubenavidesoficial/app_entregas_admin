-- Crear la tabla 'roles'
CREATE TABLE roles (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre_rol ENUM('vendedor', 'cobrador', 'cliente', 'administrador') NOT NULL
);

-- Añadir la columna 'rol_id' a la tabla 'users'
ALTER TABLE users
ADD COLUMN rol_id INT,
ADD FOREIGN KEY (rol_id) REFERENCES roles(id);

-- Crear la tabla 'clientes'
CREATE TABLE clientes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    numero_cedula VARCHAR(20) NOT NULL,
    telefono VARCHAR(20),
    correo_electronico VARCHAR(50),
    direccion VARCHAR(100),
    categoria_cliente VARCHAR(50)
);

-- Crear la tabla 'productos'
CREATE TABLE productos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre_producto VARCHAR(50) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10, 2) NOT NULL,
    cantidad_inventario INT NOT NULL
);

-- Crear la tabla 'ventas'
CREATE TABLE ventas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    fecha_venta DATETIME NOT NULL,
    cliente_id INT,
    vendedor_rol_id INT,
    total_venta DECIMAL(10, 2) NOT NULL,
    descuento DECIMAL(5, 2),
    FOREIGN KEY (cliente_id) REFERENCES clientes(id),
    FOREIGN KEY (vendedor_rol_id) REFERENCES roles(id)
);

-- Crear la tabla 'cobranzas'
CREATE TABLE cobranzas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    fecha_cobranza DATETIME NOT NULL,
    cliente_id INT,
    cobrador_id bigint(20) UNSIGNED,  -- Asegúrate de que coincida con la definición en la tabla users
    monto_cobrado DECIMAL(10, 2) NOT NULL,
    detalles_adicionales TEXT,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id),
    FOREIGN KEY (cobrador_id) REFERENCES users(id)
);

-- Crear la tabla 'cuentas_por_cobrar'
CREATE TABLE cuentas_por_cobrar (
    id INT PRIMARY KEY AUTO_INCREMENT,
    cliente_id INT,
    monto_pendiente DECIMAL(10, 2) NOT NULL,
    fecha_vencimiento DATE,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

-- Crear la tabla 'sectores'
CREATE TABLE sectores (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre_sector VARCHAR(50) NOT NULL
);

-- Crear la tabla 'barrios'
CREATE TABLE barrios (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre_barrio VARCHAR(50) NOT NULL,
    sector_id INT,
    FOREIGN KEY (sector_id) REFERENCES sectores(id)
);

-- Crear la tabla 'indicadores_gestion'
CREATE TABLE indicadores_gestion (
    id INT PRIMARY KEY AUTO_INCREMENT,
    vendedor_id bigint(20) UNSIGNED,  -- Asegúrate de que coincida con la definición en la tabla users
    devoluciones_ventas INT,
    cartera_perdida DECIMAL(10, 2),
    cartera_incobrable DECIMAL(10, 2),
    FOREIGN KEY (vendedor_id) REFERENCES users(id)
);

-- Crear la tabla 'planes_pagos'
CREATE TABLE planes_pagos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    venta_id INT,
    fecha_acuerdo DATE,
    detalles_plan_pagos TEXT,
    FOREIGN KEY (venta_id) REFERENCES ventas(id)
);

-- Crear la tabla 'entregas'
CREATE TABLE entregas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    fecha_entrega DATETIME NOT NULL,
    cliente_id INT,
    vendedor_id bigint(20) UNSIGNED,  -- Asegúrate de que coincida con la definición en la tabla users
    detalles_entrega TEXT,
    ubicacion_entrega VARCHAR(100),
    FOREIGN KEY (cliente_id) REFERENCES clientes(id),
    FOREIGN KEY (vendedor_id) REFERENCES users(id)
);
