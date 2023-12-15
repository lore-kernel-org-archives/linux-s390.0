Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E18374F2;
	Fri, 15 Dec 2023 15:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VDkfD6X6"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFFRoUV005927;
	Fri, 15 Dec 2023 15:28:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=50OurVZKQT4BJQ08ZqHWkD4gVuXBNeHXsbelfHPz7hQ=;
 b=VDkfD6X6rjjay+NJpZsvId0pgeEvjYT+LdBpMKLz/lczMU/mFNJyc1ZGv79g40JZW9mS
 fR6UF7LiFpeTLqG4ZUg0+8Ooab1FDyyZhIEbFeNGW/GMLPcknqP0Bg1ZNebaxoZ4Kwqs
 KVN37z2vCJUIq2gytUVpkZFtx3wBS40tu4B527t3XECf4FJMF43UEhqnhlRSMmX143Y6
 rYX2X+H8n6/NsGzlFd6rJJFJAdmAtajCcI86Mu9av133sikyd0qP0wod2k21p6O6YPce
 35Mn+BasO3QTg03MWJ3U2iJyw5pvCJqDa56wuMNxzUmpdJwYV55es1HMfBOFGxi99l0g sw== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v0sf9g03d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 15:28:16 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFDwoDX012593;
	Fri, 15 Dec 2023 15:28:15 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uw3jpgwjm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 15:28:15 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BFFSAR03146416
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Dec 2023 15:28:10 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ECE5D2004D;
	Fri, 15 Dec 2023 15:28:09 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D6B762004B;
	Fri, 15 Dec 2023 15:28:09 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 15 Dec 2023 15:28:09 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
	id 95F79E12CE; Fri, 15 Dec 2023 16:28:09 +0100 (CET)
From: Stefan Haberland <sth@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 03/10] s390/dasd: Remove unnecessary errorstring generation
Date: Fri, 15 Dec 2023 16:28:03 +0100
Message-Id: <20231215152809.882602-4-sth@linux.ibm.com>
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
X-Proofpoint-GUID: sY0KzMh2aLlIzUQ3z6TOHgTZHt8HoqHK
X-Proofpoint-ORIG-GUID: sY0KzMh2aLlIzUQ3z6TOHgTZHt8HoqHK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-15_10,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 adultscore=0 spamscore=0 priorityscore=1501 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312150106

From: Jan Höppner <hoeppner@linux.ibm.com>

In quite a few cases an errorstring is generated using snprintf() before
it's passed to dev_err(). This indirection is unnecessary and all
information can simply be passed directly to dev_err() instead.
The errrorstring and ERRORLENGTH definitions are removed entirely.

While at it, rephrase the error messages to provide more context where
possible. Also, fix a few incorrectly used format specifier (e.g. %x02
-> %02x) in those messages.

Signed-off-by: Jan Höppner <hoeppner@linux.ibm.com>
Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd.c          | 26 ++++++--------------------
 drivers/s390/block/dasd_3990_erp.c |  8 ++------
 drivers/s390/block/dasd_int.h      |  3 ---
 3 files changed, 8 insertions(+), 29 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 833cfab7d877..2e084fd8e520 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -1307,7 +1307,6 @@ int dasd_term_IO(struct dasd_ccw_req *cqr)
 {
 	struct dasd_device *device;
 	int retries, rc;
-	char errorstring[ERRORLENGTH];
 
 	/* Check the cqr */
 	rc = dasd_check_cqr(cqr);
@@ -1346,10 +1345,8 @@ int dasd_term_IO(struct dasd_ccw_req *cqr)
 			rc = 0;
 			break;
 		default:
-			/* internal error 10 - unknown rc*/
-			snprintf(errorstring, ERRORLENGTH, "10 %d", rc);
-			dev_err(&device->cdev->dev, "An error occurred in the "
-				"DASD device driver, reason=%s\n", errorstring);
+			dev_err(&device->cdev->dev,
+				"Unexpected error during request termination %d\n", rc);
 			BUG();
 			break;
 		}
@@ -1368,7 +1365,6 @@ int dasd_start_IO(struct dasd_ccw_req *cqr)
 {
 	struct dasd_device *device;
 	int rc;
-	char errorstring[ERRORLENGTH];
 
 	/* Check the cqr */
 	rc = dasd_check_cqr(cqr);
@@ -1388,10 +1384,8 @@ int dasd_start_IO(struct dasd_ccw_req *cqr)
 		return -EPERM;
 	}
 	if (cqr->retries < 0) {
-		/* internal error 14 - start_IO run out of retries */
-		sprintf(errorstring, "14 %p", cqr);
-		dev_err(&device->cdev->dev, "An error occurred in the DASD "
-			"device driver, reason=%s\n", errorstring);
+		dev_err(&device->cdev->dev,
+			"Start I/O ran out of retries %p\n", cqr);
 		cqr->status = DASD_CQR_ERROR;
 		return -EIO;
 	}
@@ -1469,11 +1463,8 @@ int dasd_start_IO(struct dasd_ccw_req *cqr)
 			      "not accessible");
 		break;
 	default:
-		/* internal error 11 - unknown rc */
-		snprintf(errorstring, ERRORLENGTH, "11 %d", rc);
 		dev_err(&device->cdev->dev,
-			"An error occurred in the DASD device driver, "
-			"reason=%s\n", errorstring);
+			"Unexpected error during request start %d", rc);
 		BUG();
 		break;
 	}
@@ -1910,8 +1901,6 @@ static void __dasd_device_process_ccw_queue(struct dasd_device *device,
 static void __dasd_process_cqr(struct dasd_device *device,
 			       struct dasd_ccw_req *cqr)
 {
-	char errorstring[ERRORLENGTH];
-
 	switch (cqr->status) {
 	case DASD_CQR_SUCCESS:
 		cqr->status = DASD_CQR_DONE;
@@ -1923,11 +1912,8 @@ static void __dasd_process_cqr(struct dasd_device *device,
 		cqr->status = DASD_CQR_TERMINATED;
 		break;
 	default:
-		/* internal error 12 - wrong cqr status*/
-		snprintf(errorstring, ERRORLENGTH, "12 %p %x02", cqr, cqr->status);
 		dev_err(&device->cdev->dev,
-			"An error occurred in the DASD device driver, "
-			"reason=%s\n", errorstring);
+			"Unexpected CQR status %p %02x", cqr, cqr->status);
 		BUG();
 	}
 	if (cqr->callback)
diff --git a/drivers/s390/block/dasd_3990_erp.c b/drivers/s390/block/dasd_3990_erp.c
index 89957bb7244d..0705736acf09 100644
--- a/drivers/s390/block/dasd_3990_erp.c
+++ b/drivers/s390/block/dasd_3990_erp.c
@@ -398,7 +398,6 @@ dasd_3990_handle_env_data(struct dasd_ccw_req * erp, char *sense)
 	struct dasd_device *device = erp->startdev;
 	char msg_format = (sense[7] & 0xF0);
 	char msg_no = (sense[7] & 0x0F);
-	char errorstring[ERRORLENGTH];
 
 	switch (msg_format) {
 	case 0x00:		/* Format 0 - Program or System Checks */
@@ -1004,12 +1003,9 @@ dasd_3990_handle_env_data(struct dasd_ccw_req * erp, char *sense)
 		}
 		break;
 
-	default:	/* unknown message format - should not happen
-			   internal error 03 - unknown message format */
-		snprintf(errorstring, ERRORLENGTH, "03 %x02", msg_format);
+	default:
 		dev_err(&device->cdev->dev,
-			 "An error occurred in the DASD device driver, "
-			 "reason=%s\n", errorstring);
+			"Unknown message format %02x", msg_format);
 		break;
 	}			/* end switch message format */
 
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index 1b1b8a41c4d4..71d88e931090 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -113,9 +113,6 @@ do { \
 			    __dev_id.ssid, __dev_id.devno, d_data);	\
 } while (0)
 
-/* limit size for an errorstring */
-#define ERRORLENGTH 30
-
 /* definition of dbf debug levels */
 #define	DBF_EMERG	0	/* system is unusable			*/
 #define	DBF_ALERT	1	/* action must be taken immediately	*/
-- 
2.40.1

