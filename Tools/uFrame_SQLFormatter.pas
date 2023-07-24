unit uFrame_SQLFormatter;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Graphics,
  FMX.Controls,
  FMX.Forms,
  FMX.Dialogs,
  FMX.StdCtrls,
  FMX.Memo.Types,
  FMX.ListBox,
  FMX.Platform,
  FMX.Objects,
  FMX.ScrollBox,
  FMX.Memo,
  FMX.Controls.Presentation,
  FMX.Layouts,
<<<<<<< HEAD
  Roselt.CodeFormatting,
=======

  Roselt.CodeFormatting,

>>>>>>> 53af526825e1211c7a56f7bad6746d4fce3f4c60
  Skia,
  Skia.FMX, FMX.Edit;

type
  TFrame_SQLFormatter = class(TFrame)
    layTop: TLayout;
    lblConfiguration: TLabel;
    layIndentation: TRectangle;
    cbIndentation: TComboBox;
    layIndentationTitleDescription: TLayout;
    lblIndentationTitle: TLabel;
    lblIndentationDescription: TLabel;
    imgIndentation: TSkSvg;
    layBottom: TLayout;
    layInput: TLayout;
    memTitleInput: TLabel;
    btnInputPasteFromClipboard: TButton;
    imgInputPasteFromClipboard: TSkSvg;
    lblInputPasteFromClipboard: TLabel;
    btnInputCopyToClipboard: TButton;
    imgInputCopyToClipboard: TSkSvg;
    lblInputCopyToClipboard: TLabel;
    memInput: TMemo;
    layOutput: TLayout;
    memTitleOutput: TLabel;
    btnOutputCopyToClipboard: TButton;
    imgOutputCopyToClipboard: TSkSvg;
    lblOutputCopyToClipboard: TLabel;
    memOutput: TMemo;
    SplitterInputOutput: TSplitter;
    OpenDialog: TOpenDialog;
    btnInputLoad: TButton;
    imgInputLoad: TSkSvg;
    lblInputLoad: TLabel;
    btnInputClear: TButton;
    imgInputClear: TSkSvg;
    lblInputClear: TLabel;
    chkFormatToDelphi: TCheckBox;
    edtVarName: TEdit;
    procedure FrameResize(Sender: TObject);
    procedure btnOutputCopyToClipboardClick(Sender: TObject);
    procedure btnInputCopyToClipboardClick(Sender: TObject);
    procedure btnInputPasteFromClipboardClick(Sender: TObject);
<<<<<<< HEAD
    procedure memOutputEnter(Sender: TObject);
=======
    procedure btnInputLoadClick(Sender: TObject);
    procedure btnInputClearClick(Sender: TObject);
    procedure memInputChange(Sender: TObject);
    procedure memInputKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
>>>>>>> 53af526825e1211c7a56f7bad6746d4fce3f4c60
  private
    { Private declarations }
    procedure SQLFormat();
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

procedure TFrame_SQLFormatter.btnInputClearClick(Sender: TObject);
begin
  memInput.Lines.Clear;
  SQLFormat();
end;

procedure TFrame_SQLFormatter.btnInputCopyToClipboardClick(Sender: TObject);
var
  ClipboardService: IFMXClipboardService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXClipboardService, ClipboardService) then
    ClipboardService.SetClipboard(memInput.Text);
end;

procedure TFrame_SQLFormatter.btnInputLoadClick(Sender: TObject);
begin
  if (OpenDialog.Execute) then
  begin
    memInput.Lines.LoadFromFile(OpenDialog.FileName);
    SQLFormat();
  end;
end;

procedure TFrame_SQLFormatter.btnInputPasteFromClipboardClick(Sender: TObject);
var
  ClipboardService: IFMXClipboardService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXClipboardService, ClipboardService) then
    memInput.Text := ClipboardService.GetClipboard.ToString;
end;

procedure TFrame_SQLFormatter.btnOutputCopyToClipboardClick(Sender: TObject);
var
  ClipboardService: IFMXClipboardService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXClipboardService, ClipboardService) then
    ClipboardService.SetClipboard(memOutput.Text);
end;

procedure TFrame_SQLFormatter.FrameResize(Sender: TObject);
begin
  layInput.Width := (layBottom.Width - layBottom.Padding.Left - layBottom.Padding.Right - SplitterInputOutput.Width) / 2;
end;

<<<<<<< HEAD
procedure TFrame_SQLFormatter.memOutputEnter(Sender: TObject);
=======
procedure TFrame_SQLFormatter.memInputChange(Sender: TObject);
>>>>>>> 53af526825e1211c7a56f7bad6746d4fce3f4c60
begin
  SQLFormat();
end;

<<<<<<< HEAD
Procedure TFrame_SQLFormatter.SQLFormat;
var sResult:string;
lstResult:TStringList;
begin
  lstResult := TStringList.Create;
  lstResult := FormatSQL(memInput.Text, chkFormatToDelphi.IsChecked, edtVarName.Text);

  memOutput.Lines.Clear;
  for var s in lstResult do
  begin
    memOutput.Lines.Add(s);
  end;
  
=======
procedure TFrame_SQLFormatter.memInputKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  SQLFormat();
end;

procedure TFrame_SQLFormatter.SQLFormat;
begin
  memOutput.Text := TCodeFormatter.FormatSQL(memInput.Text);
>>>>>>> 53af526825e1211c7a56f7bad6746d4fce3f4c60
end;

end.
