unit MainUnit;

{$WEAKLINKRTTI ON}
 {$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms,
  StdCtrls, ShellApi, ExtCtrls, ComCtrls;

type
  TMainForm = class(TForm)
    PasswordEdit: TLabeledEdit;
    EncodeButton: TButton;
    HashEdit: TLabeledEdit;
    DecodeButton: TButton;
    URLLabel: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    procedure DecodeButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure URLLabelClick(Sender: TObject);
    procedure EncodeButtonClick(Sender: TObject);
    procedure PasswordEditKeyPress(Sender: TObject; var Key: Char);
    procedure HashEditKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation
{$R *.dfm}
const
  Ctx1: Byte = $a5;
  Ctx2: Byte = $f;
  Ctx3: Byte = $41;

function Ctx1Encode(const ClearTextPassword: String): String;
var
  PwdBytes: array of Byte;
  Buffer: array of Byte;
  Buffer2: array of Byte;
  s: AnsiString;
  i: Integer;
begin
  Result := '';
  if Length(ClearTextPassword) = 0 then
    Exit;

  SetLength(PwdBytes, Length(ClearTextPassword) * SizeOf(Char));
  CopyMemory(@PwdBytes[0], @ClearTextPassword[1], Length(PwdBytes));

  SetLength(Buffer, Length(PwdBytes));
  Buffer[0] := PwdBytes[0] xor Ctx1;

  for i := 1 to Length(PwdBytes) - 1 do
  begin
    Assert(i-1 >= 0);
    Buffer[i] := byte((PwdBytes[i] xor (Buffer[i-1] xor Ctx1)))
  end;

  SetLength(Buffer2, Length(Buffer) * 2);

  for i := 0 to Length(Buffer) - 1 do
  begin
    Assert(i*2 + 1 <= Length(Buffer2));
    Buffer2[i * 2] := Byte((((Buffer[i] shr 4) and Ctx2) + Ctx3));
    Buffer2[i * 2 + 1] := Byte(((Buffer[i] and Ctx2) + Ctx3));
  end;

  SetLength(s, Length(Buffer2) + 1);
  CopyMemory(@s[1], @Buffer2[0], Length(Buffer2));
  Result := String(s);
end;

function Ctx1Decode(const Password: String): String;
var
  PwdBytes: array of Byte;
  Buffer: array of Byte;
  Buffer2: array of Byte;
  i: Integer;
begin
  Result := '';
  if Length(Password) < 4 then
    Exit;

  SetLength(PwdBytes, Length(Password));
  CopyMemory(@PwdBytes[0], @AnsiString(Password)[1], Length(PwdBytes));

  SetLength(Buffer, Length(Password) div 2);
  i := 0;
  while i < Length(PwdBytes) do
  begin
    Assert(i div 2 <= Length(Buffer));
    Assert(i+1 <= Length(PwdBytes));
    Buffer[i div 2] := Byte( ((PwdBytes[i] - Ctx3) shl 4) + (PwdBytes[i + 1] - Ctx3) );
    Inc(i, 2);
  end;

  // Make Buffer 2 1 longer so we can add a terminating #0
  SetLength(Buffer2, Length(Buffer) + 1);
  for i := Length(Buffer) - 1 downto 0 do
  begin
    Assert(i <= Length(Buffer2));
    Buffer2[i] := Byte((Buffer[i] xor (Buffer[i - 1] xor Ctx1)));
  end;
  Buffer2[0] := Byte((Buffer[0] xor Ctx1));

  // Add Terminating #0 so we cast it to PChar..
  Buffer2[Length(Buffer2)] := 0;
  Result := PChar(@Buffer2[0]);
end;


procedure TMainForm.EncodeButtonClick(Sender: TObject);
begin
  HashEdit.Text := Ctx1Encode(PasswordEdit.Text);
  Label1.Caption := Format('%.2d', [Length(HashEdit.Text)]);
  Label2.Caption := Format('%.2d', [Length(PasswordEdit.Text)]);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
{$IFDEF DEBUG}
  ReportMemoryLeaksOnShutDown := DebugHook <> 0;
{$ENDIF}
  Constraints.MinHeight := Height;
  Constraints.MinWidth := Width div 2;
  Constraints.MaxHeight := Height;
end;

procedure TMainForm.HashEditKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    DeCodeButton.Click;
end;

procedure TMainForm.PasswordEditKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    EncodeButton.Click;
end;

procedure TMainForm.URLLabelClick(Sender: TObject);
begin
  ShellExecute(0, 'open', PChar(URLLabel.Hint), nil, nil, SW_NORMAL);
end;

procedure TMainForm.DecodeButtonClick(Sender: TObject);
begin
  PasswordEdit.Text := Ctx1Decode(HashEdit.Text);
  Label1.Caption := Format('%.2d', [Length(HashEdit.Text)]);
  Label2.Caption := Format('%.2d', [Length(PasswordEdit.Text)]);
end;

end.
