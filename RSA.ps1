$stop=$false
$p=2
$q=7
$N=$p*$q
$fiN=($p-1)*($q-1)
$sqrtN=[math]::Sqrt($N)
$sqrtfiN=[math]::Sqrt($fiN)

$Nfactors = @()
$fiNfactors = @()
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
        if(($N % $i) -eq 0){ 
            $sqrtN += $i
            $sqrtN += $N/$i
        }
        
        $i++
    }
    $i=1
    while($i -le $sqrtQ){
        
        if(($fiN % $i) -eq 0){
                    
            $fiNfactors += $i
            $fiNfactors += $fiN/$i
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
        $output+=(compare-object -IncludeEqual $fiNfactors $cand | where-object {$_.SideIndicator -eq '=='} | foreach{$_.InputObject})
        
        if($output.Length -eq 1){
            write-host $cand
        }
        $i=1
    
    
    

    $stop=$true
}
}
write-host $cand
#Write-Host $cand