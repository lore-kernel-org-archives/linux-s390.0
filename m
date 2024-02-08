Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2B9823B4;
	Thu,  8 Feb 2024 16:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707410581; cv=none; b=p/LMSFF1GQw3jgPxr7BY1krVuo+VGBY+xMrb10cBiVr4oHNfLojtoZ0YtjVKQrA1Pa6L9l1iU1UieeF84Lxms1r8fPXe4DiZmToanxKQw4yuYMoiQq9lPWxbnh6Z32EJhuvyYdZtj98rgnAo7mZ5/3y1eLEykZfq8z61rY0h0Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707410581; c=relaxed/simple;
	bh=/8BM4fgH2B0exJf3fE4al8Mb3oY4ZV6oT9Pi51gK/rA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GPZD16o+QzbroDKAQMGm7f4FswUyWDira5F5oltdTlGvXibwYJOjKx5xI4FL8HuCZyn3eLr/cNHyCgoDzCG6JixlfJITYhH7QLBRzceXLPxLb+cDxWufvZKKNgC4rbxJeuyDgb6F+KWxrzViPyQDKf5b2II4viCdiZ42PA8Vu4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iDatIIuS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iDatIIuS"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 418GZ27c020568;
	Thu, 8 Feb 2024 16:42:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=Ub0qkzCDCQy79YZ/QFXs54q/vVlKYzOMnbT0pqQS5w4=;
 b=iDatIIuS7KIOmwoiPhEdiFnq2UDVQXHEEnj4tOiGVd3sOnAl7G7XUvWHmTJcWtQFU/sl
 rEQCr5kN49+Q7GKFWig3raj6BI25KOdkq6l2AjGwWaMrThvtHkgV6zW+9fowwMjOzrXs
 xqWTomxtpU3SmylZxZvYHqo4HoUFCtQWyObBE9l5Sl+YRUuGFcfud8kHpg2dC6omUKDV
 lg7c5TSCK2xFYNmHf4CxTLuJXfy1JwqPYH/SHZ9sfSZEZX2i5PKKeyorxN8tAZB4tuKu
 sxplYFG5Y+ju7F6Z1CX5VPxE/SVLuGGd7PSqS4CMdxlzP6MHFnFzCwhEP9V+JUqby8Mr jQ== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w509qcf47-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 16:42:54 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 418GJwI1008478;
	Thu, 8 Feb 2024 16:42:53 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w221kd9j5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 16:42:53 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 418GgmuN20316746
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Feb 2024 16:42:48 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BFB192004B;
	Thu,  8 Feb 2024 16:42:48 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AEADF2004D;
	Thu,  8 Feb 2024 16:42:48 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  8 Feb 2024 16:42:48 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
	id 4DE08E1563; Thu,  8 Feb 2024 17:42:48 +0100 (CET)
From: Stefan Haberland <sth@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Miroslav Franc <mfranc@suse.cz>
Subject: [PATCH RESEND 07/11] s390/dasd: Remove %p format specifier from error messages
Date: Thu,  8 Feb 2024 17:42:46 +0100
Message-Id: <20240208164248.540985-8-sth@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240208164248.540985-1-sth@linux.ibm.com>
References: <20240208164248.540985-1-sth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: APT52aqu1qomIJkFtc3B4OBeJIc5hE97
X-Proofpoint-GUID: APT52aqu1qomIJkFtc3B4OBeJIc5hE97
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_07,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
 impostorscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402080088

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
index 79697301fd83..b3cdf254ce69 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -1379,7 +1379,7 @@ int dasd_start_IO(struct dasd_ccw_req *cqr)
 	}
 	if (cqr->retries < 0) {
 		dev_err(&device->cdev->dev,
-			"Start I/O ran out of retries %p\n", cqr);
+			"Start I/O ran out of retries\n");
 		cqr->status = DASD_CQR_ERROR;
 		return -EIO;
 	}
@@ -1907,7 +1907,7 @@ static void __dasd_process_cqr(struct dasd_device *device,
 		break;
 	default:
 		dev_err(&device->cdev->dev,
-			"Unexpected CQR status %p %02x", cqr, cqr->status);
+			"Unexpected CQR status %02x", cqr->status);
 		BUG();
 	}
 	if (cqr->callback)
@@ -1972,16 +1972,14 @@ static void __dasd_device_check_expire(struct dasd_device *device)
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
@@ -2102,8 +2100,7 @@ int dasd_flush_device_queue(struct dasd_device *device)
 			if (rc) {
 				/* unable to terminate requeust */
 				dev_err(&device->cdev->dev,
-					"Flushing the DASD request queue "
-					"failed for request %p\n", cqr);
+					"Flushing the DASD request queue failed\n");
 				/* stop flush processing */
 				goto finished;
 			}
@@ -2619,8 +2616,7 @@ static int __dasd_cancel_req(struct dasd_ccw_req *cqr)
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

