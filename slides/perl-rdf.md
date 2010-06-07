% Praktisches RDF in Perl
% Thomas Kappler
% 2010-06-08


# Über mich

<div style='float: right'>
<img src="img/sib_logo_official.jpg" width="250" />
<br />
<img src="img/uniprot.png" width="250" style="padding-top: 20px" />
</div>

Thomas Kappler

Swiss Institute of Bioinformatics, Genf

Java, Emacs, ... Und jetzt neu: Perl

http://jugglingbits.wordpress.com


# Übersicht

  1. RDF
  2. Mit RDF arbeiten
    1. Text
    2. Datenbanken
  4. Weitere Codebeispiele

<table>
<tr> <td>Dieser Vortrag:</td>
     <td>http://github.com/thomas11/perl-rdf-talk</td> </tr>
<tr> <td>Code:</td>
     <td>http://github.com/thomas11/perl-rdf-experiments</td> </tr>
</table>


# Was ist das Problem?

<div style="font-size: 125%; padding: 1em 0 1em 0;">
**S**ilos  
**S**kripte  
**S**truktur
</div>

\> 50% der Arbeit in der Bioinformatik.


# RDF

<div style='float: right'>
![](img/rdf_logo_200.png)
</div>

Semantic Web? Erst mal reicht RDF für uns Programmierer.

<div style="font-size: 125%; padding: 1em 0 1em 0;">
Generisches Modell für Daten im Web.
</div>


# Der RDF-Graph

<table cellspacing="20">
<tr> <td>Dinge beschreiben: </td>
     <td><span style="font-size: 125%;">Subject&mdash;Property&mdash;Object</span></td>
     <td>.</td> </tr>
<tr class="incremental"> <td>Diese</td>
     <td style="text-align: center"><span style="font-size: 125%;">**Tripel**</span></td>
     <td> sind universal.</td> </tr>
<tr> <td colspan="2">&nbsp;</td> </tr>
</table>

<p style="text-align:right; margin-right:100px; margin-top:-1em;">
  <!-- <img src="img/graph-einfach.svg" /> -->
  <object data="img/graph-einfach.svg" type="image/svg+xml"
  height="250" />
</p>


# Der RDF-Graph

<table cellspacing="20">
<tr> <td>Dinge beschreiben: </td>
     <td><span style="font-size: 125%;">Subject&mdash;Property&mdash;Object</span></td>
     <td>.</td> </tr>
<tr> <td>Diese</td>
     <td style="text-align: center"><span style="font-size: 125%;">**Tripel**</span></td>
     <td> sind universal.</td> </tr>
<tr> <td colspan="2">Globale Adressierung mit **URIs**.</td> </tr>
</table>

<div style="text-align:right; margin-right:100px; margin-top:-1em;">
  <!-- <img src="img/graph-einfach.svg" /> -->
  <object data="img/graph-einfach-urls.svg" type="image/svg+xml"
  height="250" />
</div>

<!-- Wenn die URLs auch funktionieren: *Linked (Open) Data* :-) -->


# Linked Open Data

<!-- ![](img/lod-cloud-cropped.png) -->
<img src="img/lod-cloud-cropped.png" width="550" />

<div style="font-size: 75%; float: right">
Richard Cyganiak und Anja Jentzsch, CC by-sa
</div>


# Was bringt's?

*Ersparnis*.

  - XML: Parser.
  - XML Schema: Serialisierung.
  
<div style="font-size: 125%;">
  - RDF:
    - Datenmodell durch explizite Semantik.
    - Integration durch globale URLs.
</div>

<div style="font-size: 75%; text-align: right">
(frei nach Paul Gordon, Biohackathon Mailing List)
</div>


# Serialisierung

Mehrere&mdash;unabhängig vom Graphmodell.

RDF/XML  
Turtle  
N3  
JSON  
Perl-pragmatisch: `as_hashref`


# Serialisierung: RDF/XML

~~~~ {.Xml}
<?xml version='1.0' encoding='UTF-8'?>
<rdf:RDF xmlns="http://purl.uniprot.org/core/"
         xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about=
   "http://purl.uniprot.org/uniprot/P12345">
    <rdf:type rdf:resource=
     "http://purl.uniprot.org/core/Protein" />
    <created>1989-10-01</created>
    <enzyme rdf:resource=
     "http://purl.uniprot.org/enzyme/2.6.1.1" />
  </rdf:Description>
</rdf:RDF>
~~~~


# Serialisierung: Turtle

    @prefix uniprot: <http://purl.uniprot.org/core/> .
    @base <http://purl.uniprot.org/> .

    <uniprot/P12345>
        a               uniprot:Protein ;
        uniprot:created "1989-10-01" ;
        uniprot:enzyme  <enzyme/2.6.1.1> .


# Mit RDF arbeiten

<img src="img/perl-rdf-overview-800.jpg" width="700" />


# Mit RDF arbeiten

<div style="font-size: 125%; padding: 1em 0 1em 0;">
**RDF::Trine**: "An RDF Framework for Perl"  
von Gregory Williams.
</div>

RDF::Trine::Model  
<span style="visibility:hidden">RDF::Trine</span>::Node  
<span style="visibility:hidden">RDF::Trine</span>::Parser  
<span style="visibility:hidden">RDF::Trine</span>::Serializer  
<span style="visibility:hidden">RDF::Trine</span>::Store  
<span style="visibility:hidden">RDF::Trine</span>...


# Parser und Serialisierer

~~~~ {.Perl}
## use File::Slurp, Getopt::Std, strict etc.
use RDF::Trine;
# use RDF::Trine:: etc.;

my $base_uri = 'http://purl.uniprot.org/core';
my $store    = RDF::Trine::Store::Memory->new;
my $model    = RDF::Trine::Model->new($store);
 
## getopts, $file from ARGV etc.
my $rdf = read_file($file);

my $in_format  = $args{i} || 'rdfxml';
my $out_format = $args{o} || 'turtle';
~~~~


# Parser und Serialisierer

~~~~ {.Perl}
my $parser = RDF::Trine::Parser->new($in_format);
$parser->parse_into_model($base_uri,
                          $rdf, $model);

warn "Read " . $model->size . " statements.\n";

my $out = RDF::Trine::Serializer->new($out_format);
print $out->serialize_model_to_string($model);
~~~~


# Parser und Serializer

    $ perl trine-roundtrip.pl -o turtle p12345.rdf
    Read 3 statements.
    <http://purl.uniprot.org/uniprot/P12345>
        <http://purl.uniprot.org/core/created>
            "1989-10-01" ;
        <http://purl.uniprot.org/core/enzyme>
            <http://purl.uniprot.org/enzyme/2.6.1.1> ;
        a <http://purl.uniprot.org/core/Protein> .


# Mehr als nur Dateien

<ul>
  <li>Datenbank</li>
    <ul>
      <li>**Triple Stores**</li>
        <ul> <li>4store</li> <li>Virtuoso</li> <li>...</li> </ul>
        <li>Alles, was einen Graph speichern kann.</li>
        <ul> <li>In-Memory</li> <li>SQL</li> <li>...</li></ul>
    </ul>

  <li>Abfragesprache: **SPARQL**</li>
</ul>


# SPARQL

<div style="float:right;">
  <object data="img/graph-einfach-sparql.svg" type="image/svg+xml"
    height="250" />
</div>

**Graph Patterns**: Tripel mit Variablen.

Wann wurde P12345 angelegt?

    select ?date
    where {
      <uniprot/P12345>
      uniprot:created
      ?date
    }


# RDF::Query

~~~~ {.Perl}
my $query = new RDF::Query ( $sparql );
my result = $query->execute( $model );

while (my $row = $result->next) {
    print $row->{ date }->as_string;
}
~~~~


# RDF::Query

Programmatisch: siehe Extras. Kostprobe:

~~~~ {.Perl}
my $object = new_var($prop);
push @patterns,
     new_triple($subject, $UNIPROT->$prop, $object);
my $bgp = new
  RDF::Query::Algebra::BasicGraphPattern(@patterns);
# ...
~~~~


# Integration

<table cellspacing="20">
  <tr> <td>Perl-Code</td>    <td>Graph <-> Hash</td>    <td>Trine::Model</td> </tr>
  <tr> <td>Datenbank</td>    <td>Tripel relational</td> <td>Trine::Store</td> </tr>
  <tr> <td>Webanwendung</td> <td>JSON</td>              <td>Trine::{Serialiser,Parser}</td> </tr>
  <tr> <td></td>             <td>RDF bereitstellen</td> <td>Trine::{Serialiser,Parser}</td> </tr>
</table>


# Zusammenfassung

1. RDF-Graph: Tripel aus Subjekt-Prädikat-Objekt, mit URIs
<!-- 2. URIs und Literale; Linked Open Data -->
2. Serialisierung: RDF/XML, Turtle
3. RDF::Trine: Modell, Parser, Serialisierer
4. RDF::Query: SPARQL
5. Integration: MySQL, JSON, Hashes, RDFa


# Zusammenfassung

RDF mit Perl: voll unterstützt.

Extras kommen: Catalyst-Modell, RDF::LinkedData, XS.

**The Perl RDF Project**: http://www.perlrdf.org

<table>
<tr> <td>Dieser Vortrag:</td>
     <td>http://github.com/thomas11/perl-rdf-talk</td> </tr>
<tr> <td>Code:</td>
     <td>http://github.com/thomas11/perl-rdf-experiments</td> </tr>
</table>

# Danke an

**Greg Williams**, Toby Inkster, Kjetil Kjernsmo et al.:  
*The Perl RDF Project*

Toshiaki Katayama, DBCLS, CBRC: Biohackathon Tokyo

Swiss-Prot/SIB: mein Konferenzbesuch


# Mehr Code: Übersicht

1. RDF selbst gemacht: programmatisch generieren
2. SPARQL Queries programmatisch generieren

http://github.com/thomas11/perl-rdf-experiments


# RDF selbst gemacht: Übersicht

1. Namespaces
2. Ressourcen
3. Tripel
4. Graph

http://github.com/thomas11/perl-rdf-experiments/  
-> make_a_graph.pl


# RDF selbst gemacht, 1: Namespaces

~~~~ {.Perl}
my $BASE   = 'http://purl.uniprot.org/';

my %namespaces = ();
sub namespace {
    my ($section) = @_;
    my $ns = $namespaces{$section};
    if (not $ns) {
        my $url = $BASE . $section . '/';
        $ns = RDF::Trine::Namespace->new($url);
        $namespaces{$section} = $ns;
    }
    return $ns;
}

my $ONTOLOGY = namespace('core');
~~~~


# RDF selbst gemacht, 2: Resources

~~~~ {.Perl}
sub new_resource {
    my ($name, $section) = @_;
    return RDF::Trine::Node::Resource->new(
        $name, namespace($section) );
}

sub new_literal {
    my ($str) = @_;
    return RDF::Trine::Node::Literal->new( $str );
}
~~~~


# RDF selbst gemacht, 3: Statements

~~~~ {.Perl}
sub new_s {
    my ($s, $p, $o) = @_;
    return RDF::Trine::Statement->new($s, $p, $o);
}

my @stmts = (
  new_s($p12345, $ONTOLOGY->created,
        new_literal('1989-10-01')),
  new_s($p12345, $ONTOLOGY->enzyme,
        new_resource('2.6.1.1', 'enzyme')),
  new_s($p12345, $rdf->type,
        $ONTOLOGY->Protein)
);
~~~~


# RDF selbst gemacht, 4: Model

~~~~ {.Perl}
my $model = RDF::Trine::Model->new(
              RDF::Trine::Store::Memory->new );
foreach my $stmt (@stmts) {
    $model->add_statement($stmt);
}

my $serializer =
  RDF::Trine::Serializer->new( 'turtle' );
print $serializer->
  serialize_model_to_string($model), "\n";
~~~~


# RDF selbst gemacht, Ergebnis

    $ perl make_a_graph.pl
    <http://purl.uniprot.org/uniprot/P12345>
        <http://purl.uniprot.org/core/created>
            "1989-10-01" ;
	<http://purl.uniprot.org/core/enzyme>
            <http://purl.uniprot.org/enzyme/2.6.1.1> ;
	a <http://purl.uniprot.org/core/Protein> .


# SPARQL programmatisch

1. Basic Graph Pattern
2. Group Graph Pattern
3. Project
4. Query

http://github.com/thomas11/perl-rdf-experiments/  
-> make_a_sparql_query.pl


# SPARQL programmatisch: plumbing

~~~~ {.Perl}
my $BASE    = 'http://purl.uniprot.org/';
my $UNIPROT = RDF::Trine::Namespace->new('http://purl.uniprot.org/core/');

my $store   = RDF::Trine::Store::Memory->new;
my $model   = RDF::Trine::Model->new($store);

my $file = shift;
my $rdf  = read_file($file);

my $parser = RDF::Trine::Parser::Turtle->new;
$parser->parse_into_model( $BASE, $rdf, $model );
~~~~


# SPARQL programmatisch: Graph Patterns

~~~~ {.Perl}
sub new_var {
  my ($var) = @_;
  return scalar
      RDF::Query::Node::Variable->new($var);
}

sub new_triple {
  my ($s, $p, $o) = @_;
  return scalar
      new RDF::Query::Algebra::Triple($s, $p, $o)
}
~~~~


# SPARQL programmatisch: Project 

~~~~ {.Perl}
sub new_basic_project {
    my ($patterns, $result_prop) = @_;
    my $bgp = new
      RDF::Query::Algebra::BasicGraphPattern(
                  @$patterns);
    my $ggp = new
      RDF::Query::Algebra::GroupGraphPattern($bgp);
    return scalar RDF::Query::Algebra::Project->new(
                      $ggp, [new_var($result_prop)]);
}
~~~~


# SPARQL programmatisch: Project

~~~~ {.Perl}
my $p12345  = RDF::Trine::Node::Resource->new(
                  $BASE.'uniprot/P12345' );
my $result_prop = 'date';

my $patterns = [ new_triple($p12345,
                            $UNIPROT->created,
                            new_var($result_prop)) ];
my $project  = new_basic_project($patterns,
                                 $result_prop);
~~~~


# SPARQL programmatisch: Query senden

~~~~ {.Perl}
# Manual SELECT will soon be unnecessary.
my $sparql = "SELECT " . $project->as_sparql;
print $sparql, "\n\n";

my $results = new RDF::Query($sparql)
                  ->execute( $model );
while (my $triple = $results->next) {
    my $result = $triple->{ $result_prop };
    print "--> ", $result, "\n";
}
~~~~


# SPARQL programmatisch: Ergebnis

    $ perl make_a_sparql_query.pl testdata/p12345-abbr.tt 
    SELECT * WHERE {
        <http://purl.uniprot.org/uniprot/P12345>
            <http://purl.uniprot.org/core/created> ?date .
    }

    --> "1989-10-01"
    
