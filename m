Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794425001;
	b=Edk9Nckc68btXGfyqNAypJ/1it7oSg/U5O2U0divLtBHFs73/pkmX1gzhJkMvUZv7kOF
	 utXbjN6r4SGPLIXqQlnKSNNrzYgnhYB9OjI9yXmtpSYuYvUJ2MgbXd/Z93QumsU/l6HJY
	 /orCTXQAkTd7kMkHL++q8mEtJ7LElNsziCp58uqzHBaMpSzK7D6sXE8kzJH9prrN9GWBy
	 yjubXnlAVgXkQb9cbXOW4/wLKjrM3ijJgBJMTayb0wxUVwMH8h5zWL766j8hZSJ27apx3
	 QiVnXgEM3m+yGxX0Zgaiz0V4UlsN4Cxu38xq/7++l5vi900I8UMkq2jluPpBzcRgTxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794425001;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=6l7pxX9s0xOFOQV1s+MkJgAaQC35eNqSYf/sgQRXtZE=;
	b=C2kL2wAdg7emUoKEMXo4vnq2ugUDloLjKeAverFcSNjfuuY+blosTzTozVgNUUdWyKvy
	 8ZLrJlN0pFdyEGXTWJS/N8J4l8+cXI+NTpf/hlQCmdgwTnwTop3QFyIqV7D0PAtUBhk4n
	 ah3KvGtFMvn3DHTWHJPh5adSx/YgFExD3Bx3dWMVbCniAbzJEDk20hIVmInIjt12QbfbD
	 NtcGYU7kkCygYlnil3ijlpXeHk15tqkXwsIE2UeQ5cRt85kQDaTHqNm48C2S0oXra17+1
	 81m65mKcnxEu14JXBigB65LHIuJ5tI6ahhxBy7urZSQojU4iv1NUnSyrfTkiFq7Aphg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JIVSyTDc;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C156606A321;
	Wed, 11 Nov 2026 19:23:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C156606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JIVSyTDc
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABIiMFa1829021;
	Wed, 11 Nov 2026 19:23:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=6l7pxX9s0xOFOQV1s
	+MkJgAaQC35eNqSYf/sgQRXtZE=; b=JIVSyTDccbH87gQW/1TJVQZJ3PjlqaF/B
	NBoLmZeh3V+/5dRriytVQNUl0VtRxTAgAgc0oqygl3Rm8ueWZbOYkC/4rrf2FaMM
	QTNE5pPeejk8CAgL+NMoG6TuYbsaSGzZtY1MEVt2zPtDCKVgxthMqVQ2Ao38NDvj
	ynaUsXAoX1tb7Mo1r4a6KbGzh+3YnA8BOdeWWqqKXGCI3mQuyrGIFS0RKwo49L/V
	piSoEFOIJo3FGU5gChuRubz6glSBvcn4ka2PU/Gy/BsGQSzjsd5GF5gL+Enb/L9E
	Gq5cnpHl8NCxVsUp3iJqxI3jGe9tUPQm0KcFSGYSXwuM5sG0U8D5w==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hssdkuux3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 19:23:14 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABIZ1923781296;
	Wed, 11 Nov 2026 19:23:13 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hv4nswgdv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 19:23:13 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ABJNCRA21693172
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Nov 2026 19:23:12 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE8FD58069;
	Wed, 11 Nov 2026 19:23:12 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC73458052;
	Wed, 11 Nov 2026 19:23:11 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.182.62])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Nov 2026 19:23:11 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v13 02/14] s390/vfio-ap: Data structures for facilitating vfio device migration
Date: Wed, 11 Nov 2026 14:22:56 -0500
Message-ID: <20261111192308.2585984-3-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111192308.2585984-1-akrowiak@linux.ibm.com>
References: <20261111192308.2585984-1-akrowiak@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=POqaavqC c=1 sm=1 tr=0 ts=6af4c0a2 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=7vL54HQLIAyOYZVRu_kA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA3NiBTYWx0ZWRfXw4mIaAlc40R+
 s+SjZFrVgooVi37/vaxUrfzcx30JGg9I7HnXc0iX/qyg5O5r6evAGA9Elo+21Lk/1TV0XmGFuRu
 pjP5k14O0C9WrDW4GhX8b4EMrHevDjCcn9XSsABeZJBiCZmvK7m1scnh+55Xh1pgy3PnkKPs/y8
 Pk3ReAWFfilzBgcNZnRSijBGoaw2DEPmzn1Kiw/u4iB+BXT1tR2WeBWzHEo8AQrHN1UVzSSYE01
 TjNRkoXuNrfK4ANNdWYbCNs+/qrb8+FthZgUq9t6NRa2GbbfWRVzva6E73ykvNTCTrdyWgpb7KT
 9Pd0qp9+ZVFIrE6jumzbqeH/A1qv+5xasmH9FIGGxzZdUBSrwE+BX2Zzd1coHncf2BmQcoK485S
 dWW17gW6VmPUFQSHCM0/Zbo7fcED4HxAGrb22Hv/8Ey7NxFO1nTrWop64IKmqiSnyEHrCCHKtxi
 l0v8taevCFMErqHmX1w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA3NiBTYWx0ZWRfX9Sieu+tKKMuB
 0tf/DsazLapnDb2juFRHmS28Hy6Z6LJQxqDolhFjo4T0RUOiGtSG7zNaoLLJYLQ739TAlDdrFx6
 oHI4jGQYfI/kw/6mlVwI3uzi5p5C6ao=
X-Proofpoint-ORIG-GUID: _LnxtwPHpVk9HnjeW7dTqw3t3QH5m5ry
X-Proofpoint-GUID: _LnxtwPHpVk9HnjeW7dTqw3t3QH5m5ry
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110076

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

