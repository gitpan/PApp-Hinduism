use lib '/Users/metaperl/src/papp_hinduism/lib';

use Data::Dumper;
use DBIx::AnyDBD;
use DBIx::Connect;
use PApp::SQL;


my @data = DBIx::Connect->data_array('basic');
my $app  = DBIx::AnyDBD->connect(@data, 'PApp::Hinduism');
$PApp::SQL::DBH = $app->get_dbh;

#$app->insert_publisher('University of California Press');

#$app->insert_person('lecturer', 'Eck', 'Diana', 'L');

#my $x = $app->next_in_sequence('course_reader___id');
#$app->insert_course_reader('Religion 160');

#$app->insert_book('Bhagavad Gita');

#$app->insert_school("Harvard University");
#$app->insert_material_type('book');
#$app->insert_material_type('course_reader');
#$app->insert_publisher('Prentice-Hall');

=head1
{
#    my $seq_id    = $app->select_nextval('course___id');
    my $seq_id    = 27;
#    my $school_id = $app->select_school_id('Harvard University');
#    $app->insert_course($seq_id,'Readings in Hindu Myth, Image, and Pilgrimage', 'http://www.hds.harvard.edu/cswr/courselist/hinduism.htm', $school_id, 'Intensive reading and research on specific topics in Hindu mythology, image and iconography, temples and temple towns, sacred geography and pilgrimage patterns.', 'Religion 3601');

    my $x = $app->select_id_for_person_type('lecturer');
    my $cl = $app->select_person($x, 'Eck', 'Diana', 'L');
    $app->insert_course_lecturer($seq_id, $cl);

#    my $mid  = 10;# "A Rapid Sanskrit Method" $app->select_id_from_name('Bhagavad Gita', 'book');
#    my $mtid = $app->select_id_from_name('book','material_type');
#    warn "$app->insert_course_material($seq_id, $mtid, $mid);";
#    $app->insert_course_material($seq_id, $mtid, $mid);
}

=cut
