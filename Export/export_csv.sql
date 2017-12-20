COPY (SELECT * FROM voraussetzen) TO '/tmp/voraussetzen.csv' WITH CSV header;
COPY (SELECT * FROM hören) TO '/tmp/hoeren.csv' WITH CSV header;
COPY (SELECT * FROM assistenten) TO '/tmp/assistenten.csv' WITH CSV header;
COPY (SELECT * FROM professoren) TO '/tmp/professoren.csv' WITH CSV header;
COPY (SELECT * FROM studenten) TO '/tmp/studenten.csv' WITH CSV header;
COPY (SELECT * FROM pruefen) TO '/tmp/pruefen.csv' WITH CSV header;
COPY (SELECT * FROM vorlesungen) TO '/tmp/vorlesungen.csv' WITH CSV header;