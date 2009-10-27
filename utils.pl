sub stop($;$) {
	my $code;
	if (scalar @_ >1) {
		$code = pop;
	} else {
		$code = 1;
	}
	print @_, "\n";
	exit $code;
}

sub hashMerge(\%\%) {
	my $main = shift;
	foreach my $hash (@_) {
		while (my ($k, $v) = each(%$hash)) {
			$main->{$k} = $v;
		}
	}
	
	return $main;
}

sub hashIntersect(\%\%;\%) {
	my ($h1, $h2, $result) = @_;
	$result = {} unless ref $result;
	while (my($key, $value) = each %$h1) {
		$result{$key} = $value unless exists $h1{$key};
	}
	return $result;
}

sub arr2bind(\@) {
	# create '?' for each array item
	# for example, for ('a', 'b', 5) this will return '?, ?, ?';
	my $arr = shift;
	my $s = '?,' x @$arr;
	chop $s;
	return $s;
}

sub printArray($$;$$) {
	# at least $row and $delim must be passed
	my ($row, $delim, $start, $end) = @_;
	print $start if defined $start;
	print join($delim, @$row);
	print $end if defined $end;
}
