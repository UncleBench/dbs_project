COPY (SELECT * FROM assistenten) TO '/tmp/assistenten.csv' WITH CSV header;
COPY (SELECT * FROM professoren) TO '/tmp/professoren.csv' WITH CSV header;
COPY (SELECT * FROM studenten) TO '/tmp/studenten.csv' WITH CSV header;
COPY (SELECT * FROM pruefen
	LEFT OUTER JOIN studenten ON studenten.matrnr = pruefen.matrnr
	LEFT OUTER JOIN vorlesungen ON vorlesungen.VorlNr = pruefen.vorlnr
	LEFT OUTER JOIN professoren ON professoren.PersNr = pruefen.persnr
) TO '/tmp/pruefen.csv' WITH CSV header;
COPY (SELECT * FROM vorlesungen
	LEFT OUTER JOIN voraussetzen ON voraussetzen.Vorgänger = vorlesungen.VorlNr
	LEFT OUTER JOIN voraussetzen ON voraussetzen.Nachfolger = vorlesungen.VorlNr
) TO '/tmp/vorlesungen.csv' WITH CSV header;