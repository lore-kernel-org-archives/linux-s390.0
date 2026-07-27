Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAC2424D75;
	Mon, 27 Jul 2026 17:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785173575; cv=none; b=MPSYppIFs8Xp5PxL7JJ6/dYRPASyIDOGEeNMJMpxFuCZJyQPkGj+9IogOHui2T5vJSjme2WGHv8HKU+ude4cvRkJrrBJFrRMRcaVAPyKg3Gmntdjl87d69JHCZlXcv6zogJiaMYkd5dfdvhys/37HBS3tgNm1lH16WbNUv9bZjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785173575; c=relaxed/simple;
	bh=cCKxm+/FEg9gUyeYxaV5MDKa+EW6tI9eQWY75mYyUsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T7G9L9xTC7GJXZjaT2VGKMoYbVCby8twBJTDidteh7zCqT4PMPiCYT+JpuJrdT8A0aLsCiHxuR025LYIxBtOIpNxeGWhtlOBOAHU1Gugd4VY/EqijhnwHgqlQH6rgTV3LM7zgGWHKgLx5sGZ7bfkBDydO41mQ1zzrXt/9Ze3698=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rKRJNL4b; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rKRJNL4b"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDnmBa2412920;
	Mon, 27 Jul 2026 17:32:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=uxnYqiIdjcj33xl+x
	kV7cQEraqRa+NqkZLsUyL4AeA4=; b=rKRJNL4bi6gKVu7W+/iUmfB1vhbBh0z2b
	2kyMEn7zCHHGWstwZDckbNC4KAFl0Y6sokg1/GtZX7EjKkowNFsWaKP6supAxcRo
	zbyvcJnkxCQxAOkxeh/uuWh4KQS9tTYWLe6TCionl3wJsuRXGvldT3V1CiqOfR3V
	C0hrO1yySWmDvEEdRlqxAxs6Wy+W4YSMoasch7osighDTn8IEfcVyzv6jz8ecF0o
	BobooAcGWagnbXhFNeOn7jhAJm/5wMgjeBMZbJL2LIxPV1jY643g473f5LI89Smh
	C+OVpmn422SLy2+2fUtm2nOaie3DRpKW2Qv0kkf9nfQECbzx2V8tA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwcrv1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 17:32:48 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RHQLhR031847;
	Mon, 27 Jul 2026 17:32:47 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pg650y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 17:32:47 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RHW9dX6947562
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 17:32:09 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9124058058;
	Mon, 27 Jul 2026 17:32:45 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DECF658059;
	Mon, 27 Jul 2026 17:32:43 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.182.213])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 17:32:43 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v6 02/15] s390/vfio-ap: Data structures for facilitating vfio device migration
Date: Mon, 27 Jul 2026 13:32:26 -0400
Message-ID: <20260727173239.2420754-3-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727173239.2420754-1-akrowiak@linux.ibm.com>
References: <20260727173239.2420754-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: r70rXhIAAgRrx-dOrQ520L4Xjt8CndW1
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE2MCBTYWx0ZWRfX/01gzIinKL+9
 tkhUzgT+w+uJmGkrS1+fJ+GaWlJKrSpFDu6R0W9VoZBu7Y90ZkPPORstVMAURJP+mf3wr/bKe0o
 jASQwH+Pi1Oiv8s8/em+6xxQ907Hm9w=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a679640 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=OK_kerOuralICY-O2F0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE2MCBTYWx0ZWRfX2nIKEoZAeTEC
 cCTOvn4+VlZ2gXrcRH6mrMDSmBS5bLas6CDk2nCY1EB0e25i0CTnK+o2hsvjhthNXiuNPXAGHDg
 XlASMfsBaJ53EoI/VgRs465vc6iZwXgHo84RpG5fzaYOPv/5Z4wtcHeD7BM6LXmHNr1/8fJNfsw
 zVr+9PPnUK/10i9a6WDkwuNP+hRFWlYKtV5iNr5/I3TsYjvyv+eMnnivZutg5Cz1Nx1Kt1EELwS
 /9ftAvc1rOVq6WZgIVAM7gFiwDljIpIj1tEca0Fr4uPEuPpa3FqmNm0Gb84bdqLnf9UfoWAimdt
 WS/IezqydERjfy6R+vGRHFyCDbDgJ96dpX6zorYjaWSX/2jXXlyIAZuOD3uEDrzNyWIvOBfjGBU
 B2AetsUs9t5lFeM0ILNWZgwYlfjmoFp7pUrl68eq8M/3hg5U+5Zqwn7cInZoSg9J1XgcJGpJ1Af
 bbg1ZMMB2KHJklckTmA==
X-Proofpoint-GUID: r70rXhIAAgRrx-dOrQ520L4Xjt8CndW1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270160

Creates the data structures used to facilitate state transitions during
vfio device migration.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/Makefile            |  2 +-
 drivers/s390/crypto/vfio_ap_migration.c | 72 +++++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_private.h   |  5 ++
 3 files changed, 78 insertions(+), 1 deletion(-)
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
index 000000000000..fc3b2e154ad8
--- /dev/null
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Drives vfio_ap mdev migration.
+ *
+ * Copyright IBM Corp. 2025
+ */
+#include "vfio_ap_private.h"
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
+ * struct vfio_ap_migration_data
+ *
+ * Manages the migration state for the VFIO device that maintains the AP
+ * configuration of the guest being migrated.
+ *
+ * @mig_state:		the current migration state
+ * @resuming_mig_file:	the object used to restore the state of the vfio-ap
+ *			device the destination host:
+ * @stop_copy_mig_file: the object used to store the AP configuration of the
+ *			source guest for transfer to the destination host.
+ */
+struct vfio_ap_migration_data {
+	enum vfio_device_mig_state	mig_state;
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
+ * struct vfio_ap_config - the guest's AP configuration
+ *
+ * @num_queues:	the number of queues passed through to the guest
+ * @reserved:	padding to ensure proper alignment of @adm
+ * @adm:	bitmap specifying the control domains in the AP configuration
+ * @qinfo:	an array of vfio_ap_queue_info objects, each specifying the
+ *		queue information for a queue passed through to the guest
+ */
+struct vfio_ap_config {
+	u32				num_queues;
+	u8				reserved[4];
+	u64				adm[DIV_ROUND_UP(AP_DOMAINS, 64)];
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

