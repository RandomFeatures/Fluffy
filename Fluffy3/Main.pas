unit Main;

interface                                                 

uses
  Windows, SysUtils,  Graphics,  Forms, Dialogs,
  StdCtrls, ExtCtrls, DXClass, DXSprite, DXDraws,
  DXSounds,  DirectX, Classes, Controls, DIB, cmpTrackOutputs,
  cmpMidiData, cmpMidiPlayer,cmpMidiIterator, Gauges;

type
  TMainForm = class(TDXForm)
    DXTimer: TDXTimer;
    DXDraw: TDXDraw;
    DXSpriteEngine: TDXSpriteEngine;
    ImageList: TDXImageList;
    DXWaveList: TDXWaveList;
    DXSound: TDXSound;
    Edit1: TEdit;
    MidiPlayer1: TMidiPlayer;
    MidiData1: TMidiData;
    TrackOutputs1: TTrackOutputs;
    Panel1: TPanel;
    controlPanel: TPanel;
    Panel2: TPanel;
    hitGuage: TGauge;
    Panel3: TPanel;
    ManaGauge: TGauge;
    pnlf5: TPanel;
    Image1: TImage;
    Label1: TLabel;
    pnlf6: TPanel;
    Image2: TImage;
    Label2: TLabel;
    pnlf7: TPanel;
    Image3: TImage;
    Label3: TLabel;
    pnlf8: TPanel;
    Image4: TImage;
    Label4: TLabel;
    pnlf9: TPanel;
    Image6: TImage;
    Label5: TLabel;
    Panel5: TPanel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    SpeakTimer: TTimer;
    GuardTimer: TTimer;
    AttackPlayerTimer: TTimer;
    ManaTimer: TTimer;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Image5: TImage;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    ImageList2: TDXImageList;
    Label45: TLabel;
    Label46: TLabel;
    Stage3Start: TTimer;
    Stage3Chat: TTimer;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DXDrawFinalize(Sender: TObject);
    procedure DXDrawInitialize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DXTimerTimer(Sender: TObject; LagCount: Integer);
    procedure DXDrawMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DXDrawMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DXDrawMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SendNow;
    procedure Edit1Change(Sender: TObject);
    procedure letsBegin;
    procedure titlescreen;
    procedure onscreenText;
    procedure CreateTrees(numb: Integer);
    procedure CreateStandingStage2(numb: Integer);
    procedure CreateStandingStage1(numb: Integer);
    procedure CreateMoving(numb: Integer);

    procedure CreateDD;
    procedure CreateBritish;
    procedure CreateDupre;
    procedure CreateGuards;
    procedure TheDead(numb:Integer);
    procedure WinScreen;
    procedure Limbo;
    procedure FormShow(Sender: TObject);
    procedure OpenMidiFile (const FileName : string);
    procedure CloseMidiFile;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure CreateGraves(numb:Integer);
    procedure Image1Click(Sender: TObject);
   // procedure Flip(var MyBitmap: TBitmap);
  //  procedure Mirror(var MyBitmap: TBitmap);
    procedure SpeakTimerTimer(Sender: TObject);
    procedure GuardTimerTimer(Sender: TObject);
    procedure AttackPlayerTimerTimer(Sender: TObject);
    procedure ManaTimerTimer(Sender: TObject);
    procedure ResetGame;
    procedure Stage3StartTimer(Sender: TObject);
    procedure Stage3ChatTimer(Sender: TObject);

  private
    FRFIFade: Integer;
    LvlFade: integer;
    FKil1Fade: Integer;
    FKil2Fade: Integer;
    FSurface: TDirectDrawSurface;
    goingUp : boolean;
    credits: integer;
  end;

Type

TDDSprite = class(TImageSprite)
  private
    FS: Integer;
    procedure Hit;
  Protected
    procedure DoMove(MoveCount: Integer); override;
  end;

TGuardsSprite = class(TImageSprite)
  private
    Hitpoints: Integer;
    procedure Hit;
  public
    procedure DoMove(MoveCount: Integer); override;
  end;

TBritishSprite = class(TImageSprite)
  private
    FS: Integer;
    Hitpoints: Integer;
    procedure Hit;
  public
    procedure DoMove(MoveCount: Integer); override;
  end;

TDupreSprite = class(TImageSprite)
  private
    FS: Integer;
    Hitpoints: Integer;
    procedure Hit;
  public
    procedure DoMove(MoveCount: Integer); override;
  end;

TSpeakSprite = class(TImageSprite)
  private
    Hitpoints: Integer;
    procedure Hit;
  public
    procedure DoMove(MoveCount: Integer); override;
  end;

  TChickenSprite = class(TImageSprite)
  protected
    procedure DoCollision(Sprite: TSprite; var Done: Boolean); override;
    procedure DoMove(MoveCount: Integer); override;
  end;

TFireBallSprite = class(TImageSprite)
  protected
    procedure DoCollision(Sprite: TSprite; var Done: Boolean); override;
    procedure DoMove(MoveCount: Integer); override;
  end;

TPotionSprite = class(TImageSprite)
  protected
    procedure DoCollision(Sprite: TSprite; var Done: Boolean); override;
    procedure DoMove(MoveCount: Integer); override;
  end;

TExplodeSprite = class(TImageSprite)
  private
    FS: Integer;
  protected
    procedure DoMove(MoveCount: Integer); override;
    procedure DoCollision(Sprite: TSprite; var Done: Boolean); override;

  end;

TBombSprite = class(TImageSprite)
  private
    FS: Integer;
  protected
    procedure DoMove(MoveCount: Integer); override;
//    procedure DoCollision(Sprite: TSprite; var Done: Boolean); override;

  end;

var
  MainForm: TMainForm;
  //integer
  Gold        :         integer;
  Mana        :         integer;
  Health      :         integer;
  mousex      :         integer;
  mousey      :         integer;
  targetx     :         integer;
  targety     :         integer;
  fireCount   :         integer;
  PotionCount :         integer;
  Stage       :         integer;
  MovingCount :         integer;
  StandingCount:        integer;
  TitleMode   :         integer;
  SpellMode   :         integer;
  Stage3ChatCount :     integer;
  //boolean
  Mousein     :         boolean;
  MouseYes    :         boolean;
  MouseNo     :         boolean;
  ExitYesNo   :         Boolean;
  speaking    :         boolean;
  Sayit       :         boolean;
  wacked      :         boolean;
  guardUp     :         boolean;
  guardin     :         boolean;
  BullsEye    :         boolean;
  mousecontrol:         boolean;
  GameNow     :         boolean;
  GameOver    :         boolean;
  firing      :         boolean;
  DDExists    :         boolean;
  BritishExists:        boolean;
  DupreExists:          boolean;
  GuardsExists :        boolean;
  DDDead       :        boolean;
  BritishDead  :        boolean;
  DupreDead    :        boolean;
  DDStop       :        boolean;
  UsingMidi    :        boolean;
  Guards       :        Boolean;
  GotGraves    :        boolean;
  Postal       :        boolean;
  FluffyFreeze :        Boolean;
  RatTime      :        Boolean;
  //doubles
  playerx      :        double;
  playery      :        double;
  NewX         :        double;
  NewY         :        double;
  PotionTargetX:        double;
  PotionTargetY:        double;
  firex        :        double;
  firey        :        double;
  Potionx      :        double;
  Potiony      :        double;

  //reals
  centerx      :        real;
  centery      :        real;
  Pcenterx     :        real;
  Pcentery     :        real;
  //strings
  player1Says  :        string;
  Showtext     :        string;
  Cheats       :        string;
  FluffySays1  :        string;
  DDSays1      :        string;
  FluffySays2  :        string;
  DDSays2      :        string;

  //Objects

  Fluffy       :        TChickenSprite;
  DDragon      :        TDDSprite;
  Speak        :        TSpeakSprite;
  fMidiPosition:        TMidiPosition;
  SteelWolf    :        TGuardsSprite;
  SpeakColor   :        TColor;
 implementation

{$R *.DFM}


type

TBadGuySprite = class(TImageSprite)
  private
    FCounter: Double;
    FS: Integer;
    procedure Hit;
  public
    procedure DoMove(MoveCount: Integer); override;
  end;

TTreeSprite = class(TImageSprite)
  end;

TMinorSprite = class(TImageSprite)
  private
    FS: Integer;
    procedure Hit;
  public
    procedure DoMove(MoveCount: Integer); override;
  end;

TDummySprite = class(TImageSprite)
  private
    FS: Integer;
    procedure Hit;
  public
    procedure DoMove(MoveCount: Integer); override;

  end;




procedure TExplodeSprite.DoMove(MoveCount: Integer);
begin
  inherited DoMove(MoveCount);
  try
     if GameOver then dead;
     Inc(FS, MoveCount);
     if FS>425 then
     begin
          Dead;
          firing:= false;
          bullseye := true;
     end;
     Collision;
  except
        dead;
        firing := false;
        bullseye := true;
  end;
end;

procedure TBombSprite.DoMove(MoveCount: Integer);
begin
  try
     inherited DoMove(MoveCount);
     if GameOver then dead;
     Inc(FS, MoveCount);
     if FS>425 then
        begin
             PotionCount := 0;
             Dead;
        end;

    //    Collision;
  except
      PotionCount := 0;
      Dead;
  end;

end;

procedure TBadGuySprite.DoMove(MoveCount: Integer);
begin
  inherited DoMove(MoveCount);
  try
     if Gameover then
     begin
          Dec(MovingCount);
          dead;
     end;

     if Collisioned then
     begin
          if (UpperCase(player1Says) = 'KILLEMALL') Then
          begin
               firex:= x;
               firey:= y;
               centerx:= (width / 2);
               centery:= (height / 2);
               try
                  with TExplodeSprite.Create(MainForm.DXSpriteEngine.Engine) do
                    begin
                      //very loud dont do it
                      //MainForm.DXWaveList.Items.Find('explode').Play(False);
                      Image := MainForm.ImageList.Items.Find('Explode');
                      Width := Image.Width;
                      Height := Image.Height;
                      AnimStart := 0;
                      AnimCount := Image.PatternCount;
                      AnimLooped := true;
                      AnimPos:=0;
                      AnimSpeed := 14/1000;
                      x := firex - ((width /2)- centerx);
                      y:= firey -((height /2)- centery);
                      Z := 10;
                    end;
               except
               end;
          end;
          //Move in circles
          FCounter := FCounter + (100/1000)*MoveCount;
          X := X+Sin256(Trunc(FCounter))*(100/1000)*MoveCount;
          Y := Y+Cos256(Trunc(FCounter))*(100/1000)*MoveCount;
     end;
  except
       Dead;
       Dec(MovingCount);
  end;

  if not Collisioned then
  begin
    Inc(FS, MoveCount);
    if FS>2000 then
       begin
           Dead;
           Dec(MovingCount);
           if MovingCount < 2 then
           MainForm.GuardTimer.Enabled := false;
       end;
  end;


  end;


procedure TDDSprite.DoMove(MoveCount: Integer);
begin

  inherited DoMove(MoveCount);
  if Gameover then dead;

  if Collisioned then
  begin
//move dd

  end;

  if not Collisioned then
  begin
       Inc(FS, MoveCount);
       if FS>7500 then
          begin
               DDDead := true;
          end;
  end;

end;

procedure TSpeakSprite.DoMove(MoveCount: Integer);
begin
  inherited DoMove(MoveCount);
  try
     if Gameover then Collisioned := false;
     if not Collisioned then
     begin
         Speak.dead;
     end;
  except
  end;

end;

procedure TBritishSprite.DoMove(MoveCount: Integer);
begin
inherited DoMove(MoveCount);
  try
     if Gameover then Collisioned := false;
     if Collisioned then
     begin
          if (Guards) and Not(GuardsExists) then
          begin
            MainForm.CreateGuards;
            guards := false;
          end;
     end;
  except
     dead;
  end;

  if not Collisioned then
     begin
          Inc(FS, MoveCount);
          if Stage = 1 then
          begin
             if FS>4500 then
                begin
                 Speak.Collisioned := false;
                 BritishDead := True;
                 Dead;
                end;
          end
          else
             begin
                  dead;
                  Speak.Collisioned := false;
             end;
     end;

end;

procedure TDupreSprite.DoMove(MoveCount: Integer);
var
   DupreX: double;
   DupreY: Double;
begin
  inherited DoMove(MoveCount);
     if Gameover then
     begin
           DupreDead := True;
           Collisioned := false;
     end;
  try
     if Collisioned then
     begin
           DupreX := X;
           DupreY := Y;
           try
              If PotionCount < 1 then
              with TPotionSprite.Create(MainForm.DXSpriteEngine.Engine) do
              begin
                inc(PotionCount);
                Image := MainForm.ImageList.Items.Find('potion');
                x := Duprex;
                y:= Duprey;
                Z := 10;
                PotionTargetX:= Fluffy.x ;
                PotionTargetY:= Fluffy.y;
              end;
           except
           end;

           if X > Fluffy.x + 101 then X := Fluffy.x +100;
           if X < Fluffy.x - 101 then X := Fluffy.x -100;
           y := Fluffy.y - 120;

         if guardin then
             begin
                  if X >= Fluffy.x +100 then
                     guardin := false
                  else
                     X := X + 2;
             end
          else
              begin
                   if X <= Fluffy.x - 100 then
                      guardin := true
                   else
                      X := X - 2;

              end;
     end;
  except
     DupreDead := True;
     dead;
  end;

  try
     if not Collisioned then
     begin
          Image := MainForm.ImageList.Items.Find('dupredead');
          AnimLooped := False;
          AnimPos:=0;

          Inc(FS, MoveCount);
          if Stage = 2 then
          begin
               if FS>2500 then
               begin
                  DupreDead := True;
                  Dead;
               end;
          end
          else
              Dead;

     end;
  except
  end;
end;

procedure TGuardsSprite.DoMove(MoveCount: Integer);
begin

  inherited DoMove(MoveCount);
  try
     if Gameover then Collisioned := false;
     if Collisioned then
     begin
         if Stage <> 3 then
         begin
              if (x > Fluffy.x - 75) and (y < Fluffy.y + 20) and (y > Fluffy.y - 100) then
                 Image := MainForm.ImageList.Items.Find('GuardAttack')
              else
                  Image := MainForm.ImageList.Items.Find('Guardstand');

              if guardin then
                 begin
                      if X >= Fluffy.x - 50 then
                         guardin := false
                      else
                          X := X + 2;
                 end
             else
                 begin
                      if X <= Fluffy.x - 300 then
                         begin
                              guardin := true;
                              wacked := true;
                         end
                      else
                          X := X - 2;
                 end;

             if guardup then
                begin
                     if Y < Fluffy.y + 100 then
                        Y := Y + 2
                     else
                         guardup := false;
                end
             else
                 begin
                      if Y > Fluffy.y - 100 then
                         Y := Y - 2
                      else
                          guardup := true;
                 end;

             if ((x - Fluffy.x) > 1000) or ((Fluffy.x - X) > 1000) then
                Collisioned := false;
             if ((y - Fluffy.y) > 1000) or ((Fluffy.y - y) > 1000) then
                Collisioned := false;
         end
         else
             begin
                  if (x > ddragon.x - 75) and (y < ddragon.y + 20) and (y > ddragon.y - 100) then
                    begin
                     Image := MainForm.ImageList.Items.Find('GuardAttack');
                     DDragon.hit;
                    end
                  else
                      Image := MainForm.ImageList.Items.Find('Guardstand');

                  if guardin then
                     begin
                          if X >= ddragon.x - 50 then
                             guardin := false
                          else
                              X := X + 2;
                     end
                  else
                      begin
                           if X <= ddragon.x - 300 then
                              begin
                                   guardin := true;
                                   wacked := true;
                              end
                           else
                               X := X - 2;
                      end;

                  if guardup then
                     begin
                          if Y < ddragon.y + 100 then
                             Y := Y + 2
                          else
                              guardup := false;
                     end
                  else
                      begin
                           if Y > ddragon.y - 100 then
                              Y := Y - 2
                           else
                               guardup := true;
                      end;

             end;


     end;
  except
        GuardsExists := false;
        Dead;
  end;

    if not Collisioned then
       begin
           GuardsExists := false;
           Dead;
       end;


end;


procedure TMinorSprite.DoMove(MoveCount: Integer);
begin
  inherited DoMove(MoveCount);

  if Gameover then Collisioned := false;

  try
     if Collisioned then
     if (UpperCase(player1Says) = 'KILLEMALL')  Then
     begin
          firex:= x;
          firey:= y;
          centerx:= (width / 2);
          centery:= (height / 2);
          with TExplodeSprite.Create(MainForm.DXSpriteEngine.Engine) do
          begin
               //MainForm.DXWaveList.Items.Find('explode').Play(False);
               Image := MainForm.ImageList.Items.Find('Explode');
               Width := Image.Width;
               Height := Image.Height;
               AnimStart := 0;
               AnimCount := Image.PatternCount;
               AnimLooped := true;
               AnimPos:=0;
               AnimSpeed := 14/1000;
               x := firex - ((width /2)- centerx);
               y:= firey -((height /2)- centery);
               Z := 10;
          end;
     end;
  except
      dead;
      Dec(StandingCount);
  end;
  try
     if not Collisioned then
     begin
          Inc(FS, MoveCount);
          if FS>2000 then
          begin
               Dead;
               Dec(StandingCount);
          end;
     end;
  except
  end;
end;

procedure TDummySprite.DoMove(MoveCount: Integer);
begin

  inherited DoMove(MoveCount);

  if Gameover then collisioned := false;
  try
     if Collisioned then
     if (UpperCase(player1Says) = 'KILLEMALL') Then
     begin
          firex:= x;
          firey:= y;
          centerx:= (width / 2);
          centery:= (height / 2);
          with TExplodeSprite.Create(MainForm.DXSpriteEngine.Engine) do
          begin
               //MainForm.DXWaveList.Items.Find('explode').Play(False);
               Image := MainForm.ImageList.Items.Find('Explode');
               Width := Image.Width;
               Height := Image.Height;
               AnimStart := 0;
               AnimCount := Image.PatternCount;
               AnimLooped := true;
               AnimPos:=0;
               AnimSpeed := 14/1000;
               x := firex - ((width /2)- centerx);
               y:= firey -((height /2)- centery);
               Z := 10;
          end;
     end;
  except
        dead;
        Dec(StandingCount);
  end;

  if not Collisioned then
  begin
    Inc(FS, MoveCount);
    if FS>2000 then
       begin
            Dead;
            Dec(StandingCount);
       end;
  end;
end;


procedure TBadGuySprite.Hit;
begin
  try
     //Moving targets

     Collisioned := False;
     if Spellmode = 1 then
        Image := MainForm.ImageList.Items.Find('normal');

     if Spellmode = 2 then
        Image := MainForm.ImageList.Items.Find('red');

     if Spellmode = 3 then
        Image := MainForm.ImageList.Items.Find('bloody');

     if Spellmode = 4 then
        begin
             Image := MainForm.ImageList.Items.Find('body');
             Width := Image.Width;
             Height := Image.Height;
             AnimStart := 0;
             AnimCount := Image.PatternCount;
             AnimLooped := true;
             AnimPos:=0;
             AnimSpeed := 20/1000;
        end;

     if Spellmode = 5 then
        Image := MainForm.ImageList.Items.Find('burned');
  except
   dead;
  end;
  try
     if UpperCase(player1Says) <> 'KILLEMALL' Then
     MainForm.DXWaveList.Items.Find('snd').Play(false);
  except
  end;

  Inc(gold, Random(1000)* SpellMode);
  MainForm.Label31.Caption := IntToStr(gold);

end;

procedure TDDSprite.Hit;
begin
      MainForm.DXWaveList.Items.Find('wack').Play(false);
      Image := MainForm.ImageList.Items.Find('drat2');
      Collisioned := false;
      SteelWolf.Dead;
end;

procedure TGuardsSprite.Hit;
begin
  try
  Dec(HitPoints, SpellMode);
  if HitPoints <= 0 then
     begin
          Collisioned := False;
          try
             MainForm.DXWaveList.Items.Find('snd').Play(False);
          except
          end;

          Inc(gold, Random(2500)* SpellMode);
          MainForm.Label31.Caption := IntToStr(gold);
     end;
 except
 end;
end;
procedure TBritishSprite.Hit;
begin
  try
     Dec(HitPoints, SpellMode);

     if (HitPoints <= 40) and (HitPoints > 30) then
     begin
          Image := MainForm.ImageList.Items.Find('boss1.0');
          Z:= 2;
     end;

     if (HitPoints <= 30) and (HitPoints > 20) then
     begin
          Image := MainForm.ImageList.Items.Find('boss1.1');
          Z:= 2;
     end;

     if (HitPoints <= 20) and (HitPoints > 10) then
     begin
          Image := MainForm.ImageList.Items.Find('boss1.2');
          Z:= 2;
     end;

     if (HitPoints <= 10) and (HitPoints > 0) then
     begin
          Image := MainForm.ImageList.Items.Find('boss1.3');
          Z:= 2;
     end;

     if HitPoints <= 0 then
     begin
          SteelWolf.Collisioned := false;
          firecount := 100;
          Collisioned := False;
          Image := MainForm.ImageList.Items.Find('boss1.4');
          Inc(gold, Random(2500)* SpellMode);
          MainForm.Label31.Caption := IntToStr(gold);
     end;
  except
  end;
end;

procedure TDupreSprite.Hit;
begin
  try
     Dec(HitPoints, SpellMode);
     if HitPoints <= 0 then
     begin
          Image := MainForm.ImageList.Items.Find('dupredead');
          try
             MainForm.DXWaveList.Items.Find('snd').Play(False);
          except
          end;
          Width := Image.Width;
          Height := Image.Height;
          Collisioned := False;
          Inc(gold, Random(5000)* SpellMode);
          MainForm.Label31.Caption := IntToStr(gold);
     end;
  except;
  end;
end;

procedure TSpeakSprite.Hit;
begin
  if (Not(BritishExists)) or (BritishDead) then  Collisioned := False;

  try
     Dec(HitPoints, SpellMode);

     if (HitPoints <= 40) and (HitPoints > 39) then
     begin
          Image := MainForm.ImageList2.Items.Find('releaseme');
     end;

     if (HitPoints <= 39) and (HitPoints > 35) then
     begin
          Image := MainForm.ImageList2.Items.Find('power');
     end;

     if (HitPoints <= 35) and (HitPoints > 30) then
     begin
          Guards := true;
          MainForm.SpeakTimer.Enabled := true;
          Speaking := true;
          Image := MainForm.ImageList2.Items.Find('bank');
     end;
  except
  end;
  try
     if GuardsExists then Guards := false;

     if HitPoints <= 0 then
     begin
//          Collisioned := False;
          firecount := 100;
          MainForm.SpeakTimer.Enabled := false;
          Image := MainForm.ImageList2.Items.Find('SayIt');
          sayit := true;
          speaking := false;
          MainForm.SpeakTimer.Enabled := true;
          Inc(gold, Random(2500)* SpellMode);
          MainForm.Label31.Caption := IntToStr(gold);
     end;
  except
  end;
end;

procedure TMinorSprite.Hit;
begin
     try
       Collisioned := False;
       Image := MainForm.ImageList.Items.Find('body');
       Width := Image.Width;
       Height := Image.Height;
       AnimStart := 0;
       AnimCount := Image.PatternCount;
       AnimLooped := true;
       AnimPos:=0;
       AnimSpeed := 20/1000;
    except
    end;

   try
      if UpperCase(player1Says) <> 'KILLEMALL' Then
         MainForm.DXWaveList.Items.Find('snd').Play(False);
   except
   end;

  Inc(gold, Random(750)* SpellMode);
  MainForm.Label31.Caption := IntToStr(gold);

end;

procedure TDummySprite.Hit;
begin
  try
     Collisioned := False;
     Image := MainForm.ImageList.Items.Find('burning');

     Width := Image.Width;
     Height := Image.Height;
     AnimStart := 0;
     AnimCount := Image.PatternCount;
     AnimLooped := true;
     AnimPos:=0;
     AnimSpeed := 20/1000;
  except
  end;

  try
     if UpperCase(player1Says) <> 'KILLEMALL' Then
        MainForm.DXWaveList.Items.Find('snd').Play(False);
  except
  end;

  Inc(gold, Random(1000)* SpellMode);
  MainForm.Label31.Caption := IntToStr(gold);

end;

procedure TChickenSprite.DoCollision(Sprite: TSprite; var Done: Boolean);
begin
//  if Sprite is TBadGuySprite then
//    TBadGuySprite(Sprite).Hit;
  try

     if (Sprite is TBadGuySprite) and (MainForm.AttackPlayerTimer.Enabled = false) then
     begin
        MainForm.AttackPlayerTimer.enabled := true;
        try
           MainForm.DXWaveList.Items.Find('hit').Play(false);
        except
        end;
        Dec(health, Random(10));
    end;

    if (Sprite is TBombSprite)and (MainForm.AttackPlayerTimer.Enabled = false)  then
     begin
        MainForm.AttackPlayerTimer.enabled := true;
        Dec(health, Random(30));
    end;

    if (Sprite is TGuardsSprite) and (Wacked = true) and (Stage <> 3)then
     begin
          try
             MainForm.DXWaveList.Items.Find('wack').Play(false);
          except
          end;
          wacked := false;
          Dec(health, Random(20));
     end;
  except
  end;
  Done := False;
end;


procedure TChickenSprite.DoMove(MoveCount: Integer);
var
  mouseright: string;
begin
  inherited DoMove(MoveCount);
{ try
    if isUp in MainForm.DXInput.States then
     begin
          AnimStart := 0;
          AnimCount := Image.PatternCount;
          AnimLooped := true;
          AnimSpeed := 15/1000;
          Y := Y - (300/1000)*MoveCount;
     end;
  if isDown in MainForm.DXInput.States then
     begin
          AnimStart := 0;
          AnimCount := Image.PatternCount;
          AnimLooped := true;
          AnimSpeed := 15/1000;
          Y := Y + (300/1000)*MoveCount;
     end;
  if isLeft in MainForm.DXInput.States then
     begin
          Image := MainForm.ImageList.Items.Find('img2-3');
       //   img := 'img2-3';
          AnimStart := 0;
          AnimCount := Image.PatternCount;
          AnimLooped := true;
          AnimSpeed := 15/1000;
          X := X - (300/1000)*MoveCount;
     end;
  if isRight in MainForm.DXInput.States then
     begin
          Image := MainForm.ImageList.Items.Find('img2-4');
//          img := 'img2-4';
          AnimStart := 0;
          AnimCount := Image.PatternCount;
          AnimLooped := true;
          AnimSpeed := 15/1000;
          X := X + (300/1000)*MoveCount;
     end;

  if ((isRight in MainForm.DXInput.States = false) and (isLeft in MainForm.DXInput.States= false) and
     (isDown in MainForm.DXInput.States= false) and (isUp in MainForm.DXInput.States= false)and (mousecontrol =false) ) then
  except
  end;
 }
 try
    if FluffyFreeze then
    begin
       Image := MainForm.ImageList.Items.Find('img2-4');
       AnimLooped := False;
       AnimPos:=0;
       exit;
    end;
    if mousecontrol =false then
      begin
           AnimLooped := False;
           AnimPos:=0;
      end;
    if DDStop = false then
    if mousecontrol = true then
       begin
          Image := MainForm.ImageList.Items.Find('img2-4');
          AnimStart := 0;
          AnimCount := Image.PatternCount;
          AnimLooped := true;
          AnimSpeed := 15/1000;
          if mousex  > 340 then
             begin
                  Image := MainForm.ImageList.Items.Find('img2-4');

                  if Not((Engine.X - Engine.Width)<= (-2520 - (Engine.Width div 2))) then
                  if mousex > 475 then
                     X := X + (400/1000)*MoveCount
                  else
                  X := X + (200/1000)*MoveCount;
             end;
          if mousex < 300 then
             begin

               Image := MainForm.ImageList.Items.Find('img2-3');

               if Not(Engine.X >= (-15 + (Engine.Width div 2)))then
               if mousex < 156 then
                     X := X - (400/1000)*MoveCount
               else
               X := X - (200/1000)*MoveCount;
             end;

          if mousey > 260 then
             if Not((Engine.y - Engine.height)<= (-2620 - (Engine.height div 2))) then
             if mousey > 395 then
                Y := Y + (400/1000)*MoveCount
             else
                 Y := Y + (200/1000)*MoveCount;

          if mousey < 220 then
            if Not(Engine.y >= (-15 + (Engine.height div 2)))then
            if mousey < 85 then
            Y := Y - (400/1000)*MoveCount
            else
            Y := Y - (200/1000)*MoveCount;
       end;
    except
    end;

  try
     Collision;

     if (X < -10) or (X > + 2530) or (y < -10) or (y > 2645) then dec(health);
        MainForm.hitGuage.Progress := Health;
     if Health < 25 then MainForm.hitGuage.ForeColor := clred;
     if (Health > 25) and (Health < 75) then MainForm.hitGuage.ForeColor := clyellow;
     if Health > 75 then MainForm.hitGuage.ForeColor := clLime;
     if health <= 0 then
        begin
          dead;
          try
             MainForm.DXWaveList.Items.Find('snd').Play(false);
          except
          end;
          gameover := true;
          if MainForm.MidiData1.Active then
             begin
                  MainForm.MidiPlayer1.Play := false;
             end;
          MainForm.closeMidiFile;
          MainForm.MidiPlayer1.Rewind;
          MainForm.OpenMidiFile(Extractfilepath(Application.exename) + 'dead.mid');
          if MainForm.MidiData1.Active then
             begin
                  MainForm.MidiPlayer1.Play := True
             end;

        end;
  except
  end;

  try
     //Move the screen
     if mousecontrol = true then mouseright := '1' else mouseright := '0';
     Engine.X := -X+Engine.Width div 2-Width div 2;
     Engine.Y := -Y+Engine.Height div 2-Height div 2;
  except
  end;

 end;


procedure TMainForm.DXTimerTimer(Sender: TObject; LagCount: Integer);
begin
  //Main Game timer. for some reason Hori chose to use the OnAppIdle event for
  //his timer so that means we only get 1 DXTimer to use for EVERYTHING
  //as a result the followgin code is a little tricky to follow
  if not DXDraw.CanDraw then exit;

  if (GameNow) and ((StandingCount = 0) and (MovingCount = 0 )) then
     begin
          try
             if (gameOver){and ((dupreExists = false) or (dupreDead = true)) and ((BritishExists = false) or (BritishDead = true))}then
             begin
                  MainForm.resetGame;
                  exit;
             end;
          except
          end;

          try
             if stage = 3 then
             if ddExists = false then
              CreateDD
             else
                 if ddDead = True then
                    begin
                         Inc(Stage);
                         GameNow := false;
                         Player1says := '';
                         Fluffy.Dead;
                    end;
          except
          end;

          try
             if stage = 2 then
             if DupreExists = false then
              CreateDupre
             else
                 if DupreDead = True then
                    begin
                         Inc(Stage);
                         Mana := 100;
                         Health := 100;
                         mainform.ManaGauge.Progress := 100;
                         mainform.hitGuage.Progress := 100;
                         mainform.hitGuage.ForeColor := cllime;
                         mainform.ManaGauge.foreColor := cllime;
                         firecount := 0;
                         LvlFade := 254;
                         Player1says := '';
                         GameNow := false;
                         Stage3Start.Enabled := true;
                         if MainForm.MidiData1.Active then
                            MainForm.MidiPlayer1.Play := false;
                         MainForm.closeMidiFile;
                         MainForm.MidiPlayer1.Rewind;
                       //  MainForm.OpenMidiFile(Extractfilepath(Application.exename) + 'dead.mid');
                       //  if MainForm.MidiData1.Active then
                       //     MainForm.MidiPlayer1.Play := True

                    end;
          except
          end;
          try
             if stage = 1 then
             if BritishExists = false then
              CreateBritish
             else
                 if BritishDead = True then
                    begin
                         Inc(Stage);
                         Mana := 100;
                         Health := 100;
                         speak.Image := MainForm.ImageList.Items.Find('blank');
                         mainform.ManaGauge.foreColor := cllime;
                         mainform.hitGuage.foreColor := cllime;
                         mainform.ManaGauge.Progress := 100;
                         mainform.hitGuage.Progress := 100;
                         GameNow := false;
                         LvlFade := 254;
                         Player1says := '';
                         Fluffy.X := 1250;
                         Fluffy.Y := 1250;
                         letsbegin;
                   end;
             except
             end;
     end;

  try
     if Not(GameNow) then
     begin
         If stage = 0 then
          TitleScreen;

         If Stage = 4 then
            WinScreen;
         if Stage = 3 then
           Limbo;
     end
     else
         begin
           DXSpriteEngine.Move(LagCount);
           DXSpriteEngine.Dead;

           {  Description  }
           DXDraw.Surface.Fill(0);
           DXSpriteEngine.Draw;
           OnScreenText;
         end;
  except
  end;

  try
    DXDraw.Surface.Draw(mouseX-FSurface.Width div 2, mousey-FSurface.Height div 2,
                          FSurface.ClientRect, FSurface, True);
    DXDraw.Flip; //very very important :)
 except
 end;

end;

procedure TMainForm.DXDrawFinalize(Sender: TObject);
begin
  DXTimer.Enabled := False;
  FSurface.Free;
end;

procedure TMainForm.DXDrawInitialize(Sender: TObject);
begin
  //MMTimer1.Enabled := True;
  DXTimer.Enabled := True;
  FSurface := TDirectDrawSurface.Create(DXDraw.DDraw);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  Randomize;
  Panel1.Cursor := crNone;
  DXDraw.Cursor := crNone;
  MainForm.Cursor := crNone;
  ImageList.Items.MakeColorTable;
  GuardsExists := false;
  BritishExists := false;
  DupreExists := false;
  DDExists := false;
  FluffyFreeze := false;
  FRFIFade := 2;
  LvlFade := 254;
  FKil1Fade := 0;
  FKil2Fade := 0;
  credits := 0;
  goingUp := true;
  bullsEye :=false;
  wacked := true;
  speaking := false;
  sayit := false;
  Mousein  := false;
  MouseYes := false;
  MouseNo := false;
  ExitYesNo  := false;
  Postal := false;
  RatTime:= false;
  PotionCount:= 0;
  Stage3ChatCount := 0;
  TitleMode := 4;
  Gold := 00000;
  Mana := 100;
  Health := 100;
  SpellMode := 1;
  guards := false;
  Guardup := true;
  Guardin := true;
  GotGraves  := false;
  FluffySays1 := '';
  FluffySays2 := '';
  DDSays1:= '';
  DDSays2:= '';

  Try
     DXDraw.ColorTable := ImageList.Items.ColorTable;
     DXDraw.DefColorTable := ImageList.Items.ColorTable;
     DXDraw.UpdatePalette;
  except
        DXDraw.Finalize;
        DXSound.Finalize;
        closeMidiFile;
        Showmessage('Unable to initalize Direct Draw');
        Application.terminate;
  end;

  try
     with TBackgroundSprite.Create(DXSpriteEngine.Engine) do
       begin
            SetMapSize(1,1);
            Image := ImageList.Items.Find('background2');
            Z := -4;
            Tile := true;
       end;

     with TBackgroundSprite.Create(DXSpriteEngine.Engine) do
       begin
            SetMapSize(6,17);
           // SetMapSize(1,1);
            Image := ImageList.Items.Find('background');
            Z := -2;
            //Tile := true;
       end;
  except
  //No background
  end;

  CreateTrees(50);

  GameNow := False;
  GameOver:= False;
  Stage := 0;
  Try

     DXDraw.Finalize;
     //Full Screen Mode
     StoreWindow;
     BorderStyle := bsNone;
     DXDraw.Options := DXDraw.Options + [doFullScreen];
     DXDraw.Initialize;
  except
        DXDraw.Finalize;
        DXSound.Finalize;
        closeMidiFile;
        Showmessage('Unable to initalize Direct Draw full screen');
        Application.terminate;
  end;
  try
     DXSound.Initialize;
  except
     DXDraw.Finalize;
     DXSound.Finalize;
     closeMidiFile;
     Showmessage('Unable to initalize Direct Sound');
     Application.terminate;
  end
end;

procedure TMainForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  {  Application end  }
  if Key=VK_ESCAPE then
    Close;

  if Key=VK_RETURN then
  begin
    if titleMode > 0 then
       dec(titleMode)
    else
        SendNow;
    key := 0;
  end;

  if Key=VK_F2 then
  begin
    if stage <> 4 then
    if (not GameNow) then
       begin
            if (stage = 0) then
            begin
                 Stage := 1;
                 controlPanel.Visible := true;
                 Letsbegin;
                 Edit1.Text := '';
            end;
       end;
  end;

if Key=VK_F4 then
  begin
    DXDraw.Finalize;

    if doFullScreen in DXDraw.Options then
    begin
      RestoreWindow;
      BorderStyle := bsSizeable;
      DXDraw.Options := DXDraw.Options - [doFullScreen];
    end else
    begin
      StoreWindow;
      BorderStyle := bsNone;
      DXDraw.Options := DXDraw.Options + [doFullScreen];
    end;
    DXDraw.Initialize;

  end;

if Key=VK_F5 then
  begin
       pnlf5.Color := clred;
       pnlf6.Color := clblack;
       pnlf7.Color := clblack;
       pnlf8.Color := clblack;
       pnlf9.Color := clblack;
       SpellMode := 1;
  end;

if Key=VK_F6 then
  begin
       pnlf6.Color := clred;
       pnlf5.Color := clblack;
       pnlf7.Color := clblack;
       pnlf8.Color := clblack;
       pnlf9.Color := clblack;
       SpellMode := 2;
  end;

if Key=VK_F7 then
  begin
       pnlf7.Color := clred;
       pnlf5.Color := clblack;
       pnlf6.Color := clblack;
       pnlf8.Color := clblack;
       pnlf9.Color := clblack;
       SpellMode := 3;
  end;

  if Key=VK_F8 then
  begin
       pnlf8.Color := clred;
       pnlf6.Color := clblack;
       pnlf7.Color := clblack;
       pnlf5.Color := clblack;
       pnlf9.Color := clblack;
       SpellMode := 4;
  end;

//  if Key=VK_F10 then
//  begin
//   if stage <> 0 then gameover := true;
//   WinScreen;
//  end;

  if (Key=VK_F9) and (pnlf9.visible)  then
  begin
       pnlf9.Color := clred;
       pnlf6.Color := clblack;
       pnlf7.Color := clblack;
       pnlf5.Color := clblack;
       pnlf8.Color := clblack;
       SpellMode := 5;
  end;

end;

procedure TMainForm.DXDrawMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin

//    if Not(gameNow) then
       if (X >= (MainForm.width - 84)) and (Y <= 25) then
          mouseIn := true
       else
           mouseIn := false;

       if ExitYesNo then
          begin
               if (x>=258) and (x<=288) and (y>=200) and (y<=218) then
                  MouseYes := true
               else
                   MouseYes := false;

               if (x>=355) and (x<=378) and (y>=200) and (y<=218) then
                  MouseNo := true
               else
                   MouseNo := false;
          end;

    mousex:= x;
    mousey:= y;
end;

procedure TMainForm.DXDrawMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
//Start the game
if (Not(GameNow)) and (MouseIn)and (button = mbLeft) then
   begin

        Stage := 1;
        controlPanel.Visible := true;
        Letsbegin;
        Edit1.Text := '';
        exit;
  end;

if (GameNow) and (Mousein)and (button = mbLeft) then
   begin
       ExityesNo := true;
       MouseNo := false;
       Mouseyes := false;
       exit;
  end;

if (ExityesNo) and (GameNow) and (MouseNo) and (button = mbLeft) then
   begin
       ExityesNo := false;
       exit;
  end;

if (ExityesNo) and (GameNow) and (MouseYes)and (button = mbLeft) then
   begin
       Close;
       exit;
  end;

if button = mbRight then
   mousecontrol := true;
if GameNow then
if button = mbLeft then
  begin
       if ((mana > 0) or (SpellMode = 5)) and (fireCount < 1) and (DDStop = False) then
       begin
            targetx := mousex;
            targety := mousey;
            if SpellMode <> 5 then
            Dec(Mana, SpellMode);
            ManaGauge.Progress := mana;
            if Mana < 25 then MainForm.ManaGauge.ForeColor := clred;
            if (Mana > 25) and (Mana < 75) then MainForm.ManaGauge.ForeColor := clyellow;
            if Mana > 75 then MainForm.ManaGauge.ForeColor := clLime;
            try
               with TFireBallSprite.Create(DXSpriteEngine.Engine) do
                 begin
                      firing:= true;
                      if FireCount < 0 then Firecount := 0;
                      inc(FireCount);
                      try
                      if SpellMode = 3 then
                         MainForm.DXWaveList.Items.Find('ebolt').Play(False);
                      except
                      end;
                      try
                      if (SpellMode = 5) and (Postal = false) then
                         MainForm.DXWaveList.Items.Find('rpg').Play(False);
                      except
                      end;
                      if SpellMode = 1 then
                      begin
                         try
                            MainForm.DXWaveList.Items.Find('fireball').Play(False);
                         except
                         end;
                         Image := MainForm.ImageList.Items.Find('fireballRight');
                         Width := Image.Width;
                         Height := Image.Height;
                         AnimStart := 0;
                         AnimCount := Image.PatternCount;
                         AnimLooped := true;
                         AnimPos:=0;
                         AnimSpeed := 14/1000;
                      end;

                      x := Fluffy.x;
                      y:= Fluffy.y;
                      Z := 10;
                      NewX:= Fluffy.x + (TargetX - 320);
                      NewY:= Fluffy.y + (TargetY- 240);
                 end;
            except
            end;
       end;
  end;

end;

procedure TMainForm.DXDrawMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
if button = mbRight then
mousecontrol := false;

end;

procedure TExplodeSprite.DoCollision(Sprite: TSprite; var Done: Boolean);
begin
  try
     if (Sprite is TMinorSprite)then
     begin
          TMinorSprite(Sprite).Hit;
     end;

     if (Sprite is TDummySprite)then
     begin
          TDummySprite(Sprite).Hit;
     end;

     if (Sprite is TBadGuySprite)then
     begin
          TBadGuySprite(Sprite).Hit;
     end;

     if (Sprite is TBritishSprite) and (bullseye= true) then
     begin
          bullseye := false;
          Speak.Hit;
          TBritishSprite(Sprite).Hit;
     end;

     if (Sprite is TDupreSprite) and (bullseye= true) then
     begin
          bullseye := false;
          TDupreSprite(Sprite).Hit;
     end;

     if (Sprite is TGuardsSprite) and (bullseye= true) then
     begin
          bullseye := false;
          TGuardsSprite(Sprite).Hit;
     end;
  except
    dead;
  end;
  Done := False;
end;

//procedure TBombSprite.DoCollision(Sprite: TSprite; var Done: Boolean);
//begin
//  Done := False;
//end;

procedure TFireBallSprite.DoCollision(Sprite: TSprite; var Done: Boolean);
begin
  if (Sprite is TBadGuySprite) or (Sprite is TMinorSprite) or (Sprite is TDummySprite) or (Sprite is TDDSprite) or (Sprite is TGuardsSprite)or (Sprite is TBritishSprite)or (Sprite is TDupreSprite)then
  begin
      firex:= x;
      firey:= y;
      centerx:= (width / 2);
      centery:= (height / 2);
      try
         if (SpellMode = 1) or (SpellMode = 3)  or (SpellMode = 5) then
         with TExplodeSprite.Create(MainForm.DXSpriteEngine.Engine) do
         begin
              dec(FireCount);
              try
                 MainForm.DXWaveList.Items.Find('explode').Play(False);
              except
              end;
              Image := MainForm.ImageList.Items.Find('Explode');
              Width := Image.Width;
              Height := Image.Height;
              AnimStart := 0;
              AnimCount := Image.PatternCount;
              AnimLooped := true;
              AnimPos:=0;
              AnimSpeed := 14/1000;

              x := firex - ((width /2)- centerx);
              y:= firey -((height /2)- centery);
              Z := 10;
         end;
      finally
             dead;
             if FireCount > 0 then dec(FireCount);
      end;

      try
         if (Sprite is TBadGuySprite)then
            TBadGuySprite(Sprite).Hit;

         if (Sprite is TMinorSprite)then
            TMinorSprite(Sprite).Hit;

         if (Sprite is TDummySprite)then
            TDummySprite(Sprite).Hit;

         if (Sprite is TDDSprite)then
            TDDSprite(Sprite).Hit;

         if (Sprite is TGuardsSprite)then
            TGuardsSprite(Sprite).Hit;

         if (Sprite is TBritishSprite)then
            begin
                 TBritishSprite(Sprite).Hit;
                 Speak.Hit;
            end;

         if (Sprite is TDupreSprite)then
            TDupreSprite(Sprite).Hit;
      except
      end;
  end;
  Done := False;
end;

procedure TPotionSprite.DoCollision(Sprite: TSprite; var Done: Boolean);
begin
  if (Sprite is TChickenSprite)then
  begin
      Potionx:= x;
      Potiony:= y;
      Pcenterx:= (width / 2);
      Pcentery:= (height / 2);
     try
        with TBombSprite.Create(MainForm.DXSpriteEngine.Engine) do
          begin
               try
                  MainForm.DXWaveList.Items.Find('explode').Play(false);
               except
               end;
               Image := MainForm.ImageList.Items.Find('Explode');
               Width := Image.Width;
               Height := Image.Height;
               AnimStart := 0;
               AnimCount := Image.PatternCount;
               AnimLooped := true;
               AnimPos:=0;
               AnimSpeed := 14/1000;

               x := Potionx - ((width /2)- Pcenterx);
               y:= Potiony -((height /2)- Pcentery);
               Z := 10;
          end;
     finally
        Dead;
     end;
  end;
  Done := False;
end;

procedure TFireBallSprite.DoMove(MoveCount: Integer);
var
test: boolean;
xpos:boolean;
ypos:boolean;
xneg:boolean;
yneg:boolean;
begin
Test:= false;
xpos:= false;
ypos:= false;
xneg:= false;
yneg:= false;
  inherited DoMove(MoveCount);
       //Explosion or Flame strike
       if (SpellMode = 2) or (SpellMode = 4) then
         begin
            try
               with TExplodeSprite.Create(MainForm.DXSpriteEngine.Engine) do
                 begin
                      dec(FireCount);
                      try
                         MainForm.DXWaveList.Items.Find('explode').Play(False);
                      except
                      end;

                      if spellMode = 2 then
                         Image := MainForm.ImageList.Items.Find('Explode');

                      if SpellMode = 4 then
                         Image := MainForm.ImageList.Items.Find('flamestrike');

                      Width := Image.Width;
                      Height := Image.Height;
                      AnimStart := 0;
                      AnimCount := Image.PatternCount;
                      AnimLooped := true;
                      AnimPos:=0;
                      AnimSpeed := 14/1000;

                      x := Newx;

                      if spellMode = 2 then
                         y:= Newy
                      else
                         y := Newy - 60;

                      Z := 10;

                 end;
            finally
              Dead;
              if FireCount > 0 then dec(FireCount);
            end;
              exit;
         end;

//Fireball or Ebolt
  Try
         if targetx > 320 then
            if x < newX then
               begin
                    if (SpellMode = 5) and (Postal = true) then
                       x := x+(8)
                    else
                       x := x+(18);
                    Test:= true;
                    xpos := true;
               end;

         if targetx < 320 then
            if x > newX then
               begin
                    if (SpellMode = 5) and (Postal = true) then
                        x := x-(8)
                    else
                        x := x-(18);
                    xneg := true;
                    Test:= true;
               end;

         if targety > 240 then
            if y < newy then
               begin
                    if (SpellMode = 5) and (Postal = true) then
                        y := y+(8)
                    else
                        y := y+(18);
                    Test:= true;
                    ypos := true;
               end;

         if targety < 240 then
            if y > newy then
               begin
                    if (SpellMode = 5) and (Postal = true) then
                       y := y-(8)
                    else
                        y := y-(18);
                    Test:= true;
                    yneg := true;
               end;
 except
 end;

 try
    if (SpellMode = 5) and (Postal = true) then
       Image := MainForm.ImageList.Items.Find('potion');

    if (xpos = true) and (ypos = false) and (yneg = false)then
    begin
         if SpellMode = 1 then
            Image := MainForm.ImageList.Items.Find('fireballright');
         if SpellMode = 3 then
            Image := MainForm.ImageList.Items.Find('boltlr');

         if (SpellMode = 5) and (Postal = false) then
            Image := MainForm.ImageList.Items.Find('rpgright');
    end;

    if (xpos = true) and (ypos = true) and (yneg = false)then
    begin
         if SpellMode = 1 then
            Image := MainForm.ImageList.Items.Find('downright');
         if SpellMode = 3 then
            Image := MainForm.ImageList.Items.Find('boltlr');
         if (SpellMode = 5) and (Postal = false) then
            Image := MainForm.ImageList.Items.Find('rpgdownright');
   end;

   if (xpos = true) and (ypos = false) and (yneg = true)then
   begin
        if SpellMode = 1 then
           Image := MainForm.ImageList.Items.Find('upright');
        if SpellMode = 3 then
           Image := MainForm.ImageList.Items.Find('boltud');
        if (SpellMode = 5) and (Postal = false) then
           Image := MainForm.ImageList.Items.Find('rpgupright');
   end;

   if (xneg = true) and (ypos = false) and (yneg = false)then
   begin
        if SpellMode = 1 then
           Image := MainForm.ImageList.Items.Find('fireballleft');
        if SpellMode = 3 then
           Image := MainForm.ImageList.Items.Find('boltlr');
        if (SpellMode = 5) and (Postal = false) then
           Image := MainForm.ImageList.Items.Find('rpgleft');
   end;

   if (xneg = true) and (ypos = true) and (yneg = false)then
   begin
        if SpellMode = 1 then
           Image := MainForm.ImageList.Items.Find('downleft');

        if SpellMode = 3 then
           Image := MainForm.ImageList.Items.Find('boltlr');
        if (SpellMode = 5) and (Postal = false) then
           Image := MainForm.ImageList.Items.Find('rpgdownleft');
   end;

   if (xneg = true) and (ypos = false) and (yneg = true)then
   begin
        if SpellMode = 1 then
           Image := MainForm.ImageList.Items.Find('upleft');
        if SpellMode = 3 then
           Image := MainForm.ImageList.Items.Find('boltud');
        if (SpellMode = 5) and (Postal = false) then
           Image := MainForm.ImageList.Items.Find('rpgupleft');

   end;

   if (ypos = true) and (xpos = false) and (xneg = false)then
   begin
        if SpellMode = 1 then
           Image := MainForm.ImageList.Items.Find('fireballdown');
        if SpellMode = 3 then
           Image := MainForm.ImageList.Items.Find('boltud');
        if (SpellMode = 5) and (Postal = false) then
           Image := MainForm.ImageList.Items.Find('rpgdown');
   end;

   if (yneg = true) and (xpos = false) and (xneg = false)then
   begin
        if SpellMode = 1 then
           Image := MainForm.ImageList.Items.Find('fireballup');
        if SpellMode = 3 then
           Image := MainForm.ImageList.Items.Find('boltud');
        if (SpellMode = 5) and (Postal = false) then
           Image := MainForm.ImageList.Items.Find('rpgup');
   end;
 except
 end;

        if test = false then
        begin
            firex:= x;
            firey:= y;
            try
               with TExplodeSprite.Create(MainForm.DXSpriteEngine.Engine) do
               begin
                    dec(FireCount);
                    try
                       MainForm.DXWaveList.Items.Find('explode').Play(False);
                    except
                    end;
                    Image := MainForm.ImageList.Items.Find('Explode');
                    Width := Image.Width;
                    Height := Image.Height;
                    AnimStart := 0;
                    AnimCount := Image.PatternCount;
                    AnimLooped := true;
                    AnimPos:=0;
                    AnimSpeed := 14/1000;
                    x := firex;
                    y:= firey;
                    Z := 10;
               end;
            finally
                   dead;
             if FireCount > 0 then dec(FireCount);

            end;
        end;

 try
  if targetx > 320 then
  begin
      if X > Fluffy.x+320 then
      begin
         dec(fireCount);
         Dead;
         firing:= false;
         exit;
      end;
  end;

  if targetx < 320 then
  begin
       if X < Fluffy.x-320 then
       begin

         dec(fireCount);
         Dead;
         firing:= false;
         exit;
      end;
  end;

    if targety > 240 then
  begin
      if y > Fluffy.y+240 then
      begin

         dec(fireCount);
         Dead;
         firing:= false;
         exit;
      end;
  end;

  if targety < 240 then
  begin
       if y < Fluffy.y-240 then
       begin

         dec(fireCount);
         Dead;
         firing:= false;
         exit;

      end;
  end;
  except
       dec(fireCount);
       Dead;
       firing:= false;
  end;

  Collision;
end;

procedure TPotionSprite.DoMove(MoveCount: Integer);
var
BoomX : double;
BoomY : double;
begin

  inherited DoMove(MoveCount);
  if GameOver then Dead;
  if x < PotionTargetX then
     x := x + 5;

  if x > potionTargetX then
     X := x - 5;

  if y < PotionTargetY then
     Y := y + 5;

  if y > PotionTargetY then
     Y := y - 5;

     if ((x < PotionTargetX + 15) and(x > PotionTargetx - 10)) and ((y < PotionTargety + 10) and(y > PotionTargety - 10)) then
          begin
               Boomx:= x;
               Boomy:= y;
               try
                  with TBombSprite.Create(MainForm.DXSpriteEngine.Engine) do
                  begin
                       try
                          MainForm.DXWaveList.Items.Find('explode').Play(False);
                       except
                       end;

                       Image := MainForm.ImageList.Items.Find('Explode');
                       Width := Image.Width;
                       Height := Image.Height;
                       AnimStart := 0;
                       AnimCount := Image.PatternCount;
                       AnimLooped := true;
                       AnimPos:=0;
                       AnimSpeed := 14/1000;
                       x := Boomx;
                       y:= Boomy;
                       Z := 10;
                  end;
               finally
                   dead;
               end;
       end;

  Collision;
end;


procedure TMainForm.SendNow;
begin
    //hmm.. now what was all this for again??
    //CleanUp
    Cheats := Edit1.text;
    if (Cheats = 'GoPostal') and (Stage <> 0) then
       begin
            if random(2) > 0 then
            postal := false
            else
            postal := true;
            pnlf9.visible := true;
       end;
    if (Cheats = 'NoPlaceLikeHome') and (Stage <> 0) then
       begin
            Fluffy.X := 1250;
            Fluffy.Y := 1250;
       end;

    if (cheats = 'Credits') and (Stage <> 0) then
      begin
           gameover := true;
           winScreen;
      end;


    player1Says := edit1.text;
    Edit1.Text := '';
    ShowText:= '';
end;

procedure TMainForm.Edit1Change(Sender: TObject);
begin
     Showtext:= edit1.text;
end;

procedure TMainForm.letsBegin;
begin
       try
          if MainForm.MidiData1.Active then
             begin
                  MainForm.MidiPlayer1.Play := false;
             end;
          MainForm.closeMidiFile;
          MainForm.MidiPlayer1.Rewind;
          MainForm.OpenMidiFile(Extractfilepath(Application.exename) + 'game.mid');
          if MainForm.MidiData1.Active then
             begin
                  MainForm.MidiPlayer1.Play := True
             end;
      except
      end;

  Gamenow := true;
  GameOver := false;
  firecount := 0;

  DXDraw.Cursor := crDefault;

  if Stage = 1 then
     begin
          CreateStandingStage1(1);
          CreateStandingStage2(5);
          CreateMoving(24);
     end;

  if Stage = 2 then
     begin
          CreateStandingStage1(1);
          CreateStandingStage2(6);
          CreateMoving(28);
          GuardTimer.enabled := true;
          if Not(GotGraves) then
          begin
               CreateGraves(25);
               GotGraves := true;
          end;
     end;

  if Stage = 3 then
     begin
          //TheDead(20);
     end;

  if stage = 1 then
     begin
          try
             Fluffy := TChickenSprite.Create(DXSpriteEngine.Engine);
             with Fluffy do
             begin
                  Image := ImageList.Items.Find('img2-3');
                  Z := 3;
                  Width := Image.Width;
                  Height := Image.Height;
                  AnimStart := 0;
                  AnimCount := Image.PatternCount;
                  AnimLooped := true;
                  AnimPos:=0;
                  AnimSpeed := 15/1000;
                  x := 1250;
                  y := 1250;
             end;
          except
                DXDraw.Finalize;
                DXSound.Finalize;
                closeMidiFile;
                Showmessage('Fluffy is a little busy right now come back later');
                Application.terminate;
          end;
     end;


end;

procedure TMainForm.TitleScreen;
begin
 case TitleMode of
    -1: //game over
        begin
           DXDraw.Surface.Fill(0);
           ImageList2.Items[17].DrawAdd(DXDraw.Surface, Bounds((MainForm.Width - 190) div 2{left}, 190{top}, 190{width}, 40 {height}),
                                       0,FRFIFade);
              if MouseIn then
                  ImageList2.Items[7].Draw(DXDraw.Surface,(MainForm.width - 75), 10,   0)
              else
                  ImageList2.Items[6].Draw(DXDraw.Surface,(MainForm.width - 75), 10,   0);
           if FRFIFade < 254 then
           Inc(FRFIFAde, 1);


        end;
     0: //ready to play
       begin
           DXDraw.Surface.Fill(0);
           //Fluffy3
           ImageList2.Items[3].DrawAdd(DXDraw.Surface, Bounds((MainForm.Width - 335) div 2{left}, 90{top}, 335{width}, 92 {height}),
                                       0,FRFIFade);
           //Killing is my business
           ImageList2.Items[4].DrawAdd(DXDraw.Surface, Bounds((MainForm.Width - 325) div 2{left}, 190{top}, 325{width}, 54{height}),
                                       0,FKil1Fade);
           //business is good
           ImageList2.Items[5].DrawAdd(DXDraw.Surface, Bounds((MainForm.Width - 325) div 2{left}, 250{top}, 326{width}, 46 {height}),
                                       0,FKil2Fade);

           if FRFIFade < 254 then
              Inc(FRFIFAde, 2);

           if (FRFIFade > 125) and (FKil1Fade < 254)then
             Inc(FKil1Fade, 2);

           if (FKil1Fade > 125) and (FKil2Fade < 254) then
             Inc(FKil2Fade, 2);

           if fKil2Fade > 100 then
           DXDraw.Cursor := crDefault;

           if fKil2Fade > 100 then
           inc(credits);

           if fKil2Fade > 100 then
              if MouseIn then
                  ImageList2.Items[7].Draw(DXDraw.Surface,(MainForm.width - 75), 10,   0)
              else
                  ImageList2.Items[6].Draw(DXDraw.Surface,(MainForm.width - 75), 10,   0);

           if fKil2Fade > 100 then
           with DXDraw.Surface.Canvas do
              begin


                  Brush.Style := bsClear;
                  Font.Color := clWhite;
                  Font.Size := 12;
                  Font.Style := [];
                //  Textout(5,0, 'Press F2 to play');
                  Font.Style := [fsBold];
                  font.color := clBlue;

                  if (credits > 0) and (credits < 150)then
                  begin
                       font.size := 10;
                       Textout(75,360, 'Starring...');
                       font.size := 12;
                       Textout(75,380, 'Lord British          as        a  rotting  corpse');
                    //   Textout(75,400, 'Lord Blackthorn   as    a  headless');

                  end;

                  if (credits > 175) and (credits < 325)then
                  begin
                       font.size := 10;
                       Textout(75,360, 'Also Starring...');
                       font.size := 12;
                       Textout(75,380, 'Lord Dupre      as     the  mad  bomber');
                       //Textout(75,380, 'Designer Dragon      as     "dead meat"');
                  end;

                  if (credits > 350) and (credits < 500)then
                  begin
                       font.size := 10;
                       Textout(75,360, 'With Special Guest...');
                       font.size := 12;
                       Textout(75,380, 'ImaNewbie     as     a  training  dummy');
                  end;

                 Release;
              end;
       end;
     1: //Myra
       begin
           DXDraw.Surface.Fill(0);

           ImageList2.Items[2].DrawAdd(DXDraw.Surface, Bounds((MainForm.Width - 321) div 2{left}, 100{top}, 321{width}, 180 {height}),
               0, FRFIFAde);

           if FRFIFade = 254 then
              GoingUp := false;

           if FRFIFade = 0 then
              begin
                   FRFIFade := 8;
                   goingUp := true;
                   dec(TitleMode);
              end;
           if GoingUP then
              Inc(FRFIFAde, 2)
           else
              dec(FRFIFade, 2);


       end;

     2: //UOE Production
       begin
           DXDraw.Surface.Fill(0);

           ImageList2.Items[1].DrawAdd(DXDraw.Surface, Bounds((MainForm.Width - 417) div 2{left}, 100{top}, 417{width}, 257 {height}),
               0,FRFIFade);

           if FRFIFade > 249 then
              GoingUp := false;

           if FRFIFade < 6  then
              begin
                   FRFIFade := 8;
                   GoingUp := true;
                   dec(TitleMode);
              end;
           if GoingUP then
              Inc(FRFIFAde, 6)
           else
               dec(FRFIFade, 6);

       end;
     3://RFI
       begin
           DXDraw.Surface.Fill(0);

           ImageList2.Items[0].DrawAdd(DXDraw.Surface, Bounds((MainForm.Width - 471) div 2{left}, 150{top}, 471{width}, 140 {height}),
               0, FRFIFAde);

           if FRFIFade = 254 then
              GoingUp := false;

           if FRFIFade = 0 then
              begin
                   FRFIFade := 8;
                   goingUp := true;
                   dec(TitleMode);
              end;
           if GoingUP then
              Inc(FRFIFAde, 2)
           else
              dec(FRFIFade, 2);

       end;
     4:
       begin
            dec(TitleMode);
            if MidiData1.Active then
            begin
                  MidiPlayer1.Play := True
            end;
      end;
   end;//case titlemode of




end;

procedure TMainForm.WinScreen;
begin
   try
      if Stage <> 0 then
      begin
           Fluffy.dead;
           GameOver := true;
           resetGame;
           Cheats := '';
           player1Says := '';
      end;

        DXTimer.enabled := false;
        DXDraw.Visible := false;
        DXDraw.Cursor := crNone;
      //  ScrollingTextBmp1.visible := true;
     //   ScrollingTextBmp1.Cursor := crNone;
     //   ScrollingTextBmp1.StartScroll;
   except
        DXDraw.Finalize;
        DXSound.Finalize;
        closeMidiFile;
        Application.terminate;
   end;

   try
      if MidiData1.Active then
         MidiPlayer1.Play := false;
      closeMidiFile;
      MidiPlayer1.Rewind;
      OpenMidiFile(Extractfilepath(Application.exename) + 'credits.mid');
      if MidiData1.Active then
         MidiPlayer1.Play := True
   except
   end;
end;

procedure TMainForm.Limbo;
begin
   try
     DXDraw.Surface.Fill(0);

     {  ON screen text  }
     with DXDraw.Surface.Canvas do
          begin
               Brush.Style := bsClear;
               Font.Color := clWhite;
               Font.Size := 12;
               Font.Style := [];
               Textout(150, 200, 'After the death defying battle with the mad bomber');
               Textout(150, 225, 'Fluffy goes to visit his faithful pet...');

               Release;
          end;

   except
   end;
end;


procedure TMainForm.OnScreenText;
begin
     {  ON screen text  }
     with DXDraw.Surface.Canvas do
          begin
               Brush.Style := bsClear;
               Font.Color := clWhite;
               Font.Size := 12;
               Font.Style := [];

               if ExitYesNo then
                   begin
                        ImageList2.Items[12].Draw(DXDraw.Surface,((MainForm.width div 2) - 65), 160,   0);
                      if MouseYes then
                         ImageList2.Items[16].Draw(DXDraw.Surface,((MainForm.width div 2) - 65), 200,   0)
                      else
                         ImageList2.Items[15].Draw(DXDraw.Surface,((MainForm.width div 2) - 65), 200,   0);

                      if MouseNo then
                         ImageList2.Items[14].Draw(DXDraw.Surface,((MainForm.width div 2)+30), 200,   0)
                      else
                         ImageList2.Items[13].Draw(DXDraw.Surface,((MainForm.width div 2) + 30), 200,   0);
                    end;



                     if LvlFade > 0 then
                     begin
                          If stage = 1 then
                          ImageList2.Items[10].DrawAdd(DXDraw.Surface, Bounds((MainForm.Width - 168) div 2{left}, 150{top}, 168{width}, 57{height}),
                                                 0,LvlFade);
                          If stage = 2 then
                          ImageList2.Items[11].DrawAdd(DXDraw.Surface, Bounds((MainForm.Width - 168) div 2{left}, 150{top}, 168{width}, 57{height}),
                                                 0,LvlFade);

                          Dec(LvlFade,2)
                     end;

                      if MouseIn then
                         ImageList2.Items[9].Draw(DXDraw.Surface,(MainForm.width - 60), 0,   0)
                      else
                          ImageList2.Items[8].Draw(DXDraw.Surface,(MainForm.width - 60), 0,   0);

                      Textout(5, 0, 'PuNkAsS NeWbIeS left: '+inttostr(StandingCount + MovingCount));

                    //  Textout(5, 25, 'FireCount: '+inttostr(fireCount));


                 Font.Style := [fsBold];
                 Font.Color := clRed;
                 Font.Size := 8;

               if firing then
                  begin
                       case SpellMode of
                            1:
                              Textout(295, 180, 'Vas Flam');
                            3:
                             Textout(295, 180, 'Corp Por');
                            2:
                             Textout(285, 180, 'Vas Ort Flam');
                            4:
                             Textout(285, 180, 'Kal Vas Flam');
                       end;
                  end
               else

               if Showtext <> '' then Textout(5,400, ShowText);

               if Stage = 3 then
               begin
                    Font.Color := SpeakColor;
                    Textout(250, 140, FluffySays1);
                    Textout(250, 160, FluffySays2);
                    Textout(415, 60, DDSays1);
                    Textout(415, 80, DDSays2);

               end;



               Release;
          end;
end;

procedure TMainForm.CreateTrees(numb:Integer);
var
i: integer;
rd: integer;
begin
  for i:=0 to Numb -1 do

      With TTreeSprite.Create(DXSpriteEngine.Engine) do
           begin
              rd := Random(4);
              case rd of
                  0: Image := ImageList.Items.Find('tree1');
                  1: Image := ImageList.Items.Find('tree2');
                  2: Image := ImageList.Items.Find('tree3');
                  3: Image := ImageList.Items.Find('tree4');
              end;

                X := Random(2400);//-1250;
                Y := Random(2400);//-1250;
                Z := 3;
                Width := Image.Width;
                Height := Image.Height;
           end;

end;

procedure TMainForm.CreateGraves(numb:Integer);
var
i: integer;
rd: integer;
ljX: double;
ljY: double;

begin

  for i:=0 to 8 do
  begin
      With TTreeSprite.Create(DXSpriteEngine.Engine) do
           begin
                Image := ImageList.Items.Find('deadgm');
                X := Random(2400);//-1250;
                Y := Random(2400);//-1250;
                ljx := x;
                ljy := y;
                Z := 2;
                Width := Image.Width;
                Height := Image.Height;
           end;

      With TTreeSprite.Create(DXSpriteEngine.Engine) do
           begin
                case i of
                     0:
                       Image := ImageList2.Items.Find('Jakarta');
                     1:
                       Image := ImageList2.Items.Find('Boo');
                     2:
                       Image := ImageList2.Items.Find('Darwin');
                     3:
                       Image := ImageList2.Items.Find('Ghostpig');
                     4:
                       Image := ImageList2.Items.Find('Beast');
                     5:
                       Image := ImageList2.Items.Find('Squishy');
                     6:
                       Image := ImageList2.Items.Find('Goatboy');
                     7:
                       Image := ImageList2.Items.Find('Gabriel');
                     8:
                       Image := ImageList2.Items.Find('Lonestar');


                end;
                if i = 2 then
                begin
                    X := ljx - 20;
                    Y := ljy - 35;
                    Z := 1;
                end
                else
                  begin
                       X := ljx;
                       Y := ljy - 5;
                       Z := 4;
                  end;
                Width := Image.Width;
                Height := Image.Height;
           end;


end;

//  TreeCount:= Numb;
  for i:=0 to Numb -1 do

      With TTreeSprite.Create(DXSpriteEngine.Engine) do
           begin
              rd := Random(4);
              case rd of
                 // 0: Image := ImageList.Items.Find('tree');
                  0: Image := ImageList.Items.Find('grave1');
                  1: Image := ImageList.Items.Find('grave2');
                  2: Image := ImageList.Items.Find('grave3');
                  3: Image := ImageList.Items.Find('deadcounc');

              end;
                X := Random(2500);//-1250;
                Y := Random(2500);//-1250;
                Z := 2;
                Width := Image.Width;
                Height := Image.Height;
           end;



      With TTreeSprite.Create(DXSpriteEngine.Engine) do
           begin
                Image := ImageList.Items.Find('britishdead');
                X := Random(2400);//-1250;
                Y := Random(2400);//-1250;
                Z := 2;
                Width := Image.Width;
                Height := Image.Height;
           end;

      With TTreeSprite.Create(DXSpriteEngine.Engine) do
           begin
                Image := ImageList.Items.Find('blackthorndead');
                X := Random(2400);//-1250;
                Y := Random(2400);//-1250;
                Z := 2;
                Width := Image.Width;
                Height := Image.Height;
           end;
end;

procedure TMainForm.CreateStandingStage2(numb:Integer);
var
i : Integer;
ljX: double;
ljY: double;
begin
  //  Randomize;
  StandingCount:= StandingCount + Numb;
  if Stage = 1 then
  for i:=0 to Numb -1 do
      with TMinorSprite.Create(DXSpriteEngine.Engine) do
           begin
                Image := ImageList.Items.Find('minor');
                Width := Image.Width;
                Height := Image.Height;
                AnimStart := 0;
                AnimCount := Image.PatternCount;
                AnimLooped := true;
                AnimPos:=0;
                AnimSpeed := 2/1000;

                X := Random(1600);//-800;
                Y := Random(1600);//-800;
                Z := 3;
                Width := Image.Width;
                Height := Image.Height;
           end;


  if Stage = 2 then
  for i:=0 to Numb -1 do
      with TMinorSprite.Create(DXSpriteEngine.Engine) do
           begin
                Image := ImageList.Items.Find('lumberjack');
                Width := Image.Width;
                Height := Image.Height;
                AnimStart := 0;
                AnimCount := Image.PatternCount;
                AnimLooped := true;
                AnimPos:=0;
                AnimSpeed := 4/1000;

                X := Random(1600);//-800;
                Y := Random(1600);//-800;
                ljx := x;
                ljy := y;
                Z := 4;
                Width := Image.Width;
                Height := Image.Height;

                With TTreeSprite.Create(DXSpriteEngine.Engine) do
                begin
                     Image := ImageList.Items.Find('tree3');
                     X := ljx - 50;
                     Y := ljy - 80;
                     Z := 3;
                     Width := Image.Width;
                     Height := Image.Height;
                end;
           end;

end;

procedure TMainForm.TheDead(numb:Integer);
var
i : Integer;
rd: Integer;
begin
  //nonmoving coprse
  for i:=0 to ((Numb -1) div 2) do
      With TTreeSprite.Create(DXSpriteEngine.Engine) do
           begin
                rd := Random(2);
                     if rd = 0 then
                        Image := ImageList.Items.Find('Img1-2');
                     if rd = 1 then
                        Image := ImageList.Items.Find('gmdead');

                 X := Fluffy.x - Random(25)-125;
                 Y := Fluffy.y - Random(25)-125;
                Z := 3;
                Width := Image.Width;
                Height := Image.Height;
           end;


  for i:=0 to ((Numb -1) div 2) do

      With TTreeSprite.Create(DXSpriteEngine.Engine) do
           begin
                rd := Random(2);
                     if rd = 0 then
                        Image := ImageList.Items.Find('Img1-2');
                     if rd = 1 then
                        Image := ImageList.Items.Find('gmdead');

                X := Fluffy.x + Random(25)+125;
                Y := Fluffy.y + Random(25)+125;
                Z := 3;
                Width := Image.Width;
                Height := Image.Height;
           end;

     with TTreeSprite.Create(DXSpriteEngine.Engine) do
           begin
                Image := ImageList.Items.Find('BritishDead');
                X := Fluffy.x + 150;
                Y := Fluffy.y - 150;
                 Z := 3;
                Width := Image.Width;
                Height := Image.Height;
           end;

     with TTreeSprite.Create(DXSpriteEngine.Engine) do
           begin
                Image := ImageList.Items.Find('BlackThornDead');
                X := Fluffy.x - 150;
                Y := Fluffy.y + 150;
                Z := 3;
                Width := Image.Width;
                Height := Image.Height;
           end;



end;

procedure TMainForm.CreateStandingStage1(numb:Integer);
var
i : Integer;
begin
//nonmoving blue guys
//Randomize;
StandingCount := Numb;
  for i:=0 to Numb -1 do
   with TDummySprite.Create(MainForm.DXSpriteEngine.Engine) do
        begin
             Image := MainForm.ImageList.Items.Find('newbiedummy');
             Width := Image.Width;
             Height := Image.Height;
             AnimStart := 0;
             AnimCount := Image.PatternCount;
             AnimLooped := true;
             AnimPos:=0;
             AnimSpeed := 3/1000;
             X := Random(1600);//-800;
             Y := Random(1600);//-800;
             Z := 3;
        end;



end;

procedure TMainForm.CreateMoving(numb: Integer);
var
i: integer;
begin
//moving blue guys
MovingCount := Numb;
if Stage = 1 then
begin
  for i:=0 to (numb div 4) - 1 do
    with TBadGuySprite.Create(DXSpriteEngine.Engine) do
    begin
      Image := ImageList.Items.Find('newbie1');
      X := Random(1800);//-900;
      Y := Random(1800);//-900;
      Z := 2;
      Width := Image.Width;
      Height := Image.Height;
      FCounter := Random(MaxInt);
    end;

    for i:=0 to (numb div 4) - 1 do
    with TBadGuySprite.Create(DXSpriteEngine.Engine) do
    begin

      Image := ImageList.Items.Find('newbie2');

      X := Random(1800);//-900;
      Y := Random(1800);//-900;
      Z := 2;
      Width := Image.Width;
      Height := Image.Height;
      FCounter := Random(MaxInt);
    end;

  for i:=0 to (numb div 4) - 1 do
    with TBadGuySprite.Create(DXSpriteEngine.Engine) do
    begin
      Image := ImageList.Items.Find('newbie3');
      X := Random(1800);//-900;
      Y := Random(1800);//-900;
      Z := 2;
      Width := Image.Width;
      Height := Image.Height;
      FCounter := Random(MaxInt);
    end;

  for i:=0 to (numb div 4) - 1 do
    with TBadGuySprite.Create(DXSpriteEngine.Engine) do
    begin

      Image := ImageList.Items.Find('newbie4');
      X := Random(1800);//-900;
      Y := Random(1800);//-900;
      Z := 2;
      Width := Image.Width;
      Height := Image.Height;
      FCounter := Random(MaxInt);
    end;
end;

if stage = 2 then
begin
  for i:=0 to (numb div 7) - 1 do
    with TBadGuySprite.Create(DXSpriteEngine.Engine) do
    begin

      Image := ImageList.Items.Find('newbie5');
      X := Random(1800);//-900;
      Y := Random(1800);//-900;
      Z := 2;
      Width := Image.Width;
      Height := Image.Height;
      FCounter := Random(MaxInt);
    end;

  for i:=0 to (numb div 7) - 1 do
    with TBadGuySprite.Create(DXSpriteEngine.Engine) do
    begin

      Image := ImageList.Items.Find('newbie6');
      X := Random(1800);//-900;
      Y := Random(1800);//-900;
      Z := 2;
      Width := Image.Width;
      Height := Image.Height;
      FCounter := Random(MaxInt);
    end;
  for i:=0 to (numb div 7) - 1 do
    with TBadGuySprite.Create(DXSpriteEngine.Engine) do
    begin

      Image := ImageList.Items.Find('newbie7');
      X := Random(1800);//-900;
      Y := Random(1800);//-900;
      Z := 2;
      Width := Image.Width;
      Height := Image.Height;
      FCounter := Random(MaxInt);
    end;

  for i:=0 to (numb div 7) - 1 do
    with TBadGuySprite.Create(DXSpriteEngine.Engine) do
    begin

      Image := ImageList.Items.Find('newbie3');
      X := Random(1800);//-900;
      Y := Random(1800);//-900;
      Z := 2;
      Width := Image.Width;
      Height := Image.Height;
      FCounter := Random(MaxInt);
    end;

  for i:=0 to (numb div 7) - 1 do
    with TBadGuySprite.Create(DXSpriteEngine.Engine) do
    begin

      Image := ImageList.Items.Find('newbie1');
      X := Random(1800);//-900;
      Y := Random(1800);//-900;
      Z := 2;
      Width := Image.Width;
      Height := Image.Height;
      FCounter := Random(MaxInt);
    end;
  for i:=0 to (numb div 7) - 1 do
    with TBadGuySprite.Create(DXSpriteEngine.Engine) do
    begin

      Image := ImageList.Items.Find('newbie2');
      X := Random(1800);//-900;
      Y := Random(1800);//-900;
      Z := 2;
      Width := Image.Width;
      Height := Image.Height;
      FCounter := Random(MaxInt);
    end;
    for i:=0 to (numb div 7) - 1 do
    with TBadGuySprite.Create(DXSpriteEngine.Engine) do
    begin

      Image := ImageList.Items.Find('newbie4');
      X := Random(1800);//-900;
      Y := Random(1800);//-900;
      Z := 2;
      Width := Image.Width;
      Height := Image.Height;
      FCounter := Random(MaxInt);
    end;
end;


end;

//introducing Designer Dragon himself Raph Koster the lead designer for Ultima Online
procedure TMainForm.CreateDD;
begin
     DDExists := true;
     FireCount := 1;
     FluffyFreeze := true;
     DDragon := TDDSprite.Create(MainForm.DXSpriteEngine.Engine);
     with DDragon do
          begin
               Image := MainForm.ImageList.Items.Find('DDragon');
               Width := Image.Width;
               Height := Image.Height;
               x := Fluffy.x + 130;
               y := Fluffy.y - 100;
               z := 4;
          end;
end;

procedure TMainForm.CreateBritish;
begin
     BritishExists := True;
     with TBritishSprite.Create(MainForm.DXSpriteEngine.Engine) do
          begin
               Image := MainForm.ImageList.Items.Find('boss1.0');
               Width := Image.Width;
               Height := Image.Height;
               x := Fluffy.x;
               y := Fluffy.y - 120;
               z := 4;
               HitPoints := 40;
          end;
     Speak := TSpeakSprite.Create(MainForm.DXSpriteEngine.Engine);
     with Speak do
          begin
               Image := MainForm.ImageList2.Items.Find('releaseme');
               Width := Image.Width;
               Height := Image.Height;
               x := Fluffy.x - 80;
               y := Fluffy.y - 160;
               z := 4;
               HitPoints := 40;
          end;

end;

procedure TMainForm.CreateDupre;
begin
     SteelWolf.Collisioned := false;
     DupreExists := True;
//   Speak.dead;
     with TDupreSprite.Create(MainForm.DXSpriteEngine.Engine) do
          begin
               Image := MainForm.ImageList.Items.Find('duprebomb');
               Width := Image.Width;
               Height := Image.Height;
               AnimStart := 0;
               AnimCount := Image.PatternCount;
               AnimLooped := true;
               AnimPos:=0;
               AnimSpeed := 10/1000;
               x := Fluffy.x;
               y := Fluffy.y - 120;
               z := 4;
               HitPoints := 100;
          end;
end;

procedure TMainForm.CreateGuards;
begin
     GuardsExists := true;
     try
        MainForm.DXWaveList.Items.Find('teleport').Play(False);
     except
     end;
     SteelWolf := TGuardsSprite.Create(MainForm.DXSpriteEngine.Engine);
     with SteelWolf do
          begin
               Image := MainForm.ImageList.Items.Find('Guardstand');
               Width := Image.Width;
               Height := Image.Height;
               x := Fluffy.x - 120;
               y := Fluffy.y - 50;
               z := 4;
               HitPoints := 4;
               PixelCheck := True;
          end;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
     Try
        fMidiPosition := TMidiPosition.Create (self);
        fMidiPosition.MidiData := MidiData1;
        OpenMidiFile(Extractfilepath(Application.exename) + 'Intro.mid');
        //OpenMidiFile(Extractfilepath(Application.exename) + 'anti_christ_superstar.mid');
//        if MidiData1.Active then
//           begin
//                MidiPlayer1.Play := True
//           end;
     except
     end;

end;

procedure TMainForm.OpenMidiFile (const FileName : string);
begin
  MidiData1.FileName := FileName;
  MidiData1.Active := True;
  TrackOutputs1.Active := True;
  fMidiPosition.Reset;
  UsingMidi := true;
end;

procedure TMainForm.CloseMidiFile;
begin
  if UsingMidi then
     begin
          MidiPlayer1.Stop;
          TrackOutputs1.Active := False;
          MidiData1.Active := False;
          UsingMidi := false;
     end;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
    DXDraw.Finalize;
    DXSound.Finalize;
    closeMidiFile;
end;

procedure TMainForm.Image1Click(Sender: TObject);
begin
    pnlf5.Color := clblack;
    pnlf6.Color := clblack;
    pnlf7.Color := clblack;
    pnlf8.Color := clblack;
    pnlf9.Color := clblack;

if (Sender= Image1) or (Sender= Label1) then
   begin
    pnlf5.Color := clred;
    SpellMode := 1;
   end;
if (Sender = Image2)or (Sender= Label2) then
   begin
    pnlf6.Color := clred;
    SpellMode := 2;
   end;
if (Sender = Image3)or (Sender= Label3)  then
   begin
    pnlf7.Color := clred;
    SpellMode := 3;
   end;
if (Sender = Image4)or (Sender= Label4)  then
   begin
    pnlf8.Color := clred;
    SpellMode := 4;
   end;
if ((Sender = Image6)or (Sender= Label5)) and (pnlf9.visible)  then
   begin
    pnlf9.Color := clred;
    SpellMode := 5;
   end;

end;


{procedure TMainForm.Mirror(var MyBitMap: TBitmap);
var
  x,y,w,h:LongInt;
  I:TBitmap;
begin
  w:=MyBitMap.Width;
  h:=MyBitMap.Height;

  try
    I:=TBitmap.Create;
    I.Width:=w;
    I.Height:=h;
    dec(w);
    dec(h);

    for x:= 0 to w do
      for y:= 0 to h do
        I.Canvas.Pixels[w-x,y]:=MyBitMap.Canvas.Pixels[x,y];
    MyBitMap.Canvas.Draw(0,0,I);
  finally                                                     
    I.Free
  end;
end;

procedure TMainForm.Flip(var MyBitmap: TBitmap);
var
  x,y,w,h:LongInt;
  I:TBitmap;
begin
  w:=MyBitMap.Width;
  h:=MyBitMap.Height;

  try
    I:=TBitmap.Create;
    I.Width:=w;
    I.Height:=h;
    dec(w);
    dec(h);

    for x:= 0 to w do
      for y:= 0 to h do
        I.Canvas.Pixels[x,h-y]:=MyBitMap.Canvas.Pixels[x,y];
    MyBitMap.Canvas.Draw(0,0,I);
  finally
    I.Free;
  end
end;
}

procedure TMainForm.SpeakTimerTimer(Sender: TObject);
begin
   if Sayit then
      begin
           Speak.Image := MainForm.ImageList2.Items.Find('daddy');
           SpeakTimer.enabled := false;

      end
   else
   if speaking then
      begin
           Speak.Image := MainForm.ImageList.Items.Find('blank');
           Speaking := false;
      end

   else
     begin
      Speak.Image := MainForm.ImageList2.Items.Find('guards');
      if Not(guardsExists) then guards := true;
      speaking := true;
   end;


end;

procedure TMainForm.GuardTimerTimer(Sender: TObject);
begin
if (GameNow) and Not(GuardsExists) then CreateGuards;
end;

procedure TMainForm.AttackPlayerTimerTimer(Sender: TObject);
begin
     AttackPlayerTimer.enabled := false;
end;

procedure TMainForm.ManaTimerTimer(Sender: TObject);
begin
  if (Mana < 100) then
  begin
       Inc(Mana, 2);
       if Mana < 25 then MainForm.ManaGauge.ForeColor := clred;
       if (Mana > 25) and (Mana < 75) then MainForm.ManaGauge.ForeColor := clyellow;
       if Mana > 75 then MainForm.ManaGauge.ForeColor := clLime;
       if Mana > 100 then Mana := 100;
       MainForm.ManaGauge.Progress := mana;
  end;

end;

procedure TMainForm.ResetGame;
begin
     if Stage <> 4 then
     begin
          Gold := 00000;
          controlPanel.Visible := false;
          TitleMode := -1;
          stage := 0;
     end;
     Cheats := '';
     player1Says := '';
     Mana := 100;
     Health := 100;
     SpellMode := 1;
     mainform.ManaGauge.foreColor := cllime;
     mainform.hitGuage.foreColor := cllime;
     mainform.ManaGauge.Progress := 100;
     mainform.hitGuage.Progress := 100;
     firecount := 0;
     firing := false;
     standingCount := 0;
     FRFIFade  := 0;
     FKil1Fade := 254;
     fKil2Fade := 254;
     potioncount := 0;
     pnlf5.Color := clred;
     pnlf6.Color := clblack;
     pnlf7.Color := clblack;
     pnlf8.Color := clblack;
     pnlf9.Color := clblack;
     SpellMode := 1;
     Gamenow := false;
     GuardsExists := false;
     BritishExists := false;
     DupreExists := false;
     BritishDead := false;
     DupreDead := false;
     sayit := false;
     Speaking := false;
     DDExists := false;
     bullsEye :=false;
     wacked := true;
     guards := false;
     GuardTimer.enabled := false;
     SpeakTimer.enabled := false;
//     SteelWolf.Collisioned := false;
//     Speak.Collisioned := false;
     Fluffy.dead;
end;



procedure TMainForm.Stage3StartTimer(Sender: TObject);
begin
     GameNow := True;
     Stage3Start.Enabled := false;
     Stage3Chat.enabled := true;
end;

procedure TMainForm.Stage3ChatTimer(Sender: TObject);
begin
  inc(Stage3ChatCount);
         DDSays1 := '';
         DDSays2 := '';
         FluffySays1 := '';
         FluffySays2 := '';

  Case Stage3ChatCount of
  1:
    begin
         SpeakColor := clred;
         FluffySays1 :='and after you remove';
         FluffySays2 :='stat loss for all PKs...';
         Stage3Chat.Interval := 4000;
    end;
 2:
    begin
         speakColor := clred;
         FluffySays1 :='put it back in double for';
         FluffySays2 :='fishing, cooking, and mining...';
         Stage3Chat.Interval := 4000;

    end;

  3:
    begin
         speakColor := clred;
         FluffySays1:= 'and another thing. Make all';
         FluffySays2:= 'those damn rats KOS by guards';
         Stage3Chat.Interval := 4000;

    end;

  4:
    begin
         speakColor := clWhite;
         DDSays1 := '           GRRRR...';
         DDSays2 := '';
         Stage3Chat.Interval := 2000;
    end;
  5:
    begin
         speakColor := clWhite;
         DDSays1 := 'I CANT TAKE THIS ANY MORE...';
         DDSays2 := '';
         Stage3Chat.Interval := 2000;
    end;

  6:
    begin
          speakcolor := clyellow;
          DDSays1 := '*Designer Dragon decides he is';
          DDSays2 := ' better off without a master*';
          Stage3Chat.Interval := 1000;
   end;
  7:
    begin
         SpeakColor := clyellow;
          DDSays1 := '*Designer Dragon decides he is';
          DDSays2 := ' better off without a master*';
         FluffySays1:= '';
         FluffySays2:= '*DD is attacking you*';
         Stage3Chat.Interval := 4000;
    end;
  8:
    begin
         SpeakColor := clRed;
         FluffySays1:= '    Oh, good grief!      ';
         FluffySays2:= 'Will you give it a rest?!';
         Stage3Chat.Interval := 3000;

    end;

  9:
    begin
         SpeakColor:= clred;
         FluffySays1:= 'You know, you are much';
         FluffySays2:= 'too annoying as a dragon';
         Stage3Chat.Interval := 4000;
    end;

  10:
    begin
         SpeakColor:= clwhite;
         FluffySays1:= '';
         FluffySays2:= '*opens UO source code*';
         Stage3Chat.Interval := 4000;

    end;

  11:
     begin
         speakColor := clred;
          FluffySays1:= '  I got it! How about';
          FluffySays2:= '     Designer RAT!  ';
          Stage3Chat.Interval := 3000;
     end;
  12:
     begin
         DDragon.Image := MainForm.ImageList.Items.Find('drat1');
         DDragon.Width := DDragon.Image.Width;
         DDragon.Height := DDragon.Image.Height;
         DDragon.x := Fluffy.x + 100;
         DDragon.y := Fluffy.y - 50;
         Stage3Chat.Interval := 3000;
    end;
  13:
     begin
          speakColor := clred;
          FluffySays1:= 'Vendor buy the bank';
          FluffySays2:= '    some guards!';

          Stage3Chat.Interval := 2000;

     end;
  14:
     begin
          speakColor := clyellow;
          FluffySays2:= '            *evil grin*';

          try
            MainForm.DXWaveList.Items.Find('teleport').Play(False);
          except
          end;
              SteelWolf := TGuardsSprite.Create(MainForm.DXSpriteEngine.Engine);
              with SteelWolf do
              begin
                   Image := MainForm.ImageList.Items.Find('Guardstand');
                   Width := Image.Width;
                   Height := Image.Height;
                   x := DDragon.x - 120;
                   y := DDragon.y - 50;
                   z := 4;
              end;
         Stage3Chat.enabled := false;

     end;

 end;
end;

end.


