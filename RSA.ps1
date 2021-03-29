﻿$stop=$false
[BigInt]$p=101
[BigInt]$q=103
[BigInt]$N=$p*$q
[BigInt]$fiN=($p-1)*($q-1)
[BigInt]$sqrtN=[math]::Sqrt($N)
[BigInt]$sqrtfiN=[math]::Sqrt($fiN)
write-host $N
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
    
    $stop=$true
}

#factors of N and factors of fi(N)
$i=1
$stop=$false
while($stop -eq $false)
{
    
    while($i -le $sqrtN){
        if(($N % $i) -eq 0){ 
            $Nfactors += $i
            $Nfactors += $N/$i
        }
        
        $i++
    }
    $i=1
    while($i -le $sqrtfiN){
        
        if(($fiN % $i) -eq 0){
                    
            $fiNfactors += $i
            $fiNfactors += $fiN/$i
        }
            $i++
    }


    $stop=$true
}


#Select an E and D
$i=1
$cand = @()
$stop=$false


while($stop -eq $false)
{

    foreach($R in $eRules){
        $cand = @()
        $finSharedF = @()
        $NSharedF= @()
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
        
        
        $finSharedF+=(compare-object -IncludeEqual $fiNfactors $cand | where-object {$_.SideIndicator -eq '=='} | foreach{$_.InputObject})
        $NSharedF+=(compare-object -IncludeEqual $fiNfactors $cand | where-object {$_.SideIndicator -eq '=='} | foreach{$_.InputObject})
        
        if($finSharedF.Length -eq 1 -and $NSharedF.Length -eq 1){
            $publickey=$R
            
        }
        $i=1
        
        while($i -lt 10000000000){
            if((($R*$i)%$fiN) -eq 1 -and $i -ne $publickey){
                
                $privatekey=$I
                $i=10000000000
            }
            $i++
        }
        
        
        $stop=$true
}
}
[char]$plain = 'B'
$plainNum=([double]$plain/1)
#write-host ($plainNum/1)

#[bigint]$encrpytednum=(([math]::Pow($plainNum,$publickey)) % $N)
#$decrypted=([math]::Pow($encrpytednum,$privatekey)) % $N

write-host plain $plainNum
$encnum=([System.Numerics.BigInteger]::ModPow($plainNum,$publickey,$n))
$decnum=([System.Numerics.BigInteger]::ModPow($encnum,$privatekey,$n))
#write-host (([math]::Pow($plainNum,$publickey)) % $N)
#write-host (([math]::Pow(72,$privatekey)) % $N)
#write-host $encrpytednum

#write-host $decrypted

write-host PublicKey= $publickey , $N
write-host PrivateKey= $privatekey , $N