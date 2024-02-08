Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC8C823AC;
	Thu,  8 Feb 2024 16:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707410581; cv=none; b=taXt9z9QrofJjAOQ2NTZW8qgSrEVywrdekrq31bdwrF8j3xBu2dneS5U8xQmZKqwlUH2+va0TTQY3poZS+tlM98WfuSzv0DDnlMPy3tdZ9UOMPMS2XBkrIbV/S2eiqveXg6usqqDcwykREHD55c8PbC5CfFvQYU6oiTdI2dLkDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707410581; c=relaxed/simple;
	bh=DFdR+/VQPFAHdnXSYbZpZDS2mahMbZI+V3bqR+tt4R0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cbjvUUaCcNez/qRL/tkSbwYV5Jdczhq7NTSuOckV3K7oCnffjP+9Uyp96Brc3rQTLLhhxfc7VGeSZYb5xf5h3DxdxwY7Czg8IJdqt6oLv7QaBn8n8YSgQVPXZ/d/ZxHZ18Pa40erpAmxB5wjpVcScLN2tEApLckTABB1jvjQ5tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tBaG5wiM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tBaG5wiM"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 418GSBTe019461;
	Thu, 8 Feb 2024 16:42:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=VL8mdpWDBLLmfFcJ+yEvTiNiMOGsAPvtCFnyASAyHb8=;
 b=tBaG5wiMe/N5vtx5o0vqqG+IU6yjB7kjc6QU+EhnMJT0MDsibLLZBVKVxBW1S+eXHlCr
 kg1buYxOTgrR+wIp+wITioqobYAc6scFUGu3bB1YM7iPW5DaTlLb04XZXYMBPAJ3SbKy
 nj1Xk3w6/0TvwNdW8rjVnxWqRaekEo3Tp3xhfmjAlq6m/RgzUhBEl0pADwUy+1SUPVuq
 htKP5yZ9jYSy52gKzjG1Bt6xE6RFyUINujjSRPDxHohYCcWfCtpXqlUwOinBnQ8Euhaq
 7oIOfenFdvxkS8/kd/hcYSssq3LiegiY8NsOQ6gxHqoIjz5EqUnAVpi5ofW+cVz05/mV 1A== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w4yqg5vh1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 16:42:54 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 418G97ci008623;
	Thu, 8 Feb 2024 16:42:54 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w221kd9ja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 16:42:54 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 418Ggmvi20382286
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Feb 2024 16:42:48 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A15E920049;
	Thu,  8 Feb 2024 16:42:48 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8BCEB2004D;
	Thu,  8 Feb 2024 16:42:48 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  8 Feb 2024 16:42:48 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
	id 446C3E1506; Thu,  8 Feb 2024 17:42:48 +0100 (CET)
From: Stefan Haberland <sth@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Miroslav Franc <mfranc@suse.cz>
Subject: [PATCH RESEND 03/11] s390/dasd: Remove unnecessary errorstring generation
Date: Thu,  8 Feb 2024 17:42:42 +0100
Message-Id: <20240208164248.540985-4-sth@linux.ibm.com>
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
X-Proofpoint-GUID: 6Bk3KoaascicRJDQ7_28hB0PablbXgNq
X-Proofpoint-ORIG-GUID: 6Bk3KoaascicRJDQ7_28hB0PablbXgNq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_07,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402080088

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
index 7327e81352e9..a9aa2db3f4ab 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -1301,7 +1301,6 @@ int dasd_term_IO(struct dasd_ccw_req *cqr)
 {
 	struct dasd_device *device;
 	int retries, rc;
-	char errorstring[ERRORLENGTH];
 
 	/* Check the cqr */
 	rc = dasd_check_cqr(cqr);
@@ -1340,10 +1339,8 @@ int dasd_term_IO(struct dasd_ccw_req *cqr)
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
@@ -1362,7 +1359,6 @@ int dasd_start_IO(struct dasd_ccw_req *cqr)
 {
 	struct dasd_device *device;
 	int rc;
-	char errorstring[ERRORLENGTH];
 
 	/* Check the cqr */
 	rc = dasd_check_cqr(cqr);
@@ -1382,10 +1378,8 @@ int dasd_start_IO(struct dasd_ccw_req *cqr)
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
@@ -1463,11 +1457,8 @@ int dasd_start_IO(struct dasd_ccw_req *cqr)
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
@@ -1904,8 +1895,6 @@ static void __dasd_device_process_ccw_queue(struct dasd_device *device,
 static void __dasd_process_cqr(struct dasd_device *device,
 			       struct dasd_ccw_req *cqr)
 {
-	char errorstring[ERRORLENGTH];
-
 	switch (cqr->status) {
 	case DASD_CQR_SUCCESS:
 		cqr->status = DASD_CQR_DONE;
@@ -1917,11 +1906,8 @@ static void __dasd_process_cqr(struct dasd_device *device,
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

