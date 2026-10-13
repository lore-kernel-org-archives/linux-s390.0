Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6783531AF6;
	Tue, 13 Oct 2026 15:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791905560; cv=none; b=PtY6DCV/FRkC5ECaLEjPRhUnVfrAciK37JUdTqf14Dgrh+wyVoYFy6NdKPlRHwu+lJwhn8uJPtHt2DvE832Gj+20bj3iJr4PeGoCi72uLnBdmJl3mMoFmR9xyoNDaqhGYgAMmkScyaqxDaAqlXLCF55m/FfRbj/M23owFStDoaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791905560; c=relaxed/simple;
	bh=+Rbdu+WgpNW6/SBsqHhhspwj6McxfRrHzIWBaOEntD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h6+tHai3c2DvU6fwL3eEsqjaJmWLNTxWrJ+b1iID/grFjIMJ3QsyBra7aIHVWFrZEVlp6s7MtW+SllcfNaHN1PBpj1fG41GRpAXLlcTrUu1+O8o/eswn/eP7qDO8o9P0OZvCAiX+7US/tn+yZGkm/rD9tSJAw08YxgA3zbt+71c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eNXi7Z1Y; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eNXi7Z1Y"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DEEgUU725769;
	Tue, 13 Oct 2026 15:32:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=I9uqpLTnMMtLgmWj2
	VdEU3TCKGd/jzaFx9yFrLdBqqY=; b=eNXi7Z1YJ0/EX6sDSFM2i4IwFVlrmvbg5
	v4xCZBX/cYIDla3b3Hy1S59CEFNJ+JniwKEUS3y6ZclhzERlXdeo6XbIr5vNnCqw
	fTkXC6TMUhmK9/KP8lkXRPYVNx+gJO58F3HSXdbGNxqvHTRj+Hh+4VTZq4N52/Da
	Jfgk/RnLGNsEikRaH8gmYNVoVM0Y2C0R7CBLVmYSwtKgt621Lxgz0poqO7bgAZY0
	FCB10IEhDic4QVwbm3f92iKbQ6pbp5aOvVP6Tw9qexMS4lF+GS03Ad+XrzD7SCyn
	PlfzJI5ApSc8DvMUI20/lduA8XN0hthy/k2IoZqr8YNZTq0Ubf9hw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv0enb5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 15:32:31 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69DFQ0SS2667165;
	Tue, 13 Oct 2026 15:32:30 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h802vtrnr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 15:32:30 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69DFWTqE31916354
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Oct 2026 15:32:29 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 354BD58067;
	Tue, 13 Oct 2026 15:32:29 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 974FA58068;
	Tue, 13 Oct 2026 15:32:27 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.17.246])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Oct 2026 15:32:27 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v9 04/15] s390/vfio-ap: Reset migration state in VFIO_DEVICE_RESET ioctl handler
Date: Tue, 13 Oct 2026 11:32:08 -0400
Message-ID: <20261013153219.3534306-5-akrowiak@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA2MCBTYWx0ZWRfX/Ej4RmXu3vth
 zJyPg7w2k7+PIEqAQhn7/JLq45YLfkKRfwnUxY06n+L9i98UfJ3zI87alDw24+2BTwUtMRN9n1E
 A1IiJgMVPggoamTZdn7TEel3JT4h9RiRB9zs1/kBAaWXZDNsai8wqSVZZm94GjP/PhYdWxm+REw
 9/cSU2Eqyib44uzOfEpbjfycnXLeWqRCSIjDUGljLj8vGDWvaLnd3L97+W9dRRZKv/G6RDVtCwD
 1XhZb/4CJvHnfE44A2X6QhfAP/uE1A119TPFxLH1QT4VwfU/oLp++W3h+eOzTXyCIy50wj19OUA
 KYEE1kMXYeLfoTHBm+COwtEXxTi+RTOj6HNqe3LGwXob4fxOHEIhZoaTLSAxBX/vU5hCngsaIOL
 Tez74ZaT9ujq2binYL4Gsg16f3ePghNP4FveIN7DxBvfEZ05Rnaw8Sk2+DTkF1Ylh/PUfNfWEMl
 kU6MnmI5Hk+PMZeyusQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA2MCBTYWx0ZWRfX+s83o7mGrKGw
 yxFKDTE/RzabGVFGlRb1m+NpeWmXRtIieDn0cZkuudiH7pmNXLC7iMN+tamL34ItHyp8ct+s4Nx
 btilSoJd7RZ1YLvcpSjTicm52TMTqjM=
X-Proofpoint-ORIG-GUID: 8dwV-bO5yYqqT1aiyEoIyEi4YkOW4OKa
X-Authority-Analysis: v=2.4 cv=a6KlZkSF c=1 sm=1 tr=0 ts=6ace4f0f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=OlMDtWmkmZCoppm_HCYA:9
X-Proofpoint-GUID: 8dwV-bO5yYqqT1aiyEoIyEi4YkOW4OKa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130060

According to the VFIO migration specifications, userspace must issue a
VFIO_DEVICE_RESET ioctl if a vfio device enters an error state or fails a
state transition to recover the device and return its migration state to
RUNNING. This patch adds a function that is called when a VFIO_DEVICE_RESET
is issued that releases the migration files and frees the storage allocated
for maintaining the migration state.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_migration.c | 20 ++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_ops.c       | 11 +++++++++++
 drivers/s390/crypto/vfio_ap_private.h   |  1 +
 3 files changed, 32 insertions(+)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index 5d912b1b6b88..5b17e3b58a80 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -246,3 +246,23 @@ void vfio_ap_release_migration_data(struct ap_matrix_mdev *matrix_mdev)
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
+ * state and reset the device to RUNNING state as required by the VFIO
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
index d62f501ab5e6..3095e771b6a5 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -2336,6 +2336,17 @@ static ssize_t vfio_ap_mdev_ioctl(struct vfio_device *vdev,
 		break;
 	case VFIO_DEVICE_RESET:
 		ret = vfio_ap_mdev_reset_queues(matrix_mdev);
+		/*
+		 * Reset the migration state unconditionally, regardless of
+		 * whether the hardware queue reset succeeded. The migration
+		 * state tracks the AP configuration transfer lifecycle and is
+		 * independent of the hardware queue reset outcome. The VFIO
+		 * migration spec designates VFIO_DEVICE_RESET as the mechanism
+		 * to return device_state to RUNNING (e.g. to recover from
+		 * ERROR), so the migration state must be cleaned up even when
+		 * one or more queues fail to reset.
+		 */
+		vfio_ap_reset_migration_state(matrix_mdev);
 		break;
 	case VFIO_DEVICE_GET_IRQ_INFO:
 		ret = vfio_ap_get_irq_info(arg);
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 6fc10e0d934f..79cd378c30d8 100644
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

