Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDFD3F5BD9;
	Tue, 30 Jun 2026 10:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782816106; cv=none; b=gy44H0XR4fJLPDdyDqmIMQpXsTvrVHg1s7Paub/hijG1krc7/dm8S1cFiihGRSlyjfCNsgopCEalh2D/rIT08vXmDT+fuZTlKp6sQAx4pdrMnJAi9nB/7RSJ2CYIrazUOgQaGfRnPZyJWd24D0Nrn1QFAlOfZdN+gd0HQZBd99s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782816106; c=relaxed/simple;
	bh=UitA6KA3uTzU0zOIJCSouhNsDpIaclTqIJFSEw1DYsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YA5AaOZbPYh7MDd2xevGC3nqzbF4arbte2FNB57hGX1rnofj7lm+iImdugvaJ/z01aJXldPNlzM0yoaq/93CoDJeJ0jtZXESj5QGTK4D5tF2ClMCr0KkP1HSNYo4mcvPRZZk4O4Or+mNtmVWYN78uK+YThqk9f5ZI7uhdhBguAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EIAXOov5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EIAXOov5"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9n51J1843352;
	Tue, 30 Jun 2026 10:41:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+eWcdQnENwgsePIIZ
	kk3Hz0xx/7NyBBYa52lEdZ3xuc=; b=EIAXOov5s7H8drMJagIvvFPYRLqMLp2VJ
	B1HrV3sp3cxMuqx4ilIAdvPe/jKwSYGfXY0XLT+vnWPTU15LKaQSThHSyWyNQdwZ
	vtPXRngIae4CMnUihNsackHvHHbh0AkbbeGvzyQnrN/JM+J7UwXZJE1mksXuUk8Q
	oU5d2NcCIQzG+fY9NZJV/dsDPAY9De5OosxOgyWeVB7RgSXyvDm5WyevhtL2s09G
	QRS25AKklMuE2nvfz+zFjNbHCe5jy8frCqirc68+4ulWR9PtJNRq0CfafxAAb9H/
	M6k914GoS/tP/1cx6UFZ7NX89OvO365RtvU2ymv1cjTHulECYei4Q==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qfx5h4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 10:41:39 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UAYaqw024035;
	Tue, 30 Jun 2026 10:41:38 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2ruq9wcr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 10:41:38 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65UAfaHd29033000
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 10:41:36 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8670E58067;
	Tue, 30 Jun 2026 10:41:36 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7EE8558068;
	Tue, 30 Jun 2026 10:41:35 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.135.84])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jun 2026 10:41:35 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v3 02/15] s390/vfio-ap: Data structures for facilitating vfio device migration
Date: Tue, 30 Jun 2026 06:41:12 -0400
Message-ID: <20260630104132.1598851-3-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630104132.1598851-1-akrowiak@linux.ibm.com>
References: <20260630104132.1598851-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RYqgzVtv c=1 sm=1 tr=0 ts=6a439d63 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=8LKZ2_jO19hrQNhpKIYA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA5MyBTYWx0ZWRfX+S5Qegdw4xZV
 Yku1EXgZmYOcoiZKUn5xAEv5JdQtfuWF7i+qQP8ryKMLd5I5l2Ph3DpzfGtgTMqus/+s+3GR9qf
 fnSvuL3WyrEZEl6kJDmrf1Nvc3ck7A4=
X-Proofpoint-GUID: GUqS952sdUmnzGbDAM-L3wthXIAAWsdM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA5MyBTYWx0ZWRfX0gXgJSvipt+h
 NlhcuI08Hj5iYvWRau2X8ZaDxOWh9IhyeamHZbVUGMWqA0fngWBTKn984ZC7KP35MzOlK6gnlps
 1Lrc6UIaZpDxwRMsCXCIh6J6SNpeMCukS8nXE7QQCZchB8N3lnuR65XbR4X+y/GxVkKLOcTZhTV
 wKGcO2+HmHPPiZJ5pHZTf32xuLx2cSqUxtmHUSHI3hvzb0/ePydus2dUr3tvanawRKBI01HaWVG
 o72Px/L2TQ231idsVMMIo2D6airdTODTAdjCl7LaDnvdX0QqeavYrLfYYeursnriY+AfBEC96Bo
 78oakujQbx+SiYsy/cpUnSufwqP/er/JeGcnWyIzvhjhWbRRgfF5htqt6cOIJqGeDZDLVmkbMKG
 LvEzBS2hoAO7a2/ilnlfQL4lCu6Nd2vUJvUBnYs1Pr9pOAVCUVKdV5DJxcNc9sU+rkV1+ebJrmR
 hNX30En7eGf8uKwXeNQ==
X-Proofpoint-ORIG-GUID: GUqS952sdUmnzGbDAM-L3wthXIAAWsdM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300093

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

