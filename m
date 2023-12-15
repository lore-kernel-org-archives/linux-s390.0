Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062E836AE0;
	Fri, 15 Dec 2023 15:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Jh9XtyE6"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFFMSVr023281;
	Fri, 15 Dec 2023 15:28:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=OZl9urzNOO9SKr2hTEWugZp6McixMd6rryvVeJBQ2cc=;
 b=Jh9XtyE6UWDjVVDYu8Aqj5hMlVg57UP8vwelHsVwScuOqgCZALSeHKFDF2bn3E8o4bW6
 kYEGeMh1Qj2ajmYFY8b2/DcikZ6XyfYwfcXv/8EbwhO3nCOJr+hJYBr8veZg2t3P4IMt
 ZwYo8tfM4BT5oMR28LwxUudK1zzuqToOjDKeD9jziBE+xqkYVUR2d0Q4AB5HNhGgE7CF
 DkchKHwP6g9KVb1PXjMKnrLaIrdU+z4Gmf0sI9fyZA89TykeY59NRR8myqlMbbbgHuVM
 CF5OL03Fh4mNPFTHg4kLJbOuiYz0Xvod10OfPQaB0FncEK0O3NgUJJtjppvkhq8CYn3K uA== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v0scm07cv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 15:28:16 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFD6wZF008455;
	Fri, 15 Dec 2023 15:28:15 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uw2ju14x9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 15:28:15 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BFFSAt523528136
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Dec 2023 15:28:10 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4293420043;
	Fri, 15 Dec 2023 15:28:10 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1EBDF2004B;
	Fri, 15 Dec 2023 15:28:10 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 15 Dec 2023 15:28:10 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
	id 9CFFBE1510; Fri, 15 Dec 2023 16:28:09 +0100 (CET)
From: Stefan Haberland <sth@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 06/10] s390/dasd: Use dev_err() over printk()
Date: Fri, 15 Dec 2023 16:28:06 +0100
Message-Id: <20231215152809.882602-7-sth@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231215152809.882602-1-sth@linux.ibm.com>
References: <20231215152809.882602-1-sth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: arpjBXWaloBlwE7WBtUbkm_4W-WlfoAm
X-Proofpoint-ORIG-GUID: arpjBXWaloBlwE7WBtUbkm_4W-WlfoAm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-15_10,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 mlxlogscore=836 mlxscore=0 spamscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2312150106

From: Jan Höppner <hoeppner@linux.ibm.com>

To reduce the information required for the string generation in the
sense dump functions, use the more concise dev_err() variant over
printk(KERN_ERR, ...) to improve code readability.

The dev_err() function provides the component and device name for free
and the separate dev_name() calls as well as the PRINTK_HEADER can be
dropped.

Dropping PRINTK_HEADER removes the "dasd(eckd):" for all lines. Only the
first line of a dev_err() call is prefixed with the component and device
(e.g. "dasd-eckd 0.0.95d0:").

The format specifier for printed pointers is also changed to unhashed
(%px) as this can help with debugging and servicing.

Signed-off-by: Jan Höppner <hoeppner@linux.ibm.com>
Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_eckd.c | 139 +++++++++++++--------------------
 drivers/s390/block/dasd_fba.c  |  55 +++++--------
 2 files changed, 76 insertions(+), 118 deletions(-)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 229f23a30c5b..d9f776789429 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -37,11 +37,6 @@
 #include "dasd_int.h"
 #include "dasd_eckd.h"
 
-#ifdef PRINTK_HEADER
-#undef PRINTK_HEADER
-#endif				/* PRINTK_HEADER */
-#define PRINTK_HEADER "dasd(eckd):"
-
 /*
  * raw track access always map to 64k in memory
  * so it maps to 16 blocks of 4k per track
@@ -5521,15 +5516,15 @@ dasd_eckd_ioctl(struct dasd_block *block, unsigned int cmd, void __user *argp)
  * and return number of printed chars.
  */
 static void
-dasd_eckd_dump_ccw_range(struct ccw1 *from, struct ccw1 *to, char *page)
+dasd_eckd_dump_ccw_range(struct dasd_device *device, struct ccw1 *from,
+			 struct ccw1 *to, char *page)
 {
 	int len, count;
 	char *datap;
 
 	len = 0;
 	while (from <= to) {
-		len += sprintf(page + len, PRINTK_HEADER
-			       " CCW %p: %08X %08X DAT:",
+		len += sprintf(page + len, "CCW %px: %08X %08X DAT:",
 			       from, ((int *) from)[0], ((int *) from)[1]);
 
 		/* get pointer to data (consider IDALs) */
@@ -5552,7 +5547,7 @@ dasd_eckd_dump_ccw_range(struct ccw1 *from, struct ccw1 *to, char *page)
 		from++;
 	}
 	if (len > 0)
-		printk(KERN_ERR "%s", page);
+		dev_err(&device->cdev->dev, "%s", page);
 }
 
 static void
@@ -5583,9 +5578,12 @@ dasd_eckd_dump_sense_dbf(struct dasd_device *device, struct irb *irb,
 static void dasd_eckd_dump_sense_ccw(struct dasd_device *device,
 				 struct dasd_ccw_req *req, struct irb *irb)
 {
-	char *page;
 	struct ccw1 *first, *last, *fail, *from, *to;
+	struct device *dev;
 	int len, sl, sct;
+	char *page;
+
+	dev = &device->cdev->dev;
 
 	page = (char *) get_zeroed_page(GFP_ATOMIC);
 	if (page == NULL) {
@@ -5594,24 +5592,18 @@ static void dasd_eckd_dump_sense_ccw(struct dasd_device *device,
 		return;
 	}
 	/* dump the sense data */
-	len = sprintf(page, PRINTK_HEADER
-		      " I/O status report for device %s:\n",
-		      dev_name(&device->cdev->dev));
-	len += sprintf(page + len, PRINTK_HEADER
-		       " in req: %p CC:%02X FC:%02X AC:%02X SC:%02X DS:%02X "
-		       "CS:%02X RC:%d\n",
+	len = sprintf(page, "I/O status report:\n");
+	len += sprintf(page + len,
+		       "in req: %px CC:%02X FC:%02X AC:%02X SC:%02X DS:%02X CS:%02X RC:%d\n",
 		       req, scsw_cc(&irb->scsw), scsw_fctl(&irb->scsw),
 		       scsw_actl(&irb->scsw), scsw_stctl(&irb->scsw),
 		       scsw_dstat(&irb->scsw), scsw_cstat(&irb->scsw),
 		       req ? req->intrc : 0);
-	len += sprintf(page + len, PRINTK_HEADER
-		       " device %s: Failing CCW: %p\n",
-		       dev_name(&device->cdev->dev),
+	len += sprintf(page + len, "Failing CCW: %px\n",
 		       phys_to_virt(irb->scsw.cmd.cpa));
 	if (irb->esw.esw0.erw.cons) {
 		for (sl = 0; sl < 4; sl++) {
-			len += sprintf(page + len, PRINTK_HEADER
-				       " Sense(hex) %2d-%2d:",
+			len += sprintf(page + len, "Sense(hex) %2d-%2d:",
 				       (8 * sl), ((8 * sl) + 7));
 
 			for (sct = 0; sct < 8; sct++) {
@@ -5623,23 +5615,20 @@ static void dasd_eckd_dump_sense_ccw(struct dasd_device *device,
 
 		if (irb->ecw[27] & DASD_SENSE_BIT_0) {
 			/* 24 Byte Sense Data */
-			sprintf(page + len, PRINTK_HEADER
-				" 24 Byte: %x MSG %x, "
-				"%s MSGb to SYSOP\n",
+			sprintf(page + len,
+				"24 Byte: %x MSG %x, %s MSGb to SYSOP\n",
 				irb->ecw[7] >> 4, irb->ecw[7] & 0x0f,
 				irb->ecw[1] & 0x10 ? "" : "no");
 		} else {
 			/* 32 Byte Sense Data */
-			sprintf(page + len, PRINTK_HEADER
-				" 32 Byte: Format: %x "
-				"Exception class %x\n",
+			sprintf(page + len,
+				"32 Byte: Format: %x Exception class %x\n",
 				irb->ecw[6] & 0x0f, irb->ecw[22] >> 4);
 		}
 	} else {
-		sprintf(page + len, PRINTK_HEADER
-			" SORRY - NO VALID SENSE AVAILABLE\n");
+		sprintf(page + len, "SORRY - NO VALID SENSE AVAILABLE\n");
 	}
-	printk(KERN_ERR "%s", page);
+	dev_err(dev, "%s", page);
 
 	if (req) {
 		/* req == NULL for unsolicited interrupts */
@@ -5648,8 +5637,8 @@ static void dasd_eckd_dump_sense_ccw(struct dasd_device *device,
 		first = req->cpaddr;
 		for (last = first; last->flags & (CCW_FLAG_CC | CCW_FLAG_DC); last++);
 		to = min(first + 6, last);
-		printk(KERN_ERR PRINTK_HEADER " Related CP in req: %p\n", req);
-		dasd_eckd_dump_ccw_range(first, to, page);
+		dev_err(dev, "Related CP in req: %px\n", req);
+		dasd_eckd_dump_ccw_range(device, first, to, page);
 
 		/* print failing CCW area (maximum 4) */
 		/* scsw->cda is either valid or zero  */
@@ -5657,19 +5646,19 @@ static void dasd_eckd_dump_sense_ccw(struct dasd_device *device,
 		fail = phys_to_virt(irb->scsw.cmd.cpa); /* failing CCW */
 		if (from <  fail - 2) {
 			from = fail - 2;     /* there is a gap - print header */
-			printk(KERN_ERR PRINTK_HEADER "......\n");
+			dev_err(dev, "......\n");
 		}
 		to = min(fail + 1, last);
-		dasd_eckd_dump_ccw_range(from, to, page + len);
+		dasd_eckd_dump_ccw_range(device, from, to, page + len);
 
 		/* print last CCWs (maximum 2) */
 		len = 0;
 		from = max(from, ++to);
 		if (from < last - 1) {
 			from = last - 1;     /* there is a gap - print header */
-			printk(KERN_ERR PRINTK_HEADER "......\n");
+			dev_err(dev, "......\n");
 		}
-		dasd_eckd_dump_ccw_range(from, last, page + len);
+		dasd_eckd_dump_ccw_range(device, from, last, page + len);
 	}
 	free_page((unsigned long) page);
 }
@@ -5693,11 +5682,9 @@ static void dasd_eckd_dump_sense_tcw(struct dasd_device *device,
 		return;
 	}
 	/* dump the sense data */
-	len = sprintf(page, PRINTK_HEADER
-		      " I/O status report for device %s:\n",
-		      dev_name(&device->cdev->dev));
-	len += sprintf(page + len, PRINTK_HEADER
-		       " in req: %p CC:%02X FC:%02X AC:%02X SC:%02X DS:%02X "
+	len = sprintf(page, "I/O status report:\n");
+	len += sprintf(page + len,
+		       "in req: %px CC:%02X FC:%02X AC:%02X SC:%02X DS:%02X "
 		       "CS:%02X fcxs:%02X schxs:%02X RC:%d\n",
 		       req, scsw_cc(&irb->scsw), scsw_fctl(&irb->scsw),
 		       scsw_actl(&irb->scsw), scsw_stctl(&irb->scsw),
@@ -5705,9 +5692,7 @@ static void dasd_eckd_dump_sense_tcw(struct dasd_device *device,
 		       irb->scsw.tm.fcxs,
 		       (irb->scsw.tm.ifob << 7) | irb->scsw.tm.sesq,
 		       req ? req->intrc : 0);
-	len += sprintf(page + len, PRINTK_HEADER
-		       " device %s: Failing TCW: %p\n",
-		       dev_name(&device->cdev->dev),
+	len += sprintf(page + len, "Failing TCW: %px\n",
 		       phys_to_virt(irb->scsw.tm.tcw));
 
 	tsb = NULL;
@@ -5716,47 +5701,37 @@ static void dasd_eckd_dump_sense_tcw(struct dasd_device *device,
 		tsb = tcw_get_tsb(phys_to_virt(irb->scsw.tm.tcw));
 
 	if (tsb) {
-		len += sprintf(page + len, PRINTK_HEADER
-			       " tsb->length %d\n", tsb->length);
-		len += sprintf(page + len, PRINTK_HEADER
-			       " tsb->flags %x\n", tsb->flags);
-		len += sprintf(page + len, PRINTK_HEADER
-			       " tsb->dcw_offset %d\n", tsb->dcw_offset);
-		len += sprintf(page + len, PRINTK_HEADER
-			       " tsb->count %d\n", tsb->count);
+		len += sprintf(page + len, "tsb->length %d\n", tsb->length);
+		len += sprintf(page + len, "tsb->flags %x\n", tsb->flags);
+		len += sprintf(page + len, "tsb->dcw_offset %d\n", tsb->dcw_offset);
+		len += sprintf(page + len, "tsb->count %d\n", tsb->count);
 		residual = tsb->count - 28;
-		len += sprintf(page + len, PRINTK_HEADER
-			       " residual %d\n", residual);
+		len += sprintf(page + len, "residual %d\n", residual);
 
 		switch (tsb->flags & 0x07) {
 		case 1:	/* tsa_iostat */
-			len += sprintf(page + len, PRINTK_HEADER
-			       " tsb->tsa.iostat.dev_time %d\n",
+			len += sprintf(page + len, "tsb->tsa.iostat.dev_time %d\n",
 				       tsb->tsa.iostat.dev_time);
-			len += sprintf(page + len, PRINTK_HEADER
-			       " tsb->tsa.iostat.def_time %d\n",
+			len += sprintf(page + len, "tsb->tsa.iostat.def_time %d\n",
 				       tsb->tsa.iostat.def_time);
-			len += sprintf(page + len, PRINTK_HEADER
-			       " tsb->tsa.iostat.queue_time %d\n",
+			len += sprintf(page + len, "tsb->tsa.iostat.queue_time %d\n",
 				       tsb->tsa.iostat.queue_time);
-			len += sprintf(page + len, PRINTK_HEADER
-			       " tsb->tsa.iostat.dev_busy_time %d\n",
+			len += sprintf(page + len, "tsb->tsa.iostat.dev_busy_time %d\n",
 				       tsb->tsa.iostat.dev_busy_time);
-			len += sprintf(page + len, PRINTK_HEADER
-			       " tsb->tsa.iostat.dev_act_time %d\n",
+			len += sprintf(page + len, "tsb->tsa.iostat.dev_act_time %d\n",
 				       tsb->tsa.iostat.dev_act_time);
 			sense = tsb->tsa.iostat.sense;
 			break;
 		case 2: /* ts_ddpc */
-			len += sprintf(page + len, PRINTK_HEADER
-			       " tsb->tsa.ddpc.rc %d\n", tsb->tsa.ddpc.rc);
+			len += sprintf(page + len, "tsb->tsa.ddpc.rc %d\n",
+				       tsb->tsa.ddpc.rc);
 			for (sl = 0; sl < 2; sl++) {
-				len += sprintf(page + len, PRINTK_HEADER
-					       " tsb->tsa.ddpc.rcq %2d-%2d: ",
+				len += sprintf(page + len,
+					       "tsb->tsa.ddpc.rcq %2d-%2d: ",
 					       (8 * sl), ((8 * sl) + 7));
 				rcq = tsb->tsa.ddpc.rcq;
 				for (sct = 0; sct < 8; sct++) {
-					len += sprintf(page + len, " %02x",
+					len += sprintf(page + len, "%02x",
 						       rcq[8 * sl + sct]);
 				}
 				len += sprintf(page + len, "\n");
@@ -5764,15 +5739,15 @@ static void dasd_eckd_dump_sense_tcw(struct dasd_device *device,
 			sense = tsb->tsa.ddpc.sense;
 			break;
 		case 3: /* tsa_intrg */
-			len += sprintf(page + len, PRINTK_HEADER
-				      " tsb->tsa.intrg.: not supported yet\n");
+			len += sprintf(page + len,
+				      "tsb->tsa.intrg.: not supported yet\n");
 			break;
 		}
 
 		if (sense) {
 			for (sl = 0; sl < 4; sl++) {
-				len += sprintf(page + len, PRINTK_HEADER
-					       " Sense(hex) %2d-%2d:",
+				len += sprintf(page + len,
+					       "Sense(hex) %2d-%2d:",
 					       (8 * sl), ((8 * sl) + 7));
 				for (sct = 0; sct < 8; sct++) {
 					len += sprintf(page + len, " %02x",
@@ -5783,27 +5758,23 @@ static void dasd_eckd_dump_sense_tcw(struct dasd_device *device,
 
 			if (sense[27] & DASD_SENSE_BIT_0) {
 				/* 24 Byte Sense Data */
-				sprintf(page + len, PRINTK_HEADER
-					" 24 Byte: %x MSG %x, "
-					"%s MSGb to SYSOP\n",
+				sprintf(page + len,
+					"24 Byte: %x MSG %x, %s MSGb to SYSOP\n",
 					sense[7] >> 4, sense[7] & 0x0f,
 					sense[1] & 0x10 ? "" : "no");
 			} else {
 				/* 32 Byte Sense Data */
-				sprintf(page + len, PRINTK_HEADER
-					" 32 Byte: Format: %x "
-					"Exception class %x\n",
+				sprintf(page + len,
+					"32 Byte: Format: %x Exception class %x\n",
 					sense[6] & 0x0f, sense[22] >> 4);
 			}
 		} else {
-			sprintf(page + len, PRINTK_HEADER
-				" SORRY - NO VALID SENSE AVAILABLE\n");
+			sprintf(page + len, "SORRY - NO VALID SENSE AVAILABLE\n");
 		}
 	} else {
-		sprintf(page + len, PRINTK_HEADER
-			" SORRY - NO TSB DATA AVAILABLE\n");
+		sprintf(page + len, "SORRY - NO TSB DATA AVAILABLE\n");
 	}
-	printk(KERN_ERR "%s", page);
+	dev_err(&device->cdev->dev, "%s", page);
 	free_page((unsigned long) page);
 }
 
diff --git a/drivers/s390/block/dasd_fba.c b/drivers/s390/block/dasd_fba.c
index c06fa2b27120..045e548630df 100644
--- a/drivers/s390/block/dasd_fba.c
+++ b/drivers/s390/block/dasd_fba.c
@@ -25,11 +25,6 @@
 #include "dasd_int.h"
 #include "dasd_fba.h"
 
-#ifdef PRINTK_HEADER
-#undef PRINTK_HEADER
-#endif				/* PRINTK_HEADER */
-#define PRINTK_HEADER "dasd(fba):"
-
 #define FBA_DEFAULT_RETRIES 32
 
 #define DASD_FBA_CCW_WRITE 0x41
@@ -660,30 +655,27 @@ static void
 dasd_fba_dump_sense(struct dasd_device *device, struct dasd_ccw_req * req,
 		    struct irb *irb)
 {
-	char *page;
 	struct ccw1 *act, *end, *last;
 	int len, sl, sct, count;
+	struct device *dev;
+	char *page;
+
+	dev = &device->cdev->dev;
 
 	page = (char *) get_zeroed_page(GFP_ATOMIC);
 	if (page == NULL) {
 		DBF_DEV_EVENT(DBF_WARNING, device, "%s",
-			    "No memory to dump sense data");
+			      "No memory to dump sense data");
 		return;
 	}
-	len = sprintf(page, PRINTK_HEADER
-		      " I/O status report for device %s:\n",
-		      dev_name(&device->cdev->dev));
-	len += sprintf(page + len, PRINTK_HEADER
-		       " in req: %p CS: 0x%02X DS: 0x%02X\n", req,
-		       irb->scsw.cmd.cstat, irb->scsw.cmd.dstat);
-	len += sprintf(page + len, PRINTK_HEADER
-		       " device %s: Failing CCW: %p\n",
-		       dev_name(&device->cdev->dev),
+	len = sprintf(page, "I/O status report:\n");
+	len += sprintf(page + len, "in req: %px CS: 0x%02X DS: 0x%02X\n",
+		       req, irb->scsw.cmd.cstat, irb->scsw.cmd.dstat);
+	len += sprintf(page + len, "Failing CCW: %px\n",
 		       (void *) (addr_t) irb->scsw.cmd.cpa);
 	if (irb->esw.esw0.erw.cons) {
 		for (sl = 0; sl < 4; sl++) {
-			len += sprintf(page + len, PRINTK_HEADER
-				       " Sense(hex) %2d-%2d:",
+			len += sprintf(page + len, "Sense(hex) %2d-%2d:",
 				       (8 * sl), ((8 * sl) + 7));
 
 			for (sct = 0; sct < 8; sct++) {
@@ -693,20 +685,18 @@ dasd_fba_dump_sense(struct dasd_device *device, struct dasd_ccw_req * req,
 			len += sprintf(page + len, "\n");
 		}
 	} else {
-		len += sprintf(page + len, PRINTK_HEADER
-			       " SORRY - NO VALID SENSE AVAILABLE\n");
+		len += sprintf(page + len, "SORRY - NO VALID SENSE AVAILABLE\n");
 	}
-	printk(KERN_ERR "%s", page);
+	dev_err(dev, "%s", page);
 
 	/* dump the Channel Program */
 	/* print first CCWs (maximum 8) */
 	act = req->cpaddr;
-        for (last = act; last->flags & (CCW_FLAG_CC | CCW_FLAG_DC); last++);
+	for (last = act; last->flags & (CCW_FLAG_CC | CCW_FLAG_DC); last++);
 	end = min(act + 8, last);
-	len = sprintf(page, PRINTK_HEADER " Related CP in req: %p\n", req);
+	len = sprintf(page, "Related CP in req: %px\n", req);
 	while (act <= end) {
-		len += sprintf(page + len, PRINTK_HEADER
-			       " CCW %p: %08X %08X DAT:",
+		len += sprintf(page + len, "CCW %px: %08X %08X DAT:",
 			       act, ((int *) act)[0], ((int *) act)[1]);
 		for (count = 0; count < 32 && count < act->count;
 		     count += sizeof(int))
@@ -716,19 +706,17 @@ dasd_fba_dump_sense(struct dasd_device *device, struct dasd_ccw_req * req,
 		len += sprintf(page + len, "\n");
 		act++;
 	}
-	printk(KERN_ERR "%s", page);
-
+	dev_err(dev, "%s", page);
 
 	/* print failing CCW area */
 	len = 0;
 	if (act <  ((struct ccw1 *)(addr_t) irb->scsw.cmd.cpa) - 2) {
 		act = ((struct ccw1 *)(addr_t) irb->scsw.cmd.cpa) - 2;
-		len += sprintf(page + len, PRINTK_HEADER "......\n");
+		len += sprintf(page + len, "......\n");
 	}
 	end = min((struct ccw1 *)(addr_t) irb->scsw.cmd.cpa + 2, last);
 	while (act <= end) {
-		len += sprintf(page + len, PRINTK_HEADER
-			       " CCW %p: %08X %08X DAT:",
+		len += sprintf(page + len, "CCW %px: %08X %08X DAT:",
 			       act, ((int *) act)[0], ((int *) act)[1]);
 		for (count = 0; count < 32 && count < act->count;
 		     count += sizeof(int))
@@ -742,11 +730,10 @@ dasd_fba_dump_sense(struct dasd_device *device, struct dasd_ccw_req * req,
 	/* print last CCWs */
 	if (act <  last - 2) {
 		act = last - 2;
-		len += sprintf(page + len, PRINTK_HEADER "......\n");
+		len += sprintf(page + len, "......\n");
 	}
 	while (act <= last) {
-		len += sprintf(page + len, PRINTK_HEADER
-			       " CCW %p: %08X %08X DAT:",
+		len += sprintf(page + len, "CCW %px: %08X %08X DAT:",
 			       act, ((int *) act)[0], ((int *) act)[1]);
 		for (count = 0; count < 32 && count < act->count;
 		     count += sizeof(int))
@@ -757,7 +744,7 @@ dasd_fba_dump_sense(struct dasd_device *device, struct dasd_ccw_req * req,
 		act++;
 	}
 	if (len > 0)
-		printk(KERN_ERR "%s", page);
+		dev_err(dev, "%s", page);
 	free_page((unsigned long) page);
 }
 
-- 
2.40.1

