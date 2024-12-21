
-- Operational Queries:
-- Show appointments with patient details:
SELECT Appointments.Date, Appointments.Time, Patients.FirstName, Patients.LastName,
	   Doctors.DocFirstName, Doctors.DocLastName
FROM Appointments
JOIN Patients ON Appointments.PatientID = Patients.PatientID
JOIN Doctors ON Appointments.DoctorID = Doctors.DoctorID;

-- Display treatments with associated medications:
SELECT Treatments.Plan, Medications.MedicationName
FROM Treatments
JOIN Medications ON Treatments.MedicationID = Medications.MedicationID;

-- Reports:
-- Count patients in each ward:
SELECT Hospital_Wards.WardName, COUNT(Patients.PatientID) AS PatientCount
FROM Hospital_Wards
LEFT JOIN Patients ON Hospital_Wards.WardID = Patients.WardID
GROUP BY Hospital_Wards.WardName;

--List patients with their diseases and medications:
SELECT Patients.FirstName, Patients.LastName, Diseases.DiseaseName, Medications.MedicationName
FROM Patients
LEFT JOIN PatientDiseases ON Patients.PatientID = PatientDiseases.PatientID
LEFT JOIN Diseases ON PatientDiseases.DiseaseID = Diseases.DiseaseID
LEFT JOIN Medications ON Patients.PatientID = Medications.PatientID;

--Calculate efficiency of vaccines:
SELECT Vaccine.VaccineName, AVG(Vaccine.Efficiency) AS AverageEfficiency
FROM Vaccine
GROUP BY Vaccine.VaccineName;




-- DML Operations:

--Update a patient's contact information:
UPDATE Patients
SET Contact = '555-9876'
WHERE PatientID = 1;

-- Insert a new patient:
INSERT INTO Patients (FirstName, LastName, DOB, Gender, Contact, Address, WardID)
VALUES ('Alex', 'Johnson', '1998-08-10', 'M', '777-111-2222', '789 Oak St', 2);


-- Delete a nurseid = 3 and reassign the ward:
-- Update the treatments table to remove the reference to nurse with NurseID 3
UPDATE Treatments
SET NurseID = 4
WHERE NurseID = 3;

-- Now you can safely update or delete the nurse record
DELETE FROM Nurses
WHERE NurseID = 3;

UPDATE Hospital_Wards
SET NurseID = NULL
WHERE NurseID = 3;





































