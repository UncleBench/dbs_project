// Assistent erstellen
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:assistenten.csv" AS row
CREATE (:Assistent {PersNr: row.persnr, name: row.Name, fachgebiet: row.Fachgebiet});

// Professor erstellen
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:professoren.csv" AS row
CREATE (:Professor {PersNr: row.persnr, Name: row.name, Rang: row.rang, Raum: row.raum});

// Student erstellen
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:studenten.csv" AS row
CREATE (:Student {MatrNr: row.matrnr, Name: row.name, Semester: row.semester});

// Vorlesung erstellen
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:vorlesungen.csv" AS row
CREATE (:Vorlesung {VorlNr: row.vorlnr, Titel: row.titel, SWS: row.sws});

// Prüfung erstellen
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:pruefen.csv" AS row
CREATE (:Pruefung {Note: row.note});
// ************* Hier weitermachen *************************************************************************
MERGE (order:Order {orderID: row.OrderID}) ON CREATE SET order.shipName =  row.ShipName;

// Indizes erstellen
CREATE INDEX ON :Assistent(PersNr);
CREATE INDEX ON :Professor(PersNr);
CREATE INDEX ON :Student(MatrNr);
CREATE INDEX ON :Vorlesung(VorlNr);

CREATE CONSTRAINT ON (o:Order) ASSERT o.orderID IS UNIQUE;
schema await

USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:pruefen.csv" AS row
MATCH (matrnr:Student {orderID: row.matrnr})
MATCH (vorlnr:Product {productID: row.ProductID})
MERGE (order)-[pu:PRODUCT]->(product)
ON CREATE SET pu.unitPrice = toFloat(row.UnitPrice), pu.quantity = toFloat(row.Quantity);