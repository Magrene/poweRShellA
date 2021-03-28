$stop=$false
$p=2
$q=7
$N=$p*$q
$sqrtQ=[math]::Sqrt($q)
$sqrtP=[math]::Sqrt($p)
$fiN=($p-1)*($q-1)
$Pfactors = @()
$Qfactors = @()
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

#factors of N and factors of fi(N)
$i=1
$stop=$false
while($stop -eq $false)
{
    
    while($i -le $sqrtP){
        if(($p % $i) -eq 0){ 
            $Pfactors += $i
            $Pfactors += $p/$i
        }
        
        $i++
    }
    $i=1
    while($i -le $sqrtQ){
        
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
        $cand = @()
        $output = @()
        while($i -lt [math]::Sqrt($R)){
            if(($R % $i) -eq 0){ 
                
            
                $cand += $i
                $cand += $R/$i
            }
            $i++
        }

        if( ( [math]::Sqrt($R) % 1 ) -eq 0){
            $cand += $i
        }
        $output+=(compare-object -IncludeEqual $Qfactors $cand | where-object {$_.SideIndicator -eq '=='} | foreach{$_.InputObject})
        
        if($output.Length -eq 1){
            write-host $cand
        }
        $i=1
    
    
    

    $stop=$true
}
}
write-host $cand
#Write-Host $cand