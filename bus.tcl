set ns [new Simulator]
set nf [open demo.nam w]
$ns namtrace-all $nf

proc finish {} {
     global ns nf
    #$ns flush-trace
     close $nf
     exec nam demo.nam &
     exit 0
     }
     
     set n0 [$ns node]
     set n1 [$ns node]
     set n2 [$ns node]
     set n3 [$ns node]
     
     $ns make-lan "$n0 $n1 $n2 $n3" 10Mb 10ms
     
     
     set tcp [new Agent/TCP]
     $tcp set class_ 2
     $ns attach-agent $n2 $tcp
     
     set sink [new Agent/TCPSink]
     $ns attach-agent $n3 $sink
     
     $ns connect $tcp $sink
     
     set ftp [new Application/FTP]
     $ftp attach-agent $tcp
     
     $ns at 1.0 "$ftp start"
     $ns at 2.0 "$ftp stop"
     $ns at 5.0 "finish"
     
     $ns run
