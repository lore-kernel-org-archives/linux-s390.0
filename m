Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DED73716F;
	Fri,  9 Feb 2024 12:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707482735; cv=none; b=n1sd7TrOFRlqR9loW058YtBBIGmfph8RkB6b0w8jVXRT0eOTFYJ4hhvjeHksp1zcov8pRszeeqCQRTLslEBE1tiNSEePvvfC0ZpyKe4uCBPkxAsi96XvTR0Bi5YMMv87jd8VLD77/EDJjkvtvsQWTZYXyEnPS2dS4KeSUwmSPNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707482735; c=relaxed/simple;
	bh=S2OdtAeo5rxQASJqZ+bahfAtV86hqgbhkyGwRGtwk3A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TEJ9NBZipiVDheMqDrCcND0VjNk2pdH3TSK0ZWt9SMQOByFFBZZGRpGIfvJckWXnwXXK0OhR9QM3DLPQyIVFTi3lEAcTsNQxupEJcWV3vqMX6GZH2ciJuSiCzth5rESa0MmkenMJIsxZZ4GNipn5iiSkThn5dKa8Pn5d7ALtBtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=a3UjDWqu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="a3UjDWqu"
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 419CfLFG026145;
	Fri, 9 Feb 2024 12:45:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=ggzPOkBcGJjE9pDLgeB8QHqBLY1nPpHl91sNy+MiOLM=;
 b=a3UjDWqu7QvKgzSJf0YioMh3/6rqn5mcJFnW26d6n0uLTka0pM9FIodPG84q/HR4TO3K
 8inLbvgDWKzH0TZnqcJOJSpgcLW0I4RvzkEao0mp8CZKyQpnPPMs822/tOds5ScPG1oN
 GExm7YXBAw/1PzpL3MBkaxuiYLMYcVe2ITmD23h9C3O7fXnfXkf6ZozQYMVcJS4zsIgZ
 KCK69Dr5aUGih536psLD4l8fyIo4vPWWfvBzvn+a7OHpnweb7ctghffobZjh0EenXqd9
 qXC2TNuUYDe25OYGG0EhoQhkGepxXHRyLfKAgp9iS4yPLdUVCv31pceBWfbTF8mf1AUD QA== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w5m3x8a8g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Feb 2024 12:45:29 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 419B55Ir005430;
	Fri, 9 Feb 2024 12:45:28 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w21am3082-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Feb 2024 12:45:28 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 419CjMwR15598054
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Feb 2024 12:45:23 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CDF4C2004E;
	Fri,  9 Feb 2024 12:45:22 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C638520040;
	Fri,  9 Feb 2024 12:45:22 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  9 Feb 2024 12:45:22 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
	id 90700E1572; Fri,  9 Feb 2024 13:45:22 +0100 (CET)
From: Stefan Haberland <sth@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Miroslav Franc <mfranc@suse.cz>
Subject: [PATCH RESEND 1/2] s390/dasd: Improve ERP error messages
Date: Fri,  9 Feb 2024 13:45:21 +0100
Message-Id: <20240209124522.3697827-2-sth@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240209124522.3697827-1-sth@linux.ibm.com>
References: <20240209124522.3697827-1-sth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gOXfMUzAYCT0GepJ-J5sRUqay_407KzR
X-Proofpoint-ORIG-GUID: gOXfMUzAYCT0GepJ-J5sRUqay_407KzR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-09_10,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 mlxlogscore=999 impostorscore=0 suspectscore=0 adultscore=0 mlxscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402090093

From: Jan Höppner <hoeppner@linux.ibm.com>

Some ERP errors still share the same message format and only add
different reason codes to it. These reason codes don't have any meaning
anymore.
Make the individual error messages more explicit and remove the reason
codes altogether. Comments around the error messages are also removed as
they provide no additional value anymore with more explicit messages.

Signed-off-by: Jan Höppner <hoeppner@linux.ibm.com>
Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_3990_erp.c | 51 ++++++++----------------------
 1 file changed, 13 insertions(+), 38 deletions(-)

diff --git a/drivers/s390/block/dasd_3990_erp.c b/drivers/s390/block/dasd_3990_erp.c
index c59a961cfdd2..459b7f8ac883 100644
--- a/drivers/s390/block/dasd_3990_erp.c
+++ b/drivers/s390/block/dasd_3990_erp.c
@@ -1048,11 +1048,9 @@ dasd_3990_erp_com_rej(struct dasd_ccw_req * erp, char *sense)
 		set_bit(DASD_CQR_SUPPRESS_CR, &erp->refers->flags);
 		erp = dasd_3990_erp_cleanup(erp, DASD_CQR_FAILED);
 	} else {
-		/* fatal error -  set status to FAILED
-		   internal error 09 - Command Reject */
 		if (!test_bit(DASD_CQR_SUPPRESS_CR, &erp->flags))
 			dev_err(&device->cdev->dev,
-				"An error occurred in the DASD device driver, reason=09\n");
+				"An I/O command request was rejected\n");
 
 		erp = dasd_3990_erp_cleanup(erp, DASD_CQR_FAILED);
 	}
@@ -1120,13 +1118,7 @@ dasd_3990_erp_equip_check(struct dasd_ccw_req * erp, char *sense)
 	erp->function = dasd_3990_erp_equip_check;
 
 	if (sense[1] & SNS1_WRITE_INHIBITED) {
-		dev_info(&device->cdev->dev,
-			    "Write inhibited path encountered\n");
-
-		/* vary path offline
-		   internal error 04 - Path should be varied off-line.*/
-		dev_err(&device->cdev->dev, "An error occurred in the DASD "
-			"device driver, reason=%s\n", "04");
+		dev_err(&device->cdev->dev, "Write inhibited path encountered\n");
 
 		erp = dasd_3990_erp_action_1(erp);
 
@@ -1277,11 +1269,7 @@ dasd_3990_erp_inv_format(struct dasd_ccw_req * erp, char *sense)
 		erp = dasd_3990_erp_action_4(erp, sense);
 
 	} else {
-		/* internal error 06 - The track format is not valid*/
-		dev_err(&device->cdev->dev,
-			"An error occurred in the DASD device driver, "
-			"reason=%s\n", "06");
-
+		dev_err(&device->cdev->dev, "Track format is not valid\n");
 		erp = dasd_3990_erp_cleanup(erp, DASD_CQR_FAILED);
 	}
 
@@ -1655,9 +1643,8 @@ dasd_3990_erp_action_1B_32(struct dasd_ccw_req * default_erp, char *sense)
 				     sizeof(struct LO_eckd_data), device);
 
 	if (IS_ERR(erp)) {
-		/* internal error 01 - Unable to allocate ERP */
-		dev_err(&device->cdev->dev, "An error occurred in the DASD "
-			"device driver, reason=%s\n", "01");
+		DBF_DEV_EVENT(DBF_ERR, device, "%s",
+			      "Unable to allocate ERP request (1B 32)");
 		return dasd_3990_erp_cleanup(default_erp, DASD_CQR_FAILED);
 	}
 
@@ -1799,10 +1786,8 @@ dasd_3990_update_1B(struct dasd_ccw_req * previous_erp, char *sense)
 	cpa = previous_erp->irb.scsw.cmd.cpa;
 
 	if (cpa == 0) {
-		/* internal error 02 -
-		   Unable to determine address of the CCW to be restarted */
-		dev_err(&device->cdev->dev, "An error occurred in the DASD "
-			"device driver, reason=%s\n", "02");
+		dev_err(&device->cdev->dev,
+			"Unable to determine address of to be restarted CCW\n");
 
 		previous_erp->status = DASD_CQR_FAILED;
 
@@ -2001,15 +1986,9 @@ dasd_3990_erp_compound_config(struct dasd_ccw_req * erp, char *sense)
 {
 
 	if ((sense[25] & DASD_SENSE_BIT_1) && (sense[26] & DASD_SENSE_BIT_2)) {
-
-		/* set to suspended duplex state then restart
-		   internal error 05 - Set device to suspended duplex state
-		   should be done */
 		struct dasd_device *device = erp->startdev;
 		dev_err(&device->cdev->dev,
-			"An error occurred in the DASD device driver, "
-			"reason=%s\n", "05");
-
+			"Compound configuration error occurred\n");
 	}
 
 	erp->function = dasd_3990_erp_compound_config;
@@ -2145,10 +2124,9 @@ dasd_3990_erp_inspect_32(struct dasd_ccw_req * erp, char *sense)
 			erp = dasd_3990_erp_int_req(erp);
 			break;
 
-		case 0x0F:  /* length mismatch during update write command
-			       internal error 08 - update write command error*/
-			dev_err(&device->cdev->dev, "An error occurred in the "
-				"DASD device driver, reason=%s\n", "08");
+		case 0x0F:
+			dev_err(&device->cdev->dev,
+				"Update write command error occurred\n");
 
 			erp = dasd_3990_erp_cleanup(erp, DASD_CQR_FAILED);
 			break;
@@ -2157,12 +2135,9 @@ dasd_3990_erp_inspect_32(struct dasd_ccw_req * erp, char *sense)
 			erp = dasd_3990_erp_action_10_32(erp, sense);
 			break;
 
-		case 0x15:	/* next track outside defined extend
-				   internal error 07 - The next track is not
-				   within the defined storage extent */
+		case 0x15:
 			dev_err(&device->cdev->dev,
-				"An error occurred in the DASD device driver, "
-				"reason=%s\n", "07");
+				"Track outside defined extent error occurred\n");
 
 			erp = dasd_3990_erp_cleanup(erp, DASD_CQR_FAILED);
 			break;
-- 
2.40.1

