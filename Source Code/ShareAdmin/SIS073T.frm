VERSION 5.00
Object = "{8D650141-6025-11D1-BC40-0000C042AEC0}#3.0#0"; "ssdw3b32.ocx"
Begin VB.Form frmSIS073T 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "T & T Client Payments History"
   ClientHeight    =   4650
   ClientLeft      =   1095
   ClientTop       =   330
   ClientWidth     =   8985
   Icon            =   "SIS073T.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   4650
   ScaleWidth      =   8985
   Begin VB.CommandButton CmdPrint 
      Caption         =   "&Print"
      Height          =   375
      Left            =   2280
      TabIndex        =   9
      Top             =   4200
      Width           =   1095
   End
   Begin SSDataWidgets_B.SSDBGrid grd 
      Height          =   2412
      Left            =   360
      TabIndex        =   8
      Top             =   1440
      Width           =   8016
      _Version        =   196617
      DataMode        =   2
      Col.Count       =   6
      AllowUpdate     =   0   'False
      RowHeight       =   423
      Columns.Count   =   6
      Columns(0).Width=   2143
      Columns(0).Caption=   "Declaration"
      Columns(0).Name =   "Declaration"
      Columns(0).Alignment=   1
      Columns(0).DataField=   "Column 0"
      Columns(0).DataType=   7
      Columns(0).NumberFormat=   "dd-mmm-yyyy"
      Columns(0).FieldLen=   11
      Columns(1).Width=   1931
      Columns(1).Caption=   "Cheque #"
      Columns(1).Name =   "Cheque #"
      Columns(1).DataField=   "Column 1"
      Columns(1).DataType=   2
      Columns(1).FieldLen=   10
      Columns(2).Width=   2143
      Columns(2).Caption=   "Payment Date"
      Columns(2).Name =   "Payment Date"
      Columns(2).DataField=   "Column 2"
      Columns(2).DataType=   8
      Columns(2).NumberFormat=   "dd-mmm-yyyy"
      Columns(2).FieldLen=   11
      Columns(3).Width=   2752
      Columns(3).Caption=   "Amount"
      Columns(3).Name =   "Amount"
      Columns(3).Alignment=   1
      Columns(3).DataField=   "Column 3"
      Columns(3).DataType=   6
      Columns(3).NumberFormat=   "CURRENCY"
      Columns(3).FieldLen=   12
      Columns(4).Width=   2037
      Columns(4).Caption=   "Returned"
      Columns(4).Name =   "Returned"
      Columns(4).DataField=   "Column 4"
      Columns(4).DataType=   11
      Columns(4).FieldLen=   5
      Columns(5).Width=   3200
      Columns(5).Caption=   "Replacement Cheque"
      Columns(5).Name =   "Replacement Cheque"
      Columns(5).DataField=   "Column 5"
      Columns(5).DataType=   8
      Columns(5).FieldLen=   256
      _ExtentX        =   14139
      _ExtentY        =   4254
      _StockProps     =   79
      BeginProperty PageFooterFont {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BeginProperty PageHeaderFont {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin VB.CommandButton cmdOk 
      Caption         =   "&Ok"
      Height          =   300
      Left            =   6240
      TabIndex        =   0
      Top             =   4200
      Width           =   975
   End
   Begin VB.Label lb 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   255
      Index           =   1
      Left            =   1920
      TabIndex        =   7
      Top             =   1080
      Width           =   4695
   End
   Begin VB.Label lb 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   255
      Index           =   0
      Left            =   1920
      TabIndex        =   6
      Top             =   720
      Width           =   1935
   End
   Begin VB.Line Line3 
      BorderWidth     =   2
      Index           =   1
      X1              =   0
      X2              =   8900
      Y1              =   4080
      Y2              =   4080
   End
   Begin VB.Line Line1 
      BorderWidth     =   2
      X1              =   0
      X2              =   7680
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
      TabIndex        =   4
      Top             =   0
      Width           =   855
   End
   Begin VB.Label lblLabels 
      Alignment       =   1  'Right Justify
      Caption         =   "Name:"
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
      Left            =   600
      TabIndex        =   3
      Top             =   1080
      Visible         =   0   'False
      Width           =   1260
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
      TabIndex        =   2
      Top             =   0
      Width           =   375
   End
   Begin VB.Label lblLabels 
      Alignment       =   1  'Right Justify
      Caption         =   "Client Number:"
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
      Left            =   360
      TabIndex        =   1
      Top             =   720
      Width           =   1500
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
      Left            =   0
      TabIndex        =   5
      Top             =   0
      Width           =   7695
   End
End
Attribute VB_Name = "frmSIS073T"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim rsMain As ADODB.Recordset
Dim OpenErr As Integer
Dim SpCon As ADODB.Connection

Private Sub cmdOk_Click()
rsMain.Close
Set rsMain = Nothing
Unload Me
Set frmSIS073T = Nothing
frmSIS070T.Visible = True
End Sub

Private Sub cmdPrint_Click()
On Error GoTo Err_CmdPrint_Click

FrmSIS103.Show

Exit_CmdPrint_Click:
Exit Sub
Err_CmdPrint_Click:
MsgBox "SIS073T/Print"
    OpenErr = True
GoTo Exit_CmdPrint_Click

End Sub

Private Sub Form_Activate()
If OpenErr = True Then
  Unload Me
End If
End Sub

Private Sub Form_Load()
Dim qSQL As String
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
OpenErr = False
Set rsMain = New ADODB.Recordset
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
frmMDI.txtStatusMsg.SimpleText = gblReadyMsg

Set rsMain = RunSP(SpCon, "usp_FindDividendsTT", 1, gblFileKey)
UpdateScreen
' ready message
frmMDI.txtStatusMsg.SimpleText = gblReadyMsg
Screen.MousePointer = vbDefault
frmMDI.txtStatusMsg.Refresh
FL_Exit:
  Exit Sub
FL_ERR:
  MsgBox Err.Description, , "SIS073T/Load"
    OpenErr = True
  On Error Resume Next
  Resume FL_Exit
End Sub
Private Sub UpdateScreen()
 Dim sRowinfo As String
 Dim RepNo As String
 
 lb(0).Caption = frmSIS070T.grd.Columns(1).Text
 lb(1).Caption = frmSIS070T.grd.Columns(0).Text
 With rsMain
    If Not .EOF Then
      grd.RemoveAll
      Do While Not .EOF
        sRowinfo = !DECDATE & vbTab & !CHQNUM & vbTab
        sRowinfo = sRowinfo & !CHQDAT & vbTab & !ChqAmt
        sRowinfo = sRowinfo & vbTab & !reconind & vbTab
        If IsNull(!RepChqNo) Or !RepChqNo = 0 Then
           RepNo = " "
        Else
           RepNo = !RepChqNo
        End If
        sRowinfo = sRowinfo & RepNo
        grd.AddItem sRowinfo
        .MoveNext
      Loop
    End If
  End With
End Sub

Private Sub Form_Unload(Cancel As Integer)
SpCon.Close
End Sub
