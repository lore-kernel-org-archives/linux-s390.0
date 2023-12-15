Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03ABA36AF3;
	Fri, 15 Dec 2023 15:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XSmOQqxR"
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFFOHR7002221;
	Fri, 15 Dec 2023 15:28:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=LXrR67UlmTcaNgIY9xfIVR0QdYtShEzidKKjgzYEkCM=;
 b=XSmOQqxRyXi5SvGwHqQEJsvuZJxGTY8D6lizqRqIsuhl6ruBdyd4ROXZ5bevX7F01TLg
 fLj7i4hQNSVdYjJtURErtSn2Wz5GmnvkK+JiRcDlOVstTJaG6lyonx3zKc78rqdXNVmg
 ehclUfxN69HsDZL0bH7L9QP+cI1d6oTZRtQ27UQbTqi/c2VIfTldgMsH8R0/W5gvzTIQ
 auYROdPSj+fZdVJPWaFD5y/tcrzNpLduoLbEzjopSunYWmWAKulGA0IQV41WHJ+9CDsU
 aQgFFGFlV77rn/ujv7KLGrhTUKH7sF25NkGtLKNN3jJ8paT1YXSsBDEwz5NoegPYalfa OQ== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v0pymm63e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 15:28:16 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFDqP75012585;
	Fri, 15 Dec 2023 15:28:15 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uw3jpgwjn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 15:28:15 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BFFSAna11272760
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Dec 2023 15:28:10 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 29F842004D;
	Fri, 15 Dec 2023 15:28:10 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A6F32004B;
	Fri, 15 Dec 2023 15:28:10 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 15 Dec 2023 15:28:10 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
	id 9A770E1506; Fri, 15 Dec 2023 16:28:09 +0100 (CET)
From: Stefan Haberland <sth@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 05/10] s390/dasd: Remove unused message logging macros
Date: Fri, 15 Dec 2023 16:28:05 +0100
Message-Id: <20231215152809.882602-6-sth@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: sEjXLklR3gLfn97QGS9nRshgWHnkZM0Z
X-Proofpoint-GUID: sEjXLklR3gLfn97QGS9nRshgWHnkZM0Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-15_09,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=876 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312150105

From: Jan Höppner <hoeppner@linux.ibm.com>

The macros DEV_MESSAGE, MESSAGE, DEV_MESSAGE_LOG, and MESSAGE_LOG, are
not used and there is no history anymore of any usage. Remove them.

Signed-off-by: Jan Höppner <hoeppner@linux.ibm.com>
Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_int.h | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index 71d88e931090..a6c5f1fa2d87 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -123,32 +123,6 @@ do { \
 #define	DBF_INFO	6	/* informational			*/
 #define	DBF_DEBUG	6	/* debug-level messages			*/
 
-/* messages to be written via klogd and dbf */
-#define DEV_MESSAGE(d_loglevel,d_device,d_string,d_args...)\
-do { \
-	printk(d_loglevel PRINTK_HEADER " %s: " d_string "\n", \
-	       dev_name(&d_device->cdev->dev), d_args); \
-	DBF_DEV_EVENT(DBF_ALERT, d_device, d_string, d_args); \
-} while(0)
-
-#define MESSAGE(d_loglevel,d_string,d_args...)\
-do { \
-	printk(d_loglevel PRINTK_HEADER " " d_string "\n", d_args); \
-	DBF_EVENT(DBF_ALERT, d_string, d_args); \
-} while(0)
-
-/* messages to be written via klogd only */
-#define DEV_MESSAGE_LOG(d_loglevel,d_device,d_string,d_args...)\
-do { \
-	printk(d_loglevel PRINTK_HEADER " %s: " d_string "\n", \
-	       dev_name(&d_device->cdev->dev), d_args); \
-} while(0)
-
-#define MESSAGE_LOG(d_loglevel,d_string,d_args...)\
-do { \
-	printk(d_loglevel PRINTK_HEADER " " d_string "\n", d_args); \
-} while(0)
-
 /* Macro to calculate number of blocks per page */
 #define BLOCKS_PER_PAGE(blksize) (PAGE_SIZE / blksize)
 
-- 
2.40.1

