VERSION 5.00
Object = "{C4847593-972C-11D0-9567-00A0C9273C2A}#8.0#0"; "crviewer.dll"
Begin VB.Form FrmPrintTaxChq 
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Print Tax Cheque"
   ClientHeight    =   7140
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   12540
   Icon            =   "FrmPrintTaxChq.frx":0000
   MinButton       =   0   'False
   ScaleHeight     =   7140
   ScaleWidth      =   12540
   StartUpPosition =   3  'Windows Default
   Begin CRVIEWERLibCtl.CRViewer CRV 
      Height          =   5175
      Left            =   120
      TabIndex        =   5
      Top             =   1080
      Width           =   12375
      DisplayGroupTree=   -1  'True
      DisplayToolbar  =   -1  'True
      EnableGroupTree =   -1  'True
      EnableNavigationControls=   -1  'True
      EnableStopButton=   -1  'True
      EnablePrintButton=   0   'False
      EnableZoomControl=   -1  'True
      EnableCloseButton=   -1  'True
      EnableProgressControl=   -1  'True
      EnableSearchControl=   -1  'True
      EnableRefreshButton=   -1  'True
      EnableDrillDown =   -1  'True
      EnableAnimationControl=   -1  'True
      EnableSelectExpertButton=   0   'False
      EnableToolbar   =   -1  'True
      DisplayBorder   =   -1  'True
      DisplayTabs     =   -1  'True
      DisplayBackgroundEdge=   -1  'True
      SelectionFormula=   ""
      EnablePopupMenu =   -1  'True
      EnableExportButton=   0   'False
      EnableSearchExpertButton=   0   'False
      EnableHelpButton=   0   'False
   End
   Begin VB.TextBox TxtTaxChq 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   8880
      Locked          =   -1  'True
      TabIndex        =   4
      Top             =   600
      Width           =   2775
   End
   Begin VB.CommandButton CmdExit 
      Caption         =   "Exit"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   615
      Left            =   10920
      TabIndex        =   2
      Top             =   6360
      Width           =   1215
   End
   Begin VB.CommandButton CmdStart 
      Caption         =   "Start"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   615
      Left            =   120
      TabIndex        =   1
      Top             =   6360
      Width           =   1335
   End
   Begin VB.TextBox TxtRegister 
      Alignment       =   2  'Center
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   14.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   3720
      Locked          =   -1  'True
      TabIndex        =   0
      Top             =   120
      Width           =   4455
   End
   Begin VB.Image ImgPrinter 
      Height          =   465
      Left            =   10200
      Picture         =   "FrmPrintTaxChq.frx":030A
      Stretch         =   -1  'True
      ToolTipText     =   "Click to send to printer"
      Top             =   120
      Visible         =   0   'False
      Width           =   660
   End
   Begin VB.Label Label1 
      Caption         =   "Please ensure the cheque number to the right is in the printer"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   120
      TabIndex        =   3
      Top             =   600
      Width           =   8655
   End
End
Attribute VB_Name = "FrmPrintTaxChq"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim SpCon As ADODB.Connection
Dim FormHeight As Integer
Dim FormWidth As Integer
Dim PrintSw As Boolean

Private Sub CmdExit_Click()
On Error GoTo Err_CmdExit_Click

Unload Me
Set FrmPrintTaxChq = Nothing
frmSIS013.Visible = True
Exit_cmdExit_Click:
Exit Sub

Err_CmdExit_Click:
MsgBox Err & " " & Err.Description, vbOKOnly, "Error on closing create cheque print file screen"
Resume Exit_cmdExit_Click
End Sub

Private Sub CmdStart_Click()
On Error GoTo Err_CmdStart_Click
Dim adoRs As ADODB.Recordset

Set cr = New crNCB018T
Set adoRs = RunSP(SpCon, "usp_PrintTaxChq", 1)
Screen.MousePointer = vbDefault
If Not adoRs.EOF Then
   cr.PrinterSetup Me.hwnd
   cr.Database.SetDataSource adoRs
   CRV.ReportSource = cr
   CRV.ViewReport
   ImgPrinter.Visible = True
End If

Exit_CmdStart_Click:
Exit Sub

Err_CmdStart_Click:
MsgBox Err & " " & Err.Description, vbOKOnly, "Error on printing tax cheque"
Resume Exit_CmdStart_Click
End Sub
Private Sub CRV_PrintButtonClicked(UseDefault As Boolean)
PrintSw = True
If Err.Number = 20545 Then
   MsgBox "Print cancelled"
End If

End Sub

Private Sub Form_Activate()
'On Error GoTo Err_Form_Activate
Dim adoRst As ADODB.Recordset

Set adoRst = RunSP(SpCon, "usp_SelectLedger", 1)
If adoRst.EOF Then
   MsgBox "No ledger found. Unable to proceed"
   GoTo Exit_Form_Activate
Else
   TxtRegister = adoRst!StockExchange
End If
Set adoRst = RunSP(SpCon, "usp_SelectTaxCheque", 1)
If gblReply = 2 Then
   MsgBox "Tax Cheque already printed", vbOKOnly
   CmdExit_Click
   GoTo Exit_Form_Activate
End If

If adoRst.EOF Or adoRst!TaxChq = 0 Then
   MsgBox "No Cheques found. Unable to proceed"
   GoTo Exit_Form_Activate
Else
   TxtTaxChq = adoRst!TaxChq
End If

Exit_Form_Activate:
Exit Sub

Err_Form_Activate:
MsgBox Err & " " & Err.Description, vbOKOnly, "Error on retrieving current ledger"
Resume Exit_Form_Activate

End Sub

Private Sub Form_Load()
csvCenterForm Me, gblMDIFORM
Set SpCon = New ADODB.Connection
With SpCon
     .ConnectionString = gblFileName
     .CursorLocation = adUseClient
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
frmMDI.txtStatusMsg.SimpleText = gblReadyMsg
frmMDI.txtStatusMsg.Refresh
FormHeight = Me.ScaleHeight
FormWidth = Me.ScaleWidth
End Sub
Private Sub Form_Resize()
'Me.CRV.Width = Me.ScaleWidth
'Me.CRV.Height = (Me.ScaleHeight - Me.CRV.Top)
Me.CRV.Width = Me.CRV.Width / FormWidth * Me.ScaleWidth
Me.CRV.Height = Me.CRV.Height / FormHeight * Me.ScaleHeight
CmdExit.Left = CmdExit.Left / FormWidth * Me.ScaleWidth
CmdExit.Top = CmdExit.Top / FormHeight * Me.ScaleHeight
CmdStart.Left = CmdStart.Left / FormWidth * Me.ScaleWidth
CmdStart.Top = CmdStart.Top / FormHeight * Me.ScaleHeight
FormWidth = Me.ScaleWidth
FormHeight = Me.ScaleHeight
End Sub

Private Sub ImgPrinter_Click()
On Error GoTo Exit_ImgPrinter_Click
Dim iReply As Integer
Dim i As Integer
Dim msg As String

frmPrintOut.Show vbModal
If gblFileKey <> "0" Then
   GoTo Exit_ImgPrinter_Click
End If

msg = "Did the Tax cheque print without errors?"
iReply = MsgBox(msg, vbQuestion + vbYesNo, "Tax Cheque")
If iReply = vbYes Then
   i = RunSP(SpCon, "usp_RecordTaxChq", 0, CLng(TxtTaxChq))
   If i = 0 Then
      MsgBox "Tax cheque updated in system"
      GoTo Exit_ImgPrinter_Click
   Else
       MsgBox "Tax Cheque update failed"
       GoTo Exit_ImgPrinter_Click
   End If
Else
    msg = "Was Cheque Number " & TxtTaxChq & " spoilt?"
    iReply = MsgBox(msg, vbQuestion + vbYesNo, "Spoilt Tax Cheque")
    If iReply = vbYes Then
       i = RunSP(SpCon, "usp_RecordSpoiltTaxChq", 0, CLng(TxtTaxChq))
       If i = 0 Then
          MsgBox "Spoilt Tax cheque updated in system"
          GoTo Exit_ImgPrinter_Click
       Else
          MsgBox "Spolit Tax Cheque update failed"
          GoTo Exit_ImgPrinter_Click
       End If
    End If
End If
Exit_ImgPrinter_Click:
Exit Sub

Err_ImgPrinter_Click:
MsgBox Err & " " & Err.Description, vbOKOnly, "Error printing tax cheque"
Resume Exit_ImgPrinter_Click
End Sub
