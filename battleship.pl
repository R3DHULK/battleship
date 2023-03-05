use strict;
use warnings;

my @board;      # 10x10 board
my @ship_locs;  # array to hold locations of ships

# initialize board
for my $i (0..9) {
    for my $j (0..9) {
        $board[$i][$j] = '.';
    }
}

# randomly place 5 ships on the board
for (my $i = 0; $i < 5; $i++) {
    my $x = int(rand(10));
    my $y = int(rand(10));
    while ($board[$x][$y] eq 'X') {  # avoid overlapping ships
        $x = int(rand(10));
        $y = int(rand(10));
    }
    $board[$x][$y] = 'X';
    push @ship_locs, [$x, $y];
}

# game loop
my $num_hits = 0;
while ($num_hits < 5) {  # game ends when all ships are hit
    print_board();

    # get user input
    print "Enter row and column (separated by a space): ";
    chomp(my $input = <STDIN>);
    my ($row, $col) = split(/\s+/, $input);

    # check if it's a hit or a miss
    if ($board[$row][$col] eq 'X') {
        print "Hit!\n";
        $num_hits++;
        $board[$row][$col] = 'H';  # mark the hit
    } elsif ($board[$row][$col] eq '.') {
        print "Miss.\n";
        $board[$row][$col] = 'M';  # mark the miss
    } else {
        print "You've already hit that spot.\n";
    }
}

# game over
print_board();
print "Congratulations, you sank all the ships!\n";

# subroutines

sub print_board {
    print "  0 1 2 3 4 5 6 7 8 9\n";
    for my $i (0..9) {
        print "$i ";
        for my $j (0..9) {
            if ($board[$i][$j] eq 'X' || $board[$i][$j] eq '.') {
                print "$board[$i][$j] ";
            } elsif ($board[$i][$j] eq 'H') {
                print "\x1b[31mH\x1b[0m ";  # red for hit
            } else {
                print "\x1b[34mM\x1b[0m ";  # blue for miss
            }
        }
        print "\n";
    }
    print "\n";
}
