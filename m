Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5520C33A033;
	Wed, 26 Nov 2025 16:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764173205; cv=none; b=kB+j5rkBK1fVRjDPMI1wWR6sYd17Ml2sb5H1oguTCH+ly4OQR0KScqf7PdQi/xYjsnzvN21GPnhml1Y20ZIV32bKeRePwu6HqOgYyBGoeWXL0pP0NBI/fAwsbz5uPpXodkRDOgELGh/I7sKUKWRuETtJPdeIEMmiCNNXbRR8HCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764173205; c=relaxed/simple;
	bh=zrw/0t28/sloNjA+AluxIfdl4DFHtCQ2nqfodpUd65g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U72OgrZlecxcJ0ByBJwtAi8ZwWSjBhw0nfSGEIB7cilO1J1umDx2a+5qB5pktdj/qXXxjLYm+PuIBLP0hJ99FAjJ0ZWeI5PABO6VasJVTg0hUhS989Rz5pNXSri1mhOMdlouCs2ZSY11g6nzGVmsFbChUWBC084cynci0CFJCDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Vtmn9O0v; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Vtmn9O0v"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AQ7pEqf018679;
	Wed, 26 Nov 2025 16:06:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gncGsh
	5BKFPf3NiBLe+XuV5EYGMmCZAvkxzYmii+ktQ=; b=Vtmn9O0v6VtOC0V4+L+6NC
	t27rmodPCqNIoxnjxyWqrU9XXH+RKxDOizZ/124WJ3LuxjnO8i5BajJQvnUbzajV
	BS1Xl7sAuDvIBpEoKzTxT2DTgDzLpG0+cGltGS8aaWWl7nHV5+BsxeTHbUZ1Y8Ub
	L5arXnQDdgI3Tp8jjFkuJjRpwROD6EOjDTr+kT1Dyvec4BpKV6suMjzpRNGhP8jA
	ZhK7HlpEiHX7CQs/c2kEdwBk4noJJyYfsbN0P6QLRCNMhzMgjWythM7OaVH+gibd
	06GnOPPSlevZzcasj5vWbeR8kb+yR4dL4U2a8BBnqML67b7L22HuCRbXIKtE9xyg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak2kq4a50-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 16:06:41 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AQEJcuI013794;
	Wed, 26 Nov 2025 16:06:41 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4akrgnbhjp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 16:06:40 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AQG6Yf362325010
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Nov 2025 16:06:34 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C7C372004B;
	Wed, 26 Nov 2025 16:06:34 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B5D7920049;
	Wed, 26 Nov 2025 16:06:34 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 26 Nov 2025 16:06:34 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
	id 7DB75E046F; Wed, 26 Nov 2025 17:06:34 +0100 (CET)
From: Stefan Haberland <sth@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 3/4] s390/dasd: Move device name formatting into separate function
Date: Wed, 26 Nov 2025 17:06:33 +0100
Message-ID: <20251126160634.3446919-4-sth@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251126160634.3446919-1-sth@linux.ibm.com>
References: <20251126160634.3446919-1-sth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAwMCBTYWx0ZWRfX2VRr8NxzRclH
 FR6MqgwGpcs3iNfMJZc6n+Xc3uttNnqiE8mDZMOKUSOx9Fwnre8Im0ovlfcChfoKRdye4fByWWZ
 Ex5VPFX04wCUnB7ltYoabqT+4gRoUNADGqh/hl5pV4ABD8c4uggxKoKSDGASUxRUkN/xkYbww52
 G1z3eWS7U1IYDK7aJhqvPcl8H5X6uclCYJ1TlbLlhKU50dpGs+BOgCcy39zKNcRL1f8i3AYsA4I
 EJ5hVUy/GCTvszhgh22qrEg1lj8IXWKJ3KLhcayxGRHxTuuK4vCL4Gk4XKNMvntcci4KjzR9BkY
 Av0bp1J4OeaZSyDaUKMZ6g63JntI3XHbB0LiwkVV8Tzvo+NUhksPltdm4VgnApQSF8EtXMPvm2M
 ED2bGfrh7RM2EguG63Hnmq5mHfAmXg==
X-Authority-Analysis: v=2.4 cv=fJM0HJae c=1 sm=1 tr=0 ts=69272591 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=SOKMRkzLwBKilfY3KKsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: MKH88Vt1DSJIK9_KKF_-5lrdfnkyM44Q
X-Proofpoint-ORIG-GUID: MKH88Vt1DSJIK9_KKF_-5lrdfnkyM44Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511220000

From: Jan Höppner <hoeppner@linux.ibm.com>

The device name formatting can be generalized and made more readable
compared to the current state. SCSI already provides a generalized way
to format many devices in the same naming scheme as DASD does, which was
introduced with commit 3e1a7ff8a0a7 ("block: allow disk to have extended
device number").

Use this much cleaner code from drivers/scsi/sd.c to handle the legacy
naming scheme in DASD as a replacement for the current implementation.

For easier error handling for the new function, move the gendisk free
portion of dasd_gendisk_free() out into a new function dasd_gd_free().

Signed-off-by: Jan Höppner <hoeppner@linux.ibm.com>
Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_genhd.c | 80 ++++++++++++++++++++++-----------
 1 file changed, 54 insertions(+), 26 deletions(-)

diff --git a/drivers/s390/block/dasd_genhd.c b/drivers/s390/block/dasd_genhd.c
index 28e92fad0ca1..6ee3d952412e 100644
--- a/drivers/s390/block/dasd_genhd.c
+++ b/drivers/s390/block/dasd_genhd.c
@@ -22,6 +22,7 @@
 
 static unsigned int queue_depth = 32;
 static unsigned int nr_hw_queues = 4;
+static void dasd_gd_free(struct gendisk *gdp);
 
 module_param(queue_depth, uint, 0444);
 MODULE_PARM_DESC(queue_depth, "Default queue depth for new DASD devices");
@@ -29,6 +30,37 @@ MODULE_PARM_DESC(queue_depth, "Default queue depth for new DASD devices");
 module_param(nr_hw_queues, uint, 0444);
 MODULE_PARM_DESC(nr_hw_queues, "Default number of hardware queues for new DASD devices");
 
+/*
+ * Set device name.
+ *   dasda - dasdz : 26 devices
+ *   dasdaa - dasdzz : 676 devices, added up = 702
+ *   dasdaaa - dasdzzz : 17576 devices, added up = 18278
+ *   dasdaaaa - dasdzzzz : 456976 devices, added up = 475252
+ */
+static int dasd_name_format(char *prefix, int index, char *buf, int buflen)
+{
+	const int base = 'z' - 'a' + 1;
+	char *begin = buf + strlen(prefix);
+	char *end = buf + buflen;
+	char *p;
+	int unit;
+
+	p = end - 1;
+	*p = '\0';
+	unit = base;
+	do {
+		if (p == begin)
+			return -EINVAL;
+		*--p = 'a' + (index % unit);
+		index = (index / unit) - 1;
+	} while (index >= 0);
+
+	memmove(begin, p, end - p);
+	memcpy(buf, prefix, strlen(prefix));
+
+	return 0;
+}
+
 /*
  * Allocate and register gendisk structure for device.
  */
@@ -45,11 +77,13 @@ int dasd_gendisk_alloc(struct dasd_block *block)
 	};
 	struct gendisk *gdp;
 	struct dasd_device *base;
-	int len, rc;
+	unsigned int devindex;
+	int rc;
 
 	/* Make sure the minor for this device exists. */
 	base = block->base;
-	if (base->devindex >= DASD_PER_MAJOR)
+	devindex = base->devindex;
+	if (devindex >= DASD_PER_MAJOR)
 		return -EBUSY;
 
 	block->tag_set.ops = &dasd_mq_ops;
@@ -69,31 +103,17 @@ int dasd_gendisk_alloc(struct dasd_block *block)
 
 	/* Initialize gendisk structure. */
 	gdp->major = DASD_MAJOR;
-	gdp->first_minor = base->devindex << DASD_PARTN_BITS;
+	gdp->first_minor = devindex << DASD_PARTN_BITS;
 	gdp->minors = 1 << DASD_PARTN_BITS;
 	gdp->fops = &dasd_device_operations;
 
-	/*
-	 * Set device name.
-	 *   dasda - dasdz : 26 devices
-	 *   dasdaa - dasdzz : 676 devices, added up = 702
-	 *   dasdaaa - dasdzzz : 17576 devices, added up = 18278
-	 *   dasdaaaa - dasdzzzz : 456976 devices, added up = 475252
-	 */
-	len = sprintf(gdp->disk_name, "dasd");
-	if (base->devindex > 25) {
-		if (base->devindex > 701) {
-			if (base->devindex > 18277)
-			        len += sprintf(gdp->disk_name + len, "%c",
-					       'a'+(((base->devindex-18278)
-						     /17576)%26));
-			len += sprintf(gdp->disk_name + len, "%c",
-				       'a'+(((base->devindex-702)/676)%26));
-		}
-		len += sprintf(gdp->disk_name + len, "%c",
-			       'a'+(((base->devindex-26)/26)%26));
+	rc = dasd_name_format("dasd", devindex, gdp->disk_name, sizeof(gdp->disk_name));
+	if (rc) {
+		DBF_DEV_EVENT(DBF_ERR, block->base,
+			      "setting disk name failed, rc %d", rc);
+		dasd_gd_free(gdp);
+		return rc;
 	}
-	len += sprintf(gdp->disk_name + len, "%c", 'a'+(base->devindex%26));
 
 	if (base->features & DASD_FEATURE_READONLY ||
 	    test_bit(DASD_FLAG_DEVICE_RO, &base->flags))
@@ -111,15 +131,23 @@ int dasd_gendisk_alloc(struct dasd_block *block)
 	return 0;
 }
 
+/*
+ * Free gendisk structure
+ */
+static void dasd_gd_free(struct gendisk *gd)
+{
+	del_gendisk(gd);
+	gd->private_data = NULL;
+	put_disk(gd);
+}
+
 /*
  * Unregister and free gendisk structure for device.
  */
 void dasd_gendisk_free(struct dasd_block *block)
 {
 	if (block->gdp) {
-		del_gendisk(block->gdp);
-		block->gdp->private_data = NULL;
-		put_disk(block->gdp);
+		dasd_gd_free(block->gdp);
 		block->gdp = NULL;
 		blk_mq_free_tag_set(&block->tag_set);
 	}
-- 
2.51.0

