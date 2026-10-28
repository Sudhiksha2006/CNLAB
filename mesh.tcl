set ns [new Simulator]
set nf [open demo.nam w]
$ns namtrace-all $nf

proc finish {} {
     global ns nf
     $ns flush-trace
     close $nf
     exec nam demo.nam &
     exit 0
     }
     
     set n0 [$ns node]
     set n1 [$ns node]
     set n2 [$ns node]
     set n3 [$ns node]
     
     $ns duplex-link $n0 $n1 10Mb 10ms DropTail
     $ns duplex-link $n2 $n1 10Mb 10ms DropTail
     $ns duplex-link $n1 $n3 10Mb 10ms DropTail
     $ns duplex-link $n3 $n0 10Mb 10ms DropTail
     $ns duplex-link $n3 $n2 10Mb 10ms DropTail
     $ns duplex-link $n2 $n0 10Mb 10ms DropTail
     
     
     
     $ns duplex-link-op $n0 $n1 orient right
     $ns duplex-link-op $n2 $n1 orient right-up
     $ns duplex-link-op $n1 $n3 orient down
     $ns duplex-link-op $n3 $n0 orient left-up
     $ns duplex-link-op $n3 $n2 orient left
     $ns duplex-link-op $n2 $n0 orient up
     
     
     
     set tcp [new Agent/TCP]
     $tcp set class_ 2
     $ns attach-agent $n0 $tcp
     
     set sink [new Agent/TCPSink]
     $ns attach-agent $n3 $sink
     
     $ns connect $tcp $sink
     
     set ftp [new Application/FTP]
     $ftp attach-agent $tcp
     
     $ns at 1.0 "$ftp start"
     $ns at 2.0 "$ftp stop"
     $ns at 5.0 "finish"
     
     $ns run
