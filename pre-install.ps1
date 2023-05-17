class Program
{
  [string] $Temp = "obj";
  [string] $Path = "C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE";
  [string[]] $Nugets = @(
    "https://www.nuget.org/api/v2/package/EntityFramework/6.4.4",
    "https://www.nuget.org/api/v2/package/Microsoft.Data.SqlClient/5.1.1"
  );
  [string[]] $Arquivos = @(
    "EntityFramework.SqlServer.dll",
    "EntityFramework.dll",
    "Microsoft.Data.SqlClient.xml",
    "Microsoft.Data.SqlClient.dll",
    "Microsoft.Data.SqlClient.pdb"
  );

  [void] Main()
  {
    $this.Baixar();
    $this.Backup();
    $this.Copiar();
  }

  [void] Baixar()
  {
    $index = 0;

    if (!(Test-Path "$($this.Temp)"))
    {
      New-Item -ItemType Directory -Force -Path "$($this.Temp)";
    }

    foreach ($nuget in $this.Nugets)
    {
      $dest = "$($this.Temp)\$index.nupkg.zip";
      Write-Host "Baixando $nuget";
      Invoke-WebRequest -Uri $nuget -OutFile $dest;
      Expand-Archive $dest -Force -DestinationPath "$($this.Temp)\$index";

      $index++;
    }
  }

  [void] Backup()
  {
    Write-Host "Iniciando Backup";

    foreach ($arquivo in $this.Arquivos)
    {
      $origem = "$($this.Path)\$arquivo";
      $destino = "$($this.Path)\$arquivo.$([DateTimeOffset]::Now.ToUnixTimeSeconds()).bak";

      if (Test-Path $origem)
      {
        Write-Host "Movendo $origem para $destino";
        Move-Item $origem $destino;
      }
    }
  }

  [void] Copiar()
  {
    Write-Host "Iniciando Cópia";

    foreach ($arquivo in $this.Arquivos)
    {
      $destino = "$($this.Path)\$arquivo";

      $origem0 = "$($this.Temp)\0\lib\net45\$arquivo";
      if (Test-Path $origem0)
      {
        Write-Host "Copiando $origem0 para $destino";
        Copy-Item $origem0 $destino;
      }

      $origem1 = "$($this.Temp)\1\lib\net462\$arquivo";
      if (Test-Path $origem1)
      {
        Write-Host "Copiando $origem1 para $destino";
        Copy-Item $origem1 $destino;
      }
    }
  }
}

[Program]::new().Main()
