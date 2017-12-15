# NEO4J - Übungsprojekt: noSQL
## 1	Einführung
### 1.1	Was ist der Kontext, warum ist das Projekt relevant, und worum geht es?
Dieses Projekt wurde im Kontext des Moduls Datenbanksysteme durchgeführt. Die Relevanz des Projekts drückt sich dadurch aus, dass, neben dem theoretischen Input und praktischer Anwendung des erlernten Wissen in wöchentlichen Übungsaufgaben, das gesamte Wissen in einem Projekt umgesetzt werden kann. Es soll eine bereits bestehende Datenbank inklusive ihrer Beziehungen komplett zu einem anderen Datenbankmanagementsystem migriert werden. Dazu soll eine SQL Query in der Programmiersprache des neuen DBMS (in unserem Falle wäre dies Cypher) umgeschrieben werden, um die gewünschten Datensätze auszugeben. Die Studierenden müssen sich also mit einem komplett neuen Datenbanksystem auseinandersetzen sowie praktische Aufgaben in einer neuen Umgebung bewältigen. Demnach ist dieses Projekt relevant, da die Studierenden sich nicht nur mit konzeptionellen Aufgaben auseinandersetzen, sondern sich ebenfalls mit einer anderen Technologie und ihren Aspekten beschäftigen sollen.

## 2	Datenmanagement
### 2.1	Um welche Datenbanktechnologie handelt es sich?
Wir benutzen für dieses Projekt die Datenbank Neo4j. Diese ist eine Open-Source-Graphdatenbank, welche mit Java implementiert wurde. Sie erschien 2007 und ist im Vergleich mit anderen Datenbanken auf dem Platz 21 und die beste Graphdatenbank (www.db-engines.com; Stand: 06.12.2017).

### 2.2	Welche Anwendung (Use Case) unterstützt ihre Datenbank?
Zu den Use Cases der Neo4j-Datenbank (und allgemein von Graphdatenbanken) zählt zum Beispiel Betrugsentdeckung (fraud detection). Dabei müssen Datenbeziehungen in Echtzeit analysiert werden können, um Betrüger frühzeitig erkennen zu können. 
Auch sogenannte Knowledge Graphs können dadurch dargestellt werden. Ein Knowledge Graph kann Antworten auf bestimmte Fragen liefern, indem alle möglichen Daten gesammelt und dazu Beziehungen hergestellt werden.
Network&IT:
Real-Time Recommendation Engines:
Master Data Management:
Social Network:
Identity&Access Management
https://neo4j.com/use-cases/

Use cases include matchmaking, network management, software analytics, scientific research, routing, organizational and project management, recommendations, social networks, and more.

### 2.3	Welche Daten werden migriert / eingefügt, und wie genau?
Wenn man eine SQL-Datenbank in Neo4J importieren will, muss man zuerst alle Tabellen als CSV-Dateien exportieren. In Neo4J kann man die Dateien dann mit dem Cypher-Befehl:
```
LOAD CSV FROM 'file:/assistenten.csv' AS assistenten CREATE (:Assistenten { PersNr: assistenten[0], Name: assistenten[1], Fachgebiet: assistenten[2], Boss: assistenten[3] })
LOAD CSV FROM 'file:/hoeren.csv' AS hoeren CREATE (:Hoeren { Legi: hoeren[0], VorlNr: hoeren[1] })
LOAD CSV FROM 'file:/professoren.csv' AS professoren CREATE (:Professoren { PersNr: professoren[0], Name: professoren[1], Rang: 
professoren[2], Raum: professoren[3] })
LOAD CSV FROM 'file:/pruefen.csv' AS pruefen CREATE (:Pruefen { Legi: pruefen[0], Nr: pruefen[1], PersNr: pruefen[2], Note: pruefen[3]})
LOAD CSV FROM 'file:/studenten.csv' AS studenten CREATE (:Studenten { MatrNr: studenten[0], Name: studenten[1], Semester: studenten[2]})
LOAD CSV FROM 'file:/voraussetzen.csv' AS voraussetzen CREATE (:Voraussetzen { Vorgaenger: voraussetzen[0], Nachfolger: voraussetzen[1]})
LOAD CSV FROM 'file:/vorlesungen.csv' AS vorlesungen CREATE (:Vorlesungen { VorlNr: vorlesungen[0], Titel: vorlesungen[1], KP: vorlesungen[2], GelesenVon: vorlesungen[3]})
```
Importieren. Wichtig ist zu beachten, dass Neo4J über einen eigenen Import-Folder verfügt und durch file:/ automatisch dort nach der Datei sucht. Weiterhin muss man beim Importieren auch noch alle Informationen bezüglich der Benennung der Spalten der jeweiligen Tabelle angeben.
Beziehungen stellt man in Neo4J mit den folgenden Cypher-Befehlen her:
```
MATCH (a:Assistenten), (p:Professoren) WHERE a.Boss = p.PersNr CREATE (a)-[:Ist_angestellt_von]->(p)
MATCH (p:Professoren), (v:Vorlesungen) WHERE p.PersNr = v.GelesenVon CREATE (p)-[:Liest]->(v)
```
Dies stellt bei allen Assistenten und Professoren eine Beziehung mit dem Namen „Ist angestellt von“ her, bei denen der Boss von a (Assistenten) gleich der PersNr von p (Professoren) ist.

### 2.4	Wie interagiert der Benutzer mit der Datenbank?
Als Benutzer nutzt man die Abfragesprache Cypher.

## 3	Datenmodellierung
### 3.1	Welches Datenmodell (ER) liegt ihrem Projekt zugrunde?
Das SQL-Datenmodell sieht folgendermassen aus:
![SQL Schema](https://github.com/UncleBench/dbs_project/blob/master/Dokumentation/img/sql_schema.png)

### 3.2	Wie wird ihr Datenmodell in Ihrer Datenbank in ein Schema übersetzt?
Bei Neo4j wird das Datenmodell durch Knoten, Kanten und deren Beziehungen zu einander dargestellt.

## 4	Datenbanksprachen
### 4.1	Wie werden Daten anhand einer Query abgefragt?

## 5 Konsistenzsicherung
### 5.1	Wie wird die Datensicherheit gewährleistet?


### 5.2	Wie können Transaktionen parallel / konkurrierend verarbeitet werden?

## 6	Systemarchitektur
### 6.1	Wie ist der Server aufgebaut und wie wurde er installiert?
Auf der offiziellen Website von Neo4j kann man nach der Registrierung die Desktopversion herunterladen und installieren. In dieser Anwendung können verschiedenste Projekte mit der jeweils gewünschten Anzahl Datenbanken verwaltet werden. Möchte man nun mit einer Datenbank arbeiten, wird ein Neo4j Browswe geöffnet.

### 6.2	Wie kann die Effizienz von Datenanfragen optimiert werden?

## 7	Vergleich mit relationalen Datenbanken
### 7.1	Vergleichen Sie ihre NoSQL-Technologie mit SQL-Datenbanken.
Neo4j kann viel besser mit einer grossen Menge an Daten und vielen Beziehungen zwischen den Daten umgehen und somit leistet sie eine bessere Performance als relationale-Datenbanken.

## 8	Schlussfolgerungen
### 8.1	Was haben Sie erreicht, und welche Erkenntnisse haben sie dabei gewonnen?

### 8.2	Wie beurteilt ihre Gruppe die gewählte Datenbanktechnologie, und was sind Vor- und

### 8.3	Nachteile?
