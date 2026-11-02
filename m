Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793632576;
	b=RFWsxa9pOYy9yCWIobhJGqiz6n5lCy6iLg0X4gYdiyli//huDAyFV32NsyF+19rVvJbr
	 Tgn6XtT8Fmm4t882t6p61otkME22bKxXSCFVnYdmhkxE5CSEjrxVEJBF8At3K48KKCMuy
	 oZWJ1uFw03UvyxrozpNaxASv7oR0vPLtqgJrtrtqzUInkqwR0i0NxozV1siKu3JhMEdv7
	 eEPVfyVbF4LFyZWfAseEw4KatYdrnUwxZtlwLveDyScqZGkO8Sa4u35xEXx23imR+G5h/
	 gA4fjAZ23TKmdI2lKm2BOwulTLdqJHT+GqAf1hx4ZiFdqshkynx65VPm56j5l+UjBKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793632576;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=ayNl51yf+VDPWL4xbIAVgujOdmDiopyMCsYyEHaw77I=;
	b=yZcBT4/dKB96EU58qvWs9nc3LZ+7Iloaaj4AqSxu2hkI+Xdlo4So0X2fOb63zveaHLvm
	 vehOmwJzfEZlpsMyMTijseKiKMrDBWo9aC8XtD2DP7JJVrKDzLqYWwYFI1wRWfrjcwFM7
	 lAr9N5h8ZT7bg2A6kUFW7K0q3bKdhBxBb4Uxs/x8BVelFFz9JC0L9sXEujYezvH3hhfZz
	 kib/evqqM3+Frp54AOBcmA3kgFfbu567K4qI00sFa7XnQU8OkJo/UZxBqSro+MYrbjcSy
	 tllGzIw+a9utgbtGPttqVWV9lCM89lXtDQJiuuMmbWUT/1Riy+MlOo6W1agIunztDQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SWsYvsNK;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E012607B7B3;
	Mon,  2 Nov 2026 15:16:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E012607B7B3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SWsYvsNK
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2EEZ953114732;
	Mon, 2 Nov 2026 15:16:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ayNl51yf+VDPWL4xb
	IAVgujOdmDiopyMCsYyEHaw77I=; b=SWsYvsNKD9FZzi1Q1VTqrn1Yn2PFoH+9P
	YBd+a4oq7MP52taMc8+Ijd5mINXjB0dRcOjPsK//Lba2kn8WLPEvjI/aXWaHuLgf
	4JZ9yfNo9Exd4HJDwVzbh39tw4vA4IcGrEQsxQjXJNuQJ3lmZGHsM+ocXRkQEF27
	VTgCE7f1/4xWeyJTybOsfFnEv5pGWIxz9/m31nnVUIYgUOVXFs4fEzyFadHMrfI0
	RmNuBUug6ev9ek9KoQZykB6Fz72HyxxShoqv8fivgy/henRq6GxqUzFFOoqVG+OI
	3BvhM3ZxaVggj3lG7eYgdzqH+uQfE1nrVNXtxTqtuZETHPnXQ+0vQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn7yrs56w-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 15:16:11 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2E617V1034521;
	Mon, 2 Nov 2026 15:16:11 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hnu1vej6u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 15:16:11 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A2FG9hg33358550
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Nov 2026 15:16:09 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1EEB458064;
	Mon,  2 Nov 2026 15:16:09 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D37065805A;
	Mon,  2 Nov 2026 15:16:07 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.57.150])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  2 Nov 2026 15:16:07 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, freude@linux.ibm.com, borntraeger@de.ibm.com,
        cohuck@redhat.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com
Subject: [PATCH v11 02/14] s390/vfio-ap: Data structures for facilitating vfio device migration
Date: Mon,  2 Nov 2026 10:14:42 -0500
Message-ID: <20261102151604.2150055-3-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102151604.2150055-1-akrowiak@linux.ibm.com>
References: <20261102151604.2150055-1-akrowiak@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Mcr5KJ/f c=1 sm=1 tr=0 ts=6ae8a93b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=7vL54HQLIAyOYZVRu_kA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA2MCBTYWx0ZWRfXyffg3Sb9uw0P
 EdFrvLcRlofI/mR5TFnje7vqNqX283nIrYmKSb3ikAm11p9axYdzmce2KSDmget9QWNmaj0ZlA6
 AbRfWhMe3W0vq7s0mbfKL9gnRYhGyfw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA2MCBTYWx0ZWRfX8ZBRIfZSKUQB
 4rHyzyJSIyRKQjzsSVdg/jay2ilRguME8YECrGDQOa1HT41t0ovX6IX0Ann5T4XYJFNOVOxAdXJ
 +aMrs0Aol3Q0lKQ7R+bcft5tpUI5LP5AiA6Xt8EAES2HrO2y6zjEHggxtiSMtqGgtXWUapwMADg
 v9zm3b5bHTnyLI4E81uoxiMTc4RLYLPm7u+K6fNjrsfKypicwYr6HuZvMBlA2mlOB3MygzHwjEi
 dliGSbluzApStWh4vjllMzwkzTYOLnkit9VVPu+5V7HXe4St/FeDt27Y5vrLq0kruptUb3Rfba/
 yhlYuid+74lMfNmrawSkzft72R1r/m+3LmBu9i3RDlrwQEouYXyZq3sajk2dE3dsUyXIloz0JTh
 K+RYBj+FTqFsQqiJeaFHzJFA9s0ukIph7PRnIkNYmpSlpB1kjzm4UeVIrm0gVbNToYJ3cl3pKOB
 rK+gqHhFNJzYNqV9sVw==
X-Proofpoint-GUID: DWPW0_769H-9uWBvhycbpf_Q-jfPEr2B
X-Proofpoint-ORIG-GUID: DWPW0_769H-9uWBvhycbpf_Q-jfPEr2B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_04,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020060

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
index 000000000000..2a0a8c76f820
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
+ * @ap_config:		object used to store AP configuration data between read
+ *			or write calls
+ * @config_sz:		the size (in bytes) of @ap_config
+ */
+struct vfio_ap_migration_file {
+	struct ap_matrix_mdev	*matrix_mdev;
+	struct mutex		lock; /* protects read/write operations */
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

