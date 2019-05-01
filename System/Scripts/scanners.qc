/******************************************************************************
 *
 * Filename:     scanners.qc
 * Description:
 *
 * (c) COPYRIGHT QC Software, LLC 2017 All Rights Reserved
 * No part of this copyrighted work may be reproduced, modified, or distributed
 * in any form or by any means without the prior written permission of QC
 * Software, LLC.
 *
 * $Id: scanners.qc 9567 2017-09-06 18:13:04Z wlw $
 * Notes:
 *
 *****************************************************************************/
Method ScannerDefault(String scannerName, String barcode, String waveNo,
                      String sequenceNo)
{
  Lookup("SorterLookup", scannerName, barcode, sequenceNo);
}

/******************************************************************************
* Function Name: Lookup
*   Description: Main lookup function what that calls the specified
*                stored procedure.
*    Parameters: String lookupProc
*                String scannerName
*                String barcode
*                Int sequenceNo
*  Return Value:
*         Notes:
*****************************************************************************/
Method Lookup(String lookupProc,
              String scannerName,
              String barcode,
              String stringSequenceNo)
{
  Int
    containerStatus,
    outLaneNo,
    outReturnCode,
    outSecondaryLaneNo,
    outSequenceNo,
    sequenceNo
    waveNo;

  String
    clearMuZone,
    outReturnCodeMsg,
    stringLaneNo;

  sequenceNo = StringToInt(stringSequenceNo);

  Print("Location: [" + scannerName + "] Barcode: [" + barcode + "] Seq#: "
        + stringSequenceNo);

  scanner = New ScannerToPlc(scannerName);

  waveNo = 1;

  clearMuZone = "N";

  DbProc(lookupProc, In scanner.sorterId, In barcode, In waveNo,
         In sequenceNo, In scannerName, In clearMuZone, Out outSequenceNo,
         Out outLaneNo, Out outSecondaryLaneNo, Out containerStatus,
         Out outReturnCode, Out outReturnCodeMsg);
  DbCommit();

  If(outReturnCode != 0)
  {
    stringLaneNo = outLaneNo;
    SendLogMessage("FAULT", "SORTER_LOOKUP_ERROR",
                   "SORTER_ID", scannerName,
                   "CONTAINER_ID", barcode,
                   "LANE_NO", stringLaneNo,
                   "LOG_TEXT", outReturnCodeMsg);

    LogMaxNoReadNoRecord(outReturnCode, scannerName);
  }

  SendDivertMsg(scanner.sorterId, scanner.plcNo, scanner.plcDivertAddress, 20,
                outSequenceNo, outLaneNo, outSecondaryLaneNo);

  SendAssignedNoticeToStatMgr(scanner.sorterId,
                              outSequenceNo,
                              waveNo,
                              outLaneNo,
                              outSecondaryLaneNo,
                              containerStatus);

  If((barcode == "NOREAD") ||
     (barcode == "NODATA"))
  {
    SendInductNotice("eventMgr",
                     scannerName,
                     scanner.sorterId,
                     0,
                     barcode,
                     0);
  }
}

Method LogMaxNoReadNoRecord(Int returnCode, String scannerName)
{
  String
    outLogIt;

  DbProc("LookupLogNoReadMax", In returnCode, In scannerName,
         Out outLogIt);
  If(outLogIt == "Y")
  {
    SendLogMessage("FAULT", "SORTER_NOREAD_MAX",
                   "SCANNER_ID", scannerName);
  }

  DbProc("LookupLogNoRecordMax", In returnCode, In scannerName,
         Out outLogIt);
  If(outLogIt == "Y")
  {
    SendLogMessage("FAULT", "SORTER_NORECORD_MAX",
                   "SCANNER_ID", scannerName);
  }
}
