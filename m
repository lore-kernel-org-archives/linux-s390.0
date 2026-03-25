Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B509C346E4A;
	Wed, 25 Mar 2026 21:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774472532; cv=none; b=J0JdWeD/ua2NvpeKZODVpd7ZKTYUAzu7oGj5HdH4yIBkMqb2+zpeEcVBjSQVFmEx84MBsBqA7NL0lYfzEymSKSHzu35Y0LDbESsOhXfr0SgQoPhm5bBcrPopXy9dOMBFI0UG9t2wa7QDntgE6ZXRX+jf+5V8rx91kU7jC9dRsnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774472532; c=relaxed/simple;
	bh=4I0g/89g/lYK3Q1XAhKUw07p0vdBvLCNzPUzmO0cSGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pgr5pVgFSJd2IxNLlD8hbMoAQqQp1Moqg/WP99hsHeel39L7hCQ8wY2LYsEtzpntNOd8ClKa3MFAzc9A13IXXh5fn0deo+hIntnGFthIkgwkbRtsN0lE5OelIzXTOyBshFxLL/fbjhuvaBE4F+4Sh3VNopU3fTsbs5QL9iX1eeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gsE9dqza; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gsE9dqza"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PEiJNV3111761;
	Wed, 25 Mar 2026 21:02:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=vPhQ/Jc1b3P48fO8W
	BU2mNGDvqreJ4p4wKs1Elq0NEA=; b=gsE9dqzaLx016YplzNArnKnYjiznRnVB7
	uXvrNck2NugtaywWYkTkQeoEpXZkNDHLE3YDEsUIUIfEjxbq/k87KAqaLSPsptcr
	LuWePWE8orgymo1MZTwvQR7aOwTcWLRs0nwFx11jkJYxMuWWy/hDtx16TLujagje
	Dmc2IYAdqgvIyMrf+94eV57jLS7WUnN5NmBqM58QTlAw96KKtfipGjIyUoHZld+G
	uaB/ZorBiFqzGhwYmbzysmhZNy/CwaQDYVu8W2DLspbjVVewoB/faHaFFPVcDoAH
	0UUGzRMrwplJIHtJ+3uF5+msZEVFsRQkwyYtxEvrYJDrHYCViKi/w==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kumsjrp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 21:02:05 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62PKBGn8012213;
	Wed, 25 Mar 2026 21:02:04 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d27vk816m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 21:02:04 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62PL222L39191038
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 21:02:03 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 95E9558067;
	Wed, 25 Mar 2026 21:02:02 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9314858056;
	Wed, 25 Mar 2026 21:02:01 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.136.69])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Mar 2026 21:02:01 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
Subject: [PATCH v1 10/24] s390/vfio-ap: Data structures for facilitating vfio device migration
Date: Wed, 25 Mar 2026 17:00:57 -0400
Message-ID: <20260325210149.888028-11-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260325210149.888028-1-akrowiak@linux.ibm.com>
References: <20260325210149.888028-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IWkUQK2r2UAM-h8qZtUMfg2hz_k-Nza0
X-Proofpoint-ORIG-GUID: IWkUQK2r2UAM-h8qZtUMfg2hz_k-Nza0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDE0OSBTYWx0ZWRfX+Y8hfL+OIMgG
 y5VQ4fESIZrmYoKBMCM+D1Eok07tzSnQQPGLV5ZyDt6cq0zpWARjHhm2ES6j9RBiy2VT5VVuuMZ
 lmSiLgHsL1WFyu7KI+zRQVFC0KZoZt9poTQT2KBqgKm5+ZK7H74SdTLrSBo3tBhnN+JcApah+3B
 dvZqds+RfqH9OQwJxUhzjOttuTCxF450SAMmwqaADbHKtqeVJJDoXEjdxNzFwx3zkcWIKae9+fx
 pfQI0t+lgNHxgXGyXxJR9KTGoM/EvavHklV2Sl5Gsm7EGp8HZV6ZkK1OxuTwXy12J+P4BrlIg9Z
 aGxJsk5mlGWhck0u9QJRlBUJ3dw360CwkLTTS2FTWoQWfPZXEnWhVGbpbzvNT5ULTQ2Qat/+rjZ
 +LZiI8ixdoOfwxJ9wPqSO4WeBx/JcXtelOfeRm/skhdNdIANfhBWwJ61YhlF6BqLfJ4PUqVYJqm
 KrNbQSVzN9nP1gKe9bA==
X-Authority-Analysis: v=2.4 cv=KbXfcAYD c=1 sm=1 tr=0 ts=69c44d4d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=8LKZ2_jO19hrQNhpKIYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_05,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250149

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
index 514de4a73678..24db7d32e41c 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -116,6 +116,7 @@ struct ap_queue_table {
  * @aqm_add:	bitmap of APQIs added to the host's AP configuration
  * @adm_add:	bitmap of control domain numbers added to the host's AP
  *		configuration
+ * @mig_data:  vfio device migration data
  */
 struct ap_matrix_mdev {
 	struct vfio_device vdev;
@@ -134,6 +135,7 @@ struct ap_matrix_mdev {
 	DECLARE_BITMAP(apm_add, AP_DEVICES);
 	DECLARE_BITMAP(aqm_add, AP_DOMAINS);
 	DECLARE_BITMAP(adm_add, AP_DOMAINS);
+	void *mig_data;
 };
 
 /**
-- 
2.52.0

