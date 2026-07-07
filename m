Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B2838F935;
	Tue,  7 Jul 2026 09:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783414960; cv=none; b=plFYnDQI1CS8DUJ34o/aDz84mI16Q7DyVqznhguph/UFlDDxFHjGdFsTKuvJ9OoX1siHM+aJcSnXtnBAKnh01RBYsDN0utzVJO3qk75L699tQK5KmP2IN27in7F/w915o1OxTRhVyoBpDh5NHQT5MCajqlFAltDM2e7EbRglE3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783414960; c=relaxed/simple;
	bh=UitA6KA3uTzU0zOIJCSouhNsDpIaclTqIJFSEw1DYsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H3W/97TzHDjgi/uTxgUBcof1Z1qTArw5rcWUMnxugsTKLfGtXGXddo1uAfa39El91PVbRijZrasla6+XUUGwDTOjjgZBF8q5MtAnFKR8y26RRPQtz//I/vLP9D7VGiANgDxgZlAx922Yy8uLxnfSPsZnvdkPFIa8b1RqL1rgL0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=c7UM0TZG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="c7UM0TZG"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6678IGFt2910566;
	Tue, 7 Jul 2026 09:02:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+eWcdQnENwgsePIIZ
	kk3Hz0xx/7NyBBYa52lEdZ3xuc=; b=c7UM0TZGZYhbEGqp102P7YxXSys0RWmrB
	K+uuBpruGYRbELiXjdi6nepfuO19XgWxorn2b04dcAXYKuclqJOI/FNkSfMsSDAw
	eleoh45t49MLlzcu2xXlJfo8VCPfrDPzg59Pn2vkUOyPVYl81QXsO8dL3upUwSuj
	v1TCEm5IMGtO8+FR/IDxth6ZtWX1nlo/rEQFYriQNO06ynrd4ATSTXq44eECuEDj
	sLoII9L7DyFEzoLJ2Cvaqr+p7iGU8lwFGkkjhuQjSsRF2DowhtFShOcVYoVXPwJ6
	o6FSaWQkw88LNDF9f3JACdtf0dRyHzN9P+yGPK+OKF/+6FCnzPU3w==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw4p6s8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 09:02:33 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6678nZ2e028889;
	Tue, 7 Jul 2026 09:02:32 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqg1q2a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 09:02:32 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66792UXG21365384
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Jul 2026 09:02:31 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 901EC58061;
	Tue,  7 Jul 2026 09:02:30 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6FFAD5803F;
	Tue,  7 Jul 2026 09:02:29 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.160.85])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Jul 2026 09:02:29 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v4 02/15] s390/vfio-ap: Data structures for facilitating vfio device migration
Date: Tue,  7 Jul 2026 05:02:04 -0400
Message-ID: <20260707090226.3206695-3-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707090226.3206695-1-akrowiak@linux.ibm.com>
References: <20260707090226.3206695-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1hklbphFYoODFwAIjiiC7hujpow_Xeir
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA4NCBTYWx0ZWRfX/4qkaQtjzUsE
 R5lhLROaEZQcycCAr45SsqYnNBfU00F29YoL47W5U1LNu70kY7ymao9BIMZ5RN16F6SV3lDfs97
 dKedhSHZSJwaRkVvjx5Dl9kDOm4Xf1fAqPE4UmoBHTpbSBTAxddego+IUt5WjdloCR1Xbv0rscS
 1The4dmq/+3gvqlLWVgZ1Khrxc36/nAZ01G22JTMOpJfKwAXtYZC6xofE0rUdKMyPP6CVMZeT9W
 ecZa0L5Md48z3HhSnNRNsohH0o/vR2zM0ig+rDcwbPSTxG4qrpJkFq7Go1AhMezRZwPR8/i0zHP
 yRneaNvKLvebzpIf5lxYBbVCR+O1G9iMfj3cYWL0bNCkrNNiM7xYz93c5mew+eJ3/otOWJjKcCD
 TtzKwY+xp21hhSYhzVwURnOr0IiGAQmjfW0AJvWXSHu/TXQfjZhR6dC8icxAfx/Qcee8EOZsh4P
 /9IcAmtvqOMtIEPkhRA==
X-Proofpoint-ORIG-GUID: 1hklbphFYoODFwAIjiiC7hujpow_Xeir
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a4cc0a9 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=8LKZ2_jO19hrQNhpKIYA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA4NCBTYWx0ZWRfX9CLSeenwLyXY
 4aurQJDpdh8HSREgy9w4MVtNJjz0/GFM+mtXufl9VhCDknfsTXl5B9P+SGyXICajNAnlY6v4N31
 iYojdQeDJTbVbGSJfqqz0p0xmm/jbJ8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070084

Creates the data structures used to facilitate state transitions during
vfio device migration.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/Makefile            |  2 +-
 drivers/s390/crypto/vfio_ap_migration.c | 56 +++++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_private.h   |  5 +++
 3 files changed, 62 insertions(+), 1 deletion(-)
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
index 000000000000..239168c4b7ff
--- /dev/null
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Drives vfio_ap mdev migration.
+ *
+ * Copyright IBM Corp. 2025
+ */
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
+
+	struct {
+		struct file *filp;
+		struct vfio_ap_config	*ap_config;
+		size_t			config_sz;
+	} resuming_mig_state;
+
+	struct file			*stop_copy_mig_file;
+};
+
+/**
+ * vfio_ap_queue_info - the information for an AP queue
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
+ * vfio_ap_config - the guest's AP configuration
+ *
+ * @num_queues:	the number of queues passed through to the guest
+ * @reserved: padding to ensure proper alignment of qinfo array
+ * @qinfo:	an array of vfio_ap_queue_info objects, each specifying the
+ *		queue information for a queue passed through to the guest
+ */
+struct vfio_ap_config {
+	u32				num_queues;
+	u8				reserved[4];
+	size_t				config_sz;
+	struct vfio_ap_queue_info	qinfo[] __counted_by(num_queues);
+};
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 9677e49554d7..2b542648964b 100644
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

