#pragma checksum "C:\Users\jdoll\OneDrive\CSE 385\Scripts\Week 12\CSE385_A_CORE\Views\Home\Index.cshtml" "{ff1816ec-aa5e-4d10-87f7-6f4963833460}" "42af8e173047e3c02979d1d5444957397dac1641"
// <auto-generated/>
#pragma warning disable 1591
[assembly: global::Microsoft.AspNetCore.Razor.Hosting.RazorCompiledItemAttribute(typeof(AspNetCore.Views_Home_Index), @"mvc.1.0.view", @"/Views/Home/Index.cshtml")]
namespace AspNetCore
{
    #line hidden
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Threading.Tasks;
    using Microsoft.AspNetCore.Mvc;
    using Microsoft.AspNetCore.Mvc.Rendering;
    using Microsoft.AspNetCore.Mvc.ViewFeatures;
#nullable restore
#line 1 "C:\Users\jdoll\OneDrive\CSE 385\Scripts\Week 12\CSE385_A_CORE\Views\_ViewImports.cshtml"
using CSE385_A_CORE;

#line default
#line hidden
#nullable disable
#nullable restore
#line 2 "C:\Users\jdoll\OneDrive\CSE 385\Scripts\Week 12\CSE385_A_CORE\Views\_ViewImports.cshtml"
using CSE385_A_CORE.Models;

#line default
#line hidden
#nullable disable
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"SHA1", @"42af8e173047e3c02979d1d5444957397dac1641", @"/Views/Home/Index.cshtml")]
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"SHA1", @"9d96775c878069a5408fd17b5b535338f45f80ea", @"/Views/_ViewImports.cshtml")]
    public class Views_Home_Index : global::Microsoft.AspNetCore.Mvc.Razor.RazorPage<dynamic>
    {
        #pragma warning disable 1998
        public async override global::System.Threading.Tasks.Task ExecuteAsync()
        {
#nullable restore
#line 1 "C:\Users\jdoll\OneDrive\CSE 385\Scripts\Week 12\CSE385_A_CORE\Views\Home\Index.cshtml"
  
    ViewData["Title"] = "Home Page";

#line default
#line hidden
#nullable disable
            WriteLiteral(@"
<div class=""text-center"">
    <h1 class=""display-4"">Welcome</h1>

    <div style=""width:100%;"">
        <table class=""table table-striped table-bordered table-lg"">
            <thead>
                <tr><th>Random People</th></tr>
                <tr>
                    <td style=""vertical-align:middle;"">
                        <input type=""button"" id=""btnSearch"" value=""Get data"" class=""btn btn-primary"" />
                    </td>
                </tr>
            </thead>
            <tbody id=""tblBody"">
            </tbody>

        </table>
    </div>

</div>

<script type=""text/javascript"">
    $(document).ready(function () {
        var body = $('#tblBody');

        var card =
            '<div class=""card"" style=""width: 10rem; float:left; margin:8px;"">' +
            '<center><img class=""card-img-top"" style=""width:100px; height:100px;border:1px solid rgba(0,0,0,.125);border-radius:.25rem;margin-top:4px;"" src = ""<src>"" alt = ""Some Random Guy""></center>' +
            '<");
            WriteLiteral(@"div class=""card-body""><h5 class=""card-title""><fname></h5><p class=""card-text""><lname></p>' +
            '<a href=""#"" class=""btn btn-primary"">View Details</a></div></div>'
        //===================================================================================================
        // Get a list of customers from the database using an API
        //===================================================================================================
        $('#btnSearch').click(function () {
            body.empty();

            ajax('getEmployees', {}, function (data) {
                console.log(data);
                body.append('<tr><td>');
                $.each(data, function (index, val) {
                    body.append(
                        card.replace('<fname>', val.firstName)
                            .replace('<lname>', val.lastName)
                            .replace('<src>', val.avatar)
                    );
                });
                body.append('</td>");
            WriteLiteral(@"</tr>');
            });
        });
        //===================================================================================================
        // Generic method for AJAX calls
        //===================================================================================================
        var url = 'https://localhost:44360/ws/';
        function ajax(method, data, fn) {
            $.ajax({
                url: url + method,
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                type: ""GET"",
                dataType: ""json"",
                data: data,
                success: fn,
                error: function () {
                    console.log(""error"");
                }
            });
        }
    });</script>
");
        }
        #pragma warning restore 1998
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.ViewFeatures.IModelExpressionProvider ModelExpressionProvider { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.IUrlHelper Url { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.IViewComponentHelper Component { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.Rendering.IJsonHelper Json { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.Rendering.IHtmlHelper<dynamic> Html { get; private set; }
    }
}
#pragma warning restore 1591
