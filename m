Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E0ECC43217
	for <linux-s390@archiver.kernel.org>; Wed, 23 Nov 2022 16:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238729AbiKWQHe (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 23 Nov 2022 11:07:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238738AbiKWQHc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 23 Nov 2022 11:07:32 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C90DBCF;
        Wed, 23 Nov 2022 08:07:28 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ANEbIrC003931;
        Wed, 23 Nov 2022 16:07:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=bYhVZK/QSaW2wD7QGjPFWFYkp4fQFrmyCDUcqNSPCZk=;
 b=OmNwFhm37QLE/oJiesXWe+jNQ5FxCMa1OxMj0nL08mgNVmlL44c9fQjDjnOARgGoeGIm
 SiTnuXADmCnSWdiKdD4MzgLugF78L97XQitBJ6f4riCuX1ULkG80OQ80RR0dmy60YvpZ
 uOPAkO0GH8qQ69wXzxfK7TBaokk1F9dPrCr3ZtORvl8y6aA9nZ+V/2B95uOFTUCpqjUK
 6PM9+J1MCaRsKAt1to+hxZNW7mgnPgQu18pHWJ5mFkfmb16Z1rz1q3q6btRFOIrv+QyD
 tW2zd9/YnaymMEsYgHOm4eDmpw21yKqyJ/zONfYexARZCvnPDSA3ufIyFAG3s7O+PJ71 uw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3m100t38p3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 16:07:26 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2ANFfX03007652;
        Wed, 23 Nov 2022 16:07:26 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3m100t38nf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 16:07:26 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2ANG7NY9021838;
        Wed, 23 Nov 2022 16:07:24 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03fra.de.ibm.com with ESMTP id 3kxps94rp5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 16:07:24 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2ANG7L8f17629656
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Nov 2022 16:07:21 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4B560AE056;
        Wed, 23 Nov 2022 16:07:20 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3270EAE058;
        Wed, 23 Nov 2022 16:07:20 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 23 Nov 2022 16:07:20 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id E7568E06EB; Wed, 23 Nov 2022 17:07:19 +0100 (CET)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Colin Ian King <colin.i.king@gmail.com>
Subject: [PATCH 2/4] s390/dasd: increase printing of debug data payload
Date:   Wed, 23 Nov 2022 17:07:17 +0100
Message-Id: <20221123160719.3002694-3-sth@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221123160719.3002694-1-sth@linux.ibm.com>
References: <20221123160719.3002694-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ITmdVwvNxQ2bqN_SU_YZAkXf2PJPPMZp
X-Proofpoint-ORIG-GUID: 8EZrrjJ7J8gYP17aT4B-6ldNsBagHquw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-23_08,2022-11-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=948 adultscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211230114
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

32 byte are to less for important data from prefix or
other commands.
Print up to 128 byte data. This is enough for the largest
CCW data we have.

Since printk can only print up to 1024 byte at once, print the
different parts of the CCW dumps separately.

Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
---
 drivers/s390/block/dasd_eckd.c | 37 +++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 662730f3b027..85bf045c2ff9 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -5500,7 +5500,7 @@ dasd_eckd_ioctl(struct dasd_block *block, unsigned int cmd, void __user *argp)
  * Dump the range of CCWs into 'page' buffer
  * and return number of printed chars.
  */
-static int
+static void
 dasd_eckd_dump_ccw_range(struct ccw1 *from, struct ccw1 *to, char *page)
 {
 	int len, count;
@@ -5518,16 +5518,21 @@ dasd_eckd_dump_ccw_range(struct ccw1 *from, struct ccw1 *to, char *page)
 		else
 			datap = (char *) ((addr_t) from->cda);
 
-		/* dump data (max 32 bytes) */
-		for (count = 0; count < from->count && count < 32; count++) {
-			if (count % 8 == 0) len += sprintf(page + len, " ");
-			if (count % 4 == 0) len += sprintf(page + len, " ");
+		/* dump data (max 128 bytes) */
+		for (count = 0; count < from->count && count < 128; count++) {
+			if (count % 32 == 0)
+				len += sprintf(page + len, "\n");
+			if (count % 8 == 0)
+				len += sprintf(page + len, " ");
+			if (count % 4 == 0)
+				len += sprintf(page + len, " ");
 			len += sprintf(page + len, "%02x", datap[count]);
 		}
 		len += sprintf(page + len, "\n");
 		from++;
 	}
-	return len;
+	if (len > 0)
+		printk(KERN_ERR "%s", page);
 }
 
 static void
@@ -5619,37 +5624,33 @@ static void dasd_eckd_dump_sense_ccw(struct dasd_device *device,
 	if (req) {
 		/* req == NULL for unsolicited interrupts */
 		/* dump the Channel Program (max 140 Bytes per line) */
-		/* Count CCW and print first CCWs (maximum 1024 % 140 = 7) */
+		/* Count CCW and print first CCWs (maximum 7) */
 		first = req->cpaddr;
 		for (last = first; last->flags & (CCW_FLAG_CC | CCW_FLAG_DC); last++);
 		to = min(first + 6, last);
-		len = sprintf(page, PRINTK_HEADER
-			      " Related CP in req: %p\n", req);
-		dasd_eckd_dump_ccw_range(first, to, page + len);
-		printk(KERN_ERR "%s", page);
+		printk(KERN_ERR PRINTK_HEADER " Related CP in req: %p\n", req);
+		dasd_eckd_dump_ccw_range(first, to, page);
 
 		/* print failing CCW area (maximum 4) */
 		/* scsw->cda is either valid or zero  */
-		len = 0;
 		from = ++to;
 		fail = (struct ccw1 *)(addr_t)
 				irb->scsw.cmd.cpa; /* failing CCW */
 		if (from <  fail - 2) {
 			from = fail - 2;     /* there is a gap - print header */
-			len += sprintf(page, PRINTK_HEADER "......\n");
+			printk(KERN_ERR PRINTK_HEADER "......\n");
 		}
 		to = min(fail + 1, last);
-		len += dasd_eckd_dump_ccw_range(from, to, page + len);
+		dasd_eckd_dump_ccw_range(from, to, page + len);
 
 		/* print last CCWs (maximum 2) */
+		len = 0;
 		from = max(from, ++to);
 		if (from < last - 1) {
 			from = last - 1;     /* there is a gap - print header */
-			len += sprintf(page + len, PRINTK_HEADER "......\n");
+			printk(KERN_ERR PRINTK_HEADER "......\n");
 		}
-		len += dasd_eckd_dump_ccw_range(from, last, page + len);
-		if (len > 0)
-			printk(KERN_ERR "%s", page);
+		dasd_eckd_dump_ccw_range(from, last, page + len);
 	}
 	free_page((unsigned long) page);
 }
-- 
2.34.1

