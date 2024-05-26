@(echo off% <#%) &color 07 &title Please Wait...
>nul 2>&1 POWERSHELL -nop -c "$w=Add-Type -Name WAPI -PassThru -MemberDefinition '[DllImport(\"user32.dll\")]public static extern void SetProcessDPIAware();[DllImport(\"shcore.dll\")]public static extern void SetProcessDpiAwareness(int value);[DllImport(\"kernel32.dll\")]public static extern IntPtr GetConsoleWindow();[DllImport(\"user32.dll\")]public static extern void GetWindowRect(IntPtr hwnd, int[] rect);[DllImport(\"user32.dll\")]public static extern void GetClientRect(IntPtr hwnd, int[] rect);[DllImport(\"user32.dll\")]public static extern void GetMonitorInfoW(IntPtr hMonitor, int[] lpmi);[DllImport(\"user32.dll\")]public static extern IntPtr MonitorFromWindow(IntPtr hwnd, int dwFlags);[DllImport(\"user32.dll\")]public static extern int SetWindowPos(IntPtr hwnd, IntPtr hwndAfterZ, int x, int y, int w, int h, int flags);';$PROCESS_PER_MONITOR_DPI_AWARE=2;try {$w::SetProcessDpiAwareness($PROCESS_PER_MONITOR_DPI_AWARE)} catch {$w::SetProcessDPIAware()}$hwnd=$w::GetConsoleWindow();$moninf=[int[]]::new(10);$moninf[0]=40;$MONITOR_DEFAULTTONEAREST=2;$w::GetMonitorInfoW($w::MonitorFromWindow($hwnd, $MONITOR_DEFAULTTONEAREST), $moninf);$monwidth=$moninf[7] - $moninf[5];$monheight=$moninf[8] - $moninf[6];$wrect=[int[]]::new(4);$w::GetWindowRect($hwnd, $wrect);$winwidth=$wrect[2] - $wrect[0];$winheight=$wrect[3] - $wrect[1];$x=[int][math]::Round($moninf[5] + $monwidth / 2 - $winwidth / 2);$y=[int][math]::Round($moninf[6] + $monheight / 2 - $winheight / 2);$SWP_NOSIZE=0x0001;$SWP_NOZORDER=0x0004;exit [int]($w::SetWindowPos($hwnd, [IntPtr]::Zero, $x, $y, 0, 0, $SWP_NOSIZE -bOr $SWP_NOZORDER) -eq 0)">nul
chcp 850 >nul &set "0=%~f0" &set 1=%*& powershell -nop -c iex ([io.file]::ReadAllText($env:0)); &exit/b ||#>)[1]; $PS={

## Defaults: RandomizedKeyIncluded,BAT91,LongLines,CompressionOn,OriginalName+~,NoExecAfter

$Main={
$env:1; if (!$env:1) {write-host "`n No input files or folders to encode! use 'Send to' context menu ...`n" -fore Yellow}
$SendTo = [Environment]::GetFolderPath('ApplicationData') + '\Microsoft\Windows\SendTo'
## Save to SendTo menu when run from another location as well as when copy-pasted directly into powershell console
if (!$env:1 -and $env:0 -notlike '*\SendTo\SFXcreator*') {
 $BAT='@(echo off% <#%) &color 07 &title Please Wait...'+"`n"
 $BAT+='>nul 2>&1 POWERSHELL -nop -c "$w=Add-Type -Name WAPI -PassThru -MemberDefinition ''[DllImport(\"user32.dll\")]public static extern void SetProcessDPIAware();[DllImport(\"shcore.dll\")]public static extern void SetProcessDpiAwareness(int value);[DllImport(\"kernel32.dll\")]public static extern IntPtr GetConsoleWindow();[DllImport(\"user32.dll\")]public static extern void GetWindowRect(IntPtr hwnd, int[] rect);[DllImport(\"user32.dll\")]public static extern void GetClientRect(IntPtr hwnd, int[] rect);[DllImport(\"user32.dll\")]public static extern void GetMonitorInfoW(IntPtr hMonitor, int[] lpmi);[DllImport(\"user32.dll\")]public static extern IntPtr MonitorFromWindow(IntPtr hwnd, int dwFlags);[DllImport(\"user32.dll\")]public static extern int SetWindowPos(IntPtr hwnd, IntPtr hwndAfterZ, int x, int y, int w, int h, int flags);'';$PROCESS_PER_MONITOR_DPI_AWARE=2;try {$w::SetProcessDpiAwareness($PROCESS_PER_MONITOR_DPI_AWARE)} catch {$w::SetProcessDPIAware()}$hwnd=$w::GetConsoleWindow();$moninf=[int[]]::new(10);$moninf[0]=40;$MONITOR_DEFAULTTONEAREST=2;$w::GetMonitorInfoW($w::MonitorFromWindow($hwnd, $MONITOR_DEFAULTTONEAREST), $moninf);$monwidth=$moninf[7] - $moninf[5];$monheight=$moninf[8] - $moninf[6];$wrect=[int[]]::new(4);$w::GetWindowRect($hwnd, $wrect);$winwidth=$wrect[2] - $wrect[0];$winheight=$wrect[3] - $wrect[1];$x=[int][math]::Round($moninf[5] + $monwidth / 2 - $winwidth / 2);$y=[int][math]::Round($moninf[6] + $monheight / 2 - $winheight / 2);$SWP_NOSIZE=0x0001;$SWP_NOZORDER=0x0004;exit [int]($w::SetWindowPos($hwnd, [IntPtr]::Zero, $x, $y, 0, 0, $SWP_NOSIZE -bOr $SWP_NOZORDER) -eq 0)">nul'+"`n"
 $BAT+='chcp 850 >nul &set "0=%~f0" &set 1=%*& powershell -nop -c iex ([io.file]::ReadAllText($env:0)); &exit/b ||#>)[1]'
 $BAT+='; $PS={' + $PS + '}; .$PS; .$Main' + "`n#-.-# hybrid script, can be pasted directly into powershell console"
 [IO.File]::WriteAllLines($SendTo + '\SFXcreator.cmd', $BAT -split "`r`n" -split "`n", [Text.Encoding]::ASCII)
}
if (!$env:1) { timeout -1; return }

## Choice text - &x is optional hotkey toggle         # Choice value       # Default:1
  $c  = @()                                           ; $v  = @()          ; $d  = @()
  $c += '&1  Separate keys (Portable and Permanent)  '; $v += 'SplitPass'  ; $d += 0
  $c += '&2  Enable custom TAGs (Default: DATA)      '; $v += 'CustomTAGs' ; $d += 0
  $c += '&3  BAT85 encoder (+1.7% size of BAT91)     '; $v += 'BAT85'      ; $d += 0
  $c += '&4  Short lines (more overall lines)        '; $v += 'ShortLines' ; $d += 0
  $c += '&5  No LZX compression (on tiny/dense files)'; $v += 'NoCompress' ; $d += 0
  $c += '&6  Set Output Filename                     '; $v += 'OutputName' ; $d += 0
  $c += '&7  Run command after decryption            '; $v += 'ExecAfter'  ; $d += 0

## Show Choices dialog snippet - outputs $result with indexes like '1,2,4'
  $all=$c -join ',';$def=(($d -split "`n")|Select-String 1).LineNumber -join ',';$choices=@();$selected=@($false)*($c.length+1)
  $result = Choices $all $def 'OPTIONS:' 12
## Test individual choices presence via ($choices -eq 'value') or ($selected[number])
  if ($result) {$result -split ',' |% {$selected[$_-0] = $true; $choices += $v[$_-1]}}
## Quit if canceled
  if ($result -eq $null) {write-host "`n Canceled `n" -fore Yellow; return} else {$opt=$($choices -join ','); If($opt -eq ''){$opt='Default'}; write-host "Options: $opt`n"}
## Choice 3: BAT85 encoder instead of BAT91 for ~1.7% more size, but will not use web-problematic chars <*`%\>
  $key = '!#$%&()*+,-./0123456789;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~'; $chars = 91
  if ($choices -eq 'BAT85') {
    $key = '.,;{-}[+](/)_|^=?1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!@#$&~'; $chars = 85
  }
  $dict = ($key.ToCharArray()|sort -unique) -join ''; $randomized = 'default'
## Auto Generate Random Key
  $base = $key.ToCharArray(); $rnd = new-object Random; $i = 0; $j = 0; $t = 0
  while ($i -lt $chars) {$t = $base[$i]; $j = $rnd.Next($i, $chars); $base[$i] = $base[$j]; $base[$j] = $t; $i++}
  $key = $base -join ''; $randomized = 'randomized'
## Choice 1: Show InputBox to accept or change the decoding key, and verify it matches the BAT91 or BAT85 $dict
  if ($choices -eq 'SplitPass') {
    Add-Type -As 'Microsoft.VisualBasic'
    $key = [Microsoft.VisualBasic.Interaction]::InputBox("Press enter to accept $randomized key:", 'BAT'+$chars, $key)
    if (!$key -or $key.Trim().Length -ne $chars -or (($key.Trim().ToCharArray()|sort -unique) -join '') -ne $dict) {
      write-host "`nERROR! Key must be $chars chars long with only non-repeating, shuffled:" -fore Yellow; echo "$dict`n"
      timeout -1; return
    }
  }
## Start measuring total processing time
  $timer=new-object Diagnostics.StopWatch; $timer.Start()
## Process command line arguments - supports multiple files and folders
  $arg = ([regex]'"[^"]+"|[^ ]+').Matches($env:1)
## first input item must exist, else something is wrong or script was used via commandline, not SendTo entry
  if (!(test-path -lit $($arg[0].Value.Trim('"')))) {write-host "ERROR! path not found" -fore Yellow; timeout -1; return}
  $val = Get-Item -force -lit ($arg[0].Value.Trim('"'))
  $fn1 = $val.Name.replace('.','_'); $fn2 = $val.Name
## Setup work and output dirs - if source not writable fallback to user Desktop
  $root = Split-Path $val; $rng = [Guid]::NewGuid().Guid
  $dir = $root; $work = join-path $dir $rng; mkdir $work -ea 0 >''; new-item $($work + '~') -item File -ea 0 >''
  if (!(test-path -lit $work)) {$dir = [Environment]::GetFolderPath("Desktop");$work = join-path $dir $rng; mkdir $work -ea 0 >''}
  del $($work + '~') -force -ea 0 >''
## Grab target files names
  $files = @()
  foreach ($a in $arg) {
    $f = gi -force -lit $a.Value.Trim('"')
    if ($f.PSTypeNames -match 'FileInfo') {$files += $f} else {dir -lit $f -rec -force |? {!$_.PSIsContainer} |% {$files += $_}}
  }
## Choice 2: Set custom TAGs
  if ($choices -eq 'CustomTAGs') {
  Add-Type -As 'Microsoft.VisualBasic'
  $tag = [Microsoft.VisualBasic.Interaction]::InputBox("Press enter to use default TAG:", 'Enter a TAG', 'DATA')
  }
  if ($tag -eq ''){$tag=$null}
  if ($tag -eq $null){$tag='DATA'}
## Choice 6: Set Output Filename
  if ($choices -eq 'OutputName') {
    Add-Type -As 'Microsoft.VisualBasic'
    $altoutput = [Microsoft.VisualBasic.Interaction]::InputBox("Enter output filename:", 'Set Filename',"$fn1~.cmd")
  }
  if ($altoutput -eq '') {$altoutput=$null}
## Jump to work dir
  push-location -lit $work
## Improved MakeCab ddf generator to handle localized and special characters file names better
  $ddf1 = @"
.new Cabinet`r`n.Set Cabinet=ON`r`n.Set CabinetFileCountThreshold=0`r`n.Set ChecksumWidth=1`r`n.Set ClusterSize=CDROM
.Set LongSourceFileNames=ON`r`n.Set CompressionType=LZX`r`n.Set CompressionLevel=7`r`n.Set CompressionMemory=21
.Set DiskDirectoryTemplate=`r`n.Set FolderFileCountThreshold=0`r`n.Set FolderSizeThreshold=0`r`n.Set GenerateInf=ON
.Set InfFileName=nul`r`n.Set MaxCabinetSize=0`r`n.Set MaxDiskFileCount=0`r`n.Set MaxDiskSize=0`r`n.Set MaxErrors=0
.Set ReservePerCabinetSize=0`r`n.Set ReservePerDataBlockSize=0`r`n.Set ReservePerFolderSize=0`r`n.Set RptFileName=nul
.Set UniqueFiles=ON`r`n.Set SourceDir=.`r`n
"@
## MakeCab tool has issues with source filenames so just rename them while keeping destination full; skip inaccesible files
  [int]$renamed = 100; $rel = $root.Length + 1; if ($rel -eq 4) {$rel--}
  foreach ($f in $files){
    try{ copy -lit $f.FullName -dest "$work\$renamed" -force -ea 0 >''}catch{}
    if (test-path -lit "$work\$renamed") {$ddf1 += $("$renamed `""+$f.FullName.substring($rel)+"`"`r`n")}
    $renamed++
  }
  [IO.File]::WriteAllText("$work\1.ddf", $ddf1, [Text.Encoding]::UTF8)
## Choice 5: No LZX compression (full size)
  if ($choices -eq 'NoCompress') {$comp = 'OFF'} else {$comp = 'ON'}
## Run MakeCab to either just store the files without compression or use LZX
  makecab.exe /F 1.ddf /D Compress=$comp /D CabinetNameTemplate=1.cab
## Choice 7: Execute command after decoding
  if ($choices -eq 'ExecAfter') {
    Add-Type -As 'Microsoft.VisualBasic'
    $execafter=[Microsoft.VisualBasic.Interaction]::InputBox("*Command to execute after extraction*", 'Command: ',"$fn2")
    If ($execafter -eq ''){$execafter=$null}
  }
## Generate text decoding header - compact self-expanding batch file for bundled ascii encoded cab archive of target files
  $HEADER  = "@ECHO OFF&PUSHD `"%~dp0`"&MODE 35,3&ECHO.&ECHO  Please Wait...`r`n"
  $HEADER +='>nul 2>&1 POWERSHELL -nop -c "$w=Add-Type -Name WAPI -PassThru -MemberDefinition ''[DllImport(\"user32.dll\")]public static extern void SetProcessDPIAware();[DllImport(\"shcore.dll\")]public static extern void SetProcessDpiAwareness(int value);[DllImport(\"kernel32.dll\")]public static extern IntPtr GetConsoleWindow();[DllImport(\"user32.dll\")]public static extern void GetWindowRect(IntPtr hwnd, int[] rect);[DllImport(\"user32.dll\")]public static extern void GetClientRect(IntPtr hwnd, int[] rect);[DllImport(\"user32.dll\")]public static extern void GetMonitorInfoW(IntPtr hMonitor, int[] lpmi);[DllImport(\"user32.dll\")]public static extern IntPtr MonitorFromWindow(IntPtr hwnd, int dwFlags);[DllImport(\"user32.dll\")]public static extern int SetWindowPos(IntPtr hwnd, IntPtr hwndAfterZ, int x, int y, int w, int h, int flags);'';$PROCESS_PER_MONITOR_DPI_AWARE=2;try {$w::SetProcessDpiAwareness($PROCESS_PER_MONITOR_DPI_AWARE)} catch {$w::SetProcessDPIAware()}$hwnd=$w::GetConsoleWindow();$moninf=[int[]]::new(10);$moninf[0]=40;$MONITOR_DEFAULTTONEAREST=2;$w::GetMonitorInfoW($w::MonitorFromWindow($hwnd, $MONITOR_DEFAULTTONEAREST), $moninf);$monwidth=$moninf[7] - $moninf[5];$monheight=$moninf[8] - $moninf[6];$wrect=[int[]]::new(4);$w::GetWindowRect($hwnd, $wrect);$winwidth=$wrect[2] - $wrect[0];$winheight=$wrect[3] - $wrect[1];$x=[int][math]::Round($moninf[5] + $monwidth / 2 - $winwidth / 2);$y=[int][math]::Round($moninf[6] + $monheight / 2 - $winheight / 2);$SWP_NOSIZE=0x0001;$SWP_NOZORDER=0x0004;exit [int]($w::SetWindowPos($hwnd, [IntPtr]::Zero, $x, $y, 0, 0, $SWP_NOSIZE -bOr $SWP_NOZORDER) -eq 0)">nul'+"`r`n"
  if ($choices -eq 'SplitPass') {
  $HEADER += '@CLS&ECHO.&ECHO  Extracting Files...&SET "0=%~f0"&POWERSHELL -nop -c $f=[IO.File]::ReadAllText($env:0)-split'':'+$tag+'\:.*'';If((Get-ItemProperty Registry::HKLM\Software\Microsoft\Cryptography\Realtime).PSObject.Properties.Name -contains ''%~n0'') {$k=Get-ItemPropertyValue -Path Registry::HKLM\SOFTWARE\Microsoft\Cryptography\Realtime -Name ''%~n0''} Else {If([System.IO.File]::Exists(''%~dpn0.key'')){$k=GC ''%~dpn0.key'' -raw}};iex($f[1]); X(1)>nul'
  } else {
  $HEADER += '@CLS&ECHO.&ECHO  Extracting Files...&SET "0=%~f0"&POWERSHELL -nop -c $f=[IO.File]::ReadAllText($env:0)-split'':'+$tag+'\:.*'';iex($f[1]); X(1)>nul'
  }
  if ($execafter -eq $null) {
    $HEADER += "&GOTO :EOF`r`n`r`n:"+$tag+":`r`n"
  } else {
    $HEADER += "&START `"`" `"$execafter`"&GOTO :EOF`r`n`r`n:"+$tag+":`r`n"
  }
## Choice 4: Long lines (less overhead) - each line has 4 extra chars (cr lf ::) and short lines are ~8 times as many
  if ($choices -eq 'ShortLines') {$line = 128} else {$line = 1016}
## Choice 1: Split encoding key into separate file - or bundle it with the file for automatic extraction
  if ($choices -eq 'SplitPass') {
    $HEADER += '$b=''Microsoft.VisualBasic'';Add-Type -As $b;If(!$k){$k=iex "[$b.Interaction]::InputBox('''',''Enter Decryption Key'','''')"};'
    $HEADER += 'if($k.Length-ne'+$chars+'){exit};Add-Type -Ty @' + "'`r`n"
  } else {
    $HEADER += '$k='''+$key+"'; Add-Type -Ty @'`r`n"
  }
## Generate text decoding C# snippet depending on Choice 3: BAT85 encoder instead of BAT91 (now default)
  if ($choices -eq 'BAT85') {
    $HEADER += @'
using System.IO; public class BAT85 {public static void Dec (ref string[] f, int x, string fo, string key) { unchecked {
byte[] b85=new byte[256];long n=0;int p=0,q=0,c=255,z=f[x].Length; while (c>0) b85[c--]=85; while (c<85) b85[key[c]]=(byte)c++;
int[] p85={52200625,614125,7225,85,1}; using (FileStream o=new FileStream(fo,FileMode.Create)) { for (int i=0;i != z;i++) {
c=b85[f[x][i]]; if (c==85) continue; n += c * p85[p++]; if (p==5) {p=0; q=4; while (q > 0) {q--; o.WriteByte((byte)(n>>8*q));}
n=0;}} if (p>0) {for (int i=0;i<5-p;i++) {n += 84 * p85[p+i];} q=4; while (q>(5-p)) {o.WriteByte((byte)(n>>8*(--q)));} } } }}}
'@ + "`r`n'@; " + 'cd -Lit($env:__CD__); function X([int]$x=1){[BAT85]::Dec([ref]$f,$x+1,$x,$k); ' 
  } else {
    $HEADER += @'
using System.IO;public class BAT91{public static void Dec(ref string[] f,int x,string fo,string key){unchecked{int n=0,c=255,q=0
,v=91,z=f[x].Length; byte[]b91=new byte[256]; while(c>0) b91[c--]=91; while(c<91) b91[key[c]]=(byte)c++; using (FileStream o=new
FileStream(fo,FileMode.Create)){for(int i=0;i!=z;i++){c=b91[f[x][i]]; if(c==91)continue; if(v==91){v=c;}else{v+=c*91;q|=v<<n;if(
(v&8191)>88){n+=13;}else{n+=14;}v=91;do{o.WriteByte((byte)q);q>>=8;n-=8;}while(n>7);}}if(v!=91)o.WriteByte((byte)(q|v<<n));} }}}
'@ + "`r`n'@; " + 'cd -Lit($env:__CD__); function X([int]$x=1){[BAT91]::Dec([ref]$f,$x+1,$x,$k); '
  }
## Generate expand function
  $HEADER += "expand -R `$x -F:* .; del `$x -force}`r`n`r`n:"+$tag+":[ >`r`n"
## BAT91 or BAT85 ascii encoding the cab archive of target files
  if ($altoutput -eq $null) {
    $output = $dir + "\$fn1~.cmd";
    $portablekey = $dir + "\$fn1~.key"
  } else {
    $output = $dir + "\$altoutput"
    $altkey = $altoutput -replace ("(\..+)$", '.key')
    If($altoutput -eq $altkey){$altkey=$altkey+'.key'}
    $portablekey = $dir + "\$altkey"
  }
  [IO.File]::WriteAllText($output, $HEADER)
  write-host "`nBAT$chars encoding $output ... " -nonew
  $enctimer=new-object Diagnostics.StopWatch; $enctimer.Start()
  if ($choices -eq 'BAT85') {
    [BAT85]::Enc("$work\1.cab", $output, $key, $line)
  } else {
    [BAT91]::Enc("$work\1.cab", $output, $key, $line)
  }
  $enctimer.Stop()
  write-host "$([math]::Round($enctimer.Elapsed.TotalSeconds,4)) sec"
  [IO.File]::AppendAllText($output, "`r`n:"+$tag+":]`r`n")
## Choice 1: Save decoding key externally
  if ($choices -eq 'SplitPass') {
    [IO.File]::WriteAllText($portablekey, $key)
    $pname = ([System.Io.Path]::GetFileNameWithoutExtension($portablekey))
    $permanentkey = $dir + "\$pname" + '.reg'
    $rkey=$key.Replace('\','\\')
    [IO.File]::WriteAllText($permanentkey, "Windows Registry Editor Version 5.00`r`n`r`n[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Cryptography\Realtime]`r`n`"$pname`"=`"$rkey`"")
    write-host "`nPortable decoding key saved separately to $portablekey" -fore Yellow;
    write-host "Permanent decoding key saved separately to $permanentkey" -fore Red;
    write-host "`n**NOTE** Encoded file name can not be changed if permanent key is used.`n`nKey: $key`n";
  } else {del $portablekey -force -ea 0 >''}
## Done - cleanup $work dir and write timer
  push-location -lit $root; if (test-path -lit $work) {start -nonew -file cmd -args "/d/x/c rmdir /s/q ""$work"">nul 2>nul"}
  $timer.Stop()
  write-host "`nDone in $([math]::Round($timer.Elapsed.TotalSeconds,4)) sec" -fore Cyan
  timeout -1; return
} ## .$Main
## Text encoding snippet via C# (native powershell is unbearable slow for large files)
Add-Type -Ty @'
using System.IO;
public class BAT85 {
  public static void Enc(string fi, string fo, string key, int line) {
    byte[] a = File.ReadAllBytes(fi), b85=new byte[85], q = new byte[5]; long n = 0; int p = 0,c = 0,v = 0,l = 0,z = a.Length;
    unchecked {
      while (c<85) {b85[c] = (byte)key[c++];}
      using (FileStream o = new FileStream(fo, FileMode.Append)) {
        o.WriteByte(58); o.WriteByte(58);
        for (int i = 0; i != z; i++) {
          c = a[i];
          if (p == 3) {
            n |= (byte)c; v = 5; while (v > 0) {v--; q[v] = b85[(byte)(n % 85)]; n /= 85;}
            o.Write(q, 0, 5); n = 0; p = 0; l += 5;
            if (l > line) {l = 0; o.WriteByte(13); o.WriteByte(10); o.WriteByte(58); o.WriteByte(58);}
          } else {
            n |= (uint)(c << (24 - (p * 8))); p++;
          }
        }
        if (p > 0) {
          for (int i=p;i<3-p;i++) {n |= (uint)(0 << (24 - (p * 8)));}
          n |= 0; v = 5; while (v > 0) {v--; q[v] = b85[(byte)(n % 85)]; n /= 85;} o.Write(q, 0, p + 1);
        }
      }
    }
  }
}
public class BAT91 {
  public static void Enc(string fi, string fo, string key, int line) {
    byte[] a = File.ReadAllBytes(fi), b91 = new byte[91]; int n = 0, c = 0, v = 0, q = 0, l = 0, z = a.Length;
    while (c<91) {b91[c] = (byte)key[c++];}
    using (FileStream o = new FileStream(fo, FileMode.Append)) {
      o.WriteByte(58); o.WriteByte(58);
      for (int i = 0; i != z; i++) {
        q |= (byte)a[i] << n; n += 8;
        if (n > 13) {
          v = q & 8191; if (v > 88) {q >>= 13; n -= 13;} else {v = q & 16383; q >>= 14; n -= 14;}
          o.WriteByte(b91[v % 91]); o.WriteByte(b91[v / 91]);
          l += 2; if (l > line) {l = 0; o.WriteByte(13); o.WriteByte(10); o.WriteByte(58); o.WriteByte(58);}
        }
      }
      if (n > 0) {o.WriteByte(b91[q % 91]); if (n > 7 || q > 90) {o.WriteByte(b91[q / 91]);}}
    }
  }
}
'@
## Choices dialog snippet - parameters: 1=allchoices, 2=default; [optional] 3=title, 4=textsize, 5=backcolor, 6=textcolor
function Choices($all, $def, $n='Choices', [byte]$sz=12, $bc='DarkGray', $fc='Snow', $saved='HKCU:\Environment') {
 [void][Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms'); $f=new-object Windows.Forms.Form
 $a=$all.split(','); $s=$def.split(','); $reg=(gp $saved -ea 0).$n; if($reg.length) {$s=$reg.Trim().split(',')}
 function rst(){ $cb | %{ $_.Checked=0; if($s -contains $_.Name){ $_.Checked=1 } } }; $f.Add_Shown({rst; $f.Activate()})
 $cb=@(); $i=1; $a | %{ $c=new-object Windows.Forms.CheckBox; $cb+=$c; $c.Text=$_; $c.AutoSize=1;
 $c.Margin='8,4,8,4'; $c.Location='64,'+($sz*3*$i-$sz); $c.Font='Tahoma,'+$sz; $c.Name=$i; $f.Controls.Add($c); $i++}
 $bt=@(); $j=1; @('OK','Reset','Cancel') | %{ $b=new-object Windows.Forms.Button; $bt+=$b; $b.Text=$_; $b.AutoSize=1;
 $b.Margin='0,0,72,20'; $b.Location=''+(64*$j)+','+(($sz+1)*3*$i-$sz); $b.Font='Tahoma,'+$sz; $f.Controls.Add($b); $j+=2 }
 $v=@(); $f.AcceptButton=$bt[0]; $f.CancelButton=$bt[2]; $bt[0].DialogResult=1; $bt[1].add_Click({$s=$def.split(',');rst});
 $f.Text=$n; $f.BackColor=$bc; $f.ForeColor=$fc; $f.StartPosition=4; $f.AutoSize=1; $f.AutoSizeMode=0; $f.FormBorderStyle=3;
 $f.MaximizeBox=0; $r=$f.ShowDialog(); if($r -eq 1){$cb | %{if($_.Checked){$v+=$_.Name}}; $val=$v -join ','
 if($r -eq 0){return $null} $null=New-ItemProperty -Path $saved -Name $n -Value $val -Force; return $val } }
## Let's Make Console Scripts Friendlier Initiative by AveYo - MIT License -       Choices '&one, two, th&ree' '2,3' 'Usage'

}; .$PS; .$Main
#-.-# hybrid script, can be pasted directly into powershell console