DROP TABLE COMMANDER;
DROP TABLE HORRAIRE;
DROP TABLE SERVICES;
DROP TABLE POSSEDE;
DROP TABLE CHAMBRE;
DROP TABLE EMPLOYER;
DROP TABLE CLIENT;
DROP TABLE PERSONNE;
DROP TABLE DEPARTEMENT;
DROP TABLE HOTEL;
DROP TABLE DATES;

CREATE TABLE DATES (
  date_arriver DATE,
  CONSTRAINT pkdatearriver PRIMARY KEY (date_arriver)
);

CREATE TABLE HOTEL (
  hotel_id NUMBER(2),
  ville_h VARCHAR(20),
  rue_h VARCHAR(20),
  lattitude_h NUMBER(20),
  longitude_h NUMBER(20),
  confort_eq VARCHAR(20),
  qualiter_service NUMBER(1), --NB étoiles --
  accueil_handicaper NUMBER(1),
  CONSTRAINT pkHotelid PRIMARY KEY (hotel_id)
);

CREATE TABLE DEPARTEMENT (
  hotel_id number(2),
  nomdepartement VARCHAR(20),
  NomrespDP Varchar(20),
  tel_dep NUMBER(10),
  CONSTRAINT pkNomDepartement PRIMARY KEY (nomdepartement),
  CONSTRAINT fkhotelid FOREIGN KEY (hotel_id) REFERENCES HOTEL (hotel_id)
);

CREATE TABLE PERSONNE (
  personne_id VARCHAR(20),
  nom VARCHAR(20),
  rue VARCHAR(20),
  ville VARCHAR(20),
  CONSTRAINT PKPersonelid PRIMARY KEY (personne_id)
); 

CREATE TABLE CLIENT (
  personne_id VARCHAR(20),
  client_id VARCHAR(20),
  nationaliter VARCHAR(20),
  CONSTRAINT pkPClientid PRIMARY KEY (personne_id,client_id),
  CONSTRAINT fkpersonneid_client FOREIGN KEY (personne_id) REFERENCES PERSONNE (personne_id),
  CONSTRAINT fkclientid_client FOREIGN KEY (client_id) REFERENCES PERSONNE (personne_id)
); 

CREATE TABLE EMPLOYER (
  personne_id VARCHAR(20),
  employer_id VARCHAR(20),
  fonction VARCHAR(20),
  prenom_e VARCHAR(20),
  nomdepartement VARCHAR(20),
  CONSTRAINT pkemployerid PRIMARY KEY (personne_id,employer_id),
  CONSTRAINT fknomdepartement_employer FOREIGN KEY (nomdepartement) REFERENCES DEPARTEMENT (nomdepartement),
  CONSTRAINT fkpersonneid_employer FOREIGN KEY (personne_id) REFERENCES PERSONNE (personne_id)
);

CREATE TABLE CHAMBRE (
  num_chambre NUMBER(20),
  hotel_id NUMBER(2),
  date_arriver Date,
  personne_id VARCHAR(20),
  client_id VARCHAR(20),
  date_depart Date,
  nb_service number(2),
  CONSTRAINT PknumChambre PRIMARY KEY (num_chambre),
  CONSTRAINT fkhotelid_chambre FOREIGN KEY (hotel_id) REFERENCES HOTEL (hotel_id),
  CONSTRAINT fkclientid_chambre FOREIGN KEY (personne_id,client_id) REFERENCES CLIENT (personne_id,client_id),
  CONSTRAINT fkdatearriver FOREIGN KEY (date_arriver) REFERENCES DATES (date_arriver)
);

CREATE TABLE POSSEDE (
  hotel_id NUMBER(2),
  num_chambre NUMBER(20),
  nb_max_personne NUMBER(2),
  CONSTRAINT pkHotelid_numchambre PRIMARY KEY (hotel_id, num_chambre),
  CONSTRAINT fknumchambre FOREIGN KEY (num_chambre) REFERENCES CHAMBRE (num_chambre),
  CONSTRAINT fkhotelidpossede FOREIGN KEY (hotel_id) REFERENCES HOTEL (hotel_id)
);

CREATE TABLE SERVICES (
  nom_service VARCHAR(20),
  prix_service NUMBER(5,2),
  date_servcie DATE,
  CONSTRAINT pkNomservice PRIMARY KEY (nom_service)
);

CREATE TABLE HORRAIRE (
  date_du_jour DATE,
  heure date,
  CONSTRAINT pkdatedujour_heure PRIMARY KEY (date_du_jour, heure)
);

CREATE TABLE COMMANDER (
  date_du_jour DATE,
  num_chambre NUMBER(20),
  heure date,
  nom_service VARCHAR(20),
  personne_id VARCHAR(20),
  client_id VARCHAR(20),
  date_service DATE,
  service_payer NUMBER(1),
  quantité NUMBER(3),
  CONSTRAINT pknumchambre_datedujour_nomservice_clientid PRIMARY KEY (num_chambre, date_du_jour, nom_service, client_id),
  CONSTRAINT fkclientidcommander FOREIGN KEY (personne_id,client_id) REFERENCES CLIENT (personne_id,client_id),
  CONSTRAINT fkdatedujourcommander FOREIGN KEY (date_du_jour, heure) REFERENCES HORRAIRE (date_du_jour,heure),
  CONSTRAINT fknomservicecommander FOREIGN KEY (nom_service) REFERENCES SERVICES (nom_service),
  CONSTRAINT fknumchambrecommander FOREIGN KEY (num_chambre) REFERENCES CHAMBRE (num_chambre)
);

INSERT INTO DATES(date_arriver)
VALUES ( TO_DATE('25112021', 'DDMMYYYY'));

INSERT INTO HOTEL(hotel_id,ville_h,rue_h,lattitude_h,longitude_h,confort_eq,qualiter_service,accueil_handicaper) 
VALUES(01,'Angers', 'rue de civry',47.478419, 0.563166,'???',3,1);

INSERT INTO DEPARTEMENT(nomdepartement,NomrespDP,tel_dep,hotel_id) 
VALUES ('Cuisine','SMIT',0285958615, 01);

INSERT INTO PERSONNE (personne_id, nom, rue, ville) 
VALUES ('P0001', 'Smith', 'Bob', 'Oxford');

INSERT CLIENT(personne_id,client_id, nationaliter) 
VALUES ('P0001','C001', 'ECOSSE')

INSERT INTO PERSONNE (personne_id, nom, rue, ville) 
VALUES ('P0002', 'Corret', 'rue de la frileuse', 'Civry');

INSERT INTO EMPLOYER (personne_id,employer_id,fonction,prenom_e) 
VALUES ('P0002','E0001', 'Cuisinier', 'Bryan');

INSERT INTO SERVICES (nom_service,prix_service,date_servcie) 
VALUES ('Option animaux' , 10.99, TO_DATE('25112021','DDMMYYYY'));

INSERT INTO HORRAIRE (date_du_jour, heure) 
VALUES (TO_DATE('25112021','DDMMYYYY'), TO_DATE('12:32', 'hh:mi'));

INSERT INTO CHAMBRE (num_chambre,hotel_id,client_id,date_depart,nb_service) 
VALUES (1,01,'P0001',TO_DATE('27112021', 'DD:MM:YYYY'), 2);

INSERT INTO POSSEDE (hotel_id,num_chambre,nb_max_personne) 
VALUES(01,1,5);

INSERT INTO COMMANDER ( date_du_jour, num_chambre, heure, nom_service, client_id, service_payer, quantité) 
VALUES (TO_DATE('25112021','DDMMYYYY'), 01, TO_DATE('1232','hh:mi'), 'Option animaux', 'P0001',0, 2);

