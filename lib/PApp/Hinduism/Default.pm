package PApp::Hinduism::Default;

use Data::Dumper;
use DBIx::Recordset;
use PApp::SQL;

sub select_nextval {
    my ($ah, $sequence_name) = @_;
    sql_fetch \my($number), "select nextval('$sequence_name')";
    $number;
}

sub select_publisher_id {
    my ($ah, $publisher) = @_;
    sql_fetch \my($value), "select id from publisher where name = '$publisher'";
    $value;
}

sub insert_publisher {
    my ($ah, $publisher) = @_;
    my $publisher_id = $ah->select_nextval('publisher___id');
    sql_exec "INSERT into PUBLISHER VALUES ($publisher_id, '$publisher')";
}

sub select_school_id_from_school_course_number {
   my ($ah, $school_course_number) = @_;
   sql_fetch "SELECT id from course where school_course_number = '$school_course_number'";
}

sub insert_course_reader {
    my ($ah, $school_course_number) = @_;
    my $crid = $ah->select_nextval('course_reader___id');
    my $sid  = $ah->select_school_id_from_school_course_number($school_course_number);
    my $sql = "INSERT into course_reader VALUES ($crid, $sid)";
    warn $sql;
    sql_exec $sql;
    my $mtid = $ah->select_id_from_name('course_reader', 'material_type');
    $ah->insert_course_material($sid, $mtid, $crid);
}

sub insert_course_material {
    my ($ah, $course_id, $material_type_id, $material_id) = @_;
    $material_id = "'$material_id'" unless $material_id =~ /\d+/;
    sql_exec "INSERT into course_material VALUES ($course_id, $material_type_id, $material_id)";
}

sub insert_course {
    my ($ah, $seq_id, $course_name, $url, $school_id, $description, $course_number) = @_;
    my $sql = "INSERT INTO course VALUES ($seq_id, '$course_name', '$url', $school_id, '$description', '$course_number')";
    warn $sql;
    sql_exec $sql;
}

sub insert_book {
    my ($ah, $book, $publisher, $last_name, $first_name, $middle_name, $pub_year) = @_;
    my $seq_id = $ah->select_nextval('book___id');
    my $pub_id = $ah->select_publisher_id($publisher);
    my $aut_type = $ah->select_id_for_person_type('author');
    my $aut_id = $ah->select_person($aut_type, $last_name, $first_name, $middle_name);

  DBIx::Recordset->Insert({
      '!DataSource' => $PApp::SQL::DBH,
      '!Table'      => 'book',
      id => $seq_id,
      name => $book,
      publisher_id => $pub_id,
      author_id => $aut_id,
      pub_year => $pub_year
      });


}

sub insert_book_in_course_material_via_book_id_and_course_id {
    my ($ah, $book_id, $course_id) = @_; 

    my $mtid = $ah->select_id_from_name('book', 'material_type');
    $ah->insert_course_material($course_id,  $mtid, $book_id);
}

sub insert_material_type {
    my ($ah, $material_type) = @_;
    my $seq_id = $ah->next_in_sequence('material_type___id');
    sql_exec "INSERT into material_type VALUES ($seq_id,'$material_type')";
}

sub insert_school {
    my ($ah, $school) = @_;
    my $seq_id = $ah->select_nextval('school___id');
    sql_exec "INSERT into SCHOOL VALUES ($seq_id,'$school')";
}

sub select_course_materials_via_course_id {
    my ($ah, $course_id) = @_;
    my $sql = "SELECT * FROM course_material WHERE course_id = $course_id";
    warn $sql;
    my @course_material = sql_fetchall $sql;
    Dumper(\@course_material);
}

sub select_course_lecturer_via_course_id {
    my ($ah, $course_id) = @_;
    my $sql = "SELECT lecturer_id FROM course_lecturer WHERE course_id = $course_id";
#    warn $sql;
    sql_fetch \my($lecturer_id), $sql;

    return "None listed" unless $lecturer_id;

    $sql = "SELECT first_name, middle_name, last_name FROM person WHERE id = $lecturer_id";
#    warn $sql;
    sql_fetch \my ($first_name, $middle_name, $last_name), $sql;
    "$first_name $middlename $last_name";
}


sub insert_course_lecturer {
    my ($ah, $course_id, $lecturer_id) = @_;
    my $sql = "INSERT into course_lecturer VALUES ($course_id, $lecturer_id)";
    warn $sql;
    sql_exec $sql;
}

sub insert_person {
    my ($ah, $person_type, $last_name, $first_name, $middle_name) = @_;
    my $seq = $ah->select_nextval('person___id');
    my $person_type_id = $ah->select_id_for_person_type($person_type);
    sql_exec "INSERT into person VALUES ($seq, $person_type_id, '$last_name', '$first_name', '$middle_name')";
}

sub select_school_id {
    my ($ah, $school) = @_;
    sql_fetch \my($school_id), "select id from SCHOOL WHERE name = '$school'";
    $school_id;
}

sub select_course_name_via_school_id {
    my ($ah, $school_id) = @_;
    sql_fetchall "select name from course where school_id = $school_id";
}

sub select_course_rows_via_school_id {
    my ($ah, $school_id) = @_;
    sql_fetchall "select * from course where school_id = $school_id order by id";
}
    

sub select_id_from_school_course_number {
    my ($ah, $key) = @_;
    sql_fetch \my($value), "select id from course WHERE school_course_number = '$key'";
    $value;
}

sub select_id_for_person_type {
    my ($ah, $person_type) = @_;
    sql_fetch \my($id), "select id from person_type WHERE name = '$person_type'";
    $id;
}

sub select_id_from_name {
    my ($ah, $name, $table) = @_;
    my $sql = "select id from $table WHERE name = '$name'";
    warn $sql;
    sql_fetch \my($id), $sql;
    $id;
}

sub select_this_from_that {
    my ($ah,$this, $that) = @_;
    my $sql = "select $this from $that";
    warn $sql;
    sql_fetchall $sql;
}


sub select_person_type {
    my ($ah, $person_type) = @_;
    sql_fetch \my($id), "select id from person_type WHERE name = '$person_type'";
    $id;
}


sub select_person {
    my ($ah, $person_type, $last_name, $first_name, $middle_name) = @_;
    
    my $sql = "select id from person WHERE person_type_id = $person_type and last_name = '$last_name' and first_name = '$first_name'";
    $sql .=  "and middle_name = '$middle_name'" if $middle_name;

    warn $sql;
    sql_fetch \my($id), $sql;
    $id;
}
  

1;
