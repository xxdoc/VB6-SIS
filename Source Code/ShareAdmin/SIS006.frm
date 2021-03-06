VERSION 5.00
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Begin VB.Form frmSIS006 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Tax Rates"
   ClientHeight    =   2625
   ClientLeft      =   1095
   ClientTop       =   330
   ClientWidth     =   6660
   Icon            =   "SIS006.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   2625
   ScaleWidth      =   6660
   Begin MSMask.MaskEdBox meb 
      Height          =   255
      Left            =   1920
      TabIndex        =   11
      Top             =   1680
      Width           =   1335
      _ExtentX        =   2355
      _ExtentY        =   450
      _Version        =   393216
      Format          =   "0##.000"
      PromptChar      =   "_"
   End
   Begin VB.CommandButton cmdClear 
      Caption         =   "C&lear"
      Height          =   300
      Left            =   3480
      TabIndex        =   10
      Top             =   2280
      Width           =   975
   End
   Begin VB.CommandButton cmdCancel 
      Caption         =   "&Cancel"
      Height          =   300
      Left            =   5640
      TabIndex        =   3
      Top             =   2280
      Width           =   975
   End
   Begin VB.CommandButton cmdUpdate 
      Caption         =   "C&ommit"
      Height          =   300
      Left            =   4560
      TabIndex        =   2
      Top             =   2280
      Width           =   975
   End
   Begin VB.TextBox tbfld 
      Height          =   285
      Index           =   1
      Left            =   1920
      MaxLength       =   30
      TabIndex        =   1
      ToolTipText     =   "Enter the Company's Tax Reference Number"
      Top             =   1200
      Width           =   3255
   End
   Begin VB.TextBox tbfld 
      Alignment       =   1  'Right Justify
      Height          =   285
      Index           =   0
      Left            =   1920
      MaxLength       =   2
      TabIndex        =   0
      ToolTipText     =   "Use generate number or enter your own unique client Number"
      Top             =   720
      Width           =   855
   End
   Begin VB.Label lblLabels 
      Alignment       =   1  'Right Justify
      Caption         =   "Tax Rate:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Index           =   9
      Left            =   120
      TabIndex        =   9
      Top             =   1680
      Width           =   1740
   End
   Begin VB.Line Line3 
      BorderWidth     =   2
      X1              =   0
      X2              =   6840
      Y1              =   2160
      Y2              =   2160
   End
   Begin VB.Line Line1 
      BorderWidth     =   2
      X1              =   0
      X2              =   6720
      Y1              =   480
      Y2              =   480
   End
   Begin VB.Label lblLabels 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Index           =   1
      Left            =   360
      TabIndex        =   7
      Top             =   0
      Width           =   975
   End
   Begin VB.Label lblLabels 
      Alignment       =   1  'Right Justify
      Caption         =   "Tax Description:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Index           =   16
      Left            =   120
      TabIndex        =   6
      Top             =   1200
      Width           =   1740
   End
   Begin VB.Label lblLabels 
      Caption         =   "Ver:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Index           =   20
      Left            =   0
      TabIndex        =   5
      Top             =   0
      Width           =   375
   End
   Begin VB.Label lblLabels 
      Alignment       =   1  'Right Justify
      Caption         =   "Tax Code:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Index           =   5
      Left            =   120
      TabIndex        =   4
      Top             =   720
      Width           =   1740
   End
   Begin VB.Label lblLabels 
      Alignment       =   1  'Right Justify
      Caption         =   "Company Name"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Index           =   0
      Left            =   600
      TabIndex        =   8
      Top             =   0
      Width           =   6135
   End
End
Attribute VB_Name = "frmSIS006"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim X As Integer
Dim rsMain As ADODB.Recordset
Dim SpCon As ADODB.Connection
Dim unPk As cUnPackName
Dim OpenErr As Integer
Dim iOpenMain As Integer
Dim iOpenAdt As Integer
Dim iOpenCmp As Integer
Function IsValid() As Integer
Dim iErr As Integer
Dim msg As String

IsValid = True
'--
If tbfld(0) = "" Then  ' Tax Code
   iErr = 97
   tbfld(0).SetFocus
   msg = "Tax Code is missing"
   GoTo Validate_Err
 End If
 tbfld(0) = UCase(tbfld(0))
 '--
 If tbfld(1) = "" Then ' Tax Description
   iErr = 98
   tbfld(1).SetFocus
   msg = "Tax Description is missing"
   GoTo Validate_Err
 End If
 tbfld(1) = Trim(tbfld(1))
 '--
 If meb.Text = "" Then  ' Tax Rate
   iErr = 99
   msg = "Tax Rate is missing"
   meb.SetFocus
   GoTo Validate_Err
 End If
 If Not IsNumeric(meb.Text) Then
    iErr = 28
    msg = "Tax Rate Not Numeric"
    meb.SetFocus
    GoTo Validate_Err
 End If
 '--
 
Validate_Exit:
   Exit Function
'--
Validate_Err:
  MsgBox msg, vbInformation, "Tax Rates"
  IsValid = False
  GoTo Validate_Exit
'--
End Function

Private Sub cmdCancel_Click()
Shutdown
Unload Me
End Sub

Private Sub cmdClear_Click()

If gblOptions = 1 Then
   ClearScreen
   tbfld(0).SetFocus
Else
   ClearScreen
   tbfld(1).SetFocus
End If
End Sub

Private Sub cmdUpdate_Click()
Dim strChg As Integer
Dim i As Integer
On Error GoTo cmdUpdate_Err
If IsValid Then
  '--
  i = RunSP(SpCon, "usp_TaxCodeUpdate", 0, tbfld(0), tbfld(1), CDbl(meb.Text), gblLoginName)
  If i <> 0 Then
      MsgBox "There was an error saving the changes. Please re-try"
      GoTo Done
  End If
  If gblOptions = 1 Then
     ClearScreen
  Else
     Shutdown
     Unload Me
  End If
End If
'---

Done:
 Exit Sub
'--
cmdUpdate_Err:
  'MsgBox "SIS006/cmdUpdate"
  'If strChg = 1 Then SPcon.RollbackTrans
  Shutdown
  Unload Me
End Sub
Private Sub Form_Activate()
' ready message
 frmMDI.txtStatusMsg.SimpleText = gblReadyMsg
 Screen.MousePointer = vbDefault
 frmMDI.txtStatusMsg.Refresh
 '--
 If OpenErr = True Then
  Shutdown
  Unload Me
 Else
   If gblOptions = 2 Then
      Me.Caption = "Edit Tax Rate"
      tbfld(0).Enabled = False
      UpdateScreen
   End If
End If
End Sub

Private Sub Form_Load()
Dim indx As Integer
Dim strTmp As String
On Error GoTo FL_ERR
'--
'-------------------------------------
'-- Initialize License Details -------
'-------------------------------------
 lblLabels(0).Caption = gblCompName
 lblLabels(1).Caption = App.Major & "." & App.Minor & "." & App.Revision
 '--
csvCenterForm Me, gblMDIFORM
'-----------------------------------
Set SpCon = New ADODB.Connection
With SpCon
     .ConnectionString = gblFileName
     .CursorLocation = adUseServer
     .ConnectionTimeout = 0
     '.Provider = "SQLOLEDB.1"
End With
SpCon.Open , , , adAsyncConnect
Do While SpCon.State = adStateConnecting
   Screen.MousePointer = vbHourglass
   frmMDI.txtStatusMsg.SimpleText = "Connecting, Please wait......"
   frmMDI.txtStatusMsg.Refresh
Loop
Screen.MousePointer = vbDefault

OpenErr = False
iOpenCmp = False
iOpenMain = False
iOpenAdt = False
iOpenMain = True
If gblOptions = 1 Then
  Me.Caption = "New Tax Rate"
Else
  UpdateScreen
End If
'--
   
FL_Exit:
  Exit Sub
FL_ERR:
  'MsgBox "SIS006/Load"
  MsgBox "Error on loading frmSis006"
  OpenErr = True
  On Error Resume Next
  Resume FL_Exit
   
End Sub
Private Sub UpdateScreen()
Dim i As Integer, bm As Variant
Set rsMain = RunSP(SpCon, "usp_TaxCodeEdit", 1, gblFileKey)
 With rsMain
    tbfld(0).Text = !ResCode
    tbfld(1).Text = !RESCTRY
    meb.Text = !taxrate
 End With
End Sub



Private Sub meb_KeyUp(KeyCode As Integer, Shift As Integer)
Select Case KeyCode
Case vbKeyReturn, vbKeyDown
  cmdUpdate.SetFocus
Case vbKeyUp
  tbfld(1).SetFocus
End Select
End Sub

Private Sub tbfld_KeyUp(Index As Integer, KeyCode As Integer, Shift As Integer)
Select Case KeyCode
Case vbKeyReturn, vbKeyDown
   Select Case Index
   Case 0
      tbfld(1).SetFocus
   Case 1
      meb.SetFocus
   End Select
Case vbKeyUp
   Select Case Index
   Case 1
     If gblOptions = 1 Then tbfld(0).SetFocus
   Case Else
   End Select
Case Else
End Select
End Sub

Private Sub ClearScreen()
  For X = 0 To 1
    tbfld(X).Text = ""
  Next
  meb.Text = ""
  If gblOptions = 2 Then
     UpdateScreen
     tbfld(1).SetFocus
  End If
End Sub

Private Sub Shutdown()
SpCon.Close
'''set cnn = nothing
End Sub
