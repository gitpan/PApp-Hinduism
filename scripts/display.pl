#!/Users/metaperl/install/perl/bin/perl


use lib '/Users/metaperl/src/papp_hinduism/lib';

use Data::Dumper;
use DBIx::AnyDBD;
use DBIx::Connect;
use PApp::SQL;
use Text::Template;

my @data = DBIx::Connect->data_array('basic');
my $app  = DBIx::AnyDBD->connect(@data, 'PApp::Hinduism');
$PApp::SQL::DBH = $app->get_dbh;

my @school = $app->select_this_from_that('name', 'school');

my $tab = "\t";

for our $school (@school) {
    print $school, $/;


    my $school_id = $app->select_school_id($school);
#    warn $school_id;
    our @course_row = $app->select_course_rows_via_school_id($school_id);
    for my $course_row (@course_row) {
	print " <h3> $course_row->[1] ($course_row->[5]) </h3>\n";
	print $app->select_course_lecturer_via_course_id($course_row->[0]), $/;
# DESCRIPTION	print $course_row->[4];
	print $app->select_course_materials_via_course_id($course_row->[0]), $/;
    }
    
#    warn $template->fill_in;

}
