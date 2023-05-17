using System;
using System.Data.Entity;
using System.Linq;
using Infra.Contexts;
using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.Configuration;

var xBuilder = WebApplication.CreateBuilder();
{
    SqlServerTypes.Utilities.LoadNativeAssemblies(AppDomain.CurrentDomain.BaseDirectory);
    ApplicationContext.ConnectionString = xBuilder.Configuration.GetConnectionString("DefaultConnection");
}

var xApp = xBuilder.Build();
{
    using var xContext = new ApplicationContext();
    var xItens = xContext.HierarquiasOrganizacionais
        .Include(p => p.Unidades)
        .ToList();

    xItens.ForEach(p =>
    {
        Console.WriteLine($"Id={p.Id}" +
                          $", Nome=`{p.Nome}`" +
                          $", Geolocalizacao=`{p.Geolocalizacao}`" +
                          $", HierarquiaId=`{p.HierarquiaId}`");

        foreach (var xUnidade in p.Unidades)
        {
            Console.WriteLine($"\tId={xUnidade.Id}" +
                              $", Nome=`{xUnidade.Nome}`" +
                              $", HierarquiaId=`{xUnidade.HierarquiaId}`");
        }
    });
}
xApp.RunAsync();