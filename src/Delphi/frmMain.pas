unit frmMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, IPPeerClient,
  REST.Client, Data.Bind.Components, Data.Bind.ObjectScope,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Ani;

type
  TForm2 = class(TForm)
    Button1: TButton;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    Label1: TLabel;
    Label2: TLabel;
    AniIndicator1: TAniIndicator;
    RoundRect1: TRoundRect;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    RoundRect2: TRoundRect;
    Label8: TLabel;
    RoundRect3: TRoundRect;
    Label9: TLabel;
    RoundRect4: TRoundRect;
    StyleBook1: TStyleBook;
    FloatAnimation1: TFloatAnimation;
    FloatAnimation2: TFloatAnimation;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses
  System.JSON;

{$R *.fmx}
{$R *.LgXhdpiPh.fmx ANDROID}
{$R *.LgXhdpiTb.fmx ANDROID}

procedure TForm2.Button1Click(Sender: TObject);
var
  jValue:TJSONValue;
begin
  AniIndicator1.Visible := true;
  AniIndicator1.Enabled := true;
  RESTRequest1.Resource := 'status/picontroller';
  RESTRequest1.Execute;
  jValue:=RESTResponse1.JSONValue;
  if jValue.ToString.Contains('alive') then
  begin
    Label2.Text := 'Alive';
    RoundRect1.Fill.Color := 4286578432;
    Application.ProcessMessages;
  end
  else
  begin
    Label2.Text := 'Dead';
    RoundRect1.Fill.Color := 4292613180;
  end;

  RESTRequest1.Resource := 'status/pi01';
  RESTRequest1.Execute;
  jValue:=RESTResponse1.JSONValue;
  if jValue.ToString.Contains('alive') then
  begin
    Label7.Text := 'Alive';
    RoundRect2.Fill.Color := 4286578432;
  end
  else
  begin
    Label7.Text := 'Dead';
    RoundRect2.Fill.Color := 4292613180;
  end;

  RESTRequest1.Resource := 'status/pi02';
  RESTRequest1.Execute;
  jValue:=RESTResponse1.JSONValue;
  if jValue.ToString.Contains('alive') then
  begin
    Label8.Text := 'Alive';
    RoundRect3.Fill.Color := 4286578432;
  end
  else
  begin
    Label8.Text := 'Dead';
    RoundRect3.Fill.Color := 4292613180;
  end;

  RESTRequest1.Resource := 'status/pi03';
  RESTRequest1.Execute;
  jValue:=RESTResponse1.JSONValue;
  if jValue.ToString.Contains('alive') then
  begin
    Label9.Text := 'Alive';
    RoundRect4.Fill.Color := 4286578432;
  end
  else
  begin
    Label9.Text := 'Dead';
    RoundRect4.Fill.Color := 4292613180;
  end;

  AniIndicator1.Enabled := false;
  AniIndicator1.Visible := false;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  RoundRect1.Fill.Color := 4292613180;
  RoundRect1.Fill.Kind := TBrushKind.Solid;
  RoundRect2.Fill.Color := 4292613180;
  RoundRect2.Fill.Kind := TBrushKind.Solid;
  RoundRect3.Fill.Color := 4292613180;
  RoundRect3.Fill.Kind := TBrushKind.Solid;
  RoundRect4.Fill.Color := 4292613180;
  RoundRect4.Fill.Kind := TBrushKind.Solid;
end;

end.
