Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794425001;
	b=rnoL0a+YW53tz7USTNFKiR5tcKXkVRB4i9ktf+55vH9q/IIMnQU0wFSYoT0nhn9MiVXk
	 jUbL7LRFchlTpfJ65IyyvfrqmEYxC8avs8IGRRbm56/LxLzrMyyeon9SRMnvciUiudMVA
	 O0ysd+eZXluaxdj/WIZJrykg3ZtKDigzZaGhQ08GJ3NKNwv/14ZikslIos3J4FV8PXc4P
	 yE5jhIghvD4VIlTIq1BF7+GmRYUn8niA2dJcR2quwTjPZPLFma2JeHP0EUN6QWejVXAmQ
	 CU/+9X1Q8Aq3uNFY+p2caEe0gQVbDUPgw6F2EwZ01Lxe59m2g41oTR2kmgtumAtIdig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794425001;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=lx1JsB409NqjqtzLBv0T3JHbf2Pq6fO8sQ4yuYUWMbM=;
	b=q4l702n+ZoUdwDBQxQu+JPDMtBKeyJJGPJnTCphnt5dZuMm2zJxDz7Jn7CAymDz/rEG3
	 Ia2RQDl1Ti1rdin1eCCigITn/i5kW7S06UksV6GBa6RZbnwXI/iLNU5x8ybEAfBOe5uN3
	 JPSsE/q2j2/xcc5ylErrmNnVZOf8PTjJHjnmJ2d2xxmhn8JIJdg06Oqux8iJQvt0pHnr8
	 8Wf8a0msI27lZC1q/42QUJc7wyRibO+MaYXtsUultiMMCLyuHfY5ss72NvnjMjiXXW1vc
	 J/x/MS7Uzpk2pw+n7z3C5RYjBEzWSV/vXntTrH/SDMYJiB/1Ut4T7P3vxkijAQ8hyNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kBjnOjZ1;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9C5606A88D;
	Wed, 11 Nov 2026 19:23:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E9C5606A88D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kBjnOjZ1
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABIiRLl1892547;
	Wed, 11 Nov 2026 19:23:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=lx1JsB409NqjqtzLB
	v0T3JHbf2Pq6fO8sQ4yuYUWMbM=; b=kBjnOjZ1cEiaeBHtYR6LMOuDD4zX5iy7k
	zZd82Df79Y3jRQ970tzPu8x0/jh0SkfpZBpB0IMoVKs2FyFb+Pe7/cG67nMvBhjj
	uqHWERSCDqCDA5HQxHh1xbhWSx6pdtoeWCIA1FeXYtcFSPtjcY2qJTSfJgDL8YGo
	pgXXXuLtfmvWkhcgKmYxogrbHBFwIGXdh6cXGNfhnGscQBay9RpYKi+ZgF1VUrGa
	IRZn0PKv0ENQdwzYbGQstc2ptjbsWKcKyYP1Qxsc69JLk1TZ0+O1q2D9Cww2UH+m
	+fHMD4AsIXCbDIO4+FDTlOysfvBcR+OLJqcWifh7NdfCRjRYvohLA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsumv32s8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 19:23:16 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABInwxS3774289;
	Wed, 11 Nov 2026 19:23:16 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hvkq0tbqr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 19:23:16 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ABJNFo727198158
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Nov 2026 19:23:15 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E8DD258052;
	Wed, 11 Nov 2026 19:23:14 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB3A758067;
	Wed, 11 Nov 2026 19:23:13 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.182.62])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Nov 2026 19:23:13 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v13 04/14] s390/vfio-ap: Reset migration state on VFIO_DEVICE_RESET and device close
Date: Wed, 11 Nov 2026 14:22:58 -0500
Message-ID: <20261111192308.2585984-5-akrowiak@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA3NiBTYWx0ZWRfX38Ada06vvpOV
 hLfjDrqt760WYVkh9Uwa1FySwOwMui9AbJmcL/v70kqorInm2plYwtlNT/Rv2y+ramPpDvMnbSP
 mGiM5T0lB149kmDR5dEe/JaAZ2K9Zso=
X-Authority-Analysis: v=2.4 cv=GISdgeNK c=1 sm=1 tr=0 ts=6af4c0a4 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=eQTwN0R4n4tQ0T9Vep8A:9
X-Proofpoint-GUID: xuyYMupu9GVA2a87OlWtWbvWRO-Ra4JJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA3NiBTYWx0ZWRfXzhygoxgxiDGZ
 eQmu8ugszx85AuZ0xNAVIIie56VgQqR/Byljmuy5wnhIO3HoqDF8xxVOWoEoyqFhUr5/JOdTY3E
 t4UxgiM13B6ZmwqVeR1ilBbaZmZ4MaYAEP8HmCeM8iRXkZPw+NetN86KSgpsSe7s10S6K4s0CK4
 gXyrw78/8tp6GB/13GE2AKqnH45LAg69VJciYXAp2DV9cv+Vfz0Hp8HBho96O1N10tjIS7gJT7r
 SzWrW49agNXNrDa/4pqVZa5FN+PTrC9fugQoZH5bhHyN9orVRPe4Zuse0a/R/uMGwkFH2TaqjCe
 fl9ek+28FuyCING3UlQl5bqeIZqkaWjMgtCjk/s0zI4nABCOPwIywvp1OJIAzzkrG+SPr7WTF9x
 wFdv2KnUPVgyzJcF92fGKHgQyjjV920Qc39MkC2kipDJ9TmwBqI0FARYTTY/u+fAu+Co4tia+aV
 nR6GaygAowACybEOdJQ==
X-Proofpoint-ORIG-GUID: xuyYMupu9GVA2a87OlWtWbvWRO-Ra4JJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110076

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

