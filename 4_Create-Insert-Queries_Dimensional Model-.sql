-- Create the "disease_dw" schema
CREATE SCHEMA disease_dw;

-- Set the search path to include the new schema
SET search_path TO disease_dw, public;

-- Create dimension tables
CREATE TABLE PatientDim (
    PatientID SERIAL PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Gender VARCHAR(10),
    DOB DATE
);

CREATE TABLE DoctorDim (
    DoctorID SERIAL PRIMARY KEY,
    DocFirstName VARCHAR(50),
    DocLastName VARCHAR(50),
    Specialty VARCHAR(50)
);

CREATE TABLE NurseDim (
    NurseID SERIAL PRIMARY KEY,
    NurFirstName VARCHAR(50),
    NurLastName VARCHAR(50)
);

CREATE TABLE DiseaseDim (
    DiseaseID SERIAL PRIMARY KEY,
    DiseaseName VARCHAR(50),
    DiseaseType VARCHAR(50)
);

CREATE TABLE MedicationDim (
    MedicationID SERIAL PRIMARY KEY,
    MedicationName VARCHAR(50),
    MedDosage VARCHAR(20)
);

CREATE TABLE VaccineDim (
    VaccineID SERIAL PRIMARY KEY,
    VaccineName VARCHAR(50),
    Manufacture VARCHAR(50),
    Efficiency DECIMAL(5, 2),
    VaccineDosage VARCHAR(20)
);

CREATE TABLE WardDim (
    WardID SERIAL PRIMARY KEY,
    WardName VARCHAR(50)
);

-- Create fact tables
CREATE TABLE TreatmentFact (
    TreatmentID SERIAL PRIMARY KEY,
    Plan VARCHAR(100),
    StartDate DATE,
    EndDate DATE,
    PatientID INT REFERENCES PatientDim(PatientID),
    DoctorID INT REFERENCES DoctorDim(DoctorID),
    DiseaseID INT REFERENCES DiseaseDim(DiseaseID),
    MedicationID INT REFERENCES MedicationDim(MedicationID),
    NurseID INT REFERENCES NurseDim(NurseID),
    VaccineID INT REFERENCES VaccineDim(VaccineID),
    WardID INT REFERENCES WardDim(WardID)
);

CREATE TABLE AppointmentFact (
    AppointmentID SERIAL PRIMARY KEY,
    Date DATE,
    Time TIME,
    PatientID INT REFERENCES PatientDim(PatientID),
    DoctorID INT REFERENCES DoctorDim(DoctorID),
    TreatmentID INT REFERENCES TreatmentFact(TreatmentID)
);


-- Extract and Load Patient Dimension
INSERT INTO disease_dw.PatientDim (PatientID, FirstName, LastName, Gender, DOB)
SELECT PatientID, FirstName, LastName, Gender, DOB
FROM public.Patients;


-- Extract and Load Doctor Dimension
INSERT INTO disease_dw.DoctorDim (DoctorID, DocFirstName, DocLastName, Specialty)
SELECT DoctorID, DocFirstName, DocLastName, Specialty
FROM public.Doctors;


-- Extract and Load Nurse Dimension
INSERT INTO disease_dw.NurseDim (NurseID, NurFirstName, NurLastName)
SELECT NurseID, NurFirstName, NurLastName
FROM public.Nurses;

-- Extract and Load Ward Dimension
INSERT INTO disease_dw.WardDim (WardID, WardName)
SELECT WardID, WardName
FROM public.Hospital_Wards;

-- Extract and Load Disease Dimension
INSERT INTO disease_dw.DiseaseDim (DiseaseID, DiseaseName, DiseaseType)
SELECT DiseaseID, DiseaseName, DiseaseType
FROM public.Diseases;

-- Extract and Load Medication Dimension
INSERT INTO disease_dw.MedicationDim (MedicationID, MedicationName, MedDosage)
SELECT MedicationID, MedicationName, MedDosage
FROM public.Medications;

-- Extract and Load Vaccine Dimension
INSERT INTO disease_dw.VaccineDim (VaccineID, VaccineName, Manufacture, Efficiency, VaccineDosage)
SELECT VaccineID, VaccineName, Manufacture, Efficiency, VaccineDosage
FROM public.Vaccine;

-- Extract and Load Treatment Fact
INSERT INTO disease_dw.TreatmentFact (TreatmentID, Plan, StartDate, EndDate, DoctorID, DiseaseID, MedicationID, NurseID)
SELECT
    t.TreatmentID, t.Plan, t.StartDate, t.EndDate,
    d.DoctorID, dis.DiseaseID, m.MedicationID, n.NurseID
FROM
    public.Treatments t 
    JOIN public.Doctors d ON t.DoctorID = d.DoctorID
    JOIN public.Diseases dis ON t.DiseaseID = dis.DiseaseID
    JOIN public.Medications m ON t.MedicationID = m.MedicationID
    JOIN public.Nurses n ON t.NurseID = n.NurseID;
Select * from disease_dw.TreatmentFact

-- Extract and Load Appointment Fact
INSERT INTO disease_dw.AppointmentFact (AppointmentID, Date, Time, PatientID, DoctorID, TreatmentID)
SELECT
    a.AppointmentID, a.Date, a.Time,
    p.PatientID, d.DoctorID, t.TreatmentID
FROM
    public.Appointments a
    JOIN public.Patients p ON a.PatientID = p.PatientID
    JOIN public.Doctors d ON a.DoctorID = d.DoctorID
    JOIN public.Treatments t ON a.TreatmentID = t.TreatmentID;










