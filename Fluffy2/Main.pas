unit Main;

interface

uses
  Windows,  SysUtils,  Graphics,  Forms,
  StdCtrls, ExtCtrls, DXClass, DXSprite, DXDraws,
  DXSounds,  DirectX, xprocs, Classes, Controls, DIB;

type
  TMainForm = class(TDXForm)
    DXTimer: TDXTimer;
    DXDraw: TDXDraw;
    DXSpriteEngine: TDXSpriteEngine;
    ImageList: TDXImageList;
    DXWaveList: TDXWaveList;
    DXSound: TDXSound;
    GameTimer: TTimer;
    Timer2: TTimer;
    Edit1: TEdit;
    Player2saysTimer: TTimer;
    ddspeak2: TTimer;
    ddspeak1: TTimer;
    ddspeak3: TTimer;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DXDrawFinalize(Sender: TObject);
    procedure DXDrawInitialize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DXTimerTimer(Sender: TObject; LagCount: Integer);
    procedure DXTimerActivate(Sender: TObject);
    procedure DXTimerDeactivate(Sender: TObject);
    procedure DXDrawMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DXDrawMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DXDrawMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SendNow;
    procedure Edit1Change(Sender: TObject);
    procedure GameTimerTimer(Sender: TObject);
    function  Parsestring(s:string): String;
    procedure Timer2Timer(Sender: TObject);
    procedure letsBegin;
    procedure titlescreen;
    procedure onscreenText;
    procedure CreateTrees(numb: Integer);
    procedure CreateStandingGM(numb: Integer);
    procedure CreateStandingConselor(numb: Integer);
    procedure CreateMovingGM(numb: Integer);
    procedure CreateClassic(numb: Integer);
    procedure CreateNewbie(numb: Integer);
    procedure CreateMovingConselor(numb: Integer);
    procedure Stage1Screen;
    procedure Stage2Screen;
    procedure Stage3Screen;
    procedure Stage5Screen;
    procedure Stage6Screen;

    procedure CreateDD;
    procedure CreateBritish;
    procedure CreateBlackThorn;
    procedure Player2saysTimerTimer(Sender: TObject);
    procedure ddspeak2Timer(Sender: TObject);
    procedure TheDead(numb:Integer);
    procedure ddspeak1Timer(Sender: TObject);
    procedure WinScreen;
    procedure ddspeak3Timer(Sender: TObject);

  private
    FAngle: Integer;
    FSurface: TDirectDrawSurface;
  end;

Type

TDDSprite = class(TImageSprite)
  private
    FS: Integer;
    Hitpoints: Integer;
    procedure Hit;
  public
    procedure DoMove(MoveCount: Integer); override;
  end;

TBlackThornSprite = class(TImageSprite)
  private
    FS: Integer;
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

TExplodeSprite = class(TImageSprite)
  private
    FS: Integer;
  protected
    procedure DoMove(MoveCount: Integer); override;
    procedure DoCollision(Sprite: TSprite; var Done: Boolean); override;

  end;

var
  MainForm: TMainForm;
  //integer
  mousex      :         integer;
  mousey      :         integer;
  targetx     :         integer;
  targety     :         integer;
  fireCount   :         integer;
  count       :         integer;
  Stage       :         integer;
  MovingCount :         integer;
  StandingCount:        integer;
  TreeCount   :         integer;
  DDSpeakInt  :         integer;
  //boolean
  fireLeft    :         boolean;
  fireUp      :         boolean;
  mousecontrol:         boolean;
  GameNow     :         boolean;
  GameOver    :         boolean;
  firing      :         boolean;
  DDExists    :         boolean;
  BritishExists:        boolean;
  BlackthornExists:     boolean;
  DDDead       :        boolean;
  BritishDead  :        boolean;
  BlackthornDead:       boolean;
  GameAgain    :        boolean;
  StartNew     :        boolean;
  DDStop       :        boolean;
  NewEnd       :        boolean;
  //doubles
  playerx      :        double;
  playery      :        double;
  NewX         :        double;
  NewY         :        double;
  firex        :        double;
  firey        :        double;
  Player2x     :        double;
  Player2y     :        double;
  //reals
  centerx      :        real;
  centery      :        real;
  //strings
  player1Says  :        string;
  player2Says  :        string;
  metext       :        string;
  xy           :        string;
  tmpPlayer1   :        string;
  player2mouse :        string;
  Cheats       :        string;
  //Objects
  FireBall     :        TFireBallSprite;
  Fluffy       :        TChickenSprite;
  DDragon      :        TDDSprite;
  BlackThorn   :        TBlackThornSprite;
  British      :        TBritishSprite;
  Explosion    :        TExplodeSprite;

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

TGMSprite = class(TImageSprite)
  private
    FS: Integer;
    procedure Hit;
  public
    procedure DoMove(MoveCount: Integer); override;
  end;





procedure TExplodeSprite.DoMove(MoveCount: Integer);
begin
  inherited DoMove(MoveCount);

    Inc(FS, MoveCount);
    if FS>425 then
     begin
         Dead;
         firing:= false;
     end;

 Collision;
end;

procedure TBadGuySprite.DoMove(MoveCount: Integer);
begin

  if player1Says = 'KillemAll' Then
     begin
          firex:= x;
          firey:= y;
          centerx:= (width / 2);
          centery:= (height / 2);
          with TExplodeSprite.Create(MainForm.DXSpriteEngine.Engine) do
                 begin
                     // MainForm.DXWaveList.Items.Find('explode').Play(False);
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
//          Dead;
//          MovingCount := 0;
     end;
  if Gameover then dead;
  inherited DoMove(MoveCount);
  if Collisioned then
  begin
  FCounter := FCounter + (100/1000)*MoveCount;
  X := X+Sin256(Trunc(FCounter))*(100/1000)*MoveCount;
  Y := Y+Cos256(Trunc(FCounter))*(100/1000)*MoveCount;
  end;

  if not Collisioned then
  begin
    Inc(FS, MoveCount);
    if FS>2000 then
       begin
           Dead;
           Dec(MovingCount);
       end;
  end;
end;


procedure TDDSprite.DoMove(MoveCount: Integer);
var
rdx:Integer;
rdy:Integer;
begin

  if Gameover then dead;
  inherited DoMove(MoveCount);
  if Collisioned then
  begin
   if  MainForm.ddspeak2.Enabled = false then
      begin
           if DDStop = False then
              begin
                  rdx := Random(2);
                  if rdx = 0 then
                     X:= X + 5
                  else
                     X:= X - 5;

                  rdy := Random(2);
                  if rdy = 0 then
                     y:= y + 5
                  else
                     y:= y - 5;
                 //  X := x + (Random(120)-60);
                 //  Y := y +(Random(120)-60);
              end;
      end
  end;
  if not Collisioned then
         begin
              Inc(FS, MoveCount);
              if FS>5000 then
                 begin
                      DDDead := true;
                 end;
         end;

end;

procedure TBritishSprite.DoMove(MoveCount: Integer);
var
rdx:Integer;
rdy:Integer;
begin
  if Gameover then dead;
  inherited DoMove(MoveCount);
  if Collisioned then
     begin
          rdx := Random(3);
          if rdx = 0 then
             X:= X - 5
          else
              X:= X + 5;

          rdy := Random(3);
          if rdy = 0 then
             y:= y + 5
          else
              y:= y - 5;

           //X := x + (Random(80)-40);
           //Y := y +(Random(80)-40);
     end;

  if not Collisioned then
  begin
    Inc(FS, MoveCount);
    if FS>1500 then
       begin
           BritishDead := True;
           Dead;
       end;
  end;

end;

procedure TBlackThornSprite.DoMove(MoveCount: Integer);
var
rdx:Integer;
rdy:Integer;
begin

  if Gameover then dead;
  inherited DoMove(MoveCount);
  if Collisioned then
     begin
          rdx := Random(3);
          if rdx = 0 then
             X:= X + 5
          else
              X:= X - 5;

          rdy := Random(3);
          if rdy = 0 then
             y:= y - 5
          else
              y:= y + 5;
         //  X := x + (Random(40)-20);
         //  Y := y +(Random(40)-20);
     end;

    if not Collisioned then
  begin
    Inc(FS, MoveCount);
    if FS>1500 then
       begin
           BlackThornDead := True;
           Dead;
       end;
  end;


end;


procedure TGMSprite.DoMove(MoveCount: Integer);
begin

  if player1Says = 'KillemAll' Then
     begin
          firex:= x;
          firey:= y;
          centerx:= (width / 2);
          centery:= (height / 2);
          with TExplodeSprite.Create(MainForm.DXSpriteEngine.Engine) do
                 begin
                 //     MainForm.DXWaveList.Items.Find('explode').Play(False);
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

//          Dead;
//          StandingCount := 0;
     end;
  if Gameover then dead;
  inherited DoMove(MoveCount);
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
  Collisioned := False;
  if Stage = 1 then
     Image := MainForm.ImageList.Items.Find('img1-2');
  if stage = 2 then
  Image := MainForm.ImageList.Items.Find('GMdead');
  if stage > 3 then
  Image := MainForm.ImageList.Items.Find('Body');

  if Player1says <> 'KillemAll' then
  MainForm.DXWaveList.Items.Find('snd').Play(False);

end;

procedure TDDSprite.Hit;
begin

  Dec(HitPoints);
  If hitPoints = 0 then
     begin
          x := playerx;
          y := playery - 175;
          Player2says := 'Designer Dragon: Vas Ylem Rel';
          MainForm.Player2saysTimer.Enabled := true;
          Image := MainForm.ImageList.Items.Find('Dragon');
          Height := Image.Height;
          Width := Image.Width;
          MainForm.ddspeak3.enabled := true;
          DDStop := true;
     end;
end;
procedure TBlackThornSprite.Hit;
begin
  Dec(HitPoints);
  if HitPoints = 0 then
     begin
          Collisioned := False;
          MainForm.DXWaveList.Items.Find('snd').Play(False);
          Image := MainForm.ImageList.Items.Find('BlackThornDead');
          Z:= 2;
     end;

end;
procedure TBritishSprite.Hit;
begin
  Dec(HitPoints);
  if HitPoints = 0 then
     begin
          Collisioned := False;
          MainForm.DXWaveList.Items.Find('snd').Play(False);
          Image := MainForm.ImageList.Items.Find('BritishDead');
          Z:= 2;
     end;
end;


procedure TGMSprite.Hit;
begin
  Collisioned := False;
  if Stage = 1 then
     Image := MainForm.ImageList.Items.Find('img1-2');
  if stage = 2 then
  Image := MainForm.ImageList.Items.Find('GMdead');
  if Player1says <> 'KillemAll' then
  MainForm.DXWaveList.Items.Find('snd').Play(False);
end;

procedure TChickenSprite.DoCollision(Sprite: TSprite; var Done: Boolean);
begin
  if Sprite is TBadGuySprite then
    TBadGuySprite(Sprite).Hit;
  Done := False;
end;


procedure TChickenSprite.DoMove(MoveCount: Integer);
var
  mouseright: string;
begin
  inherited DoMove(MoveCount);

   //removed joystick and keyboard support
   // because I too lazy to make the targeting code
   //for the fireball support them :)
  {  if isUp in MainForm.DXInput.States then
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
 } if mousecontrol =false then
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
                  if mousex > 475 then
                     X := X + (400/1000)*MoveCount
                  else
                  X := X + (200/1000)*MoveCount;
             end;
          if mousex < 300 then
             begin
               Image := MainForm.ImageList.Items.Find('img2-3');
               if mousex < 156 then
                     X := X - (400/1000)*MoveCount
               else
               X := X - (200/1000)*MoveCount;
             end;

          if mousey > 260 then
             if mousey > 395 then
                Y := Y + (400/1000)*MoveCount
             else
                 Y := Y + (200/1000)*MoveCount;

          if mousey < 220 then
            if mousey < 85 then
            Y := Y - (400/1000)*MoveCount
            else
            Y := Y - (200/1000)*MoveCount;
  end;

  Collision;
  playerx := x;
  playery:= y;

  xy := FloatToStr(mousex) + ':' + FloatToStr(mousey);

  if mousecontrol = true then mouseright := '1' else mouseright := '0';
  Engine.X := -X+Engine.Width div 2-Width div 2;
  Engine.Y := -Y+Engine.Height div 2-Height div 2;
 end;




procedure TMainForm.DXTimerActivate(Sender: TObject);
begin
  Caption := Application.Title;
end;

procedure TMainForm.DXTimerDeactivate(Sender: TObject);
begin
  Caption := Application.Title + ' [Pause]';
end;

procedure TMainForm.DXTimerTimer(Sender: TObject; LagCount: Integer);
begin
  //Main Game timer. for some reason Hori chose to use the OnAppIdle event for
  //his timer so that means we only get 1 DXTimer to use for EVERYTHING
  //as a result the followgin code is a little tricky to follow

  if not DXDraw.CanDraw then exit;


  if (GameNow) and ((StandingCount = 0) and (MovingCount = 0 )) then
     begin

          if stage = 5 then
            begin
                 Stage := 4;
                 GameNow := false;
                 GameTimer.enabled := false;
                 Player1says := '';
                 Player2says := '';
                 Player2saysTimer.enabled := false;
               //  GameAgain := True;
                 Fluffy.Dead;
                //Fluffy.X := 0;
               // Fluffy.y := 0;
            end;

          if stage = 6 then
            begin
                 Inc(Stage);
                 GameNow := false;
                 GameTimer.enabled := false;
                 Player1says := '';
                 Player2says := '';
                 Player2saysTimer.enabled := false;
                // GameAgain := True;
                 Fluffy.Dead;
            end;

          if stage = 3 then
             if ddExists = false then
              CreateDD
             else
                 if ddDead = True then
                    begin
                         Inc(Stage);
                         GameNow := false;
                         GameTimer.enabled := false;
                         Player1says := '';
                         Player2says := '';
                         Player2saysTimer.enabled := false;
                         GameAgain := True;
                         Fluffy.Dead;
                    end;

          if stage = 2 then
             if BritishExists = false then
              CreateBritish
             else
                 if BritishDead = True then
                    begin
                         Inc(Stage);
                         GameNow := false;
                         GameTimer.enabled := false;
                         Player1says := '';
                         Player2says := '';
                         Player2saysTimer.enabled := false;
                    end;

          if stage = 1 then
             if BlackThornExists = false then
              CreateBlackthorn
             else
                 if BlackThornDead = True then
                    begin
                         Inc(Stage);
                         GameNow := false;
                         GameTimer.enabled := false;
                         Player2saysTimer.enabled := false;
                         Player1says := '';
                         Player2says := '';
                         Fluffy.X := 0;
                         Fluffy.Y := 0;
                   end;
     end;

   if (count = 0) then
     begin
          gameover := True;
          Stage:= 0;
     end;

  if Not GameNow then
     begin
         count := 1;
         If stage = 0 then
          TitleScreen;

         If Stage = 1 then
            Stage1Screen;

         If Stage = 2 then
            Stage2Screen;

         If Stage = 3 then
            Stage3Screen;

         If Stage = 4 then
            WinScreen;

         If Stage = 5 then
            Stage5Screen;

         If Stage = 6 then
            Stage6Screen;

         If Stage = 7 then
            WinScreen;



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

   if (count = 0) then
     begin
          gamenow := false;
     end;

      DXDraw.Surface.Draw(mouseX-FSurface.Width div 2, mousey-FSurface.Height div 2,
 FSurface.ClientRect, FSurface, True);

      DXDraw.Flip; //very very important :)
end;

procedure TMainForm.DXDrawFinalize(Sender: TObject);
begin
  DXTimer.Enabled := False;
  FSurface.Free;
  FSurface := nil;
end;

procedure TMainForm.DXDrawInitialize(Sender: TObject);
begin
  DXTimer.Enabled := True;
  FSurface := TDirectDrawSurface.Create(DXDraw.DDraw);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  Randomize;
  ImageList.Items.MakeColorTable;
  GameAgain := false;
  StartNew := false;
  BlackThornExists := false;
  BritishExists := false;
  DDExists := false;
  DDStop := false;
  DDSpeakInt := 0;

  NewEnd:= True;
  DXDraw.ColorTable := ImageList.Items.ColorTable;
  DXDraw.DefColorTable := ImageList.Items.ColorTable;
  DXDraw.UpdatePalette;
  with TBackgroundSprite.Create(DXSpriteEngine.Engine) do
       begin
            SetMapSize(1,1);
            Image := ImageList.Items.Find('background');
            Z := -2;
            Tile := true;
       end;

       CreateTrees(50);

  Count:= 300;
  GameNow := False;
  GameOver:= False;
  MainForm.DXWaveList.Items.Find('evillaugh').Play(False);
  Stage := 0;

end;

procedure TMainForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  {  Application end  }
  if Key=VK_ESCAPE then
    Close;

  if Key=VK_RETURN then
  begin
    SendNow;
    key := 0;
  end;

  if Key=VK_F2 then
  begin

    if (not GameNow) and (not GameAgain) then
       begin
            //for the new lvls in ver 2.1
            if Cheats = 'Classic' then
               Stage:= 5
            else
            if Cheats = 'IHateNewbies' then
               Stage:= 6
            else
            if (stage = 0) or (StartNew) then
            begin
                 Stage := 1;
                 StartNew := False;
            end;
       end;
  end;

  if Key=VK_SPACE then
  begin

    if (not GameNow) and (Stage <> 0) and (Not GameAgain) then
       begin
            Letsbegin;
            Edit1.Text := '';
       end;
  end;


if Key=VK_F4 then
  begin
    DXDraw.Finalize;

    if doFullScreen in DXDraw.Options then
    begin
      RestoreWindow;

      DXDraw.Cursor := crCross;
      BorderStyle := bsSizeable;
      DXDraw.Options := DXDraw.Options - [doFullScreen];
    end else
    begin
      StoreWindow;

     DXDraw.Cursor := crCross;
      BorderStyle := bsNone;
      DXDraw.Options := DXDraw.Options + [doFullScreen];
    end;
    DXDraw.Initialize;

  end;
end;

procedure TMainForm.DXDrawMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
    mousex:= x;
    mousey:= y;
end;

procedure TMainForm.DXDrawMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin

if button = mbRight then
   mousecontrol := true;
if GameNow then
if button = mbLeft then
  begin
       if (fireCount < 1) and (DDStop = False) then
       begin
            targetx := mousex;
            targety := mousey;

            with TFireBallSprite.Create(DXSpriteEngine.Engine) do
                 begin
                      MainForm.DXWaveList.Items.Find('fireball').Play(False);
                      Image := MainForm.ImageList.Items.Find('fireballRight');
                      firing:= true;
                      inc(FireCount);
                      Width := Image.Width;
                      Height := Image.Height;
                      AnimStart := 0;
                      AnimCount := Image.PatternCount;
                      AnimLooped := true;
                      AnimPos:=0;
                      AnimSpeed := 14/1000;
                     // PixelCheck := True;
                     // Collisioned := True;

                      x := Playerx;
                      y:= Playery;
                      Z := 10;
                      NewX:= PlayerX + (TargetX - 320);
                      NewY:= PlayerY + (TargetY- 240);

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

  if (Sprite is TGMSprite)then
  begin
    TGMSprite(Sprite).Hit;
  end;

  if (Sprite is TBadGuySprite)then
  begin
    TBadGuySprite(Sprite).Hit;
  end;

  Done := False;
end;


procedure TFireBallSprite.DoCollision(Sprite: TSprite; var Done: Boolean);
begin


  if (Sprite is TBadGuySprite) or (Sprite is TGMSprite) or (Sprite is TDDSprite) or (Sprite is TBlackthornSprite)or (Sprite is TBritishSprite)then
  begin
      firex:= x;
      firey:= y;
      centerx:= (width / 2);
      centery:= (height / 2);
     with TExplodeSprite.Create(MainForm.DXSpriteEngine.Engine) do
                 begin
                      MainForm.DXWaveList.Items.Find('explode').Play(False);
                      Image := MainForm.ImageList.Items.Find('Explode');
                      Width := Image.Width;
                      Height := Image.Height;
                      AnimStart := 0;
                      AnimCount := Image.PatternCount;
                      AnimLooped := true;
                      AnimPos:=0;
                      AnimSpeed := 14/1000;
                     // PixelCheck := True;
                     // Collisioned := True;

                      x := firex - ((width /2)- centerx);
                      y:= firey -((height /2)- centery);

                      Z := 10;

                 end;
    if (Sprite is TBadGuySprite)then
    TBadGuySprite(Sprite).Hit;

    if (Sprite is TGMSprite)then
    TGMSprite(Sprite).Hit;

    if (Sprite is TDDSprite)then
    TDDSprite(Sprite).Hit;

    if (Sprite is TBlackThornSprite)then
    TBlackThornSprite(Sprite).Hit;

    if (Sprite is TBritishSprite)then
    TBritishSprite(Sprite).Hit;

   fireCount :=0;

   Dead;
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
  Try
         if targetx > 320 then
            if x < newX then
               begin
                    x := x+(18);
                    Test:= true;
                    xpos := true;
               end;

         if targetx < 320 then
            if x > newX then
               begin
                    x := x-(18);
                    xneg := true;
                    Test:= true;
               end;

         if targety > 240 then
            if y < newy then
               begin
                    y := y+(18);
                    Test:= true;
                    ypos := true;
               end;

         if targety < 240 then
            if y > newy then
               begin
                    y := y-(18);
                    Test:= true;
                    yneg := true;
               end;

 if (xpos = true) and (ypos = false) and (yneg = false)then
    Image := MainForm.ImageList.Items.Find('fireballright');

 if (xpos = true) and (ypos = true) and (yneg = false)then
    Image := MainForm.ImageList.Items.Find('downright');

 if (xpos = true) and (ypos = false) and (yneg = true)then
    Image := MainForm.ImageList.Items.Find('upright');

 if (xneg = true) and (ypos = false) and (yneg = false)then
    Image := MainForm.ImageList.Items.Find('fireballleft');

 if (xneg = true) and (ypos = true) and (yneg = false)then
    Image := MainForm.ImageList.Items.Find('downleft');

 if (xneg = true) and (ypos = false) and (yneg = true)then
    Image := MainForm.ImageList.Items.Find('upleft');

 if (ypos = true) and (xpos = false) and (xneg = false)then
    Image := MainForm.ImageList.Items.Find('fireballdown');

if (yneg = true) and (xpos = false) and (xneg = false)then
    Image := MainForm.ImageList.Items.Find('fireballup');


  if test = false then
         begin
            firex:= x;
            firey:= y;
            with TExplodeSprite.Create(MainForm.DXSpriteEngine.Engine) do
                 begin
                      MainForm.DXWaveList.Items.Find('explode').Play(False);
                      Image := MainForm.ImageList.Items.Find('Explode');
                      Width := Image.Width;
                      Height := Image.Height;
                      AnimStart := 0;
                      AnimCount := Image.PatternCount;
                      AnimLooped := true;
                      AnimPos:=0;
                      AnimSpeed := 14/1000;
                    //  PixelCheck := True;
                    //  Collisioned := true;

                      x := firex;
                      y:= firey;
                      Z := 10;

                 end;

              Dead;
              fireCount :=0;
         end;

  if targetx > 320 then
  begin
      if X > playerx+320 then
      begin
         fireCount :=0;
         Dead;
         firing:= false;

      end;
  end;

  if targetx < 320 then
  begin
       if X < playerx-320 then
       begin

         fireCount :=0;
         Dead;
         firing:= false;

      end;
  end;

    if targety > 240 then
  begin
      if y > playery+240 then
      begin
         fireCount :=0;
         Dead;
         firing:= false;

      end;
  end;

  if targety < 240 then
  begin
       if y < playery-240 then
       begin

         fireCount :=0;
         Dead;
         firing:= false;

      end;
  end;
  except
       fireCount :=0;
       Dead;
       firing:= false;

  end;

  Collision;
end;



procedure TMainForm.SendNow;
begin
    //hmm.. now what was all this for again??
    //CleanUp
    Cheats := Edit1.text;
    if (Not GameNow) And ((Cheats = 'IHateNewbies') or (Cheats = 'Classic')) then

    MainForm.DXWaveList.Items.Find('evillaugh').Play(False);

    player1Says := edit1.text;
    Edit1.Text := '';
    metext:= '';
end;

procedure TMainForm.Edit1Change(Sender: TObject);
begin
     metext:= edit1.text;
end;

procedure TMainForm.GameTimerTimer(Sender: TObject);
begin
     if count > 0 then
        dec(count);
end;

function TMainForm.Parsestring(s:string): String;
var
i:integer;
temp1: string;
temp2: string;
temp3: string;
begin
temp1 := '';
temp2 := '';
temp3 := '';

for i := 0 to strTokenCount(s, Space) -1 do
begin
temp1 :=  strTokenAt(s, Space,i);
if (Length(temp1) < 15) and  (Length(temp3) < 15) then
   begin
        temp2 := temp2 + Space + temp1;
        temp3 := Temp3 + temp1;
   end
else
   begin
        temp2 := temp2 + '^' + temp1;
        temp3 := '';
   end;


end;
 Result:= Temp2;
end;

procedure TMainForm.Timer2Timer(Sender: TObject);
begin
Player1Says := '';
timer2.enabled := false;
end;

procedure TMainForm.letsBegin;
begin
  Gamenow := true;
  GameOver := false;
  GameTimer.enabled := true;

  if Stage = 1 then
     begin
          Count:= 150;
          CreateStandingConselor(6);
          CreateMovingConselor(24);
     end;
  if Stage = 2 then
     begin
          Count:= 300;
          CreateStandingGM(10);
          CreateMovingGM(50);
     end;

  if Stage = 3 then
     begin
          Count:= 300;
          TheDead(20);
          DdSpeak1.enabled := true;
          DdSpeak2.enabled := true;
     end;

  if Stage = 5 then
     begin
          Count:= 300;
          CreateClassic(100);
     end;
  if Stage = 6 then
     begin
          Count:= 300;
          CreateNewbie(100);
     end;


  if (stage = 1) or (stage > 3)  then
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
         // bad idea
         //     PixelCheck := True;
         //     Collisioned := true;
  end;


end;

procedure TMainForm.TitleScreen;
begin

  DXDraw.Surface.Fill(0);

 //Alpha Bleeding pre Hori's example
 ImageList.Items[27].Draw(DXDraw.Surface,(MainForm.Width - 644) div 2, 180,   0);

 ImageList.Items[28].DrawWaveX(DXDraw.Surface, (MainForm.Width - 500) div 2, MainForm.Height - 90, 500, 62, 0, 5, 60, FAngle*4);

 ImageList.Items[30].Draw(DXDraw.Surface,(MainForm.Width - 277) div 2, 20,   0);


  ImageList.Items[29].DrawAdd(DXDraw.Surface, Bounds((MainForm.Width - 260) div 2, 130, 260, 210),
    0,Trunc(Cos256(FAngle+160)*126+127));



       with DXDraw.Surface.Canvas do
            begin
                 Brush.Style := bsClear;
                 Font.Color := clWhite;
                 Font.Size := 12;
                 Font.Style := [];
                 Textout(5,0, 'Press F2 to play');
                 Font.Color := clYellow;
                 Textout(150,0, 'Version 2.1 Created to test Hori`s DelphiX code');

                 if GameOver then
                    begin
                         GameTimer.enabled := false;
//                                 Textout(5,24, 'All in game support personel are dead and accounted for!');
//                                 Textout(5,48, 'Way to kick ass man!!');
                         Textout(5,24, 'Sorry! You ran out of time!');
                         Textout(5,48, 'Better luck next time.');

                         Font.Color := clRed;
                         Font.Size := 24;
                         Font.Style := [fsBold];
                         Textout(220,360, 'GAME OVER');
                         Fluffy.x := 0;
                         Fluffy.y := 0;
                    end;
                 Release;
            end;
  Inc(FAngle);
end;

procedure TMainForm.WinScreen;
begin

  DXDraw.Surface.Fill(0);
 //more alpha B.. damn this stuff is cool
 ImageList.Items[27].Draw(DXDraw.Surface,0, 180,   0);

 ImageList.Items[28].DrawWaveX(DXDraw.Surface, 50, MainForm.Height - 90, 500, 62, 0, 5, 60, FAngle*4);

 ImageList.Items[30].Draw(DXDraw.Surface,180, 20,   0);

  ImageList.Items[29].DrawAdd(DXDraw.Surface, Bounds(180, 130, 260, 210),
    0,Trunc(Cos256(FAngle+160)*126+127));


       //lets handle this with one block of code and a bunch of Ifs...
       with DXDraw.Surface.Canvas do
            begin
                 Brush.Style := bsClear;
                 Font.Color := clWhite;
                 Font.Size := 12;
                 Font.Style := [];
                 if GameAgain then
                    Textout(5,0, 'Press ESC to exit')
                 else
                    Begin
                         Textout(5,0, 'Press F2 to play again');
                         StartNew:= True;
                    end;
                 Textout(5,24, 'You WON!');
                 if Stage = 7 then
                    Textout(5,48, 'Way to kick some Newbie BUTT!')
                 else
                 Textout(5,48, 'Way to kick some OSI BUTT!');

                 if NewEnd = true then
                    begin
                         Textout(5,70, 'A New World Order begins');
                         Textout(5,94, 'To be continued....');
                    end;

                 Font.Color := clRed;
                 Font.Size := 24;
                 Font.Style := [fsBold];
                 Textout(220,360, 'YOU WIN!!!');
                 Release;
            end;

  Inc(FAngle);

end;


procedure TMainForm.Stage5Screen;
begin
  DXDraw.Surface.Fill(0);
  with DXDraw.Surface.Canvas do
       begin
            Brush.Style := bsClear;
            Font.Color := clWhite;
            Font.Size := 16;
            Font.Style := [fsBold];
            Textout(5,60, 'Press SPACE BAR to play Classic Fluffy');
            Release;
       end;
end;

procedure TMainForm.Stage6Screen;
begin
  DXDraw.Surface.Fill(0);
  with DXDraw.Surface.Canvas do
       begin
            Brush.Style := bsClear;
            Font.Color := clWhite;
            Font.Size := 16;
            Font.Style := [fsBold];
            Textout(5,60, 'Press SPACE BAR to play I Hate Newbies');
            Release;
       end;
end;

procedure TMainForm.Stage1Screen;
begin
  DXDraw.Surface.Fill(0);
  with DXDraw.Surface.Canvas do
       begin
            Brush.Style := bsClear;
            Font.Color := clWhite;
            Font.Size := 16;
            Font.Style := [fsBold];
            Textout(5,60, 'Press SPACE BAR to wreak havoc in Level 1');
            Release;
       end;
end;

procedure TMainForm.Stage2Screen;
begin
  DXDraw.Surface.Fill(0);
  with DXDraw.Surface.Canvas do
       begin
            Brush.Style := bsClear;
            Font.Color := clWhite;
            Font.Size := 16;
            Font.Style := [fsBold];
            Textout(5,60, 'Press SPACE BAR to spread your chaos to Level 2');
            Release;
       end;
end;

procedure TMainForm.Stage3Screen;
begin
  DXDraw.Surface.Fill(0);
  with DXDraw.Surface.Canvas do
       begin
            Brush.Style := bsClear;
            Font.Color := clWhite;
            Font.Size := 16;
            Font.Style := [fsBold];
            Textout(5,60, 'Press SPACE BAR to start the New World Order ');
            Release;
       end;
end;



procedure TMainForm.OnScreenText;
Var
i: Integer;
begin
     {  ON screen text  }
     with DXDraw.Surface.Canvas do
          begin
               Brush.Style := bsClear;
               Font.Color := clWhite;
               Font.Size := 12;
               Font.Style := [];

               If stage = 1 then
                  Textout(5, 0, 'BUG Exploi...err I mean Counslors Left: '+inttostr(StandingCount + MovingCount));
               If stage = 2 then
                  Textout(5, 0, 'GOD Client Abus...err I mean...uh GMs Left: '+inttostr(StandingCount + MovingCount));
               If stage = 5 then
                  Textout(5, 0, 'Worthless UO Rulers Left: '+inttostr(MovingCount));
               If stage = 6 then
                  Textout(5, 0, 'Brain Dead Newbies Left: '+inttostr(MovingCount));


               Font.Style := [fsBold];
               Font.Color := clBlue;
               Textout(5, 24, 'This server will be shutting down in: '+IntToStr(count));

               if firing then
                  begin
                       Font.Style := [fsBold];
                       Font.Color := clRed;
                       Font.Size := 8;
                       Textout(295, 205, 'Vas Flam');
                  end;

               Font.Style := [fsBold];
               Font.Color := clRed;
               Font.Size := 10;

               if Player1Says <> '' then
                  begin
                       timer2.enabled := true;
                       tmpPlayer1 := Parsestring(Player1Says);
                       for i := 0 to strTokenCount(tmpPlayer1,'^') - 1 do
                           begin
                                Textout(280,190 - (24 * (strTokenCount(tmpPlayer1,'^')-1)) + (24 * i), strTokenAt(tmpPlayer1, '^', i));
                           end;
                  end;

               if metext <> '' then Textout(5,456, metext);

               Font.Style := [];
               Font.Color := clWhite;
               Font.Size := 12;

               if Player2Says <> '' then Textout(5,440, Player2Says);

               Release;
          end;


end;

procedure TMainForm.CreateTrees(numb:Integer);
var
i: integer;
begin
  TreeCount:= Numb;
  for i:=0 to Numb -1 do

      With TTreeSprite.Create(DXSpriteEngine.Engine) do
           begin
                //treehere
               Image := ImageList.Items.Find('tree');

                X := Random(5000)-1250;
                Y := Random(5000)-1250;
                Z := 3;
                Width := Image.Width;
                Height := Image.Height;
           end;

end;

procedure TMainForm.CreateStandingGM(numb:Integer);
var
i : Integer;
rd: Integer;
begin
  //the non moving red guys :)
  StandingCount:= Numb;
  for i:=0 to Numb -1 do
      with TGMSprite.Create(DXSpriteEngine.Engine) do
           begin
                rd := Random(3);
                     if rd = 0 then
                        Image := ImageList.Items.Find('gm6');
                     if rd = 1 then
                        Image := ImageList.Items.Find('gm7');
                     if rd = 2 then
                        Image := ImageList.Items.Find('gm8');

                X := Random(2500)-1250;
                Y := Random(2500)-1250;
                Z := 3;
                Width := Image.Width;
                Height := Image.Height;
                //bad idea
               // PixelCheck := True;
               // Collisioned := true;

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

                 X := PlayerX - Random(25)-125;
                 Y := Playery - Random(25)-125;
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

                X := PlayerX + Random(25)+125;
                Y := Playery + Random(25)+125;
                Z := 3;
                Width := Image.Width;
                Height := Image.Height;
           end;

     with TTreeSprite.Create(DXSpriteEngine.Engine) do
           begin
                Image := ImageList.Items.Find('BritishDead');
                X := PlayerX + 150;
                Y := Playery - 150;
                 Z := 3;
                Width := Image.Width;
                Height := Image.Height;
           end;

     with TTreeSprite.Create(DXSpriteEngine.Engine) do
           begin
                Image := ImageList.Items.Find('BlackThornDead');
                X := PlayerX - 150;
                Y := Playery + 150;
                Z := 3;
                Width := Image.Width;
                Height := Image.Height;
           end;



end;

procedure TMainForm.CreateStandingConselor(numb:Integer);
var
i : Integer;
rd: Integer;
begin

//nonmoving blue guys
StandingCount := Numb;
  for i:=0 to Numb -1 do
      with TGMSprite.Create(DXSpriteEngine.Engine) do
           begin
                rd := Random(2);
                    begin
                     if rd = 0 then
                        Image := ImageList.Items.Find('cou3');
                     if rd = 1 then
                        Image := ImageList.Items.Find('cou4');
                    end;

                X := Random(1250)-625;
                Y := Random(1250)-625;
                Z := 3;
                Width := Image.Width;
                Height := Image.Height;
                //bad idea
               // PixelCheck := True;
              // Collisioned := true;

           end;


end;

procedure TMainForm.CreateMovingGm(numb: Integer);
var
i: integer;
rd: integer;
begin
//moving red guys

Randomize;
MovingCount := Numb;
  for i:=0 to numb - 1 do
    with TBadGuySprite.Create(DXSpriteEngine.Engine) do
    begin
      rd := Random(5);

      If rd = 0 then
         Image := ImageList.Items.Find('gm1');
      If rd = 1 then
         Image := ImageList.Items.Find('gm2');
      If rd = 2 then
         Image := ImageList.Items.Find('gm3');
      If rd = 3 then
         Image := ImageList.Items.Find('gm4');
      If rd = 4 then
         Image := ImageList.Items.Find('gm5');


      X := Random(2500)-1250;
      Y := Random(2500)-1250;
      Z := 2;
      Width := Image.Width;
      Height := Image.Height;
      FCounter := Random(MaxInt);
      //bad idea
     // PixelCheck := True;
     // Collisioned := True;

    end;

end;
procedure TMainForm.CreateMovingConselor(numb: Integer);
var
i: integer;
rd: integer;
begin
//moving blue guys
Randomize;
MovingCount := Numb;

  for i:=0 to numb - 1 do
    with TBadGuySprite.Create(DXSpriteEngine.Engine) do
    begin
      rd := Random(2);

      If rd = 0 then
         Image := ImageList.Items.Find('cou1');
      If rd = 1 then
         Image := ImageList.Items.Find('cou2');


      X := Random(1250)-625;
      Y := Random(1250)-625;
      Z := 2;
      Width := Image.Width;
      Height := Image.Height;
      FCounter := Random(MaxInt);
  // bad idea
  //    PixelCheck := True;
  //    Collisioned := True;
    end;

end;
//new in version 2.1 the abilite to play version 1.0
procedure TMainForm.CreateClassic(numb: Integer);
var
i: integer;
rd: integer;
begin
Randomize;
MovingCount := Numb;
  for i:=0 to numb - 1 do
    with TBadGuySprite.Create(DXSpriteEngine.Engine) do
    begin
      rd := Random(4);

      If rd = 0 then
         Image := ImageList.Items.Find('britishleft');
      If rd = 1 then
         Image := ImageList.Items.Find('britishright');
      If rd = 2 then
         Image := ImageList.Items.Find('blackthornleft');
      If rd = 3 then
         Image := ImageList.Items.Find('blackthornright');


      X := Random(3500)-1750;
      Y := Random(3500)-1750;
      Z := 2;
      Width := Image.Width;
      Height := Image.Height;
      FCounter := Random(MaxInt);
    end;

end;
//new in version 2.1 by popular demand fluffy goes after IMANEWBIE
procedure TMainForm.CreateNewbie(numb: Integer);
var
i: integer;
rd: integer;
begin
Randomize;
MovingCount := Numb;
  for i:=0 to numb - 1 do
    with TBadGuySprite.Create(DXSpriteEngine.Engine) do
    begin
      rd := Random(2);

      If rd = 0 then
         Image := ImageList.Items.Find('newbieleft');
      If rd = 1 then
         Image := ImageList.Items.Find('newbieright');
      //my god newbies everywhere
      X := Random(3500)-1750;
      Y := Random(3500)-1750;
      Z := 2;
      Width := Image.Width;
      Height := Image.Height;
      FCounter := Random(MaxInt);
    end;

end;

//introducing Designer Dragon himself Raph Koster the lead designer for Ultima Online
procedure TMainForm.CreateDD;
begin
     DDExists := true;
     Player2Says := 'Designer Dragon:  You fool you'+#39+'ve killed everyone!';
     Player2saysTimer.enabled := true;
     FireCount := 1;
     Count := 300;
     with TDDSprite.Create(MainForm.DXSpriteEngine.Engine) do
          begin
               Image := MainForm.ImageList.Items.Find('DD');
               Width := Image.Width;
               Height := Image.Height;
               x := playerx;
               y := playery - 125;
               z := 4;
               HitPoints := 25;
               //DD just doesnt animate well
               //man I need to learn to draw :(
              // AnimStart := 0;
             //  AnimCount := Image.PatternCount;
             //  AnimLooped := true;
            //   AnimPos:=0;
            //   AnimSpeed := 14/1000;
          end;
end;

procedure TMainForm.CreateBritish;
begin
     BritishExists := True;
     Player2Says := 'Lord British:  You will regret thy actions, swine!';
     Player2saysTimer.enabled := true;
     Count := 200;
     with TBritishSprite.Create(MainForm.DXSpriteEngine.Engine) do
          begin
               Image := MainForm.ImageList.Items.Find('BritishFight');
               Width := Image.Width;
               Height := Image.Height;
               x := playerx;
               y := playery - 120;
               z := 4;
               HitPoints := 10;
          end;
end;

procedure TMainForm.CreateBlackThorn;
begin
     BlackthornExists := true;
     Player2Says := 'Lord Blackthorn:  Scum!! You will die for that!';
     Player2saysTimer.enabled := true;
     Count := 100;
     with TBlackthornSprite.Create(MainForm.DXSpriteEngine.Engine) do
          begin
               Image := MainForm.ImageList.Items.Find('BlackthornFight');
               Width := Image.Width;
               Height := Image.Height;
               x := playerx;
               y := playery - 120;
               z := 4;
               HitPoints := 5;
          end;
end;
{*--------------------------------------------------------------------*}
// I was having problems with the timing of Fluffys and DD conversation at the end
// with only one time so I broke it down into several timers. Messy but more accurate
procedure TMainForm.Player2saysTimerTimer(Sender: TObject);
begin
     Player2says := '';
     Player2SaysTimer.enabled := False;

end;

procedure TMainForm.ddspeak2Timer(Sender: TObject);
begin
    Player1says := '*evil grin*';
    DDspeak2.enabled :=False;
    FireCount := 0;
end;

procedure TMainForm.ddspeak1Timer(Sender: TObject);
begin
    Player1says := 'No, not everyone...';
    DDspeak1.enabled :=False;
end;

procedure TMainForm.ddspeak3Timer(Sender: TObject);
begin
Inc(DDSpeakInt);
if DDSpeakInt = 1 then
   begin
    MainForm.DXWaveList.Items.Find('para').Play(False);
    Timer2.Enabled := False;
    Player1Says := '*You are frozen and cannot move*';
    Timer2.Enabled := true;

    Player2saysTimer.Enabled := False;
    Player2says := 'Designer Dragon: AH HAH!! Now I will rip you to pieces!!';
    Player2saysTimer.Enabled := true;
   end;

if DDSpeakInt = 2 then
   begin
        Timer2.Enabled := False;
        Player1Says := '*evil grin*';
        Timer2.Enabled := true;
   end;

if DDSpeakInt = 3 then
   begin
        Player2saysTimer.Enabled := False;
        Player2says := 'Designer Dragon: Prepare to DIE!!!!';
        Player2saysTimer.Enabled := true;
   end;

if DDSpeakInt = 4 then
   begin
        Timer2.Enabled := False;
        Player1Says := '*You start to tame Designer Dragon*';
        Timer2.Enabled := true;
   end;

if DDSpeakInt = 5 then
   begin
        Player2saysTimer.Enabled := False;
        Timer2.Enabled := False;
        Player1Says := 'I have always wanted a pet like you.';
        Timer2.Enabled := true;
        Player2says := 'Designer Dragon: HEY!!! What are you doing?!?!';
        Player2saysTimer.Enabled := true;
   end;


if DDSpeakInt = 6 then
   begin
        Player2saysTimer.Enabled := False;
        Timer2.Enabled := False;
        Player1Says := '*Designer Dragon accepts you as his master*';
        Timer2.Enabled := true;
        Player2says := 'Designer Dragon: Someone HELP MEEEEE!!!!';
        Player2saysTimer.Enabled := true;

   end;

if DDSpeakInt = 7 then
   begin
        Player2saysTimer.Enabled := False;
        Timer2.Enabled := False;
        Player1Says := 'Now, we can finally have some real fun!';
        Timer2.Enabled := true;
        Player2says := 'Designer Dragon: NOOOOOOOOOOOOOO!!!!!!';
        Player2saysTimer.Enabled := true;
   end;

if DDSpeakInt = 8 then
    begin
        MainForm.DXWaveList.Items.Find('evillaugh').Play(False);
        ddspeak3.Enabled := false;
        ddDead := True
   end;


end;
//end of all the timers :)
{*----------------------------------------------------------------*}
end.


