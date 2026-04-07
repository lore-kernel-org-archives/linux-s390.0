Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AACD37B002;
	Tue,  7 Apr 2026 20:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775595075; cv=none; b=grP2Ob2SB6PtIum57m0c8ozcz8uiwGEZzkeUNoC1LE8ldNB9211iUqhehul5gs+ru25T+/GsDyVcLr1x8QGZa6vyQJr3Q00kk5mZFpIahs6nCVYloskX66yK4LNUP2CrpDY5vdYFVeLRlTIMTmy+eSe1/Zg2tkmBr7HraV4kq6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775595075; c=relaxed/simple;
	bh=3Q1OrPi/TKQb7vu6By2eHytk30DHNulfO2s88uB/NF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YFIqfU6V9AgrsxMN0XMrIq3zpZu9nX5nLt8mjfR+yiFb3C/Hnx8AkObKXyHR+YyemL+vyAeZzB8h4kQ5gKD4Gds7BeZBQu/qSjNUdxE832Ma+Yc6WOgiqcEl+8vwEk6dQ7/uoa136W0RekTdDnKcAD5+vIjK4HwA2OWnlZ50tXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rhNoMUBi; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rhNoMUBi"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637DwpXt2326341;
	Tue, 7 Apr 2026 20:51:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Uwd32E0ON+rDFLj08
	wwC9rMdN0AUy8UbnCTfFznJAB0=; b=rhNoMUBiGRaYWaaQofKaBofUpFfqDy4Yf
	fKmUOec2gRpTUzw+Cw2C7RCt34J3NNTV2kxV5Js36PVmtP0And/VfSPm77Uxa0VP
	HX3EF1oZqesz4GxS3fT8GrfU8F9rUQ8rFCJ130HsqQmrZJtmbLTWf9EOhx93RIa0
	KeqCl0EO+bmExecBmNecI7w23MTUAwyVWtD+Ziz8c1MkMEITCwrjle3MY/D/c+Tw
	iOGeVmXeOiG7DP2/UjZFKhe1YsoWi/6mlLtx3uzi+k0oNrRQewHV6i70wJBF+vku
	aRC6ob7A7LSIWvDLH/uSWKqA/o+wX91GRpNnP0zo6Z5UIju71N1cg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2kcnsy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 20:51:09 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 637IlNS5030025;
	Tue, 7 Apr 2026 20:51:09 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcme7cucq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 20:51:09 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 637Kp84831392406
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Apr 2026 20:51:08 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2369C58058;
	Tue,  7 Apr 2026 20:51:08 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 99AC358059;
	Tue,  7 Apr 2026 20:51:06 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.101.194])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Apr 2026 20:51:06 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v2 03/16] s390/vfio-ap: Data structures for facilitating vfio device migration
Date: Tue,  7 Apr 2026 16:50:19 -0400
Message-ID: <20260407205100.331150-4-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260407205100.331150-1-akrowiak@linux.ibm.com>
References: <20260407205100.331150-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE4OSBTYWx0ZWRfX+0PhaoumlHv5
 XPqxQhQSI6Z6G2gF2He/9d/YjatGozl//8pDlOKbB/XuvuPsppGly5eSb44qOR6bn8RKz7MEfZC
 2upYsnrTgEW23hRrxHP/ywyW/n7wWlGFJPHcxm2jfQeXUQ/LJk6PYUjYA6pj2OIQDoAeLgXEjlS
 5fHyWbAhPnCuQxSHHD/gHO0mIHq1yXfBdz84Bz3TuIpQyq7kNWwduh6QA5DCYSoSX0k7qzbfTF8
 seCfNMTlgAlR39bTpZOLWnFvM8OBC4BJKEQCBlqNGMW8uZ5FXKEOzfu24D+M0+kl5KD3pg2UEX5
 alNnAfvWqUONCFMRIuKlBdJ6g52qurcXDUiGyqQJ5vi0vDRorvwGa/IPyWuVtxWaehMzBthY3Su
 pghbVckBde7IhtX+n2i2c3aDW+2+8pR5lkMeoirDxko9rskfHLfygrJGh+QNFLy2M5fRg9uDlcT
 M+v6sg9PFF8+ysHZang==
X-Proofpoint-ORIG-GUID: vbWvJTPVrOz-zWTUomkzeJT2Ws_SSQKd
X-Authority-Analysis: v=2.4 cv=e9k2j6p/ c=1 sm=1 tr=0 ts=69d56e3d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=8LKZ2_jO19hrQNhpKIYA:9
X-Proofpoint-GUID: vbWvJTPVrOz-zWTUomkzeJT2Ws_SSQKd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_04,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070189

Creates the data structures used to facilitate state transitions during
vfio device migration.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/Makefile            |  2 +-
 drivers/s390/crypto/vfio_ap_migration.c | 68 +++++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_private.h   |  2 +
 3 files changed, 71 insertions(+), 1 deletion(-)
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
index 000000000000..2c5978dde61d
--- /dev/null
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Drives vfio_ap mdev migration.
+ *
+ * Copyright IBM Corp. 2025
+ */
+#include "uapi/linux/vfio_ap.h"
+
+#include "vfio_ap_private.h"
+
+/**
+ * vfio_ap_migration_data - the data needed to migrate a guest with pass-through
+ *			    access to AP devices
+ *
+ * @mig_state:		the current migration state
+ * @resuming_migf:	the object used to resume the target guest
+ * @saving_migf:	the object used to save the state of the source guest
+ */
+struct vfio_ap_migration_data {
+	enum vfio_device_mig_state	mig_state;
+	struct vfio_ap_migration_file	*resuming_migf;
+	struct vfio_ap_migration_file	*saving_migf;
+};
+
+/**
+ * vfio_ap_queue_info - the information for an AP queue
+ *
+ * @data: contains the queue information returned in GR2 from the PQAP(TAPQ)
+ *	  command
+ * @apqn: the APQN of the queue
+ */
+struct vfio_ap_queue_info {
+	u64 data;
+	u16 apqn;
+};
+
+/**
+ * vfio_ap_config - the guest's AP configuration
+ *
+ * @num_queues:	the number of queues passed through to the guest
+ * @qinfo:	an array of vfio_ap_queue_info objects, each specifying the
+ *		queue information for a queue passed through to the guest
+ */
+struct vfio_ap_config {
+	unsigned int			num_queues;
+	struct vfio_ap_queue_info	qinfo[];
+};
+
+/**
+ * vfio_ap_migration_file - object used to facilitate migration of a guest with
+ *			    pass-through access to AP devices
+ *
+ * @matrix_mdev: the mediated device attached to the guest being migrated
+ * @filp:	 the file used to facilitate communication between userspace
+ *		 and the vfio_ap device driver during a particular phase of
+ *		 the migration
+ * @disabled:	 boolean value indicating whether this object is disabled (true)
+ *		 or not (false)
+ * @ap_config:	 the information for each queue passed through to a guest
+ * @config_sz:	 the size of @ap_config when filled with queue information
+ */
+struct vfio_ap_migration_file {
+	struct ap_matrix_mdev	*matrix_mdev;
+	struct file		*filp;
+	bool			disabled;
+	struct vfio_ap_config	*ap_config;
+	size_t			config_sz;
+};
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index d66586825ef4..a1bc50a59633 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -110,6 +110,7 @@ struct ap_queue_table {
  * @aqm_add:	bitmap of APQIs added to the host's AP configuration
  * @adm_add:	bitmap of control domain numbers added to the host's AP
  *		configuration
+ * @mig_data:  vfio device migration data
  */
 struct ap_matrix_mdev {
 	struct vfio_device vdev;
@@ -125,6 +126,7 @@ struct ap_matrix_mdev {
 	DECLARE_BITMAP(apm_add, AP_DEVICES);
 	DECLARE_BITMAP(aqm_add, AP_DOMAINS);
 	DECLARE_BITMAP(adm_add, AP_DOMAINS);
+	void *mig_data;
 };
 
 /**
-- 
2.52.0

