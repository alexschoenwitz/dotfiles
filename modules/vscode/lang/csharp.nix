{ pkgs, ... }:
{
  extensions = with pkgs.vscode-extensions; [
    ms-dotnettools.csharp
    ms-dotnettools.csdevkit
    ms-dotnettools.vscode-dotnet-runtime
  ];
  settings = {
    "[csharp]"."editor.defaultFormatter" = "ms-dotnettools.csharp";
    "csharp.suppressHiddenDiagnostics" = false;
    "dotnet.backgroundAnalysis.analyzerDiagnosticsScope" = "fullSolution";
    "dotnet.backgroundAnalysis.compilerDiagnosticsScope" = "fullSolution";
    "debug.allowBreakpointsEverywhere" = true;
  };
}
