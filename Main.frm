VERSION 5.00
Object = "{22D6F304-B0F6-11D0-94AB-0080C74C7E95}#1.0#0"; "msdxm.ocx"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Begin VB.Form Main 
   BorderStyle     =   0  'None
   Caption         =   "Form1"
   ClientHeight    =   465
   ClientLeft      =   150
   ClientTop       =   435
   ClientWidth     =   705
   ControlBox      =   0   'False
   Icon            =   "Main.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   465
   ScaleWidth      =   705
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Begin MSComDlg.CommonDialog cd 
      Left            =   240
      Top             =   0
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin MediaPlayerCtl.MediaPlayer mp 
      Height          =   615
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   735
      AudioStream     =   -1
      AutoSize        =   0   'False
      AutoStart       =   -1  'True
      AnimationAtStart=   -1  'True
      AllowScan       =   -1  'True
      AllowChangeDisplaySize=   -1  'True
      AutoRewind      =   -1  'True
      Balance         =   30
      BaseURL         =   ""
      BufferingTime   =   5
      CaptioningID    =   ""
      ClickToPlay     =   -1  'True
      CursorType      =   0
      CurrentPosition =   -1
      CurrentMarker   =   0
      DefaultFrame    =   ""
      DisplayBackColor=   0
      DisplayForeColor=   16777215
      DisplayMode     =   0
      DisplaySize     =   4
      Enabled         =   -1  'True
      EnableContextMenu=   -1  'True
      EnablePositionControls=   -1  'True
      EnableFullScreenControls=   0   'False
      EnableTracker   =   -1  'True
      Filename        =   ""
      InvokeURLs      =   -1  'True
      Language        =   -1
      Mute            =   0   'False
      PlayCount       =   1
      PreviewMode     =   0   'False
      Rate            =   1
      SAMILang        =   ""
      SAMIStyle       =   ""
      SAMIFileName    =   ""
      SelectionStart  =   -1
      SelectionEnd    =   -1
      SendOpenStateChangeEvents=   -1  'True
      SendWarningEvents=   -1  'True
      SendErrorEvents =   -1  'True
      SendKeyboardEvents=   0   'False
      SendMouseClickEvents=   0   'False
      SendMouseMoveEvents=   0   'False
      SendPlayStateChangeEvents=   -1  'True
      ShowCaptioning  =   0   'False
      ShowControls    =   -1  'True
      ShowAudioControls=   -1  'True
      ShowDisplay     =   0   'False
      ShowGotoBar     =   0   'False
      ShowPositionControls=   -1  'True
      ShowStatusBar   =   0   'False
      ShowTracker     =   -1  'True
      TransparentAtStart=   0   'False
      VideoBorderWidth=   0
      VideoBorderColor=   0
      VideoBorder3D   =   0   'False
      Volume          =   -480
      WindowlessVideo =   0   'False
   End
   Begin VB.Menu PopUp 
      Caption         =   "&PopUp"
      Visible         =   0   'False
      Begin VB.Menu Nothing 
         Caption         =   "a"
      End
   End
End
Attribute VB_Name = "Main"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False


Private Sub Form_Load()
    Me.Show
    Me.Refresh
       With nid
        .cbSize = Len(nid)
        .hwnd = Me.hwnd
        .uId = vbNull
        .uFlags = NIF_ICON Or NIF_TIP Or NIF_MESSAGE
        .uCallBackMessage = WM_MOUSEMOVE
        .hIcon = Me.Icon
        .szTip = "Quick MP3" & vbNullChar
       End With
       Shell_NotifyIcon NIM_ADD, nid
    Main.Hide
End Sub

Private Sub Form_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
Dim Result As Long
Dim msg As Long
    
     If Me.ScaleMode = vbPixels Then
         msg = X
     Else
         msg = X / Screen.TwipsPerPixelX
     End If
    
     Select Case msg
                
        Case WM_LBUTTONUP
             Result = SetForegroundWindow(Me.hwnd)
             Me.PopupMenu Me.PopUp
         Case WM_RBUTTONUP
             Unload Me
    End Select
End Sub



Private Sub Form_Unload(Cancel As Integer)
    Shell_NotifyIcon NIM_DELETE, nid
End Sub

Private Sub PopUp_Click()
    cd.Filter = "Supported Audio Files|*.mp3;*.wav"
    cd.CancelError = True
    On Error GoTo saveerror
    cd.Action = 1
    On Error GoTo 0
    mp.FileName = cd.FileName
    mp.Play
    Main.Show
    Main.Refresh
    nid.szTip = cd.FileName
    Main.Hide
Exit Sub
saveerror:
End Sub

