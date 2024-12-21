-- Create Patients table
CREATE TABLE Patients (
    PatientID SERIAL PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DOB DATE,
    Gender VARCHAR(10),
    Contact VARCHAR(20),
    Address VARCHAR(100)
);

-- Create Diseases table
CREATE TABLE Diseases (
    DiseaseID SERIAL PRIMARY KEY,
    DiseaseName VARCHAR(50),
    DiseaseType VARCHAR(50)
);

-- Create Medications table
CREATE TABLE Medications (
    MedicationID SERIAL PRIMARY KEY,
    MedicationName VARCHAR(50),
    MedDosage VARCHAR(20)
);

-- Create Vaccine table
CREATE TABLE Vaccine (
    VaccineID SERIAL PRIMARY KEY,
    VaccineName VARCHAR(50),
    Manufacture VARCHAR(50),
    Efficiency DECIMAL(5, 2),
    VaccineDosage VARCHAR(20)
);

-- Create Doctors table
CREATE TABLE Doctors (
    DoctorID SERIAL PRIMARY KEY,
    DocFirstName VARCHAR(50),
    DocLastName VARCHAR(50),
    Specialty VARCHAR(50),
    Contact VARCHAR(20)
);
-- Create Nurses table
CREATE TABLE Nurses (
    NurseID SERIAL PRIMARY KEY,
    NurFirstName VARCHAR(50),
    NurLastName VARCHAR(50),
    Contact VARCHAR(20)
);
-- Create Treatments table
CREATE TABLE Treatments (
    TreatmentID SERIAL PRIMARY KEY,
    Plan VARCHAR(100),
    StartDate DATE,
    EndDate DATE
);
-- Create Hospital_Wards table
CREATE TABLE Hospital_Wards (
    WardID SERIAL PRIMARY KEY,
    WardName VARCHAR(50)
);

-- Create Appointments table
CREATE TABLE Appointments (
    AppointmentID SERIAL PRIMARY KEY,
    Date DATE,
    Time TIME
);

-- Create PatientDiseases table for many-to-many relationship
CREATE TABLE PatientDiseases (
    PatientID INT NOT NULL,
    DiseaseID INT NOT NULL,
    PRIMARY KEY (PatientID, DiseaseID),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DiseaseID) REFERENCES Diseases(DiseaseID)
);

-- Create PatientVaccines table for many-to-many relationship
CREATE TABLE PatientVaccines (
    PatientID INT NOT NULL,
    VaccineID INT NOT NULL,
    PRIMARY KEY (PatientID, VaccineID),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (VaccineID) REFERENCES Vaccine(VaccineID)
);

-- Alter Patients table to add a foreign key for a one-to-many relationship with Hospital_Wards
ALTER TABLE Patients
ADD COLUMN WardID INT NOT NULL,
ADD FOREIGN KEY (WardID) REFERENCES Hospital_Wards(WardID);

-- Alter Treatments table to add foreign keys for one-to-many relationships with Doctors, Diseases, Medications, Nurses
ALTER TABLE Treatments
ADD COLUMN DoctorID INT NOT NULL,
ADD COLUMN DiseaseID INT NOT NULL,
ADD COLUMN MedicationID INT NOT NULL,
ADD COLUMN NurseID INT NOT NULL,
ADD FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID),
ADD FOREIGN KEY (DiseaseID) REFERENCES Diseases(DiseaseID),
ADD FOREIGN KEY (MedicationID) REFERENCES Medications(MedicationID),
ADD FOREIGN KEY (NurseID) REFERENCES Nurses(NurseID);

-- Alter Hospital_Wards table to add a foreign key for a one-to-many relationship with Nurses table
ALTER TABLE Hospital_Wards
ADD COLUMN NurseID INT NOT NULL,
ADD FOREIGN KEY (NurseID) REFERENCES Nurses(NurseID);

-- Alter Medications table to add foreign key references to Patients, Doctors, Diseases
ALTER TABLE Medications
ADD COLUMN PatientID INT NOT NULL,
ADD COLUMN DoctorID INT NOT NULL,
ADD COLUMN DiseaseID INT NOT NULL,
ADD FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
ADD FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID),
ADD FOREIGN KEY (DiseaseID) REFERENCES Diseases(DiseaseID);

-- Add foreign keys to Appointments for one-to-many relationships with Patients, Doctors, Treatments
ALTER TABLE Appointments
ADD PatientID INT NOT NULL,
ADD DoctorID INT NOT NULL,
ADD TreatmentID INT NOT NULL,
ADD FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
ADD FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID),
ADD FOREIGN KEY (TreatmentID) REFERENCES Treatments(TreatmentID);


-- Insert Query
INSERT INTO Nurses (NurFirstName, NurLastName, Contact)
VALUES
    ('Nurse Emily', 'Williams', '555-4321'),
    ('Nurse James', 'Brown', '555-8765'),
    ('Nurse Smith', 'Miller', '111-222-3333'),
    ('Nurse Davis', 'Wilson', '444-555-6666'),
    ('Nurse Taylor', 'Johnson', '777-888-9999'),
    ('Nurse Brown', 'Clark', '333-777-5555'),
    ('Nurse Robinson', 'Lee', '555-999-1111');

INSERT INTO Hospital_Wards (WardName, NurseID)
VALUES
    ('Cardiology Ward', 1),
    ('Pediatrics Ward', 2);
	
INSERT INTO Patients (FirstName, LastName, DOB, Gender, Contact, Address, WardID)
VALUES
    ('Emma', 'Doe', '1990-05-15', 'Male', '201-456-7890', '123 Main St, Cityville', 1),
    ('Jemmy', 'Smith', '1985-08-22', 'Female', '987-654-3210', '456 Oak St, Townsville', 2),
    ('Celeb', 'Brown', '1995-08-20', 'F', '555-111-2222', '342 Oak St, Townsville', 2),
    ('Bob', 'Smith', '1980-03-12', 'M', '444-333-5555', '789 Maple Ave, Townsville', 1),
    ('Catherine', 'Davis', '2000-11-05', 'F', '777-888-9999', '123 Pine Rd, Columbia', 2),
    ('Lucas', 'Miller', '1975-06-30', 'M', '222-666-4444', '101 Cedar Ln, Townsville', 2),
    ('Harpar', 'Taylor', '1992-09-15', 'F', '888-777-5555', '222 Birch Blvd, New jersey', 1);

INSERT INTO Diseases (DiseaseName, DiseaseType)
VALUES
    ('Influenza', 'Viral'),
    ('Diabetes', 'Metabolic'),
    ('Hypertension', 'Cardiovascular'),
    ('Diabetes', 'Metabolic'),
    ('Migraine', 'Neurological'),
    ('Allergy', 'Immunological');

INSERT INTO Vaccine (VaccineName, Manufacture, Efficiency, VaccineDosage)
VALUES
    ('COVID-19 Vaccine', 'PharmaCorp', 0.95, '2 doses'),
    ('Flu Vaccine', 'HealthCare Ltd', 0.90, '1 dose'),
    ('Hepatitis B Vaccine', 'BioPharma', 0.88, '3 doses'),
    ('COVID-19 Vaccine', 'Pfizer', 0.95, '1 doses'),
    ('Flu Vaccine', 'Sanofi', 0.92, '1 doses'),
    ('HPV Vaccine', 'Merck', 0.94, '1 doses'),
    ('Hepatitis B Vaccine', 'GSK', 0.95, '1 doses'),
    ('MMR Vaccine', 'Mylan', 0.95, '1 doses');

INSERT INTO Doctors (DocFirstName, DocLastName, Specialty, Contact)
VALUES
    ('Dr. Sarah', 'Johnson', 'Cardiology', '555-1234'),
    ('Dr.Michael', 'Smith', 'Pediatrics', '555-5678'),
    ('Dr. Patel', 'Jones', 'Internal Medicine', '555-999-1111'),
    ('Dr. Lee', 'Williams', 'Oncology', '888-444-3333'),
    ('Dr. Brown', 'Taylor', 'Pediatrics', '333-777-5555'),
    ('Dr. Wilson', 'Clark', 'Dermatology', '444-666-8888'),
    ('Dr. Robinson', 'Anderson', 'Orthopedics', '222-555-7777');

-- Assuming PatientID 7 and 8 corresponds to a specific patient
INSERT INTO Medications (MedicationName, MedDosage, PatientID, DoctorID, DiseaseID)
VALUES
    ('Aspirin', '100mg', 3, 1, 4),
    ('Insulin', '10 units', 4, 2, 6),
    ('Lisinopril', '2 units', 5, 3, 1),
    ('Insulin', '10 units', 1, 4, 5),
    ('Sumatriptan', '10 units', 2, 5, 2),
    ('Claritin', '10 units', 6, 6, 3);

INSERT INTO Treatments (Plan, StartDate, EndDate, DoctorID, DiseaseID, MedicationID, NurseID)
VALUES
    ('Rehabilitation', '2023-01-10', '2023-02-28', 1, 6, 4, 1),
    ('Diabetes Management', '2023-03-05', '2023-04-30', 2, 5, 2, 2),
	('Physical Therapy', '2023-02-15', '2023-03-15', 3, 4, 1, 3),
    ('Allergy Testing', '2023-04-01', '2023-04-30', 6, 3, 6, 4),
    ('Cardiac Monitoring', '2023-05-10', '2023-06-10', 4, 2, 2, 6),
    ('Orthopedic Surgery', '2023-03-15', '2023-04-15', 5, 3, 2, 7),
    ('Neurological Assessment', '2023-04-20', '2023-05-20', 7, 4, 4, 5);

INSERT INTO Appointments (Date, Time, PatientID, DoctorID, TreatmentID)
VALUES
    ('2023-01-20', '10:00:00', 1, 4, 8),
    ('2023-03-15', '14:30:00', 2, 3, 9),
    ('2022-01-10', '10:00:00', 3, 4, 9),
    ('2022-01-15', '14:30:00', 4, 2, 8),
    ('2022-02-01', '09:45:00', 5, 7, 10),
    ('2022-02-10', '11:15:00', 6, 6, 11),
    ('2022-03-05', '16:00:00', 1, 5, 8);

INSERT INTO PatientDiseases (PatientID, DiseaseID)
VALUES
    (1, 1),
    (1, 3),
	(1, 2),
    (2, 3),
	(3, 3),
    (3, 4),
	(4, 5),
    (5, 4),
	(6, 4),
    (6, 5),
	(6, 2),
	(7, 6);

INSERT INTO PatientVaccines (PatientID, VaccineID)
VALUES
    (6, 1),
    (5, 2),
    (5, 3),
	(1, 1),
    (1, 5),
	(4, 2),
    (4, 3),
	(3, 3),
    (3, 5),
	(4, 5),
    (5, 4),
	(6, 4),
    (6, 5),
	(6, 7),
	(7, 6);











