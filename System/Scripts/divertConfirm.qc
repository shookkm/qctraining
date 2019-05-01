/******************************************************************************
 *
 * Filename:     divertConfirm.qc
 * Description:
 *
 * (c) COPYRIGHT QC Software, LLC 2017 All Rights Reserved
 * No part of this copyrighted work may be reproduced, modified, or distributed
 * in any form or by any means without the prior written permission of QC
 * Software, LLC.
 *
 * $Id: divertConfirm.qc 9567 2017-09-06 18:13:04Z wlw $
 * Notes:
 *
 *****************************************************************************/
Method DivertConfirm(String stringPlcNo,
                     String stringSequenceNo,
                     String stringSortedLaneNo,
                     String stringReturnCode,
                     String stringSortedId)
{
  Int
    assignedLaneNo,
    inPlcNo,
    inSequenceNo,
    inSorterId,
    inSortStatus,
    inSortedLaneNo,
    returnCode,
    sortedLaneNo,
    sorterId,
    waveNo;
  String
    updateMuZone,
    barcode,
    stringAssignedLaneNo,
    returnCodeMsg;

  inSequenceNo = StringToInt(stringSequenceNo);
  inSortStatus = StringToInt(stringReturnCode);
  inSorterId = StringToInt(stringSortedId);
  inSortedLaneNo = StringToInt(stringSortedLaneNo);
  inPlcNo = StringToInt(stringPlcNo);

  updateMuZone = "N";

  Print("DivertConfirm:  PlcNo: " + inPlcNo +
        " Sorter#: " + stringSortedId +
        " Seq#: " + inSequenceNo +
        " ActualLane: " + inSortedLaneNo +
        " Status: " + inSortStatus);

  DbProc("ContainerDivertedByToteMgr",
         In inSorterId, In inSequenceNo, In inSortedLaneNo, In inSortStatus,
         In updateMuZone,
         Out barcode, Out waveNo, Out sorterId,
         Out assignedLaneNo, Out sortedLaneNo,
         Out returnCode, Out returnCodeMsg);

  DbCommit();
  
  stringAssignedLaneNo = assignedLaneNo;

  If(inSortStatus != 0)
    SendLogMessage("WARNING", "SORTER_DIVERT_ERROR",
                   "SORTER_ID", stringSortedId,
                   "BARCODE", barcode,
                   "ASSIGNED_LANE_NO", stringAssignedLaneNo,
                   "SORTED_LANE_NO", stringSortedLaneNo,
                   "LOG_TEXT", returnCodeMsg);

  Print("Wave#: " + waveNo);

  SendSortNoticeToStatMgr(sorterId,
                          inSequenceNo,
                          waveNo,
                          assignedLaneNo,
                          sortedLaneNo,
                          returnCode,
                          inSortStatus);
}
