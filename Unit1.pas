unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ToolWin, ComCtrls, Menus, ExtCtrls, jpeg, XPMenu, StdCtrls,
  Buttons, DelphiTwain, ImgList;

type
  TForm1 = class(TForm)
    CoolBar1: TCoolBar;
    Image1: TImage;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Exit1: TMenuItem;
    N1: TMenuItem;
    PrintSetup1: TMenuItem;
    Print1: TMenuItem;
    N2: TMenuItem;
    SaveAs1: TMenuItem;
    Save1: TMenuItem;
    Open1: TMenuItem;
    New1: TMenuItem;
    Edit1: TMenuItem;
    Object1: TMenuItem;
    N3: TMenuItem;
    GoTo1: TMenuItem;
    N4: TMenuItem;
    PasteSpecial1: TMenuItem;
    Paste1: TMenuItem;
    Copy1: TMenuItem;
    Cut1: TMenuItem;
    N5: TMenuItem;
    Repeatcommand1: TMenuItem;
    Undo1: TMenuItem;
    Help1: TMenuItem;
    About1: TMenuItem;
    HowtoUseHelp1: TMenuItem;
    SearchforHelpOn1: TMenuItem;
    Contents1: TMenuItem;
    Image2: TImage;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn9: TBitBtn;
    BitBtn10: TBitBtn;
    BitBtn11: TBitBtn;
    BitBtn12: TBitBtn;
    BitBtn13: TBitBtn;
    ToolBar1: TToolBar;
    DelphiTwain1: TDelphiTwain;
    StatusBar1: TStatusBar;
    ScrollBox1: TScrollBox;
    Image3: TImage;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    XPMenu1: TXPMenu;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ImageList1: TImageList;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    Label1: TLabel;
    Edit2: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    ComboBox1: TComboBox;
    Memo1: TMemo;
    View1: TMenuItem;
    SelectedField1: TMenuItem;
    TemplateProperties1: TMenuItem;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Edit3: TEdit;
    Memo2: TMemo;
    Edit4: TEdit;
    Button1: TButton;
    procedure GoTo1Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure TwainTwainAcquire(Sender: TObject; const Index: Integer;
      Image: TBitmap; var Cancel: Boolean);
    procedure Image3MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ToolButton6Click(Sender: TObject);
    procedure Image3MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ToolButton4Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton7Click(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);
    procedure ToolButton10Click(Sender: TObject);
    procedure SelectedField1Click(Sender: TObject);
    procedure TemplateProperties1Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
  private
    { Private declarations }
  public
   lastx,lasty:integer;
   startx,starty:integer;
   state:integer;
   DrawColor:TColor;
   imagefunct:string;
   imagedeheight:integer;
   imagedewidth:integer;
   curzoom:integer;
  end;

var
  Form1: TForm1;

const
  crMyCursor = 5;

implementation

{$R *.dfm}

procedure TForm1.GoTo1Click(Sender: TObject);
var
  SelItem: Integer; 
begin
  //Loads the library and the source manager
  if DelphiTwain1.LoadLibrary() then
    with DelphiTwain1 do 
    begin
      LoadSourceManager();
      SelItem := SelectSource();
      //If no item was selected, show message
      if SelItem = -1 then
        StatusBar1.Panels[0].Text:='Using Twain Source : No item was chosen'
      else
        StatusBar1.Panels[0].Text:='Using Twain Source : ' + Source[SelItem].ProductName;
    end
  else StatusBar1.Panels[0].Text:='Twain is not installed';
end;

procedure TForm1.BitBtn5Click(Sender: TObject);
begin
  //Loads library and source manager. In case the
  //LibraryLoaded value continues to be FALSE, it
  //means that twain is not installed, so exit
  DelphiTwain1.LibraryLoaded := TRUE;
  DelphiTwain1.SourceManagerLoaded := TRUE;
  if DelphiTwain1.LibraryLoaded = FALSE then Exit;
  //If there is no sources, also exit
  if DelphiTwain1.SourceCount = 0 then exit;

  //Acquire from the first source
  DelphiTwain1.Source[0].TransferMode := ttmMemory;
  DelphiTwain1.Source[0].Loaded := TRUE;
  DelphiTwain1.Source[0].Enabled := TRUE;
  while DelphiTwain1.Source[0].Enabled do Application.ProcessMessages;
  {Unload library}
  DelphiTwain1.UnloadLibrary;

end;

procedure TForm1.TwainTwainAcquire(
  Sender: TObject; const Index: Integer;
  Image: TBitmap; var Cancel: Boolean);
begin
  //Copies the Image parameter to the TImage
  Image3.Picture.Assign(Image);
  //We only want the first image
  Cancel := TRUE;
  DelphiTwain1.UnloadLibrary;
end;

procedure TForm1.Image3MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 if(imagefunct='addtext') then
  begin
   image3.Canvas.Pen.Mode:=pmXOR;
   image3.Canvas.MoveTo(startx,starty);
   image3.Canvas.LineTo(startx,lasty);
   image3.Canvas.LineTo(lastx,lasty);
   image3.Canvas.LineTo(lastx,starty);
   image3.Canvas.LineTo(startx,starty);
   image3.Canvas.Pen.Mode:=pmXOR;
   image3.Canvas.MoveTo(startx,starty);
   image3.Canvas.LineTo(startx,y);
   image3.Canvas.LineTo(x,y);
   image3.Canvas.LineTo(x,starty);
   image3.Canvas.LineTo(startx,starty);
   lastx:=x; lasty:=y;
  end;
end;

procedure TForm1.Image3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 if(imagefunct='addtext') then
  begin
   startx:=x; starty:=y;
   lastx:=x;lasty:=y;
   state:=4;
   image3.Canvas.Pen.Color:=clred;
   image3.Canvas.Brush.Color:=clred;
  end;
end;

procedure TForm1.ToolButton6Click(Sender: TObject);
begin
  imagefunct:='addtext';
  Screen.Cursors[crMyCursor] := LoadCursor(HInstance, 'addtext');
  Image3.Cursor:=crMyCursor ;
end;

procedure TForm1.Image3MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 if(imagefunct='addtext') then
  begin
   image3.Canvas.Pen.Mode:=pmXOR;
   image3.Canvas.MoveTo(startx,starty);
   image3.Canvas.LineTo(startx,lasty);
   image3.Canvas.LineTo(lastx,lasty);
   image3.Canvas.LineTo(lastx,starty);
   image3.Canvas.LineTo(startx,starty);
   image3.Canvas.Pen.Color:=drawcolor;
   image3.Canvas.Brush.Color:=drawcolor;
   image3.Canvas.Pen.Mode:=pmCopy;
   image3.Canvas.MoveTo(startx,starty);
   image3.Canvas.LineTo(startx,lasty);
   image3.Canvas.LineTo(lastx,lasty);
   image3.Canvas.LineTo(lastx,starty);
   image3.Canvas.LineTo(startx,starty);
   state:=3;
  end;
end;

procedure TForm1.ToolButton4Click(Sender: TObject);
begin
  imagefunct:='zoomout';
  Screen.Cursors[crMyCursor] := LoadCursor(HInstance, 'zoom_out');
  Image3.Cursor:=crMyCursor ;
end;

procedure TForm1.ToolButton3Click(Sender: TObject);
begin
  imagefunct:='zoomin';
  Screen.Cursors[crMyCursor] := LoadCursor(HInstance, 'zoom_in');
  Image3.Cursor:=crMyCursor ;
end;

procedure TForm1.ToolButton1Click(Sender: TObject);
begin
  imagefunct:='click';
  Image3.Cursor:=crDefault;
end;

procedure TForm1.ToolButton7Click(Sender: TObject);
begin
  imagefunct:='addnumber';
  Screen.Cursors[crMyCursor] := LoadCursor(HInstance, 'addnumber');
  Image3.Cursor:=crMyCursor ;
end;

procedure TForm1.ToolButton8Click(Sender: TObject);
begin
  imagefunct:='addcheck';
  Screen.Cursors[crMyCursor] := LoadCursor(HInstance, 'addcheck');
  Image3.Cursor:=crMyCursor ;
end;

procedure TForm1.ToolButton10Click(Sender: TObject);
begin
  imagefunct:='delete';
  Image3.Cursor:=crNo ;
end;

procedure TForm1.SelectedField1Click(Sender: TObject);
begin
  If(SelectedField1.Checked=true) then
   Groupbox1.Visible:=true
  else
   GroupBox1.Visible:=false;
end;

procedure TForm1.TemplateProperties1Click(Sender: TObject);
begin
  If(TemplateProperties1.Checked=true) then
   Groupbox2.Visible:=true
  else
   GroupBox2.Visible:=false;
end;

procedure TForm1.Image3Click(Sender: TObject);
begin
 if(imagefunct='zoomin') then
  if(curzoom<5)then
   curzoom:=curzoom+1;
 if(imagefunct='zoomout') then
  if(curzoom>-5)then
   curzoom:=curzoom-1;
 image3.Width:=imagedewidth*curzoom;
 image3.Height:=imagedeheight*curzoom;
end;

procedure TForm1.BitBtn9Click(Sender: TObject);
begin
  Image3.Picture.LoadFromFile('018 - Luis Royo.BMP');
  imagedeheight:=image3.Height;
  imagedewidth:=image3.Width;
  curzoom:=1;
end;

end.


