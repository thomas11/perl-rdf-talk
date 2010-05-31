# Semantisches Hacking: RDF in Perl


## Abstract

Modernes Perl fuer das moderne Web: Tim Berners-Lees Vision der
Zukunft des Internets ist das Semantic Web. Dessen wichtigster
Baustein ist das Datenformat [RDF](http://www.w3.org/TR/rdf-primer/).

In diesem Vortrag schauen wir uns zunaechst die Grundlagen von RDF
an. Auch die Frage, wo zu das alles eigentlich gut ist (und wozu
nicht), sollte nicht zu kurz kommen.

Dann wird's praktischer: wir sehen, wie man mit RDF::Trine und
RDF::Query RDF lesen, serialisieren, speichern, und abfragen
kann. Dabei machen wir immer wieder kurze Ausfluege in die Grundlagen
des Semantic Web. Wir werden zwischen den verschiedenen
Serialisierungen von RDF konvertieren (und sehen, warum es die
ueberhaupt gibt).

Wenn die Zeit reicht, werden wir schliesslich in einem kleinen
praktischen Beispiel RDF aus dem Netz in eine Datenbank laden und ein
kleines Werkzeug zum bequemen Abfragen des Selben bauen.  Dies alles
ist bequem mit vorhandenen CPAN-Modulen machbar.


## Vortrag

Die Folien und Verweise zu Code sind auf
[Github](http://github.com/thomas11/perl-rdf-talk).

Der im Vortrag gezeigte Code basiert grossteils auf diesem
[Repository](http://github.com/thomas11/perl-rdf-experiments).


## Links

Perls RDF-Community ist auf [www.perlrdf.org](http://www.perlrdf.org/)
organisiert. Dort finden sich auch Verweise zu den wichtigsten
CPAN-Modulen.

Zum tieferen Einstieg in RDF ist der
[RDF Primer](http://www.w3.org/TR/rdf-primer/) unverzichtbar. Die
[Linked Data](http://linkeddata.org/) Bewegung vereint viele
Ressourcen und Initiativen zur praktischen Anwendung von RDF zur
besseren Verbreitung und Verknuepfung von Daten. Auf
[Planet RDF](http://planetrdf.com/) bekommt man mit, was sich tut in
der RDF-Welt.


## Der Vortragende

Thomas Kappler hat an der Uni Karlsruhe Informatik studiert und nach
dem Diplom zunaechst als freiberuflicher Entwickler gearbeitet, bevor
es ihn 2008 nach Genf verschlagen hat. Dort ist er Programmierer bei
[Swiss-Prot](http://www.isb-sib.ch/groups/geneva-/swiss-prot-i-xenarios.html)
am [Swiss Institute of Bioinformatics](http://www.isb-sib.ch), wo er
mit Perl und Java Werkzeuge fuer Biologen entwickelt. Dabei arbeitet
er auch an [UniProtKB](www.uniprot.org), der weltweit bedeutendsten
Protein-Datenbank und einer der groessten freien RDF-Datensaetze.

Thomas programmiert hauptsaechlich in Java und hat erst spaet zu Perl
gefunden, dann aber Feuer gefangen. Die Einladung zum Biohackathon
2010 in Tokyo gab ihm die Moeglichkeit, die Perl-Module rund um RDF zu
erkunden, wofuer er sich bei den Gastgebern
[DBCLS](http://dbcls.rois.ac.jp/en/) und
[CBRC](http://www.cbrc.jp/index.eng.html) sehr herzlich bedankt.

Sein technisches Blog ist
[Juggling Bits](http://jugglingbits.wordpress.com).
