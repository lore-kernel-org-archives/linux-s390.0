Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73ADB395D8F;
	Tue,  7 Jul 2026 09:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783414964; cv=none; b=T/T3uFCSNfq9DmJUuskWxc+pTopz3GRIzbqZO49/xobrm7I+Fgacrq+4pLJChln9dBZb+o/Rpe+Lrc8LfccHH3pJFGYnZheF4hytOVSczjqYAOkHzmxF5Vu54uuFY5vRa8ZBgSta2ZmxfTIS6sEXw/rXpvtL0gGyLRxdyAyi8Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783414964; c=relaxed/simple;
	bh=EiRvIo35q2iFo5ZSA/IM8GZA9HtOqpYK8FczzZuPDQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W9Knxx+0erNCyFSGq2+SNWZHdHSNen4ALFngoiOsfDnRvFEKhnChthUVmUmtazBVEen5jTE31+3PVOdfPAzYl/AC5ObSeDQnQ5lC7zRC/TmK7xxkReGK/b31batmnM1ikWCneBvlekG5uDZLsMctRnCFeqrJZTAG9uYQk/OIvhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fycnx73x; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fycnx73x"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6678IIcV3011709;
	Tue, 7 Jul 2026 09:02:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=yjNkJCtjWvGzcbsfD
	WoNXCPCaiuYKvW9yMqKCfEqfPk=; b=fycnx73xXmoPDNWc1QPwxn8lcencBZ43F
	GDfWS6AnrWUgbB2SRHfLFxYAh/t+fbZsogBU94/0eUANeDfd/n7PIAnX9O3KXEhm
	zpCTRIVVVN7/LvOQQMN9j7wJMRtjc934NXYJg2RXYir1WrzFa19KQVGHm5Py/D4f
	Ozdf8yHrGY422iAUpGzPREGLc1Ewg1TDds6CTfe3rEUrslNhXd+n7Ni6jKn2XrAp
	Aa+DH/uH6BcEUnpaAQyHXMcMaCHqk8BUv9rIRCWqAIDWI6/TkP7KLQ5ujuads9Xz
	dxt/ONfzQtAMLpro38Ul37+XsNDJHHkZzPesY8pH+yScQ/Z1V8bTA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sp3p8rv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 09:02:35 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6678nZiJ028883;
	Tue, 7 Jul 2026 09:02:35 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqg1q2p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 09:02:35 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66792XU434734802
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Jul 2026 09:02:33 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 216B15803F;
	Tue,  7 Jul 2026 09:02:33 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F12F158060;
	Tue,  7 Jul 2026 09:02:31 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.160.85])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Jul 2026 09:02:31 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v4 04/15] s390/vfio-ap: Reset migration state in VFIO_DEVICE_RESET ioctl handler
Date: Tue,  7 Jul 2026 05:02:06 -0400
Message-ID: <20260707090226.3206695-5-akrowiak@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=KsJ9H2WN c=1 sm=1 tr=0 ts=6a4cc0ac cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=6UAmCRYpaa-dfjEBkfkA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA4NCBTYWx0ZWRfX2nmWiKeivjyx
 wFP/gEMeOpMvA3Kgt5AEJgl+uHPOPOteq+pJK4ppuX1mEvZmtcinJxMP127Zm+XNQ8P66/J8X9d
 Y8Qk1obzUK/tf/SU0vHRzq937JQ7ggI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA4NCBTYWx0ZWRfX7p8SWAHxq44Q
 bXiojOCfiAhG1HiPw2OyZRyy5jJWQKRgkYyCnDxrHvJK7jSk5TKF43SUFRWqpZXvb5zIuE6VMQV
 miuAJb02vVv71tPulhHCBKm3B9jwL1dtBqEw4JtfD2fTx3CwJCJphQSC7pC3jGq0L4LlY/Rg2C2
 rY8oqjcfydwz0v+O3s1eGo+ZVOuARFLvpkTCGefpaHOKJS1UxTDbW4w4GrTyknor03jLA+M5AJ/
 7S/ZkOtjTlv5FTVEc/cZ5CC0c2EpqbiTB30zx/NnOVs15XMpAvgDC9ETyOGmcPg7co/VYCi0ik1
 J/ntPIu60ttiEHdtjx9tNxIocnHO8hIGfnh7v3smAAd+Anw930aVAmRSKbQq2H4+RMel51zBhxb
 fKm/76OAR5r0W5n6MvFVXlVYka6Rsoljz8qODHhM5vIivRCEJKc7Hco5Ou0Z+xmhjWg02Mz32M+
 XwMZ+WscQEztUM/bAWA==
X-Proofpoint-ORIG-GUID: 3w27gwEFvuQyVKb6IW-1dhi-9Nqdl7NR
X-Proofpoint-GUID: 3w27gwEFvuQyVKb6IW-1dhi-9Nqdl7NR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070084

According to the VFIO migration specifications, userspace must issue a
VFIO_DEVICE_RESET ioctl if a vfio device enters an error state or fails a
state transition to recover the device and return its migration state to
RUNNING. This patch adds a function that is called when a VFIO_DEVICE_RESET
is issued that releases the migration files and frees the storage allocated
for maintaining the migration state.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_migration.c | 20 ++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_ops.c       |  4 ++++
 drivers/s390/crypto/vfio_ap_private.h   |  1 +
 3 files changed, 25 insertions(+)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index 5b6d48ccf332..c7c71980bdbb 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -129,3 +129,23 @@ void vfio_ap_release_migration_data(struct ap_matrix_mdev *matrix_mdev)
 	kfree(matrix_mdev->mig_data);
 	matrix_mdev->mig_data = NULL;
 }
+
+/**
+ * vfio_ap_reset_migration_state - Reset the vfio-ap migration state
+ *
+ * @matrix_mdev: pointer to the object maintaining the vfio-ap device state
+ *
+ * Called during VFIO_DEVICE_RESET to clean up any active migration
+ * stte and reset the device to RUNNING state as required by the VFIO
+ * migration specification.
+ */
+void vfio_ap_reset_migration_state(struct ap_matrix_mdev *matrix_mdev)
+{
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
+
+	if (!matrix_mdev->mig_data)
+		return;
+
+	vfio_ap_release_mig_files(matrix_mdev);
+	matrix_mdev->mig_data->mig_state = VFIO_DEVICE_STATE_RUNNING;
+}
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 813290214866..8a9e83921f74 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -2332,6 +2332,10 @@ static ssize_t vfio_ap_mdev_ioctl(struct vfio_device *vdev,
 		break;
 	case VFIO_DEVICE_RESET:
 		ret = vfio_ap_mdev_reset_queues(matrix_mdev);
+		if (ret == 0) {
+			/* Reset migration state per VFIO migration spec */
+			vfio_ap_reset_migration_state(matrix_mdev);
+		}
 		break;
 	case VFIO_DEVICE_GET_IRQ_INFO:
 		ret = vfio_ap_get_irq_info(arg);
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index a2a713f93674..1fbdfcce5a11 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -175,5 +175,6 @@ void vfio_ap_on_scan_complete(struct ap_config_info *new_config_info,
 void vfio_ap_init_migration_capabilities(struct ap_matrix_mdev *matrix_mdev);
 int vfio_ap_init_migration_data(struct ap_matrix_mdev *matrix_mdev);
 void vfio_ap_release_migration_data(struct ap_matrix_mdev *matrix_mdev);
+void vfio_ap_reset_migration_state(struct ap_matrix_mdev *matrix_mdev);
 
 #endif /* _VFIO_AP_PRIVATE_H_ */
-- 
2.53.0

