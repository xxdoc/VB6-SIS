VERSION 5.00
Object = "{8D650141-6025-11D1-BC40-0000C042AEC0}#3.0#0"; "ssdw3b32.ocx"
Begin VB.Form FrmCreateChqPrintFile 
   BackColor       =   &H80000013&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Create Cheque Print File"
   ClientHeight    =   3360
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   4680
   Icon            =   "FrmCreateChqPrintFile.frx":0000
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3360
   ScaleWidth      =   4680
   StartUpPosition =   3  'Windows Default
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
      Left            =   3240
      TabIndex        =   5
      Top             =   2640
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
      TabIndex        =   4
      Top             =   2640
      Width           =   1335
   End
   Begin VB.CheckBox ChkSkip 
      BackColor       =   &H80000013&
      Caption         =   "Skip first cheque"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   120
      TabIndex        =   3
      ToolTipText     =   "Tick to allow the print to skip te first cheque in the sequence"
      Top             =   2040
      Width           =   1935
   End
   Begin VB.TextBox TxtChqNum 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   2160
      Locked          =   -1  'True
      TabIndex        =   2
      Top             =   1440
      Width           =   2415
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
      Left            =   120
      Locked          =   -1  'True
      TabIndex        =   0
      Top             =   120
      Width           =   4455
   End
   Begin SSDataWidgets_B.SSDBCombo SSDBAccount 
      Height          =   375
      Left            =   2160
      TabIndex        =   6
      Top             =   840
      Width           =   2415
      DataFieldList   =   "Column 0"
      _Version        =   196617
      DataMode        =   2
      BeginProperty HeadFont {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      RowHeight       =   503
      Columns.Count   =   2
      Columns(0).Width=   5741
      Columns(0).Caption=   "Account Number"
      Columns(0).Name =   "Account Number"
      Columns(0).DataField=   "Column 0"
      Columns(0).DataType=   8
      Columns(0).FieldLen=   256
      Columns(1).Width=   2275
      Columns(1).Caption=   "Currency"
      Columns(1).Name =   "Currency"
      Columns(1).DataField=   "Column 1"
      Columns(1).DataType=   8
      Columns(1).FieldLen=   256
      _ExtentX        =   4260
      _ExtentY        =   661
      _StockProps     =   93
      BackColor       =   -2147483643
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      DataFieldToDisplay=   "Column 0"
   End
   Begin VB.Label Label2 
      BackColor       =   &H80000013&
      Caption         =   "Select the currency"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   120
      TabIndex        =   7
      Top             =   840
      Width           =   2055
   End
   Begin VB.Label Label1 
      BackColor       =   &H80000013&
      Caption         =   "Cheque Number"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   120
      TabIndex        =   1
      Top             =   1560
      Width           =   1695
   End
End
Attribute VB_Name = "FrmCreateChqPrintFile"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim SpCon As ADODB.Connection
Dim OriginalNo As Long
Dim iExchABBR As String

Private Sub ChkSkip_Click()
On Error GoTo Err_ChkSkip_Click

If ChkSkip = 1 Then
   TxtChqNum = OriginalNo + 1
Else
   TxtChqNum = OriginalNo
End If
Exit_ChkSkip_Click:
Exit Sub

Err_ChkSkip_Click:
MsgBox Err & " " & Err.Description, vbOKOnly, "Error on skipping next account number"
Resume Exit_ChkSkip_Click
End Sub

Private Sub CmdExit_Click()
On Error GoTo Err_CmdExit_Click

Unload Me

Exit_cmdExit_Click:
Exit Sub

Err_CmdExit_Click:
MsgBox Err & " " & Err.Description, vbOKOnly, "Error on closing create cheque print file screen"
Resume Exit_cmdExit_Click
End Sub

Private Sub CmdStart_Click()
On Error GoTo Err_CmdStart_Click
Dim i As Integer
Dim tSkip As Integer

If OriginalNo = 0 Then
   MsgBox "Unable to process as no cheque number was found"
   GoTo Exit_CmdStart_Click
End If

If SSDBAccount = "" Then
   MsgBox "Please select a currency first"
   GoTo Exit_CmdStart_Click
End If
If ChkSkip = 1 Then
   tSkip = 1
Else
   tSkip = 0
End If

i = RunSP(SpCon, "usp_MakeChq", 0, SSDBAccount.Columns(0).Text, CLng(TxtChqNum), SSDBAccount.Columns(1).Text, iExchABBR, tSkip)
If i <> 0 Then
   MsgBox "Error on the cheque numbering exercise. Please try again"
   GoTo Exit_CmdStart_Click
Else
   MsgBox "Cheque numbering was successfull. You may now print cheques"
End If

Exit_CmdStart_Click:
Exit Sub

Err_CmdStart_Click:
MsgBox Err & " " & Err.Description, vbOKOnly, "Error on retrieving current ledger"
Resume Exit_CmdStart_Click
End Sub

Private Sub Form_Activate()
On Error GoTo Err_Form_Activate
Dim adoRst As ADODB.Recordset

Set adoRst = RunSP(SpCon, "usp_SelectLedger", 1)
If adoRst.EOF Then
   MsgBox "No ledger found. Unable to proceed"
   GoTo Exit_Form_Activate
Else
   TxtRegister = adoRst!StockExchange
   iExchABBR = adoRst!ExchangeABBR
End If
SSDBAccount.SetFocus
OriginalNo = 0

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

End Sub

Private Sub SSDBAccount_Click()
On Error GoTo Err_SSDBAccount_Click
Dim adoRst As ADODB.Recordset
Dim StrSql As String

Set adoRst = RunSP(SpCon, "usp_NextAvailableChqNo", 1, SSDBAccount.Columns(0).Text, iExchABBR, "C")
If IsNull(adoRst!StartingNo) Or adoRst!StartingNo = "No Chqs found" Then
   MsgBox "Divdend inventory is empty. Unable to proceed"
Else
   If adoRst!StartingNo = "Already exists" Then
      StrSql = "Cheque numbers already assigned for " & SSDBAccount.Columns(1).Text & vbCrLf
      StrSql = StrSql & "in " & TxtRegister
      MsgBox StrSql
   Else
      OriginalNo = adoRst!StartingNo
      TxtChqNum = OriginalNo
   End If
End If

Exit_SSDBAccount_Click:
Exit Sub
Err_SSDBAccount_Click:
MsgBox Err & " " & Err.Description, vbOKOnly, "Error on selecting accounts"
Resume Exit_SSDBAccount_Click
End Sub

Private Sub SSDBAccount_InitColumnProps()
On Error GoTo Err_SSDBAccount_InitColumnProps
Dim StrSql As String
Dim adoRst As ADODB.Recordset
Dim i As Integer

Set adoRst = RunSP(SpCon, "usp_ListActiveAccounts", 1)
If adoRst.EOF Then
   MsgBox "Accounts were not setup" & vbCrLf & "Please do so now", vbCritical, "Account Error"
   GoTo Exit_SSDBAccount_InitColumnProps
End If

'adoRst.MoveFirst
With SSDBAccount
     .RemoveAll
     Do While Not adoRst.EOF
     StrSql = adoRst!AccountNo & vbTab & adoRst!Currency & vbTab
     .AddItem StrSql
     'If adoRst!CurrencyType = "L" Then
     '   i = .Rows
     'End If
     adoRst.MoveNext
     StrSql = ""
     Loop
     '.Bookmark = .GetBookmark(i - 1)
     ' SSDBAccount = .Columns(0).CellText(i - 1)
End With

adoRst.Close
Set adoRst = Nothing
Exit_SSDBAccount_InitColumnProps:
Exit Sub

Err_SSDBAccount_InitColumnProps:
MsgBox Err & " " & Err.Description, vbOKOnly, "Error on listing active accounts"
Resume Exit_SSDBAccount_InitColumnProps
End Sub
