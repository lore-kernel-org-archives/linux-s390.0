Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792777444;
	b=Qe1akQrmbGyi5ezYwN7Z4wkHu6+jpGV6cALSNwk6uUVGFSuiYrLwzz6skOWN2eqKaQzG
	 Q3qOuWR2xnTLj+jdKg/n3H1t4X5Spvk8B1kBPl4mf31FBpxdnz4u7EBmegQMdYa6zh0Ey
	 p9qzMl5DA077clw1+1+dD+qdU9N4tI/MpLDO0gvLtvw1H4VlO1sA7XMvqgi936bxUEEWh
	 rpeDdimza1BEtSnMgnEhZ2+P+O8e0GPj05TwwjHuZFtsnbqV4vuo8u28ux1Wr+qYi/Yrb
	 sDURMeV5TKwDKAhaYGua1OzXQaOzIsQ15MBIJB/W9PL/qdzKLTGQ6m/iO5i88JAUmgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792777444;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=BP8xYFpCq1IVLM0BMphExhvmD4sS95L0evM5/uWkISw=;
	b=k4ypMbmS1ehDaoxLDJgncdyIh05P8n1/Be6AkVPLEYX44a7P2lOo7t94WioJvoYQhnG9
	 Novy1gAC70IJ2yLhZ/fPDcfqvN+uWI9RHY744vHNhRvVqu244IiNF+5eB3CQAqCxlJR++
	 XK7ThrCQUdMeBrOLjX1Y/7lkXn7gfEymCGAelwEuUTmAKZL0cEf0FTYjLNDfA1OUxl1v1
	 K683m+R1/wNxysqlqD/Cx/xAurPGyF56TPgS78kpdjz/w0ybTS+JCesgytBwBdt48qNGr
	 Fd7KWlfTxDMbKsO7fNJGcy42IzhIE41Rue+CTnFr6eRnpseMR7NaHTrfg199DyqOF6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lilAGoKk;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45B9606A31F;
	Fri, 23 Oct 2026 17:44:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C45B9606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lilAGoKk
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NGoV5t3562219;
	Fri, 23 Oct 2026 17:43:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=BP8xYFpCq1IVLM0BM
	phExhvmD4sS95L0evM5/uWkISw=; b=lilAGoKk7wpTGVyitRoPeo25yMrjmcaa9
	8denUj8rbB4qiUcST7LtCLYGrK4ir9k33YsyQLkAFvmcthaBNhYpPq+PuBwav+4O
	++4UAK0WxJCRZgY5Xp4hqUVcrc59FTDhqN8zzBbIXbNNTsGLw960UqOKXu1X0uqF
	oGWkB3jN5OC0znw3mqs0YSRpHWdQ2N15nZuUS+lsHcz48jSfbtar0bmgmcaDf1r5
	NjFgkhymM7ww7hX9PonczPxfiEtX+hwC1Ka7Bp5dH57/bMvR6jJFL4lgIpuPyJrd
	xBBXe+g+bgOziGs9uTMoG8MzXLGvyHxzN/roqjWEa8Xt2otHwc1zw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5apksa-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 17:43:57 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69NELEAL2203435;
	Fri, 23 Oct 2026 17:43:56 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hekdgn6tg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 17:43:56 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69NHhttj5046874
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Oct 2026 17:43:55 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 085DC5805A;
	Fri, 23 Oct 2026 17:43:55 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F73C58054;
	Fri, 23 Oct 2026 17:43:53 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.48.60])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Oct 2026 17:43:53 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v10 02/15] s390/vfio-ap: Data structures for facilitating vfio device migration
Date: Fri, 23 Oct 2026 13:43:36 -0400
Message-ID: <20261023174349.3545941-3-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261023174349.3545941-1-akrowiak@linux.ibm.com>
References: <20261023174349.3545941-1-akrowiak@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2NyBTYWx0ZWRfX6UstmDrChLEb
 FoJGMUK49znVclUk2hQdie2MmF2H/Irxsb9toHyvw6oQzjSGmXMfXypsbX8lqiuGuSq0GIDqwp4
 gDjUHwjfDwEEW6VZCufBCSHGKzI3jGY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2NyBTYWx0ZWRfX0qurIFA1UhLs
 aNAV/FGpxatouPlpb4WBFcv6Ts6RzETQ+kOGLigOIFfCGfaX62xcRO9XyglPJan53FsJiYzo/iW
 5q43qORTtXza1l9ToVeKagacqJRmyYhUAq7ZH3Rj18Alz0GR5Iu6lhM9gNS4xD3GpMKzUDJYtG6
 hTTLri0QnRDcUube4igwAibwE9yxE2JKyBfCqF5KH4AjcIqIcI8nt8viv5sqf1fD8eyd+HosWcz
 YDcHRDUk0HRHaiyHPBEOb+r60Y6PcVRlkKHBMDTmNpdJ+ylUAZC1D/LpkK/lV+CJJx8m/q6BIpj
 vzKo7ICpHihlyNlVI0KBoKUYH3mkdCQESa4TJQPKRd0mSaZoZIFDT+vN7eFalVlbUz8bh9T2R50
 1vW9iKDfIju3c6BALgDpmdTxnsBqXcZ32ElwWyLEDsTedco+D550zdIsIgSrum6D1VeC+7XxwTO
 IQyUYxpVq42Gucn4Kog==
X-Proofpoint-GUID: 2juaieHk5PwxuIGs4P25ggheOQsyuXtC
X-Authority-Analysis: v=2.4 cv=JIKuIMKb c=1 sm=1 tr=0 ts=6adb9cdd cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=68nMaGKcsOw5dmipEVMA:9
X-Proofpoint-ORIG-GUID: 2juaieHk5PwxuIGs4P25ggheOQsyuXtC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230067

Creates the data structures used to facilitate state transitions during
vfio device migration.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
---
 drivers/s390/crypto/Makefile            |   2 +-
 drivers/s390/crypto/vfio_ap_migration.c | 121 ++++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_private.h   |   5 +
 3 files changed, 127 insertions(+), 1 deletion(-)
 create mode 100644 drivers/s390/crypto/vfio_ap_migration.c

diff --git a/drivers/s390/crypto/Makefile b/drivers/s390/crypto/Makefile
index e83c6603c858..20f29184825a 100644
--- a/drivers/s390/crypto/Makefile
+++ b/drivers/s390/crypto/Makefile
@@ -34,5 +34,5 @@ pkey-uv-objs := pkey_uv.o
 obj-$(CONFIG_PKEY_UV) += pkey-uv.o
 
 # adjunct processor matrix
-vfio_ap-objs := vfio_ap_drv.o vfio_ap_ops.o
+vfio_ap-objs := vfio_ap_drv.o vfio_ap_ops.o vfio_ap_migration.o
 obj-$(CONFIG_VFIO_AP) += vfio_ap.o
diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
new file mode 100644
index 000000000000..f01a37e4c418
--- /dev/null
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Drives vfio_ap mdev migration.
+ *
+ * Copyright IBM Corp. 2025
+ */
+#include "vfio_ap_private.h"
+
+/* Magic number and version for the vfio_ap_config migration blob */
+#define VFIO_AP_MIG_MAGIC			0x76666170U  /* "vfap" */
+#define VFIO_AP_MIG_VERSION			1U
+
+/**
+ * struct vfio_ap_migration_file
+ *
+ * This object is used for chunk processing of multiple reads and writes of
+ * AP configuration information.
+ *
+ * @filp:	file stream used to read or write AP configuration data
+ * @ap_config:	object used to store AP configuration data between read or write
+ *		calls
+ * @config_sz:	the size (in bytes) of @ap_config
+ */
+struct vfio_ap_migration_file {
+	struct file		*filp;
+	struct vfio_ap_config	*ap_config;
+	unsigned long		config_sz;
+};
+
+/**
+ * struct vfio_ap_migration_data:
+ *
+ * Manages the migration state for the VFIO device that maintains the AP
+ * configuration of the guest being migrated.
+ *
+ * @mig_state:			the current migration state
+ * @resuming_mig_data_complete:	indicates whether a complete, valid AP
+ *				configuration blob was received (true) or not (false)
+ *				during the RESUMING phase. This must be checked
+ *				on RESUMING->STOP to enforce the vfio.h
+ *				requirement that SET_STATE must fail if the data
+ *				is incomplete or invalid.
+ * @resuming_mig_file:		the object used to restore the state of the
+ *				vfio-ap device on the destination host.
+ * @stop_copy_mig_file:		the object used to store the AP configuration of
+ *				the source guest for transfer to the destination
+ *				host.
+ */
+struct vfio_ap_migration_data {
+	enum vfio_device_mig_state	mig_state;
+	bool				resuming_mig_data_complete;
+	struct vfio_ap_migration_file	resuming_mig_file;
+	struct vfio_ap_migration_file	stop_copy_mig_file;
+};
+
+/**
+ * struct vfio_ap_queue_info - the information for an AP queue
+ *
+ * @data: contains the queue information returned in GR2 from the PQAP(TAPQ)
+ *	  command
+ * @apqn: the APQN of the queue
+ * @reserved: padding to ensure consistent structure size across platforms
+ */
+struct vfio_ap_queue_info {
+	u64 data;
+	u16 apqn;
+	u8  reserved[6];
+};
+
+/**
+ * struct vfio_ap_config:
+ *
+ * Stores the state of a guest's AP configuration.
+ *
+ * VFIO device migration state transition from STOP to STOP_COPY:
+ * -------------------------------------------------------------
+ * When the migration state transitions from STOP to STOP_COPY, the vfio_ap device
+ * driver will open a file stream in read-only mode and return the fd to userspace.
+ * This fd is used during the STOP_COPY phase to read the current state of the
+ * vfio-ap device on the source host. In response, the driver will store the
+ * source guest's AP configuration data in a vfio_ap_config object and copy it to
+ * userspace.
+ *
+ * VFIO device migration state transition from STOP to RESUMING:
+ * ------------------------------------------------------------
+ * When the VFIO migration state transitions from STOP to RESUMING,
+ * the vfio_ap device driver will open a file stream in write-only mode and
+ * return the fd to userspace. This fd is used during the RESUMING phase to
+ * write the source guest's vfio_ap_config data that was read in during the
+ * STOP_COPY phase to the vfio_ap device driver on the destination host. In
+ * response, the device driver will copy the data sent from userspace to a
+ * vfio_ap_config instance which is then used to update the destination guest's
+ * AP configuration.
+ *
+ * Since the source and destination hosts may be running different versions of
+ * the linux kernel, the vfio_ap_config object provides two fields (@magic and
+ * @version) which must be set by the source device driver and verified by the
+ * destination device driver to ensure the migration ABI of the source and
+ * destination hosts are compatible.
+ *
+ * Note: Since a guest's AP configuration could be comprised of a large number of
+ *	 AP queue devices, a vfio_ap_config object should be allocated using
+ *	 kvzalloc.
+ *
+ * @magic:	identifies this as a valid vfio_ap_config migration blob;
+ *		must equal VFIO_AP_MIG_MAGIC
+ * @version:	layout version; must equal VFIO_AP_MIG_VERSION
+ * @num_queues:	the number of queues passed through to the guest
+ * @reserved:	padding to ensure proper alignment of @adm
+ * @adm:	bitmap specifying the control domains in the AP configuration
+ * @qinfo:	an array of vfio_ap_queue_info objects, each specifying the
+ *		queue information for a queue passed through to the guest
+ */
+struct vfio_ap_config {
+	u32				magic;
+	u32				version;
+	u32				num_queues;
+	u8				reserved[4];
+	u64				adm[DIV_ROUND_UP(AP_DOMAINS, 64)];
+	struct vfio_ap_queue_info	qinfo[] __counted_by(num_queues);
+};
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 12d7d240addd..172471793e22 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -91,6 +91,9 @@ struct ap_queue_table {
 	DECLARE_HASHTABLE(queues, 8);
 };
 
+/* Forward declaration for migration data structure */
+struct vfio_ap_migration_data;
+
 /**
  * struct ap_matrix_mdev - Contains the data associated with a matrix mediated
  *			   device.
@@ -110,6 +113,7 @@ struct ap_queue_table {
  * @aqm_add:	bitmap of APQIs added to the host's AP configuration
  * @adm_add:	bitmap of control domain numbers added to the host's AP
  *		configuration
+ * @mig_data:  vfio device migration data
  */
 struct ap_matrix_mdev {
 	struct vfio_device vdev;
@@ -125,6 +129,7 @@ struct ap_matrix_mdev {
 	DECLARE_BITMAP(apm_add, AP_DEVICES);
 	DECLARE_BITMAP(aqm_add, AP_DOMAINS);
 	DECLARE_BITMAP(adm_add, AP_DOMAINS);
+	struct vfio_ap_migration_data *mig_data;
 };
 
 /**
-- 
2.53.0

