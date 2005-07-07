package Tie::IxHash::FromText::Parse;

sub _ixhash {
    tie(my %h, 'Tie::IxHash');
    \%h;
}

sub _dxhash {
    tie(my %h, 'Tie::DxHash');
    \%h;
}


sub _parse {
    local $_ = shift;
    my $constr = {i=>\&_ixhash,d=>\&_dxhash}->{shift()};

    s/^[\s\n]+//so;
    s/^\*+\*\s/* /so;
    s/\n+$//sg;
    s/\n+/\n/sg;
    s/\s+$//mg;
    $_.=$/;

#    print ;    print $/x3;
    my @last = (0);
    my @st = ();
    my $tree=$constr->();
    s/^([\*]+)\s+(.+)/
      #	print "$1 $2\n";
      if(length($1) > $last[-1]){
	push @last, length($1);
	push @st, $2;
#	print '$tree->'.join('->', map{"{'$_'}"}@st)."\n";
	eval '$tree->'.join('->', map{"{'$_'}"}@st).'=$constr->()';
      }
    elsif(length($1) < $last[-1]){
      foreach (1..$last[-1] - length($1)){
#	print '...';
	pop @st;
	pop @last;
      }
	if(length($1) eq $last[-1]){
	  pop @st;
	  pop @last;
	  push @last, length($1);
	  push @st, $2;
	}
#      print '$tree->'.join('->', map{"{'$_'}"}@st)."\n";
      eval '$tree->'.join('->', map{"{'$_'}"}@st).'=$constr->()';
    }
    else {
      pop @st;
      pop @last;
      push @last, length($1);
      push @st, $2;
#      print '$tree->'.join('->', map{"{'$_'}"}@st)."\n";
	
      eval '$tree->'.join('->', map{"{'$_'}"}@st).'=$constr->()';
    }
#    print " (@last) (@st)\n\n";
    
/mexg;
    $tree;
}


1;
