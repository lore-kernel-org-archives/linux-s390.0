Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B60374EA;
	Fri, 15 Dec 2023 15:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZNI2ANwx"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFFRsug018511;
	Fri, 15 Dec 2023 15:28:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=AmlnFLfMdikv8BkCKAJrrVZibaeZ3V7Her5mFGyFhB0=;
 b=ZNI2ANwxx+Zl3GBJ2m6KZEhORovAlf7IQCUrgGCxlVXtwqFhnlnFPRSjBGutoWCJVJtW
 ULaD+s+HdbShQ2FwtdEi2RkwBOLx6h9Qwo4zILzAwMimAwQ+KuTOq6+MEm1PgMm/nyVx
 vI1nBUccEsuoyyQKogI4nPaWgtv4jUazV+rNuWHzMhhOdC3PcAFTQTCq3txBRJvVTW3d
 tk6o57CBFWMJg7UDCdst75H++t9/qTJ7b7KBc4oPX2D2BGF+CPy+QVbYwCpG4WMZjSmU
 V6WXIUEqgl6W+I7R/S2ILpT6g4DDKyw626FKzw6oirRH5Iiv7m5J5qJcvjVAGPiDMPg9 fw== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v0sfb007m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 15:28:16 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFE6RPo028217;
	Fri, 15 Dec 2023 15:28:15 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uw2y090q7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 15:28:15 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BFFSAm114811876
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Dec 2023 15:28:10 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 26F352004B;
	Fri, 15 Dec 2023 15:28:10 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 14EFF20043;
	Fri, 15 Dec 2023 15:28:10 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 15 Dec 2023 15:28:10 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
	id 9F60CE1515; Fri, 15 Dec 2023 16:28:09 +0100 (CET)
From: Stefan Haberland <sth@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 07/10] s390/dasd: Remove %p format specifier from error messages
Date: Fri, 15 Dec 2023 16:28:07 +0100
Message-Id: <20231215152809.882602-8-sth@linux.ibm.com>
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
X-Proofpoint-GUID: BnuRBr3-rHl6btttEUWyoaWzb58ext6L
X-Proofpoint-ORIG-GUID: BnuRBr3-rHl6btttEUWyoaWzb58ext6L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-15_10,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 suspectscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312150106

From: Jan Höppner <hoeppner@linux.ibm.com>

Printing pointer in error messages doesn't add any value since the
addresses are hashed. Remove the %p format specifier and adapt the error
messages slightly.

Replace %p with %px in ERP to get the actual addresses since ERP is used
for debugging purposes only anyway.

Signed-off-by: Jan Höppner <hoeppner@linux.ibm.com>
Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd.c          | 20 ++++++++------------
 drivers/s390/block/dasd_3990_erp.c | 14 +++++---------
 drivers/s390/block/dasd_erp.c      |  4 ++--
 3 files changed, 15 insertions(+), 23 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 60e666b7ca05..be5f019d878b 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -1385,7 +1385,7 @@ int dasd_start_IO(struct dasd_ccw_req *cqr)
 	}
 	if (cqr->retries < 0) {
 		dev_err(&device->cdev->dev,
-			"Start I/O ran out of retries %p\n", cqr);
+			"Start I/O ran out of retries\n");
 		cqr->status = DASD_CQR_ERROR;
 		return -EIO;
 	}
@@ -1913,7 +1913,7 @@ static void __dasd_process_cqr(struct dasd_device *device,
 		break;
 	default:
 		dev_err(&device->cdev->dev,
-			"Unexpected CQR status %p %02x", cqr, cqr->status);
+			"Unexpected CQR status %02x", cqr->status);
 		BUG();
 	}
 	if (cqr->callback)
@@ -1978,16 +1978,14 @@ static void __dasd_device_check_expire(struct dasd_device *device)
 		if (device->discipline->term_IO(cqr) != 0) {
 			/* Hmpf, try again in 5 sec */
 			dev_err(&device->cdev->dev,
-				"cqr %p timed out (%lus) but cannot be "
-				"ended, retrying in 5 s\n",
-				cqr, (cqr->expires/HZ));
+				"CQR timed out (%lus) but cannot be ended, retrying in 5s\n",
+				(cqr->expires / HZ));
 			cqr->expires += 5*HZ;
 			dasd_device_set_timer(device, 5*HZ);
 		} else {
 			dev_err(&device->cdev->dev,
-				"cqr %p timed out (%lus), %i retries "
-				"remaining\n", cqr, (cqr->expires/HZ),
-				cqr->retries);
+				"CQR timed out (%lus), %i retries remaining\n",
+				(cqr->expires / HZ), cqr->retries);
 		}
 		__dasd_device_check_autoquiesce_timeout(device, cqr);
 	}
@@ -2108,8 +2106,7 @@ int dasd_flush_device_queue(struct dasd_device *device)
 			if (rc) {
 				/* unable to terminate requeust */
 				dev_err(&device->cdev->dev,
-					"Flushing the DASD request queue "
-					"failed for request %p\n", cqr);
+					"Flushing the DASD request queue failed\n");
 				/* stop flush processing */
 				goto finished;
 			}
@@ -2625,8 +2622,7 @@ static int __dasd_cancel_req(struct dasd_ccw_req *cqr)
 		rc = device->discipline->term_IO(cqr);
 		if (rc) {
 			dev_err(&device->cdev->dev,
-				"Cancelling request %p failed with rc=%d\n",
-				cqr, rc);
+				"Cancelling request failed with rc=%d\n", rc);
 		} else {
 			cqr->stopclk = get_tod_clock();
 		}
diff --git a/drivers/s390/block/dasd_3990_erp.c b/drivers/s390/block/dasd_3990_erp.c
index 0705736acf09..b39c0798a110 100644
--- a/drivers/s390/block/dasd_3990_erp.c
+++ b/drivers/s390/block/dasd_3990_erp.c
@@ -2659,7 +2659,7 @@ dasd_3990_erp_further_erp(struct dasd_ccw_req *erp)
 		 * necessary
 		 */
 		dev_err(&device->cdev->dev,
-			"ERP %p has run out of retries and failed\n", erp);
+			"ERP %px has run out of retries and failed\n", erp);
 
 		erp->status = DASD_CQR_FAILED;
 	}
@@ -2782,11 +2782,9 @@ dasd_3990_erp_action(struct dasd_ccw_req * cqr)
 			    "ERP chain at BEGINNING of ERP-ACTION\n");
 		for (temp_erp = cqr;
 		     temp_erp != NULL; temp_erp = temp_erp->refers) {
-
 			dev_err(&device->cdev->dev,
-				    "ERP %p (%02x) refers to %p\n",
-				    temp_erp, temp_erp->status,
-				    temp_erp->refers);
+				"ERP %px (%02x) refers to %px\n",
+				temp_erp, temp_erp->status, temp_erp->refers);
 		}
 	}
 
@@ -2833,11 +2831,9 @@ dasd_3990_erp_action(struct dasd_ccw_req * cqr)
 			    "ERP chain at END of ERP-ACTION\n");
 		for (temp_erp = erp;
 		     temp_erp != NULL; temp_erp = temp_erp->refers) {
-
 			dev_err(&device->cdev->dev,
-				    "ERP %p (%02x) refers to %p\n",
-				    temp_erp, temp_erp->status,
-				    temp_erp->refers);
+				"ERP %px (%02x) refers to %px\n",
+				temp_erp, temp_erp->status, temp_erp->refers);
 		}
 	}
 
diff --git a/drivers/s390/block/dasd_erp.c b/drivers/s390/block/dasd_erp.c
index c07e6e713518..c462f01d22e3 100644
--- a/drivers/s390/block/dasd_erp.c
+++ b/drivers/s390/block/dasd_erp.c
@@ -170,12 +170,12 @@ dasd_log_sense(struct dasd_ccw_req *cqr, struct irb *irb)
 	device = cqr->startdev;
 	if (cqr->intrc == -ETIMEDOUT) {
 		dev_err(&device->cdev->dev,
-			"A timeout error occurred for cqr %p\n", cqr);
+			"A timeout error occurred for cqr %px\n", cqr);
 		return;
 	}
 	if (cqr->intrc == -ENOLINK) {
 		dev_err(&device->cdev->dev,
-			"A transport error occurred for cqr %p\n", cqr);
+			"A transport error occurred for cqr %px\n", cqr);
 		return;
 	}
 	/* dump sense data */
-- 
2.40.1

