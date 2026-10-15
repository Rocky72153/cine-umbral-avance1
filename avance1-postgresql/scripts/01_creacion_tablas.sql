CREATE TABLE Cargo_Staff (
    id_cargo_staff SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE Estado_Staff (
    id_estado_staff SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE Tipo_Contrato (
    id_tipo_contrato SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE Tipo_Documento (
    id_tipo_documento SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE Metodo_Pago_Venta (
    id_metodo_pago SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE Tipo_Boleta (
    id_tipo_boleta SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE Clasificacion_Pelicula (
    id_clasificacion_pelicula SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE Tipo_Sala (
    id_tipo_sala SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE Estado_Sala (
    id_estado_sala SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE Staff (
    id_staff SERIAL PRIMARY KEY,
    id_cargo_staff INT NOT NULL,
    id_estado_staff INT NOT NULL,
    id_tipo_documento INT NOT NULL,
    primer_nombre VARCHAR(50) NOT NULL,
    segundo_nombre VARCHAR(50),
    primer_apellido VARCHAR(50) NOT NULL,
    segundo_apellido VARCHAR(50),
    numero_documento VARCHAR(20) NOT NULL UNIQUE,
    correo VARCHAR(100) UNIQUE,
    FOREIGN KEY (id_cargo_staff) REFERENCES Cargo_Staff(id_cargo_staff),
    FOREIGN KEY (id_estado_staff) REFERENCES Estado_Staff(id_estado_staff),
    FOREIGN KEY (id_tipo_documento) REFERENCES Tipo_Documento(id_tipo_documento)
);

CREATE TABLE Contrato (
    id_contrato SERIAL PRIMARY KEY,
    id_staff INT NOT NULL,
    id_tipo_contrato INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    salario DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_staff) REFERENCES Staff(id_staff),
    FOREIGN KEY (id_tipo_contrato) REFERENCES Tipo_Contrato(id_tipo_contrato)
);

CREATE TABLE Espectador (
    id_espectador SERIAL PRIMARY KEY,
    id_tipo_documento INT NOT NULL,
    primer_nombre VARCHAR(50) NOT NULL,
    segundo_nombre VARCHAR(50),
    primer_apellido VARCHAR(50) NOT NULL,
    segundo_apellido VARCHAR(50),
    numero_documento VARCHAR(20) NOT NULL UNIQUE,
    correo VARCHAR(100) UNIQUE,
    FOREIGN KEY (id_tipo_documento) REFERENCES Tipo_Documento(id_tipo_documento)
);

CREATE TABLE Actor_Director (
    id_actor_director SERIAL PRIMARY KEY,
    primer_nombre VARCHAR(50) NOT NULL,
    segundo_nombre VARCHAR(50),
    primer_apellido VARCHAR(50) NOT NULL,
    segundo_apellido VARCHAR(50),
    rol VARCHAR(50) NOT NULL, 
    nacionalidad VARCHAR(50),
    correo VARCHAR(100)
);

CREATE TABLE Pelicula (
    id_pelicula SERIAL PRIMARY KEY,
    id_clasificacion_pelicula INT NOT NULL,
    titulo VARCHAR(150) NOT NULL,
    duracion INT NOT NULL, 
    anio INT NOT NULL,
    pais_origen VARCHAR(50),
    FOREIGN KEY (id_clasificacion_pelicula) REFERENCES Clasificacion_Pelicula(id_clasificacion_pelicula)
);

CREATE TABLE Actor_Director_Pelicula (
    id_actor_director INT NOT NULL,
    id_pelicula INT NOT NULL,
    PRIMARY KEY (id_actor_director, id_pelicula),
    FOREIGN KEY (id_actor_director) REFERENCES Actor_Director(id_actor_director),
    FOREIGN KEY (id_pelicula) REFERENCES Pelicula(id_pelicula)
);

CREATE TABLE Sala (
    id_sala SERIAL PRIMARY KEY,
    id_estado_sala INT NOT NULL,
    id_tipo_sala INT NOT NULL,
    capacidad INT NOT NULL,
    FOREIGN KEY (id_estado_sala) REFERENCES Estado_Sala(id_estado_sala),
    FOREIGN KEY (id_tipo_sala) REFERENCES Tipo_Sala(id_tipo_sala)
);

CREATE TABLE Funcion (
    id_funcion SERIAL PRIMARY KEY,
    id_pelicula INT NOT NULL,
    id_sala INT NOT NULL,
    fecha DATE NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL,
    FOREIGN KEY (id_pelicula) REFERENCES Pelicula(id_pelicula),
    FOREIGN KEY (id_sala) REFERENCES Sala(id_sala)
);

CREATE TABLE Venta (
    id_venta SERIAL PRIMARY KEY,
    id_staff INT NOT NULL,
    id_funcion INT NOT NULL,
    id_espectador INT NOT NULL,
    id_metodo_pago INT NOT NULL,
    monto_total DECIMAL(10, 2) NOT NULL,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    FOREIGN KEY (id_staff) REFERENCES Staff(id_staff),
    FOREIGN KEY (id_funcion) REFERENCES Funcion(id_funcion),
    FOREIGN KEY (id_espectador) REFERENCES Espectador(id_espectador),
    FOREIGN KEY (id_metodo_pago) REFERENCES Metodo_Pago_Venta(id_metodo_pago)
);

CREATE TABLE Boleta (
    id_boleta SERIAL PRIMARY KEY,
    id_venta INT NOT NULL,
    id_tipo_boleta INT NOT NULL,
    precio DECIMAL(10, 2) NOT NULL,
    numero_asiento VARCHAR(10) NOT NULL,
    FOREIGN KEY (id_venta) REFERENCES Venta(id_venta),
    FOREIGN KEY (id_tipo_boleta) REFERENCES Tipo_Boleta(id_tipo_boleta)
);
