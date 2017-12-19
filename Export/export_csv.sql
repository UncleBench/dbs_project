COPY (SELECT * FROM assistenten) TO ‘/private/tmp/export/assistenten.csv’ WITH CSV header;
COPY (SELECT * FROM professoren) TO ‘/private/tmp/export/professoren.csv’ WITH CSV header;
COPY (SELECT * FROM studenten) TO ‘/private/tmp/export/studenten.csv’ WITH CSV header;
COPY (SELECT * FROM vorlesungen
	LEFT OUTER JOIN voraussetzen ON voraussetzen.Vorgänger = vorlesungen.VorlNr
	LEFT OUTER JOIN voraussetzen ON voraussetzen.Nachfolger = vorlesungen.VorlNr
) TO ‘/private/tmp/export/vorlesungen.csv’ WITH CSV header;
COPY (SELECT * FROM prüfen
	LEFT OUTER JOIN studenten ON studenten.Legi = prüfen.Legi
	LEFT OUTER JOIN vorlesungen ON vorlesungen.VorlNr = prüfen.Nr
	LEFT OUTER JOIN professoren ON professoren.PersNr = prüfen.PersNr
) TO ‘/private/tmp/export/pruefen.csv’ WITH CSV header;