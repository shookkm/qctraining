/******************************************************************************
 *
 * Filename:     plc.qc
 * Description:
 *
 * (c) COPYRIGHT QC Software, LLC 2017 All Rights Reserved
 * No part of this copyrighted work may be reproduced, modified, or distributed
 * in any form or by any means without the prior written permission of QC
 * Software, LLC.
 *
 * $Id: plc.qc 9567 2017-09-06 18:13:04Z wlw $
 * Notes:
 *
 *****************************************************************************/
/*****************************************************************************
 * Class ScannerToPlc
 *
 * This class is used to read the ScannerToPlc database table.
 ****************************************************************************/
Class ScannerToPlc
{
  Int sorterId, plcNo;
  String plcDivertAddress;

  /****************************************************************************
   * ScannerToPlc
   *
   * Call get the next set of lanes for a container.
   *
   * Input: scannerName, barcode
   *
   * Returns void
   ***************************************************************************/
  Method ScannerToPlc(String scannerName)
  {
    String filter;

    filter = "Where ScannerId = '" + scannerName + "'";
    DbReadClass(this, filter);

    Print("ScannerName: [" + scannerName + "]" +
          " SorterId: " + sorterId +
          " PlcNo: " + plcNo +
          " PlcAddress: [" + plcDivertAddress + "]");
  }
}

/*****************************************************************************
 * SendDivertMsg
 *
 * Send the divert msg to the PLC.
 *
 * Input: Int plc,
 *        String plcAddress, Int plcMsgLength,
 *        Int seqNo, Int primaryDest, Int secondaryDest,
 *        Int spare1, Int spare2
 *
 * Returns void
 ****************************************************************************/
Method SendDivertMsg(Int sorterId, 
                     Int plc, 
                     String plcAddress, 
                     Int plcMsgLength,
                     Int sequenceNo, 
                     Int primaryDest,
                     Int secondaryDest)
{
  Int
    plcCommand,
    plcWord1, plcWord2, plcWord3, plcWord4, plcWord5,
    plcWord6, plcWord7, plcWord8, plcWord9, plcWord10, plcWord11;

  Print("Sending Divert Msg...");
  Print("     PLC#: " + plc + " PLC Address: [" + plcAddress + "]" + 
        " MsgLen: " + plcMsgLength + " Seq#: " + sequenceNo +);
  Print("     Primary Lane#: " + primaryDest + 
        " Secondary Lane: " + secondaryDest);

  plcCommand = 201;

  plcWord1 = plcMsgLength;
  plcWord2  = plcCommand;
  plcWord3  = 0;
  plcWord4  = 0;
  plcWord5  = 0;
  plcWord6  = 0;
  plcWord7  = 0;
  plcWord8  = sorterId;
  plcWord9  = sequenceNo;
  plcWord10 = primaryDest;
  plcWord11 = secondaryDest;

  PlcWriteCmd(plc, plcAddress, plcMsgLength, plcCommand,
              plcWord1,plcWord2,plcWord3,plcWord4,plcWord5,
              plcWord6,plcWord7,plcWord8,plcWord9,plcWord10, plcWord11);
}
