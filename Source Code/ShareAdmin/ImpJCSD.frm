VERSION 5.00
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "COMCTL32.OCX"
Begin VB.Form ImpJCSD 
   BackColor       =   &H0080C0FF&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Import Stock Exchange Payments"
   ClientHeight    =   3300
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4785
   Icon            =   "ImpJCSD.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3300
   ScaleWidth      =   4785
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton cmdStart 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "&Start"
      Default         =   -1  'True
      Height          =   300
      Left            =   2520
      TabIndex        =   3
      Top             =   2880
      Width           =   975
   End
   Begin VB.CommandButton cmdCancel 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "&Cancel"
      Height          =   300
      Left            =   3600
      TabIndex        =   2
      Top             =   2880
      Width           =   1095
   End
   Begin ComctlLib.ProgressBar ProgressBar1 
      Height          =   252
      Left            =   240
      TabIndex        =   1
      Top             =   2160
      Width           =   4332
      _ExtentX        =   7646
      _ExtentY        =   450
      _Version        =   327682
      Appearance      =   1
   End
   Begin VB.Label lbl 
      BackColor       =   &H00FFFFFF&
      BorderStyle     =   1  'Fixed Single
      Caption         =   "display Key Field"
      Height          =   372
      Left            =   600
      TabIndex        =   0
      Top             =   1080
      Width           =   3372
   End
End
Attribute VB_Name = "ImpJCSD"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim rsMain As ADODB.Recordset
Dim rsMnDte As ADODB.Recordset
Dim iRecs As Long, iRecsAdded As Long
Dim AppExcl As Excel.Application
Dim X As Integer, Y As Integer, curCell As Object, nextCol As Object
Dim nextCell As Object, txtfile As String
Dim qSQL As String
Dim SpCon As ADODB.Connection

Private Sub cmdCancel_Click()
Unload Me
Set ImpJCSD = Nothing
End Sub

Private Sub CmdStart_Click()
Dim iResp As Integer
Dim sMsg As String, sTitle As String
Dim sErrMsgL1 As String, sErrMsgL2 As String, sErrMsg As String
Dim iAcnt As Long, iCBL As Double, iRat As Single
Dim sNam As String, sAD1 As String, sAD2 As String, sAd3 As String, sTax As String
Dim i As Integer
Dim MndAcntNme As String
Dim MndName As String
Dim MndAddr1 As String, MndAddr2 As String, MndAddr3 As String
Dim MndAcnt As String
Dim Jnt1 As String, Jnt2 As String, Jnt3 As String

sErrMsgL1 = "Update failed while clearing balances of "
sErrMsgL2 = " Note this error."

'--
sMsg = "WARNING: This procedure will will delete existing " & gblHold & " Sub Ledger Records"
sMsg = sMsg & "  then recreate them from the XL Import file. Select No if "
sMsg = sMsg & " you are unsure or accidentally selected this option."
sMsg = sMsg & " Do you want to continue?"
sTitle = "Building Stock Exchange data"
iResp = MsgBox(sMsg, vbExclamation + vbYesNo, sTitle)
If iResp = vbNo Then
  cmdCancel_Click
  Exit Sub
End If
'--
lbl.Caption = "Clearing existing files"
lbl.Visible = True
i = RunSP(SpCon, "usp_DeleteSE", 0, gblReply)
If i <> 0 Then
  GoTo ImpJCSD_Fail
  Exit Sub
End If

'--
'''On Error GoTo ImpJCSD_Fail
sErrMsg = "Procedure failed when trying to activate EXCEL"
Set AppExcl = CreateObject("Excel.application")
lbl.Caption = "Recreating " & gblHold & " SUB Ledger for"

txtfile = frmMDI.CmnDialog.FileName
Screen.MousePointer = vbHourglass
frmMDI.txtStatusMsg.SimpleText = "Recreating " & gblHold & " Payments..."
frmMDI.txtStatusMsg.Refresh
'--
sErrMsg = "Procedure failed/check if " & gblHold & " changed the format of the XL Sheet"
With AppExcl
  .Workbooks.Open (txtfile)
  Set curCell = .Worksheets(1).Range("E2")
  Do While Not IsEmpty(curCell)
    iRecs = iRecs + 1
    Set nextCell = curCell.Offset(1, 0)
    Set curCell = nextCell
  Loop
  InitProgressBar (iRecs)
  iRecs = 0: iRecsAdded = 0
  ProgressBar1.Visible = True
  '--Updating subledger routine
  '--
  Set curCell = .Worksheets(1).Range("E2")
  Do While Not IsEmpty(curCell)
    sErrMsg = "Procedure failed while formatting/check if " & gblHold & " changed the format of the XL Sheet"
    Set nextCol = curCell.Offset(0, 0) '- account number
    If IsNumber(nextCol.Value) Then
       iAcnt = nextCol.Value
    Else
       iAcnt = ConvertToNumber(nextCol.Value)
    End If
    lbl.Caption = "Recreating " & gblHold & " SUB Ledger for " & iAcnt
    lbl.Refresh
    Set nextCol = curCell.Offset(0, 5) '-account name
    sNam = nextCol.Value
    Set nextCol = curCell.Offset(0, 6) '-Joint name 1
    If Not IsEmpty(curCell) Then
       Jnt1 = nextCol.Value
    Else
       Jnt1 = ""
    End If
    Set nextCol = curCell.Offset(0, 7) '-Joint name 2
    If Not IsEmpty(curCell) Then
       Jnt2 = nextCol.Value
    Else
       Jnt2 = ""
    End If
    Set nextCol = curCell.Offset(0, 8) '-Joint name 3
    If Not IsEmpty(curCell) Then
       Jnt3 = nextCol.Value
    Else
       Jnt3 = ""
    End If
    Set nextCol = curCell.Offset(0, 12) '-address line 1
    sAD1 = nextCol.Value
    Set nextCol = curCell.Offset(0, 13) '-address line 2A
    sAD2 = nextCol.Value
    Set nextCol = curCell.Offset(0, 14) '-address line 2B
    If Not IsEmpty(curCell) Then
       sAD2 = Trim(sAD2) & " " & Trim(nextCol.Value)
    End If
    
    Set nextCol = curCell.Offset(0, 16) '-address line 3A
    sAd3 = nextCol.Value
    Set nextCol = curCell.Offset(0, 15) '-address line 3B
    If Not IsEmpty(curCell) Then
       sAd3 = Trim(sAd3) & " " & Trim(nextCol.Value)
    End If
    Set nextCol = curCell.Offset(0, 17) '-address line 3C
    If Not IsEmpty(curCell) Then
       If Trim(nextCol.Value) = "JAM" Then
          sAd3 = sAd3
       Else
          sAd3 = Trim(sAd3) & " " & Trim(nextCol.Value)
       End If
    End If
    
    Set nextCol = curCell.Offset(0, 21) '-stocks
    iCBL = nextCol.Value
    
    
    sErrMsg = "Procedure failed in writing to JCSD Sub ledger"
    If IsNothing(sAD1) Then
       sAD1 = " "
    End If
    If IsNothing(sAD2) Then
       sAD2 = " "
    End If
    If IsNothing(sAd3) Then
       sAd3 = " "
    End If
    
    i = RunSP(SpCon, "usp_ImportSEData", 0, CLng(iAcnt), sNam, sAD1, sAD2, sAd3, CDbl(iCBL), iRat, gblReply, Jnt1, Jnt2, Jnt3)
    
    iRecsAdded = iRecsAdded + 1  'count records added
    
       
    Set nextCol = curCell.Offset(0, 36) '-MndAcntName
    If nextCol = "" Then
       MndAcntNme = " "
       GoTo Commit_Check
    End If
    
    MndAcntNme = Trim(nextCol.Value)
    
        
    Set nextCol = curCell.Offset(0, 37) ' -MndName
    If nextCol = "" Then
       MndName = "."
       Else
       MndName = Trim(nextCol.Value)
    End If
    
    Set nextCol = curCell.Offset(0, 38) ' -MndAddr1
    If nextCol = "" Then
       MndAddr1 = "."
       Else
       MndAddr1 = Trim(nextCol.Value)
    End If
    
    Set nextCol = curCell.Offset(0, 39) ' -MndAddr2
    If nextCol = "" Then
       MndAddr2 = "."
       Else
       MndAddr2 = Trim(nextCol.Value)
    End If

    Set nextCol = curCell.Offset(0, 42) ' -MndAddr3
    If nextCol = "" Then
       MndAddr3 = "."
       Else
       MndAddr3 = Trim(nextCol.Value)
    End If
    Set nextCol = curCell.Offset(0, 44) 'MndAcnt
    If Len(Trim(nextCol.Value)) > 16 Then
       MndAcnt = 0
       GoTo MnDteUpdate
    End If
    If nextCol <> 0 Then
       MndAcnt = CStr(Trim(nextCol.Value))
    End If
        
MnDteUpdate:
    If MndName = "BCN JAMAICA LIMITED" Then
       i = 0
    End If
    If iAcnt = "98223257" Then
       iAcnt = iAcnt
    End If
    
    i = RunSP(SpCon, "usp_ImportSEMandateData", 0, iAcnt, MndAcnt, _
        MndAcntNme, MndName, MndAddr1, MndAddr2, MndAddr3, gblReply)

Commit_Check:
    iRecs = iRecs + 1
    ProgressBar1.Value = iRecs
    Set nextCell = curCell.Offset(1, 0)
    Set curCell = nextCell
  Loop
  sErrMsg = "Procedure failed in closing EXCEL spread sheet"
 ' .ActiveWorkbook.Save
 .Workbooks.Close
 AppExcl.Quit
End With

'--
CmdStart.Enabled = False
SpCon.Close

'-- display success message
lbl.Caption = ""
ProgressBar1.Visible = False
MsgBox "Update successfull. Select Ok to clear this message, then Cancel to end."
frmMDI.txtStatusMsg.SimpleText = gblReadyMsg
Screen.MousePointer = vbDefault
frmMDI.txtStatusMsg.Refresh
Exit Sub
Open_err:
  MsgBox "Fail to Open Existing " & gblHold & " Sub-Legder; update aborting. "
  Exit Sub
ImpJCSD_Fail:
   MsgBox sErrMsg
   cmdCancel_Click
   Exit Sub
End Sub
Private Sub InitProgressBar(max As Long)
  If max = 0 Then Exit Sub
    ProgressBar1.Min = 0
    ProgressBar1.max = max
    ProgressBar1.Visible = True

'Set the Progress's Value to Min.
    ProgressBar1.Value = ProgressBar1.Min

End Sub
Private Sub Form_Load()
csvCenterForm Me, gblMDIFORM
'ready Message
frmMDI.txtStatusMsg.SimpleText = gblReadyMsg
Screen.MousePointer = vbDefault
frmMDI.txtStatusMsg.Refresh
ProgressBar1.Visible = False
lbl.Caption = ""
lbl.Visible = False
'--

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
Me.Caption = "Import " & gblHold & " Payments"

FL_Exit:
Exit Sub
End Sub


