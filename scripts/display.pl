#!/Users/metaperl/install/perl/bin/perl


use lib '/Users/metaperl/src/papp_hinduism/lib';

use Data::Dumper;
use DBIx::AnyDBD;
use DBIx::Connect;
use PApp::SQL;


my @data = DBIx::Connect->data_array('basic');
my $app  = DBIx::AnyDBD->connect(@data, 'PApp::Hinduism');
$PApp::SQL::DBH = $app->get_dbh;

my @school = $app->select_this_from_that('name', 'school');

my $tab = "\t";

for my $school (@school) {
    print $school, $/;
    my $school_id = $app->select_school_id($school);
#    warn $school_id;
    my @course_row = $app->select_course_rows_via_school_id($school_id);
    for my $course_row (@course_row) {
	print $tab, $course_row->[1], $tab, $course_row->[5], $/;
#	warn Dumper($course_row);
    }
}
