#!/usr/bin/perl

if (@ARGV != 1) {
  print "usage : ./wave_parser.pl <file name>"
}

binmode FP;
open (FP, $ARGV[0]) or die("cannot open the file");

$line = 0;
while (read(FP, $buff, 1)) {

  while ( $line < 12 ) { # Riff chunk parser
    if ($line < 4 ) {
      if ($line == 0) {
        print "ckID:";
      }
      print "$buff";
    }
    elsif ($line < 8 ) {
      if ($line == 4) {
        print "\n";
        print "ckSize:";
        $val0 = unpack("C", $buff);
        printf("%02x ", unpack("C", $buff));
      }
      elsif ($line == 5) {
        $val1 = unpack("C", $buff);
        printf("%02x ", unpack("C", $buff));
      }
      elsif ($line == 6) {
        $val2 = unpack("C", $buff);
        printf("%02x ", unpack("C", $buff));
      }
      else {
        printf("%02x ", unpack("C", $buff));
        $val3 = unpack("C", $buff);
        $val0 = $val0 + ($val1 << 8) + ($val2 << 16) + ($val3 << 24);
        print "( $val0 Byte)";
      }
    }
    elsif ($line < 12 ) {
      if ($line == 8) {
        print "\n";
        print "Riff Type:";
      }
      print "$buff";
    }
    $line ++;
    read(FP, $buff, 1);
  }

  while ( $line < 36 ) { # fmt chunk parser
    if ($line < 16 ) {
      if ($line == 12) {
        print "\n";
        print "FMT ID:";
      }
      print "$buff";
    }
    elsif ($line < 20 ) {
      if ($line == 16) {
        print "\n";
        print "FMT size:";
        $val0 = unpack("C", $buff);
        printf("%02x ", unpack("C", $buff));
      }
      elsif ($line == 17) {
        $val1 = unpack("C", $buff);
        printf("%02x ", unpack("C", $buff));
      }
      elsif ($line == 18) {
        $val2 = unpack("C", $buff);
        printf("%02x ", unpack("C", $buff));
      }
      else {
        printf("%02x ", unpack("C", $buff));
        $val3 = unpack("C", $buff);
        $val0 = $val0 + ($val1 << 8) + ($val2 << 16) + ($val3 << 24);
        print "( $val0 Byte)";
      }
    }
    elsif ($line < 22) {
      if ($line == 20) {
        print "\n";
        print "Format Tag:";
        $val0 = unpack("C", $buff);
      }
      printf("%02x ", unpack("C", $buff));
    }
    elsif ($line < 24) {
      if ($line == 22) {
        print "\n";
        print "Channel Num:";
        $val0 = unpack("C", $buff);
        printf("%02x ", unpack("C", $buff));
      }
      elsif ($line == 23) {
        $val1 = unpack("C", $buff);
        printf("%02x ", unpack("C", $buff));
        $val0 = $val0 + ($val1 << 8);
        print "( $val0 )";
      }
    }
    elsif ($line < 28) {
      if ($line == 24) {
        print "\n";
        print "Sampling Frequency:";
        $val0 = unpack("C", $buff);
        printf("%02x ", unpack("C", $buff));
      }
      elsif ($line == 25) {
        $val1 = unpack("C", $buff);
        printf("%02x ", unpack("C", $buff));
      }
      elsif ($line == 26) {
        $val2 = unpack("C", $buff);
        printf("%02x ", unpack("C", $buff));
      }
      else {
        printf("%02x ", unpack("C", $buff));
        $val3 = unpack("C", $buff);
        $val0 = $val0 + ($val1 << 8) + ($val2 << 16) + ($val3 << 24);
        print "( $val0 Hz )";
      }
    }
    elsif ($line < 32) {
      if ($line == 28) {
        print "\n";
        print "Average Byte/Sec:";
        $val0 = unpack("C", $buff);
        printf("%02x ", unpack("C", $buff));
      }
      elsif ($line == 29) {
        $val1 = unpack("C", $buff);
        printf("%02x ", unpack("C", $buff));
      }
      elsif ($line == 30) {
        $val2 = unpack("C", $buff);
        printf("%02x ", unpack("C", $buff));
      }
      else {
        printf("%02x ", unpack("C", $buff));
        $val3 = unpack("C", $buff);
        $val0 = $val0 + ($val1 << 8) + ($val2 << 16) + ($val3 << 24);
        print "( $val0 )";
      }
    }
    elsif ($line < 34) {
      if ($line == 32) {
        print "\n";
        print "Block Size(Byte/sample):";
        $val0 = unpack("C", $buff);
        printf("%02x ", unpack("C", $buff));
      }
      elsif ($line == 33) {
        $val1 = unpack("C", $buff);
        printf("%02x ", unpack("C", $buff));
        $val0 = $val0 + ($val1 << 8);
        print "( $val0 )";
      }
    }
    elsif ($line < 36) {
      if ($line == 34) {
        print "\n";
        print "Bit num:";
        $val0 = unpack("C", $buff);
        printf("%02x ", unpack("C", $buff));
      }
      elsif ($line == 35) {
        $val1 = unpack("C", $buff);
        printf("%02x ", unpack("C", $buff));
        $val0 = $val0 + ($val1 << 8);
        print "( $val0 bit )";
      }
    }
    
    $line ++;
    read(FP, $buff, 1);
  }

  while ( $line < 44 ) { # list chunk parser
    if ($line < 40 ) {
      if ($line == 36) {
        print "\n";
        print "Data ID:";
      }
      print "$buff";
    }
    elsif ($line < 44 ) {
      if ($line == 40) {
        
        print "\n";
        print "Data size:";
        $val0 = unpack("C", $buff);
        printf("%02x ", unpack("C", $buff));
      }
      elsif ($line == 41) {
        $val1 = unpack("C", $buff);
        printf("%02x ", unpack("C", $buff));
      }
      elsif ($line == 42) {
        $val2 = unpack("C", $buff);
        printf("%02x ", unpack("C", $buff));
      }
      else {
        printf("%02x ", unpack("C", $buff));
        $val3 = unpack("C", $buff);
        $val0 = $val0 + ($val1 << 8) + ($val2 << 16) + ($val3 << 24);
        print "( $val0 Byte)";
        $dataSize = $val0;
      }
    }
    $line ++;
    read(FP, $buff, 1);
  }

  #$num = ($line - 44);
  #while ( $num < $dataSize) {
  #  if ( $num < 4 ) {
  #    if ( $num == 0 ) {
  #      print "\n";
  #   }
  #    print $buff;
  #  }
  #  elsif ( $num < 8 ) {
  #    if ( $num == 4 ) {
  #      print "\n";
  #    }
  #    print $buff;
  #  }
  #  else {
  #    $val0 = unpack("C", $buff);
  #    printf("%02x ", unpack("C", $buff));
  #  }
  #  $line ++;
  #  $num = ($line - 44);
  #  read(FP, $buff, 1);
  #}

  if ( $line >= 44 ) {
    last;
  }
}
print "\n";

close (FP);


