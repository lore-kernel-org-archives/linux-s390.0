Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB31436344;
	Mon, 27 Jul 2026 17:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785173584; cv=none; b=X0YlJnpRrU0Pk0asI1SboWqgp6jBqwKkx/hgicnk+OoJXZw6NigMI6SBBEqirIx0Fjp9yNWxSPDJYfM8ZgKf/i/9ERusOQQozRIvfJJFwSglG4Ok7qlF9lKa6AxZn+jRKAgPu1tztAvxsrTi2W+n9hf4CYlA9o4yzRKMrhG5bdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785173584; c=relaxed/simple;
	bh=bnZOEMDWA1fbJbjuKzyhzbca79hTEQAyKrLoNpcDNxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C3wOcTEBZhz096fMdgFxiDt9Zd8GJgJb1BWboHMEvbv9dhplNtt/PL0+uDsJiwLXXcOsgqhz/cyAJ8u2DtdiTdZ4V5E0PoCNaTOJfZ1f7v8vK1smF1upqZt7ZJ24ObJchbHCCJ1IXeXi1cAuq+bfn1zezpnmB1OuJyF3i0xZ9fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oElSaOIp; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oElSaOIp"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDmcml2406258;
	Mon, 27 Jul 2026 17:32:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=heoPSbAJ9FeJQpBdz
	h+g+WWV6kaRG2OD8XZMFfOlvmY=; b=oElSaOIpjpgplooBcvP4pXybnTa2scXRe
	dUp8Z6dIMKpEWt9v5Cxx2A59hLcutmeRwXppZobRjif/7O9SCUvWIrg7YrgycL6I
	JYwYnzvavHQwisxg99TtSu/3c2/2HPrH0jevzRgojSmojdSej/6QekkHriP4sZJK
	iwPEwv0rYsNAIIdFmymvE2BdNHPD1hpAkYIwJtPOdHqbSfB3mNJyiy1ESwaYpg06
	XbbCWOfg5ZnW0X7flIdIbzXBqetVkFSyzDak69RP+T/36O82gWDz8CmjS53J+5us
	/A5FuVl4DiAfeXE9kEpcRJkSM7g1SJok1qkD/emHEB/L50YKOsprA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xha7r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 17:32:55 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RHQOY0022281;
	Mon, 27 Jul 2026 17:32:54 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uvxfpd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 17:32:54 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RHWrNa19989206
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 17:32:53 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 34CF75805C;
	Mon, 27 Jul 2026 17:32:53 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8613358059;
	Mon, 27 Jul 2026 17:32:51 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.182.213])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 17:32:51 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v6 06/15] s390/vfio-ap: Transition guest migration state from STOP to STOP_COPY
Date: Mon, 27 Jul 2026 13:32:30 -0400
Message-ID: <20260727173239.2420754-7-akrowiak@linux.ibm.com>
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
X-Proofpoint-GUID: BLDvO1HmikiBqeatGA_-nukyfHuuq7VE
X-Proofpoint-ORIG-GUID: BLDvO1HmikiBqeatGA_-nukyfHuuq7VE
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE2MCBTYWx0ZWRfX92uFp9pPL3Bl
 9IgPhYk9avetyVyaG+tsaThi8eTJyNAfNnDv/bw/7fMpF2Uc3ty7lH6NhYtY3biCOpDfsJcWRWi
 RPY63Msne62+RgoTMg3LWIMd+w62BLk=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a679647 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=M0PqInsX-VO7aBZjA1gA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE2MCBTYWx0ZWRfX/XUj8F8c16+q
 ea+ofZuVMpnmb3ThCXBhniNMzJqrumXGI0jI9aGJb7rOSkGz6v6EPszJdWDXbzEgOeIPD4eYdPn
 lRpW1NKON2zZQGFVe1Sm8C7B/V/sOwYSTKN0lzNQfInH4/UFewaSUT06Ge+6uXRu3xMRlr9YPRB
 rDpR4ZKDUUdHWOeLPVlVfBWgV1eRdI5K+NzNsyofseOim+cTv68upVGj1CfTfx8npUOSVmMnYZi
 DQMw3J1jiZ+Vn2O2vH71xn0n7i56GaZAe7e8E3NdIZ81Lxt7HjyN9fUXrabQfq7elc+VvtLveNn
 PxgpKNknfD5xr270jhCjgXinZLZnk31yaX/0Qe3gDLbr4DVgUp9Vik9stj90uLag7yHrItoALcv
 poIYolhvgvfxrhHSU1gP+QwCK4oZlB2Kj0UJ2lloyKK8ubbGloAfA0ydLf83W0exXayyOwC4Ty+
 5ufeXXPOV9TBBG8Oe7A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270160

The transition of the guest migration state from VFIO_DEVICE_STATE_STOP to
VFIO_DEVICE_STATE_STOP_COPY begins the process of saving the
vfio device state. The vfio device state is comprised of the guest's
AP configuration which specifies the adapters, domains and control
domains to which the guest will be given access.

To begin the process of saving the vfio device state, the VFIO AP device
driver opens a file stream that will be used to read the source guest's
AP configuration.

Note:
This commit introduces the file operations structure for migration state
files with a stub implementation of the read operation. The complete
implementation is provided in the subsequent commit.

This incremental approach allows for easier review of the migration
infrastructure setup separate from the actual implementation logic.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_migration.c | 146 ++++++++++++++++++++----
 1 file changed, 126 insertions(+), 20 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index 77d15c5cc9af..2b736bab7729 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -4,6 +4,7 @@
  *
  * Copyright IBM Corp. 2025
  */
+#include <linux/anon_inodes.h>
 #include <linux/file.h>
 #include "vfio_ap_private.h"
 
@@ -72,6 +73,92 @@ struct vfio_ap_config {
 	struct vfio_ap_queue_info	qinfo[] __counted_by(num_queues);
 };
 
+static void
+vfio_ap_release_stop_copy_file(struct vfio_ap_migration_data *mig_data)
+{
+	kfree(mig_data->stop_copy_mig_file.ap_config);
+	mig_data->stop_copy_mig_file.ap_config = NULL;
+	mig_data->stop_copy_mig_file.config_sz = 0;
+	mig_data->stop_copy_mig_file.filp = NULL;
+}
+
+static ssize_t
+vfio_ap_stop_copy_read(struct file *, char __user *, size_t, loff_t *)
+{
+	/* TODO */
+	return -EOPNOTSUPP;
+}
+
+static int vfio_ap_release_mig_file(struct inode *file_inode, struct file *filp)
+{
+	struct ap_matrix_mdev *matrix_mdev = filp->private_data;
+	int ret = 0;
+
+	mutex_lock(&matrix_dev->mdevs_lock);
+
+	/*
+	 * mig_data may be NULL if the device was closed (vfio_ap_mdev_close_device)
+	 * before the migration FD was released by userspace. In that case the
+	 * migration file state was already cleaned up; nothing to do here.
+	 */
+	if (!matrix_mdev->mig_data)
+		goto done;
+
+	if (filp == matrix_mdev->mig_data->stop_copy_mig_file.filp)
+		vfio_ap_release_stop_copy_file(matrix_mdev->mig_data);
+	else
+		ret = -ENOENT;
+
+done:
+	mutex_unlock(&matrix_dev->mdevs_lock);
+	vfio_device_put_registration(&matrix_mdev->vdev);
+	return ret;
+}
+
+static const struct file_operations vfio_ap_stop_copy_fops = {
+	.owner = THIS_MODULE,
+	.read = vfio_ap_stop_copy_read,
+	.compat_ioctl = compat_ptr_ioctl,
+	.release = vfio_ap_release_mig_file,
+};
+
+static struct file *vfio_ap_open_file_stream(struct ap_matrix_mdev *matrix_mdev,
+					     const struct file_operations *fops,
+					     int flags)
+{
+	struct file *filp;
+
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
+
+	/*
+	 * Pin the vfio_device registration so that matrix_mdev cannot be freed
+	 * while the migration FD is still open. The matching put is in
+	 * vfio_ap_release_mig_file().
+	 */
+	if (!vfio_device_try_get_registration(&matrix_mdev->vdev))
+		return ERR_PTR(-ENODEV);
+
+	filp = anon_inode_getfile("vfio_ap_mig_file", fops, matrix_mdev, flags);
+	if (IS_ERR(filp)) {
+		vfio_device_put_registration(&matrix_mdev->vdev);
+		return filp;
+	}
+
+	stream_open(filp->f_inode, filp);
+
+	/*
+	 * Take a second reference on the file so the driver holds its own
+	 * reference independent of the one consumed when the VFIO core
+	 * installs the FD into the userspace file table. Without this,
+	 * the driver's saved filp could be the only reference; an fput()
+	 * during a device reset would prematurely destroy the file while
+	 * the userspace FD still points to it.
+	 */
+	get_file(filp);
+
+	return filp;
+}
+
 static struct file *
 vfio_ap_transition_to_state(struct ap_matrix_mdev *matrix_mdev,
 			    enum vfio_device_mig_state new_state)
@@ -85,10 +172,22 @@ vfio_ap_transition_to_state(struct ap_matrix_mdev *matrix_mdev,
 	dev_dbg(matrix_mdev->vdev.dev, "%s: %d -> %d\n", __func__, cur_state,
 		new_state);
 
+	/*
+	 * Begins the process of saving the vfio device state by creating and
+	 * returning a streaming data_fd to be used to read out the internal
+	 * state of the vfio-ap device on the source host.
+	 */
 	if (cur_state == VFIO_DEVICE_STATE_STOP &&
 	    new_state == VFIO_DEVICE_STATE_STOP_COPY) {
-		/* TODO */
-		return ERR_PTR(-EOPNOTSUPP);
+		struct file *filp = vfio_ap_open_file_stream(matrix_mdev,
+							     &vfio_ap_stop_copy_fops,
+							     O_RDONLY);
+		if (IS_ERR(filp))
+			return ERR_CAST(filp);
+
+		mig_data->stop_copy_mig_file.filp = filp;
+
+		return filp;
 	}
 
 	if (cur_state == VFIO_DEVICE_STATE_STOP &&
@@ -259,24 +358,6 @@ int vfio_ap_init_migration_data(struct ap_matrix_mdev *matrix_mdev)
 	return 0;
 }
 
-/**
- * vfio_ap_release_migration_data: reclaim private migration data
- *
- * @vdev: pointer to the mdev
- */
-void vfio_ap_release_migration_data(struct ap_matrix_mdev *matrix_mdev)
-{
-	lockdep_assert_held(&matrix_dev->mdevs_lock);
-
-	if (!matrix_mdev->mig_data)
-		return;
-
-	kfree(matrix_mdev->mig_data->resuming_mig_file.ap_config);
-	kfree(matrix_mdev->mig_data->stop_copy_mig_file.ap_config);
-	kfree(matrix_mdev->mig_data);
-	matrix_mdev->mig_data = NULL;
-}
-
 static void vfio_ap_release_mig_files(struct ap_matrix_mdev *matrix_mdev)
 {
 	struct vfio_ap_migration_data *mig_data;
@@ -311,6 +392,31 @@ static void vfio_ap_release_mig_files(struct ap_matrix_mdev *matrix_mdev)
 	mig_data->resuming_mig_file.config_sz = 0;
 }
 
+/**
+ * vfio_ap_release_migration_data: reclaim private migration data
+ *
+ * @vdev: pointer to the mdev
+ */
+void vfio_ap_release_migration_data(struct ap_matrix_mdev *matrix_mdev)
+{
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
+
+	if (!matrix_mdev->mig_data)
+		return;
+
+	/*
+	 * Drop the driver's get_file() references on any open migration FDs
+	 * and free the associated ap_config buffers before freeing mig_data.
+	 * This ensures that if the device is closed while a migration FD is
+	 * still held by userspace, vfio_ap_release_mig_file() will see
+	 * mig_data == NULL and skip the cleanup (the fput() here will
+	 * eventually trigger .release, but mig_data is gone by then).
+	 */
+	vfio_ap_release_mig_files(matrix_mdev);
+	kfree(matrix_mdev->mig_data);
+	matrix_mdev->mig_data = NULL;
+}
+
 /**
  * vfio_ap_reset_migration_state - Reset the vfio-ap migration state
  *
-- 
2.53.0

