use lib '/Users/metaperl/src/papp_hinduism/lib';

use Data::Dumper;
use DBIx::AnyDBD;
use DBIx::Connect;
use PApp::SQL;


my @data = DBIx::Connect->data_array('basic');
my $app  = DBIx::AnyDBD->connect(@data, 'PApp::Hinduism');
$PApp::SQL::DBH = $app->get_dbh;

$app->create_temp('course');

#$app->insert_dept('Sanskrit and Indian Studies');
#$app->insert_school_dept_course(

#$app->insert_book_in_course_material_via_book_id_and_course_id( 15  , 27);
#$app->insert_book("Patanjali's Yoga Sutras");

#$app->insert_publisher('University of California Press');

#Leonard W. J. van der Kuijp 

#$app->insert_person('lecturer', 'Kuijp', 'Leonard', 'W. J. van der');

#my $x = $app->next_in_sequence('course_reader___id');
#$app->insert_course_reader('RELS 104');



#$app->insert_school("Harvard University");
#$app->insert_material_type('book');
#$app->insert_material_type('course_reader');
#$app->insert_publisher('Prentice-Hall');

=head1
{
    my $seq_id    = $app->select_nextval('course___id');
#    my $seq_id    = 28;
    my $school_id = $app->select_school_id('Harvard University');
    $app->insert_course(
$seq_id,
'Intermediate Sanskrit',
'http://www.registrar.fas.harvard.edu/Courses/SanskritandIndianStudies.html', 
$school_id, 

''
,
'Sanskrit 102b');

    my $x = $app->select_id_for_person_type('lecturer');
    my $cl = $app->select_person($x, 'Kuijp', 'Leonard', 'W. J. van der');
    $app->insert_course_lecturer($seq_id, $cl);

#    my $mid  = 10;# "A Rapid Sanskrit Method" $app->select_id_from_name('Bhagavad Gita', 'book');
#    my $mtid = $app->select_id_from_name('book','material_type');
#    warn "$app->insert_course_material($seq_id, $mtid, $mid);";
#    $app->insert_course_material($seq_id, $mtid, $mid);
}

=cut
