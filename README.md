# EF6

Estudo elaborado para a utilização do `Entity Framework 6` com EDMX usando o `dotnetcore`.

## Funcionalidades requeridas

- [x] HierarchyId
- [x] Spatial
- [x] EDMX
- [x] T4

## Pré-requisitos

- [x] Visual Studio 2022

## Pre-instalação

- [x] Executar o pre-install.ps1

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString(' https://raw.githubusercontent.com/wzuqui/EF6/main/pre-install.ps1'))
```

## Referências

[Entity Framework 6 SQL Server provider based on Microsoft.Data.SqlClient](https://github.com/dotnet/ef6/blob/cce74783c0be193d17273b247d6dc53f987ce279/src/Microsoft.EntityFramework.SqlServer/readme.md?plain=1#L1)
