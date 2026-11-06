Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978595;
	b=zMwKohT8aiC7OG1oNvUg0jhvC2fb670/5GeWJqFA+L6HxhzzTMWBl3B2d6yhxAERkiR4
	 rGqdFbRTxexy0dUz6tbjGIhnRJjudQevHNmmhXmBtSw3JjE5Su9K/P5nTuz3UiUNg2Qfg
	 RN9Rc8kAJmmFU16u23craOiLa+xUm3nVjPEmNIM2wgjoeZYjvDcMlwo8Urwq+8HBinoVK
	 +aqnuEruDl3r36RjNBzDpIZLbeN91NjwFXH+IKnG3NTP2MheLQP8PFXHwIsiCKdVGyblg
	 Qc+idXS4u+N55oOqNooku7DGd88pMEvVj6TnjWQOVVRmmSUWcEid0kE3LZltQ0ir4xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978595;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=6l7pxX9s0xOFOQV1s+MkJgAaQC35eNqSYf/sgQRXtZE=;
	b=R4HKkrEoRkyNYQgbNHRx/ca0CRcqax51qEvWQQ6uyvnmTvvJ3NwX8RXieDjrdUAIazfj
	 RMfJf/xZGziW6gV7+Y5QTn18H+EuGdNtI/rAfMo9kVrTNa0TjV1KIyB2zO9/ocG9s1/Gk
	 NhNGO07HJFnJ/qc2euf2uzMxlDs33l/rcgHE7Ujxn64v9q0hCaqcN6nr7JKdjfU6pltU6
	 AM2zsttRX2fvNwtuC9liBGHyl4Zg5l/xHFpf8x8dvaaDAEBZPDGH/lyuGwbJYovOBWZWi
	 1HnFq2jtcS3GVNZ3TacIrPoRnfHymVWUyUJtPAu25EFQo95fu0JixgXdJjpfw1koYFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=nchoGeZZ;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276A4606A33C;
	Fri,  6 Nov 2026 15:23:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 276A4606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=nchoGeZZ
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6FE7Ks1094515;
	Fri, 6 Nov 2026 15:23:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=6l7pxX9s0xOFOQV1s
	+MkJgAaQC35eNqSYf/sgQRXtZE=; b=nchoGeZZ4q3+KvNMhmKIJOtYfiTKc6mYX
	C5ehKier1JVHC4dDb3UocXIvYDavE8NDySMAnO4dVzIKVrGUWHbUbp9U9yTEmh/f
	Aouct2VyVpkSHYpgoxfU7XpCbkGg6dHPUQKh/FkSXvWQE+s8kBsMwgadX4HRKhp1
	yWHmgxH1HQqiOvwpmGcyDce3MbPLvyf6TdQE3l1EIX9oXfKJ7kAZzj+ho1D4rgwb
	oCv01v2kHpmkD1RnpVbLl1fR/pXB04WRSC4R2qOmG4wJyrA1vgIx5qILFzhYhpPE
	P6qEHk0Bm2ohNimNjBt4ZZQZ1aAd5t7u2MU2Oj2WJNNamDsCvnTsQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3raw776-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 15:23:08 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6F4wNW2390145;
	Fri, 6 Nov 2026 15:23:07 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hs7h13m06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 15:23:07 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6FN67x29032978
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 15:23:06 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0823458064;
	Fri,  6 Nov 2026 15:23:06 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5696158055;
	Fri,  6 Nov 2026 15:23:04 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.114.69])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 15:23:04 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v12 02/14] s390/vfio-ap: Data structures for facilitating vfio device migration
Date: Fri,  6 Nov 2026 10:22:47 -0500
Message-ID: <20261106152259.1360651-3-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106152259.1360651-1-akrowiak@linux.ibm.com>
References: <20261106152259.1360651-1-akrowiak@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=QYDzLcbv c=1 sm=1 tr=0 ts=6aedf0dc cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=7vL54HQLIAyOYZVRu_kA:9
X-Proofpoint-GUID: QoNGPoeYzJ3KaMOQuTo_bdtiS_8U-R25
X-Proofpoint-ORIG-GUID: QoNGPoeYzJ3KaMOQuTo_bdtiS_8U-R25
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2MCBTYWx0ZWRfX2iRp7vtYonIw
 LLznraGxlT7UsO+lbigzs4vdvQsAd05yeyvco4fujBQgzJWmccWY7CnHCvNbjypgww9mN6xVIRp
 4s03dL2NRW17eZM3bZJZRbD4U0YO4S0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2MCBTYWx0ZWRfX7OwZWl3xlkpL
 5Ayc/X/XKLd+Tm/6gbCiFjSm66ML3DfPU9lbGgfZIqP2wlvmD8p19vueEMsVQns1RvPOnbqVTCu
 35AOUJU+xuZ7f/6sv6cLPLFTIFnqwlDcbNXTSVy7TACWDhRW9OPY+MwWBNMiA4uLl/F+J14PP7Z
 PuGab6+jS5IDN3v9Al9UUmQ0iI4VKqtEumMhUwj5kBqSEJZqnBDjVW8QV6HC27unCvak1LD1ES5
 20MAbwLx48WULCPFGywvlDOtRfVtRjU10LOVDFuix6rvIN9E4pq3xs7wGOdAj5N1awqntzO8Hlv
 c7RbvAmtUCDwsLhUreXjJToumPglmgtHi5CcOvPNLOTQhth/TEnsnTFjnhZoN9Gq92wtobzuv4g
 wgoJcC56swNZZR9lYhf7T0SO5x0XPg6aNKJvkXi72TlIxEB3Zb1G06DHoJ256NCi1TDL0b8MA0h
 u2+bMn+YbDBz3y1GGEA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060060

Creates the data structures used to facilitate state transitions during
vfio device migration.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
---
 drivers/s390/crypto/Makefile            |   2 +-
 drivers/s390/crypto/vfio_ap_migration.c | 125 ++++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_private.h   |   5 +
 3 files changed, 131 insertions(+), 1 deletion(-)
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
index 000000000000..52f9a0524ae9
--- /dev/null
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -0,0 +1,125 @@
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
+ * struct vfio_ap_migration_file:
+ *
+ * This object is used for chunk processing of multiple reads and writes of
+ * AP configuration information.
+ *
+ * @matrix_mdev:	object used for managing the state of the mdev
+ * @lock:		mutex used for synchronizing read/write operations
+ * @filp:		file stream used to read or write AP configuration data
+ * @ap_config:		buffer used to store AP configuration data between read
+ *			or write calls
+ * @config_sz:		the size (in bytes) of @ap_config
+ */
+struct vfio_ap_migration_file {
+	struct ap_matrix_mdev	*matrix_mdev;
+	struct mutex		lock; /* protects read/write operations */
+	struct file		*filp;
+	void			*ap_config;
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

