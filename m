Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7394334DB;
	Mon, 27 Jul 2026 17:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785173579; cv=none; b=rKld0CDpHFWPni2xajtX+w5Ii9fa5H9leLAnxGxYElD5udHyIg6q8LZsTdG9e528G/7GAFqr8a3MqGagK4rPRQZUIF0Df7ROshGRbtrVhzTONuAMOU1opQTxBbJvnpLvAxMzkjds9BXJ+7z71kJMoOrwM0Re0m6ZcTL8w+AlXQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785173579; c=relaxed/simple;
	bh=/yyguvKPlqrywIu48aoTx5Jt0GouQ+GuT/lH/ZgwRqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R4Hl4pjOorhzx/BDWsKroxFwuBdVqeUn/4a5+LIiLVwGQ1B1yqf1GUtnzrzfII+eDcVriQbVy+qiaIboYIkON1f6YcXnpXjJ4p8K7oHkurAy6EV6gtG1be7Ta/nR7YKWvZzU8CMLZlV9rlFfDr2KyhDcoXe2YJZT5erodnHw/Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pnthU48D; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pnthU48D"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDmfbs2373095;
	Mon, 27 Jul 2026 17:32:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=1bVu0G9H299UdaeGW
	gUw4HpgzqJNPL2SHdavHqzlv4k=; b=pnthU48DauT4ty/pnVJNpUIlaEdvYBIk5
	i0xR3ofeU2YG6rI6pkbm+8W4DAT033evUcIJkl4xn1yi/0Ei6V9VS8USMfjPmZ/a
	6WpHv305Xwwn8fZfPzGNK5ljxs7QxvchSkhHoH2JuM8dIW7MfnnO+whnfFQIsp2G
	WCx9CmjfDmBItPyimQHeswAA4zgv+6WrWRvsVcELACspfmaevKLFgQkFAShH3Xcx
	FPMFrz7ukyXEY/dc/SvfawrcukNCIifEb6aGbMME3hRtMg1VSO0xfb+o+97GouWb
	WvFMWixJQOeGupA4wDe7hhiZGEaAJIZjn2cbc7ZjbmNL2c7fNKyrA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw799yr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 17:32:51 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RHQG7u031789;
	Mon, 27 Jul 2026 17:32:50 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pg6513-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 17:32:50 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RHWnUp25100834
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 17:32:49 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6BD7758058;
	Mon, 27 Jul 2026 17:32:49 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A7A945805B;
	Mon, 27 Jul 2026 17:32:47 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.182.213])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 17:32:47 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v6 04/15] s390/vfio-ap: Reset migration state in VFIO_DEVICE_RESET ioctl handler
Date: Mon, 27 Jul 2026 13:32:28 -0400
Message-ID: <20260727173239.2420754-5-akrowiak@linux.ibm.com>
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
X-Proofpoint-GUID: fRYA_i3blXa3e6Ekt1-RhjiQAHshc10T
X-Proofpoint-ORIG-GUID: fRYA_i3blXa3e6Ekt1-RhjiQAHshc10T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE2MCBTYWx0ZWRfX+XqTmwDQYTA+
 k5fyMnmsaXou2+927mFRQB/fZia1JEk3XqJJe8YyYQIskxC96vLZmLTOmN1NXS1HRZAqopTC2Y+
 XqZ6shXIJraXEvVITAIOWsNOGTi3x6om7QO2mbvB6prN8Wpcjh/Sa4TUuAe77W/SJ0sIF0TabaF
 pz8z4e4p6j4/Z/4eEwWiiMeuqH6sQIcxfW2SjjFsqGMAKUkpNqcE6n6g/7nLej3OcH+CXGNhJVP
 s8dzJmKUGdQQW9KeVCH0AeR+MCyrHmP+5QeKC8EogscX7FPkkhNldEuvrz8BUATkfG35QMP8PKY
 Zj/3M6gZYa7VA8f7qbKCB+MA5MvzlTJRuoAEOGJG+K/SJKdm4Z269SZATejnwcsW7lPl+Htr7oF
 3KvQXoOsQ93ORp61/yXvQHfKIqbANezSqisGV1+nDdPE8ZBno0foCFRo0iCMjlUZvYYHRDCMxen
 jK5QJ7kUtIbJYlxAIRA==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a679643 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=yK-hndWHgRgZV9HjYSkA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE2MCBTYWx0ZWRfX8F6jq1N3dXdX
 9M9fxiOyX/3Dp9EEN3K1yOkyF7a+KDKV5huRwZahZL3nUNT4OBdLIaS2JC7jxr84CZ5Cxv0VUtH
 iIcnmHprBfORkpQ9v2RgId8PepvqjK8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270160

According to the VFIO migration specifications, userspace must issue a
VFIO_DEVICE_RESET ioctl if a vfio device enters an error state or fails a
state transition to recover the device and return its migration state to
RUNNING. This patch adds a function that is called when a VFIO_DEVICE_RESET
is issued that releases the migration files and frees the storage allocated
for maintaining the migration state.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_migration.c | 54 +++++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_ops.c       |  4 ++
 drivers/s390/crypto/vfio_ap_private.h   |  1 +
 3 files changed, 59 insertions(+)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index ae0bd1f415fe..093219e6bb9f 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -150,3 +150,57 @@ void vfio_ap_release_migration_data(struct ap_matrix_mdev *matrix_mdev)
 	kfree(matrix_mdev->mig_data);
 	matrix_mdev->mig_data = NULL;
 }
+
+static void vfio_ap_release_mig_files(struct ap_matrix_mdev *matrix_mdev)
+{
+	struct vfio_ap_migration_data *mig_data;
+
+	/*
+	 * The fput call does not call .release synchronously while the
+	 * mdevs_lock mutex is held, so there is no problem with incurring a
+	 * deadlock situation if fput is executed in this function.
+	 */
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
+
+	mig_data = matrix_mdev->mig_data;
+	if (!mig_data)
+		return;
+
+	if (mig_data->stop_copy_mig_file.filp) {
+		fput(mig_data->stop_copy_mig_file.filp);
+		mig_data->stop_copy_mig_file.filp = NULL;
+	}
+
+	kfree(mig_data->stop_copy_mig_file.ap_config);
+	mig_data->stop_copy_mig_file.ap_config = NULL;
+	mig_data->stop_copy_mig_file.config_sz = 0;
+
+	if (mig_data->resuming_mig_file.filp) {
+		fput(mig_data->resuming_mig_file.filp);
+		mig_data->resuming_mig_file.filp = NULL;
+	}
+
+	kfree(mig_data->resuming_mig_file.ap_config);
+	mig_data->resuming_mig_file.ap_config = NULL;
+	mig_data->resuming_mig_file.config_sz = 0;
+}
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
index 90b0fce0123b..d05372b50d2f 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -2330,6 +2330,10 @@ static ssize_t vfio_ap_mdev_ioctl(struct vfio_device *vdev,
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

