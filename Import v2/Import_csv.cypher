// Assistent erstellen
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:///assistenten.csv" AS row
CREATE (:Assistent {PersNr: row.persnr, Name: row.name, Fachgebiet: row.fachgebiet});

// Professor erstellen
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:///professoren.csv" AS row
CREATE (:Professor {PersNr: row.persnr, Name: row.name, Rang: row.rang, Raum: row.raum});

// Student erstellen
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:///studenten.csv" AS row
CREATE (:Student {MatrNr: row.matrnr, Name: row.name, Semester: row.semester});

// Vorlesung erstellen
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:///vorlesungen.csv" AS row
CREATE (:Vorlesung {VorlNr: row.vorlnr, Titel: row.titel, SWS: row.sws});

// Prüfung erstellen
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:///pruefen.csv" AS row
CREATE (:Pruefung {MatrNr: row.matrnr, VorlNr: row.vorlnr, PersNr: row.persnr, Note: row.note});

// Indizes erstellen wo möglich
CREATE INDEX ON :Assistent(PersNr);
CREATE INDEX ON :Professor(PersNr);
CREATE INDEX ON :Student(MatrNr);
CREATE INDEX ON :Vorlesung(VorlNr);

schema await;

// Assistent assistiert Professor
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:///assistenten.csv" AS row
MATCH (assi:Assistent {PersNr: row.persnr})
MATCH (prof:Professor {PersNr: row.boss})
MERGE (assi)-[:ASSISTIERT]->(prof)

// Professor liest Vorlesung
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:///vorlesungen.csv" AS row
MATCH (prof:Professor {PersNr: row.gelesenvon})
MATCH (vorl:Vorlesung {VorlNr: row.vorlnr})
MERGE (prof)-[:LIEST]->(vorl)

// Student hoert Vorlesung
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:///hoeren.csv" AS row
MATCH (stud:Student {MatrNr: row.matrnr})
MATCH (vorl:Vorlesung {VorlNr: row.vorlnr})
MERGE (stud)-[:HOERT]->(vorl)

// Vorlesung setzt_voraus Vorlesung
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:///voraussetzen.csv" AS row
MATCH (vorgaenger:Vorlesung {VorlNr: row.vorgaenger})
MATCH (nachfolger:Vorlesung {VorlNr: row.nachfolger})
MERGE (vorgaenger)-[:SETZT_VORAUS]->(nachfolger)

// Vorlesung folgt_auf Vorlesung
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:///voraussetzen.csv" AS row
MATCH (nachfolger:Vorlesung {VorlNr: row.nachfolger})
MATCH (vorgaenger:Vorlesung {VorlNr: row.vorgaenger})
MERGE (nachfolger)-[:FOLGT_AUF]->(vorgaenger)

// Pruefung wird_durchgefuehrt_von Professor
// Pruefung wird_geschrieben_von Student
// Pruefung thematisiert Vorlesung
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:///pruefen.csv" AS row
MATCH (pruef:Pruefung {MatrNr: row.matrnr, VorlNr: row.vorlnr, PersNr: row.persnr, Note: row.note})
MATCH (prof:Professor {PersNr: row.persnr})
MATCH (stud:Student {MatrNr: row.matrnr})
MATCH (vorl:Vorlesung {VorlNr: row.vorlnr})
MERGE (prof)-[:PRUEFT]->(pruef)
MERGE UNIQUE (stud)-[:SCHREIBT]->(pruef)
MERGE UNIQUE (pruef)-[:THEMATISIERT]->(vorl)