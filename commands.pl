# import file into storage (cp)
sub importFile($$) {
	my ($src, $dst) = @_;
}

# hash list is a hash, where each key - oid, value - hash with object props or undef, if props not loaded
# properties include:
# 
#	oid		same as key, it's database key of object row
#	hash	md5 of object content
# optional attributes:
#	tags - hash, where key is tagname, value - undef (can be extended in future)
#	attributes - hash, where key is attribute name, value - attribute value
#	attaches - hash, where key is attach oid, value - undef (can be extended in future)


# import info objects into database
# returns ref to object hashlist
sub importObjects(\@) {
	my $files = shift;
}

sub tagObjects(\%\%) {
	my ($oids, $tags) = @_;
}

sub untagObjects(\%\%) {
	my ($oids, $tags) = @_;
}

sub getObjectInfo(\%;\%) {
	my ($oids, $fullList) = @_;
}

sub setObjectAttributes(\%\%) {
	my ($objectList, $attributes) = @_;
}

sub getObjectAttributes(\%;\@) {
	my ($objectList, $attrNames) = @_;
}

sub attachObjects(\%\%) {
	my ($objects, $attaches) = @_;
}

sub detachObjects(\%\%) {
	my ($objects, $attaches) = @_;
}

sub getObjectAttaches(\%) {
	my $objects = shift;
}

sub getObjects($\@;\%) {
	my ($key, $values, $objects) = @_;
}

sub getTagObjects(\%;\%) {
	my ($tags, $objectList) = @_;
}

sub getAttachMasters(\%;\%) {
	my ($attaches, $objects) = @_;
}

sub getAttributeOwners(\%;\%) {
	my ($attributes, $objects) = @_;
}

sub deleteTags(\[%@]) {
	my $tags = shift;
	my $tagList;
	$taglist = (ref $tags eq 'HASH')? [keys %$tags]: $tags;
}