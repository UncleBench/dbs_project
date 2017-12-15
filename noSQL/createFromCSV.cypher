// Create professoren
LOAD CSV FROM "file:/professoren.csv" AS studenten
CREATE (:Studenten { Legi: studenten, Name: studenten, Semester: studenten});

// Create studenten
LOAD CSV FROM "file:/studenten.csv" AS studenten
CREATE (:Studenten { Legi: studenten, Name: studenten, Semester: studenten});

// C
