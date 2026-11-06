Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978598;
	b=FI7ZsvZB1RCUxQi2NBKD5BaTxnWyRRsSlAueIYu91MLGU4dj1nXzClwrpoxnyLudnWrZ
	 g6IhV/STwmpMDx5E5TdXUfOvk7Lu6lSyuDqFHVgmZGuzgK69xN+YgYbm+N5HcrcxMw6m2
	 82HwP7oNGp4K22mnSNGYUktvyDPCHpxmLoJgNfnFupWTPlIYC7aIf+nJK31prWsC4U8YE
	 IPREXDAW4EhDOqOUnUKxyLd2M67bG1Y4p3UQ3/dlmJGR7qlAFg4H3AVXLl+F6lA+qywRV
	 pIx4hKGjl/5rNCWnlLWxSafEL0xroEPgtL5pGbOi2pvgkVThubHSJ+/tdatS3Y/h3fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978598;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=lx1JsB409NqjqtzLBv0T3JHbf2Pq6fO8sQ4yuYUWMbM=;
	b=Z07pyA32Twa+wNZyo+ZEVFo1nXFkMaDNuclFOMGW0wFd3v5hRGZrbZB390X5WS9tjYfu
	 pqcqDROHsLt2xup5aG9t/xaHYNUOAoCZrHMjvcpT5Z7h0XhDiWzuG5me8l9n9aBNhm/8j
	 DIHKORrKvXdRuDPwJ/KLqsxEnCMkwTCyr2+cM0ltJyihkQoOx3pH52zCzmfVCHzWtHztN
	 /AX1BAAR078/WjY/RyGEKHKth23Xte7hTGdY9skBuNsSRofSsf/sA7cf79RglD8G97jhx
	 jiuwGt4h0zPPqIP+9FbZKLlw0NwW0UH96oYDDyM8IgXoiv8xBD5Acdo0qAJuljJ6k6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bsvhWC41;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A7E606A32D;
	Fri,  6 Nov 2026 15:23:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1A7E606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bsvhWC41
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6FEA4B1094569;
	Fri, 6 Nov 2026 15:23:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=lx1JsB409NqjqtzLB
	v0T3JHbf2Pq6fO8sQ4yuYUWMbM=; b=bsvhWC41v3DGgyqhZpEHVrwPCRYTVXQEW
	iFUOQ2N6rua+zMzv1Q1jrSlYvzLrTe8PKfDljE7dAedjb/X/Qf5B5T+XT0uxTVio
	C+mJcq5fkRV0ITfXG6IuTblqeLpY6FNW5U0kFiPTLO03Vb7FN/zFFBSBVCv2Gx7F
	zTlfoG7i0gjLeCnbVdWz6rotCs+NJBExfgJ5QYB/ILN+YCdE61+4YHvhshAMF1CC
	JT97NzSQ9mmRHiEHnGAMZDc53yeSxTHYin/vs4ZZFk/FhoWjZWx8QT/z8MoqIXo1
	JLZgj2uDnNlyDgsMWz4Iv5JCmgnilz1IFTAzpGmRJyNI/+Dsx0KpA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3raw77h-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 15:23:11 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6F4t8V3584929;
	Fri, 6 Nov 2026 15:23:11 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hrka71u0q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 15:23:11 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6FN9NQ24183486
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 15:23:10 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B64B658066;
	Fri,  6 Nov 2026 15:23:09 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 200AA58062;
	Fri,  6 Nov 2026 15:23:08 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.114.69])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 15:23:08 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v12 04/14] s390/vfio-ap: Reset migration state on VFIO_DEVICE_RESET and device close
Date: Fri,  6 Nov 2026 10:22:49 -0500
Message-ID: <20261106152259.1360651-5-akrowiak@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=QYDzLcbv c=1 sm=1 tr=0 ts=6aedf0df cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=eQTwN0R4n4tQ0T9Vep8A:9
X-Proofpoint-GUID: 05cWTY-yeJD5WqbiTVXhr7MjY-kcw3JS
X-Proofpoint-ORIG-GUID: 05cWTY-yeJD5WqbiTVXhr7MjY-kcw3JS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2MCBTYWx0ZWRfX7dikAKoD8wF4
 Y037Sj4Jooa2uTr7cg1KsPCm6PKz5ymXaqZhKqUJ1wPZ8umI0ajubDPwmISj5rOFQV4DuzjVaU/
 4IDw+T6Stdl12KwVSXoMLkvf3HKj8Kc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2MCBTYWx0ZWRfX8HMBH0UOuJoq
 klK91f+ATDxVMgWK4d9QN7qw9ojBWg7AI9ZDzRUNTeYVh7YG3V+S1eN87C6yjm5T6bJRpiwO3XK
 rnVfWa1Y3jJL5xaf3X4LLyjUJiwI+OXFOrzNr2A+9WIxl3ics9hXSoRPbhmpKMukTAM4N3UhPzS
 cB5ZR6KGUnBIfJ5/KP3uM+Ts+T5T59V+DAmq4bDZ+oYDGGR27WAoTQORI+o3fiDTKc+LyOkH7Z4
 +wrE+Yu6VPuK3sKHUkv3MxdEu4+i8AmcnmCQ0I1hLtXTBmYH4yn4Fy+RFI49V6+j4WF+M+hla0E
 CWg4HWOMgRTUBx4dVi34YFdIAr+NjZyAlS9aVrTf3CRWpSxvAr9D4P9eVHrfWQgkxlKPbn4z02e
 INT3pSavAP2IEP5tiggmDJSEnpA4F2CNpa+A5gqLjpP398lLX0zpixkvmREC/PCjVLh9+QH9ktQ
 OXZ4hZxv0TIv5X+g4sw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060060

According to the VFIO migration specifications, userspace must issue a
VFIO_DEVICE_RESET ioctl if a vfio device enters an error state or fails a
state transition to recover the device and return its migration state to
RUNNING. This patch adds a function that is called when a VFIO_DEVICE_RESET
is issued that releases any open migration file buffers and resets the
migration state to RUNNING.

The same function is called when the vfio device is closed. The migration
data is not freed on close because a migration file descriptor can outlive
the vfio device file descriptor, so the state left over from one open must
be reset for the next. To do so under the locks required to detach the
guest, vfio_ap_mdev_unset_kvm() no longer takes the locks itself. Instead,
vfio_ap_mdev_close_device() takes them using get_update_locks_for_kvm()
and calls vfio_ap_mdev_unset_kvm() and vfio_ap_reset_migration_state()
with the locks held. vfio_ap_mdev_unset_kvm() asserts that the locks it
requires are held.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_migration.c | 21 +++++++++++++++++
 drivers/s390/crypto/vfio_ap_ops.c       | 30 ++++++++++++++++++++++---
 drivers/s390/crypto/vfio_ap_private.h   |  1 +
 3 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index e2e9a8e7a833..94772cab1e85 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -236,3 +236,24 @@ void vfio_ap_release_migration_data(struct ap_matrix_mdev *matrix_mdev)
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
+ * migration specification. It is also called when the vfio device is closed
+ * so the migration state of one open does not carry over to the next.
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
index 77b9328bdcb1..8d70089eb9c9 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -1899,20 +1899,25 @@ static void vfio_ap_mdev_dma_unmap(struct vfio_device *vdev, u64 iova,
  * by @matrix_mdev.
  *
  * @matrix_mdev: a matrix mediated device
+ *
+ * The locks acquired by get_update_locks_for_kvm() for the KVM guest
+ * @matrix_mdev->kvm must be held by the caller.
  */
 static void vfio_ap_mdev_unset_kvm(struct ap_matrix_mdev *matrix_mdev)
 {
 	struct kvm *kvm = matrix_mdev->kvm;
 
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
+
 	if (kvm && kvm->arch.crypto.crycbd) {
-		get_update_locks_for_kvm(kvm);
+		lockdep_assert_held(&kvm->lock);
+		lockdep_assert_held_write(&kvm->arch.crypto.pqap_hook_rwsem);
+
 		kvm->arch.crypto.pqap_hook = NULL;
 
 		kvm_arch_crypto_clear_masks(kvm);
 		vfio_ap_mdev_reset_queues(matrix_mdev);
 		matrix_mdev->kvm = NULL;
-
-		release_update_locks_for_kvm(kvm);
 	}
 }
 
@@ -2098,8 +2103,16 @@ static void vfio_ap_mdev_close_device(struct vfio_device *vdev)
 {
 	struct ap_matrix_mdev *matrix_mdev =
 		container_of(vdev, struct ap_matrix_mdev, vdev);
+	/*
+	 * Save the KVM pointer because vfio_ap_mdev_unset_kvm() clears it and
+	 * the same pointer is needed to release the locks.
+	 */
+	struct kvm *kvm = matrix_mdev->kvm;
 
+	get_update_locks_for_kvm(kvm);
 	vfio_ap_mdev_unset_kvm(matrix_mdev);
+	vfio_ap_reset_migration_state(matrix_mdev);
+	release_update_locks_for_kvm(kvm);
 }
 
 static void vfio_ap_mdev_request(struct vfio_device *vdev, unsigned int count)
@@ -2316,6 +2329,17 @@ static ssize_t vfio_ap_mdev_ioctl(struct vfio_device *vdev,
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
index aa8a22585204..c6e577064e7e 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -174,5 +174,6 @@ void vfio_ap_on_scan_complete(struct ap_config_info *new_config_info,
 
 int vfio_ap_init_migration_data(struct ap_matrix_mdev *matrix_mdev);
 void vfio_ap_release_migration_data(struct ap_matrix_mdev *matrix_mdev);
+void vfio_ap_reset_migration_state(struct ap_matrix_mdev *matrix_mdev);
 
 #endif /* _VFIO_AP_PRIVATE_H_ */
-- 
2.53.0

