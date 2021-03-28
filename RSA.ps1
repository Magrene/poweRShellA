$stop=$false
$p=2
$q=7
$N=$p*$q
$sqrtQ=[math]::Sqrt($q)
$sqrtP=[math]::Sqrt($p)
$fiN=($p-1)*($q-1)

$eRules = @()
$i=2
#build list of 1 < e < fi(N) List is $eRules
while($stop -eq $false){

    while($i -lt $fiN){
        $eRules+=$i
        $i++
    }
    write-host $eRules
    $stop=$true
}

#factors of p and factors of q
$i=1
$stop=$false
while($stop -eq $false)
{
    
    while($i -lt $sqrtP){
        if(($p % $i) -eq 0){ 
            $Pfactors += $i
            $Pfactors += $p/$i
        }

        $i++
    }
    $i=1
    while($i -lt $sqrtQ){
        
        if(($q % $i) -eq 0){
                    
            $Qfactors += $i
            $Qfactors += $q/$i
        }
            $i++
    }

    $stop=$true
}


#Select an E
$i=1
$cand = @()
$candidate=$eRules[0]
$stop=$false
while($stop -eq $false)
{
    foreach($R in $eRules){
        
        while($i -lt [math]::Sqrt($R)){
            if(($R % $i) -eq 0){ 
                write-host $R % $i
            
                $cand += $i
                $cand += $R/$i
            }
            $i++
        }
        #$boolen=$i.GetType().Name
        #write-host ([math]::Sqrt($R)).getType().name
        
        if( ([math]::Sqrt($R) %1 ) -eq 0){
            $cand += $R
        }
        $i=1
    
    
    

    $stop=$true
}
}
write-host $cand
#Write-Host $cand