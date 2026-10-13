Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD71353160E;
	Tue, 13 Oct 2026 15:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791905556; cv=none; b=MyKhxufImOkHQya1vz0yyY5ZM+vJh20QmAcfO0/Nwz0s6a+o7zXjF62XaMfP+neGXSt5Gs1pjIokB6jAvCQ0ELvXDqfJXDSwob1ecskllaNFHiDPXaD0cowksCQ3eM/VFsfnICG3fK5ZsBqDborBQj2jVUDtr16b3QDCCCcOUAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791905556; c=relaxed/simple;
	bh=3p8V/XNcz4UBA0nSuVVCscnSVjVAp1ZSkXhCGsx8pkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e6elHZ2Td1KTzyNOVhLSbBktoR/acGIPE6G7Ut9N+eqlBf1Iy+p9fbtNHAZB6MwXUIlE2bDv0s1y9jl0wqVVkEw3gHx/2wpImjyRTTxres0RfCTSJklfBRjnTuKURF7UIN7naGUJSgjF/GSORGFse8grKxx27O86Fr6yP4aBN3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HW8nR13n; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HW8nR13n"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DE0xuI2016029;
	Tue, 13 Oct 2026 15:32:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=aauzIxXtBl2bDuudZ
	bSB3Ge7IrUQGG2lpugijlw/b20=; b=HW8nR13nvdYDAvIc9YBcCst5nCQvq5DVJ
	rnHK1rTtjuzElgPlzVIwfyFfOxSvBUVZOo6HF0a2n+di5FPYZ61oW/9uQnX68VLx
	rPH0XxH0L1ZaPGaQfBsOkM9JtRmisBQKDGa9wiEYoyaSrVoXFQ42V7agz0m7/wuz
	j5Jx8aLDMIIPs9aq8OR6I6yEyGoio64XTh/zVus3+B2tiAMu0MSC9Kr32MhB9SOn
	MYdHnYsu5fvWSUHHSV4bA/hVF3WvvlMm8S031BTTl8bUTEdtzo8rYp6Iz0W9amyp
	q+qfqV7jQXspCIA2rCG4D4PNQIenGkuNc3Sgum3dxYpjjay9ptZPA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dugf2ky-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 15:32:27 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69DFTYTA3303975;
	Tue, 13 Oct 2026 15:32:27 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h9qb6r0ka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 15:32:27 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69DFWPWj32113194
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Oct 2026 15:32:25 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A40EC58063;
	Tue, 13 Oct 2026 15:32:25 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0DF3A5804B;
	Tue, 13 Oct 2026 15:32:24 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.17.246])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Oct 2026 15:32:23 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v9 02/15] s390/vfio-ap: Data structures for facilitating vfio device migration
Date: Tue, 13 Oct 2026 11:32:06 -0400
Message-ID: <20261013153219.3534306-3-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013153219.3534306-1-akrowiak@linux.ibm.com>
References: <20261013153219.3534306-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Cr0q4X4D c=1 sm=1 tr=0 ts=6ace4f0b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=q7H8pZeb9lwjMWFkImUA:9
X-Proofpoint-GUID: dH0zuqjnDKgGD_FPBqgZF9SW0wacHsPu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA2MCBTYWx0ZWRfX3p8CY55iemWo
 vM/+KbVxtPNdOhQLQ/AG1eDxSUfU3/skd8+suf/J+LQ11UmWnX6rk1D3QJl1Ig+QvDG2sBpvqHQ
 awc1L04VQ+m+7DFC9WWgsl7houRnr+AfpL2P+I0EnbLHe9IZi6yGXIOvhepe8ZDIjFdWd3xds6V
 itW+kWQHGbYisKSXDykj9lZpRpqLX10I57mmUjPDCB7J+guUdhetxPDZRiRvmvro+atssFxzEn0
 d+H09oBM3RTUbQJ5IAI44l895eOnQdKV2Jv6gNHQJlfogBy2zs/p46rbtbbJ9eHpjr9wnZX/l5g
 QjOryOg0N6ENw24ANvL1S2FLW8dx2bVn5UTD0mbVygrzuASVuV7gKXsfMLhM9Fayh2eSIIKJNKU
 Kw1y4tRssSuoz9ggyc+QJ1xgkbqoU/y79eEFs3PPFMXRfDKudUk4g0KRSjhwhZSnO/uFBW93Y1M
 tNvTWYSymCpeHdTw7/g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA2MCBTYWx0ZWRfX23dNyIkYQhHW
 zKa8+TzGLiuQUsYyc7MEY7HDLwd9etHt7Rbos4lNd36tzSehg2zAbFRafsK/9LxDoOEURXkfJ3D
 /IVcwf4fARrbnAe9ZyFCzkFOtCmXls0=
X-Proofpoint-ORIG-GUID: dH0zuqjnDKgGD_FPBqgZF9SW0wacHsPu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130060

Creates the data structures used to facilitate state transitions during
vfio device migration.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
---
 drivers/s390/crypto/Makefile            |   2 +-
 drivers/s390/crypto/vfio_ap_migration.c | 113 ++++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_private.h   |   5 ++
 3 files changed, 119 insertions(+), 1 deletion(-)
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
index 000000000000..f76d151a5cce
--- /dev/null
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -0,0 +1,113 @@
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
+ * @mig_state:		the current migration state
+ * @resuming_mig_file:	the object used to restore the state of the vfio-ap
+ *			device on the destination host.
+ * @stop_copy_mig_file:	the object used to store the AP configuration of the
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

