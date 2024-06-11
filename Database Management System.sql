--Youssef Laamari BIG DATA
create database TPBASE;   --creation de la base de donne�s projet  
use TPBASE;
-- Creation des tableaux avec les contraintes et les Relations

create table Developpeur(
NumDev int identity(1,1) primary key,
NomDev varchar(45) not null,
adrDeV varchar(55) not null,
EmailDev varchar (32) unique check(EmailDev LIKE '%_@__%.__%'),
telDev varchar(45) not null
)
create table Projet(
Numproj int identity (1,1) primary key ,
TitreProj varchar(45)not null,
DateDeb date,
DateFin date
)
create table Logiciel (
    Codlog INT IDENTITY(1,1) PRIMARY KEY,
    Numproj INT,
    FOREIGN KEY (Numproj) REFERENCES Projet(Numproj),
    Nomlog VARCHAR(45) NOT NULL,
    Prixlog DECIMAL(10,2),
    typeproj VARCHAR(43) CHECK (typeproj IN ('gestion', 'traitement', 'd�veloppement'))
);

CREATE TABLE Realisation (
    NumProj INT,
    NumDev INT,
    FOREIGN KEY (NumProj) REFERENCES Projet(NumProj),
    FOREIGN KEY (NumDev) REFERENCES Developpeur(NumDev),
    budget DECIMAL(10, 2)
);

-- ( remplissage de tables)
-- Ajout d'enregistrements dans la table Developpeur
INSERT INTO Developpeur (NomDev, adrDeV, EmailDev, telDev)
VALUES 
    ('Abderahmane', 'Adresse1', 'abdulrahman@email.com', '123456789'),
    ('Fatima', 'Adresse2', 'fatima@email.com', '987654321'),
    ('Mohamed', 'Adresse3', 'mohammed@email.com', '654321789');

-- Ajout d'enregistrements dans la table Projet
INSERT INTO Projet (TitreProj, DateDeb, DateFin)
VALUES 
    ('Proj1', '2024-01-01', '2024-02-01'),
    ('Proj2', '2024-02-01', '2024-03-01'),
    ('Proj3', '2024-03-01', '2024-04-01');

-- Ajout d'enregistrements dans la table Logiciel
INSERT INTO Logiciel (Numproj, Nomlog, Prixlog, TypeProj)
VALUES 
    (1, 'log1', 150.00, 'd�veloppement'),
    (2, 'log2', 200.00, 'gestion'),
    (3, 'log3', 180.00, 'traitement');

-- Ajout d'enregistrements dans la table Realisation
INSERT INTO Realisation (NumProj, NumDev, budget)
VALUES 
    (1, 1, 5000.00),
    (2, 2, 7000.00),
    (3, 3, 6000.00);




--3

SELECT NomLog
FROM Logiciel
WHERE PrixLog >= 20000;

--4

SELECT Codlog
FROM Logiciel
WHERE NomLog LIKE '%A%' OR NomLog LIKE '%a%';
 

--5

SELECT *
FROM Realisation
ORDER BY budget ;

--6

SELECT
    NumProj,
    TitreProj,
    (
        SELECT COUNT(*)
        FROM Realisation
        WHERE NumProj = Projet.NumProj
          AND GETDATE() BETWEEN Projet.DateDeb AND Projet.DateFin
    ) AS EnCours
FROM
    Projet;

--7


SELECT DISTINCT NumDev
FROM Realisation
WHERE NumProj IN (SELECT NumProj FROM Logiciel WHERE Codlog = 2);

--8 :
 
SELECT DISTINCT p.TitreProj
FROM Projet p
JOIN Realisation r ON p.NumProj = r.NumProj
WHERE r.NumDev IN (3, 4);

--9:


SELECT DISTINCT NomLog
FROM Logiciel
WHERE Codlog NOT IN (
    SELECT Codlog
    FROM Realisation
    WHERE NumDev = (SELECT NumDev FROM Developpeur WHERE NomDev = 'Hakim')
);





