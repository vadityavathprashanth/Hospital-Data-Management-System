-- Count of Patients by Gender:
SELECT Gender, COUNT(*) AS PatientCount
FROM disease_dw.PatientDim
GROUP BY Gender;



--Top 5 Doctors by Number of Appointments:
SELECT d.DocFirstName, d.DocLastName, COUNT(a.AppointmentID) AS AppointmentCount
FROM disease_dw.DoctorDim d
JOIN disease_dw.AppointmentFact a ON d.DoctorID = a.DoctorID
GROUP BY d.DocFirstName, d.DocLastName
ORDER BY AppointmentCount DESC
LIMIT 5;

--Average Efficiency of Vaccines:
SELECT AVG(Efficiency) AS AverageEfficiency
FROM disease_dw.VaccineDim;


--Number of Patients Treated for Each Disease:
SELECT dis.DiseaseName, COUNT(*) AS PatientCount
FROM disease_dw.DiseaseDim dis
JOIN disease_dw.TreatmentFact t ON dis.DiseaseID = t.DiseaseID
GROUP BY dis.DiseaseName;



































