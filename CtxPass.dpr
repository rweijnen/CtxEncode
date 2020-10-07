program CtxPass;

{$WEAKLINKRTTI ON}
 {$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}


uses
  Windows,
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm};

// We are a Terminal Server aware application ;-)
// http://www.remkoweijnen.nl/blog/2007/11/24/delphi-and-terminal-server-aware/
{$SetPEOptFlags IMAGE_DLLCHARACTERISTICS_TERMINAL_SERVER_AWARE}

{$IFDEF RELEASE}
  // Leave out Relocation Table in Release version
  {$SetPEFlags IMAGE_FILE_RELOCS_STRIPPED}
{$ENDIF RELEASE}

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Citrix Password Hasher';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
