package TaggedStorage;




# 7) TODO: tagit search term	- must search in CONTENT
# 8) TODO: add VCS suport

use constant SQLITE_ERROR     =>   1;   # SQL error or missing database
use constant SQLITE_INTERNAL  =>   2;   # Internal logic error in SQLite
use constant SQLITE_PERM      =>   3;   # Access permission denied
use constant SQLITE_ABORT     =>   4;   # Callback routine requested an abort
use constant SQLITE_BUSY      =>   5;   # The database file is locked
use constant SQLITE_LOCKED    =>   6;   # A table in the database is locked
use constant SQLITE_NOMEM     =>   7;   # A malloc() failed
use constant SQLITE_READONLY  =>   8;   # Attempt to write a readonly database 
use constant SQLITE_INTERRUPT =>   9;   # Operation terminated by sqlite3_interrupt()
use constant SQLITE_IOERR     =>  10;   # Some kind of disk I/O error occurred 
use constant SQLITE_CORRUPT   =>  11;   # The database disk image is malformed 
use constant SQLITE_NOTFOUND  =>  12;   # NOT USED. Table or record not found 
use constant SQLITE_FULL      =>  13;   # Insertion failed because database is full 
use constant SQLITE_CANTOPEN  =>  14;   # Unable to open the database file 
use constant SQLITE_PROTOCOL  =>  15;   # NOT USED. Database lock protocol error 
use constant SQLITE_EMPTY     =>  16;   # Database is empty 
use constant SQLITE_SCHEMA    =>  17;   # The database schema changed 
use constant SQLITE_TOOBIG    =>  18;   # String or BLOB exceeds size limit 
use constant SQLITE_CONSTRAINT=>  19;   # Abort due to constraint violation 
use constant SQLITE_MISMATCH  =>  20;   # Data type mismatch 
use constant SQLITE_MISUSE    =>  21;   # Library used incorrectly 
use constant SQLITE_NOLFS     =>  22;   # Uses OS features not supported on host 
use constant SQLITE_AUTH      =>  23;   # Authorization denied 
use constant SQLITE_FORMAT    =>  24;   # Auxiliary database format error 
use constant SQLITE_RANGE     =>  25;   # 2nd parameter to sqlite3_bind out of range 
use constant SQLITE_NOTADB    =>  26;   # File opened that is not a database file 
use constant SQLITE_ROW       =>  100;  # sqlite3_step() has another row ready 
use constant SQLITE_DONE      =>  101;  # sqlite3_step() has finished executing 


use constant NOT_FOUND		=>	-1;
use constant ALREADY_EXISTS	=>	-2;
use constant SQL_ERROR		=>	-3;
use constant FS_ERROR		=>	-4;

use DBI;
use Digest::MD5::File qw(file_md5_hex);
use File::Spec;
use File::Copy;

sub hashMerge(\%\%) {
	my $main = shift;
	foreach my $hash (@_) {
		while (my ($k, $v) = each(%$hash)) {
			$main->{$k} = $v unless exists $main->{$k};
		}
	}
	
	return $main;
}

=pod

=item init

Initializes internal machinery to work with storage, starting tarnsaction if requested
 optional:
 dbFile
 fileStorage
 transaction: autocommit/autorollback/none; default is autorollback

=cut

my $defaultDataDir = "$ENV{HOME}/.local/share/tagit";
my %defaultOptions = (
	dbFile 		=> "$dataDir/base.sqlite",
	fileStorage => "$dataDir/items",
	transaction => "none",	# currently NOT IMPLEMENTED
);

my $dbh;

sub init(;\%) {
	my $options = shift;
	$options = {} unless $options;
	hashMerge(%$options, %defaultOptions);
	my $base="dbi:SQLite:dbname=" . $options->dbFile;
	$dbh = DBI->connect($base,"","",
		{
        	PrintError => 0,
		}
	);

}

#### Transactions support

# arg: commit/rollback/none
#if transaction is active, changes wil be applied when it will be ended
# is transaction is not active, changes are applied immediately, (and transaction may start)
sub setTransactionMode($) {
}

sub beginTransaction() {
}

sub commit() {
}

sub rollback() {
}

#### core functionality

# hash list is a hash, where each key - oid, value - hash with object props or undef, if props not loaded
# properties include:
# 
#	oid		same as key, it's database key of object row
#	hash	md5 of object content
# optional attributes:
#	tags - taghash == hash, where key is tagname, value - undef (can be extended in future)
#	attributes - attrhash == hash, where key is attribute name, value - attribute value
#	attaches - attach-hash == hash, where key is attach oid, value - undef (can be extended in future)

# any function return OK or error constant, if not stated otherwise

# import file into storage (cp)
sub importFile($$) {
	my ($src, $dst) = @_;
}

# import info about objects into database
# accepts array of file paths
# returns ref to object hashlist

sub importObjects(\@) {
	my $files = shift;
}

# accepts hashlist, taghash
sub tagObjects(\%\%) {
	my ($oids, $tags) = @_;
}

# accepts hashlist, taghash
sub untagObjects(\%\%) {
	my ($oids, $tags) = @_;
}

# accepts hashlist, hashlist
# fills first arg with object info (set hash values based on oids),
# if second arg is geven, merges first arg to it
sub getObjectInfo(\%;\%) {
	my ($oids, $fullList) = @_;
}


# accepts hashlist, attrhash
sub setObjectAttributes(\%\%) {
	my ($objectList, $attributes) = @_;
}

# accepts hashlist and array of needed attribute names
# extends hashlist values with appropriate attrhashes
sub getObjectAttributes(\%;\@) {
	my ($objectList, $attrNames) = @_;
}

# accepts hashlist, attach-hash
sub attachObjects(\%\%) {
	my ($objects, $attaches) = @_;
}

# accepts hashlist, attach-hash
sub detachObjects(\%\%) {
	my ($objects, $attaches) = @_;
}

# accepts hashlists
# extends hashlist values with appropriate attach-hashes
sub getObjectAttaches(\%) {
	my $objects = shift;
}

# accepts name of base property (oid, hash etc)
# accepts array of property values
# optionally accepts hashlist where search result will be merged
# returns search result as hashlist or error constant 
sub getObjects($\@;\%) {
	my ($key, $values, $objects) = @_;
}

# accepts taghash
# optionally accepts hashlist where search result will be merged
# returns search result as hashlist or error constant
sub getTagObjects(\%;\%) {
	my ($tags, $objectList) = @_;
}

# accepts hashlist
# optionally accepts hashlist where search result will be merged
# returns search result as hashlist or error constant
sub getAttachMasters(\%;\%) {
	my ($attaches, $objects) = @_;
}

# accepts attrlist
# optionally accepts hashlist where search result will be merged
# returns search result as hashlist or error constant
sub getAttributeOwners(\%;\%) {
	my ($attributes, $objects) = @_;
}

# accepts attrlist or array of tagnames
# deletes only tags, not objects
# objects can become not tagged at all after this
sub deleteTags(\[%@]) {
	my $tags = shift;
	my $tagList;
	$taglist = (ref $tags eq 'HASH')? [keys %$tags]: $tags;
}


# returns hashlist of untagged objects
sub getWidowObjects{
}
