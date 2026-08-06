Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC313A1681;
	Thu,  6 Aug 2026 14:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786025033; cv=none; b=DyTiCQ3MO/BN22RRvBOuR9MlrOJ3Kz9Hc4H30nC0ZYFPcAoifnm2ixkjINQYujJSUiTqTaqvGQLC2WGY0VaHnng78nIMLhNpA5/LJxSVUE6r3+vfwc3gUJr4Hl/VDvRoWnLCDGfCzlwpwSPnpqc8UAyM9vJlsD7a/RSzWUa6XG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786025033; c=relaxed/simple;
	bh=AEsNW+NBYPMBEfy8fUmKwiFCnf52pOVGTH7UhHvKcK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fDuQwZaP7YfwVmg/HbnkdszlaP0ssA8Tu2PABbRY6tXRTS/lnXrty/kDHZbeigiS1BQIl2pY8ctdVjo+qG8xn35eyVvJTiMT+ebDZ7w1FaIgwnKhTrfB+EwHzqXyv08bN+ubyUNZUVeSNqU0F6gczgvFf+/RITTWSs6yQf9L2Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VxpbSYIf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VxpbSYIf"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675NmB5E3404367;
	Thu, 6 Aug 2026 14:03:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=a5unDbdIng8tDwr7ncJJHzm+/8KeIBDABaZxAuNRN
	XI=; b=VxpbSYIfvYjurJexHioYyGRywxp6rC8POmNxkMETwbWFnMbbnEaJFRYfG
	fQcvB1bvcHk6YLpN4YTQGgnf1b+VxtAOqsJdTAVvBDcytvyrXfD+OwtHW+gK2ak6
	nrg3p4OblKb5tyzsLmYErKbXGH8WErhUjmdTUpdl/vkk68pdMSh4vDDMGSwx3b4/
	ABu9X6c7DzmXUnRFDW+haZI2Uvs5kHxCEJP/WawuoD9wghOcear4iaAbTTfKCH60
	qJH+L42UqRljI7zNDkMj3vE8vNDi5Q7hBUROJlP0F7IAMmd22q/jvW8CaABMMSa9
	qntC8hTIwlAietz9dG16TytLG6e2Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fr0gc8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 14:03:47 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 676DuG8G028447;
	Thu, 6 Aug 2026 14:03:46 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmhkc25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 14:03:46 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 676E3ifg28574286
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 14:03:44 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 56EB058064;
	Thu,  6 Aug 2026 14:03:44 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EF0315805F;
	Thu,  6 Aug 2026 14:03:42 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.92.156])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 14:03:42 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        stable@vger.kernel.org
Subject: [PATCH v4] s390/vfio-ap: fix stale pqap_hook pointer on error in vfio_ap_mdev_set_kvm()
Date: Thu,  6 Aug 2026 10:03:42 -0400
Message-ID: <20260806140342.611294-1-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IH0OnD3wdfP14lTx9xKdrG0e-WYs8uVK
X-Proofpoint-ORIG-GUID: IH0OnD3wdfP14lTx9xKdrG0e-WYs8uVK
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEwOCBTYWx0ZWRfXx/bordy/sASm
 uQuKOTIa+oCdivOpnquKCvBmrH+v7ry5gKIexk+L1QShesv45QUtz87BjT2BTKDbogY3jFGAv3g
 EFP3XL7xWDTYRbJjkev2ZVG4KS+pIo8=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a749443 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=fnNIMH4mEDlqOEiJ55YA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEwOCBTYWx0ZWRfXzTXiYUkLhxCo
 A/+R3w7E0li4fututo8wE4CMyZJzq7mn/XQMeP9Ox5+zjohlWVaOr9TUUSj+3Qm38YuPcPM+hMp
 6ex9IHVfvBeTtOIw7WDgg6EMeX/ARwRpA72bY9zT23gYb2lhmxxv42pN8Wgff+/xn2106qTk7P4
 z6BYypkDq81Z3EFzpS9ukvCvtkmY15fPCyQwJqL7xN7eeVPt1+/b0w1qEqAeH7UhXZXGvU17Rn2
 fr0bQxYp9eXKEaQWucAQSuXG2iR9SVIGULhHw1pKT3pU2W9NffvhXF6B9ZBSpuoVvEgeeAuKmLb
 Hh0DYXHq4QAAzatKNcq4mlJW0Lmd5VKDsvYk0Wf7LpZMVY1q54rahevS/7RsehsvZSeyuz5UiKD
 JhO5SqoI8blZY8c99p2j+GVNc8ktz3QDK3GLNU8okblUnd0wudWMJGyDNHtjFiav5odBXNNdcoe
 jgLILwOi4xus1i7H8gw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060108

In vfio_ap_mdev_set_kvm(), kvm->arch.crypto.pqap_hook is set to
&matrix_mdev->pqap_hook before the update locks are acquired and the
mdev list is checked for a conflicting assignment. If another mdev is
already attached to the same KVM instance, the function returns -EPERM
without restoring the hook pointer, leaving kvm->arch.crypto.pqap_hook
pointing at the failing matrix_mdev instead of the mdev that legitimately
owns the KVM.

Since matrix_mdev->kvm is never set on this error path,
vfio_ap_mdev_unset_kvm() will not clean up the hook when matrix_mdev
is later closed. If matrix_mdev is subsequently freed, any PQAP
instruction executed by the guest will dereference the stale pointer
through pqap_hook_rwsem, resulting in a use-after-free.

Since kvm->arch.crypto.pqap_hook is only set in the vfio_ap_mdev_set_kvm()
function and is cleared in the vfio_ap_mdev_unset_kvm() function, a check
for 'kvm->arch.crypto.pqap_hook != NULL' is all that is needed to determine
whether it belongs to another mdev. This will alleviate the need to iterate
the matrix_dev->mdev_list list to see if the kvm object is assigned to
another mdev.This was introduced in v3 to alleviate the need to take the
mdevs_lock while iterating the list; however, this did not prevent a
potential race condition.

The pqap_hook_rwsem(write) is now performed inside
get_update_locks_for_kvm(), which is updated to acquire
pqap_hook_rwsem(write) between kvm->lock and mdevs_lock. This ordering
is consistent with the PQAP intercept path, which acquires pqap_hook_rwsem
in read mode while srcu is held under vcpu->mutex, establishing the
dependency: kvm->lock -> vcpu->mutex -> srcu -> pqap_hook_rwsem(read).

The pqap_hook_rwsem is now released inside the
release_update_locks_for_kvm(), which is updated to release
pqap_hook_rwsem(write) between mdevs_lock and kvm->lock.

Additionally, kvm_put_kvm() in vfio_ap_mdev_unset_kvm() is moved
after release_update_locks_for_kvm(). Previously it was called while
kvm->lock was held; if it were ever the last reference, kvm_destroy_vm()
would run under kvm->lock, which would deadlock.

Fixes: 86956e70761b3 ("s390/vfio-ap: replace open coded locks for VFIO_GROUP_NOTIFY_SET_KVM notification")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 45 ++++++++++++++-----------------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 44b3a1dcc1b3..99a0efd999ef 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -48,15 +48,19 @@ static void vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q);
  * 1. matrix_dev->guests_lock: required to use the KVM pointer to update a KVM
  *			       guest's APCB.
  * 2. kvm->lock:	       required to update a guest's APCB
- * 3. matrix_dev->mdevs_lock:  required to access data stored in a matrix_mdev
+ * 3. kvm->arch.crypto.pqap_hook_rwsem: required to update pqap_hook and
+ *					serialize against PQAP intercepts
+ * 4. matrix_dev->mdevs_lock:  required to access data stored in a matrix_mdev
  *
- * Note: If @kvm is NULL, the KVM lock will not be taken.
+ * Note: If @kvm is NULL, the KVM lock and pqap_hook_rwsem will not be taken.
  */
 static inline void get_update_locks_for_kvm(struct kvm *kvm)
 {
 	mutex_lock(&matrix_dev->guests_lock);
-	if (kvm)
+	if (kvm) {
 		mutex_lock(&kvm->lock);
+		down_write(&kvm->arch.crypto.pqap_hook_rwsem);
+	}
 	mutex_lock(&matrix_dev->mdevs_lock);
 }
 
@@ -68,16 +72,19 @@ static inline void get_update_locks_for_kvm(struct kvm *kvm)
  *
  * The proper unlocking order is:
  * 1. matrix_dev->mdevs_lock
- * 2. kvm->lock
- * 3. matrix_dev->guests_lock
+ * 2. kvm->arch.crypto.pqap_hook_rwsem
+ * 3. kvm->lock
+ * 4. matrix_dev->guests_lock
  *
- * Note: If @kvm is NULL, the KVM lock will not be released.
+ * Note: If @kvm is NULL, the KVM lock and pqap_hook_rwsem will not be released.
  */
 static inline void release_update_locks_for_kvm(struct kvm *kvm)
 {
 	mutex_unlock(&matrix_dev->mdevs_lock);
-	if (kvm)
+	if (kvm) {
+		up_write(&kvm->arch.crypto.pqap_hook_rwsem);
 		mutex_unlock(&kvm->lock);
+	}
 	mutex_unlock(&matrix_dev->guests_lock);
 }
 
@@ -1821,26 +1828,17 @@ static const struct attribute_group *vfio_ap_mdev_attr_groups[] = {
 static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev,
 				struct kvm *kvm)
 {
-	struct ap_matrix_mdev *m;
-
 	if (kvm->arch.crypto.crycbd) {
-		down_write(&kvm->arch.crypto.pqap_hook_rwsem);
-		kvm->arch.crypto.pqap_hook = &matrix_mdev->pqap_hook;
-		up_write(&kvm->arch.crypto.pqap_hook_rwsem);
-
 		get_update_locks_for_kvm(kvm);
-
-		list_for_each_entry(m, &matrix_dev->mdev_list, node) {
-			if (m != matrix_mdev && m->kvm == kvm) {
-				release_update_locks_for_kvm(kvm);
-				return -EPERM;
-			}
+		if (kvm->arch.crypto.pqap_hook) {
+			release_update_locks_for_kvm(kvm);
+			return -EPERM;
 		}
+		kvm->arch.crypto.pqap_hook = &matrix_mdev->pqap_hook;
 
 		kvm_get_kvm(kvm);
 		matrix_mdev->kvm = kvm;
 		vfio_ap_mdev_update_guest_apcb(matrix_mdev);
-
 		release_update_locks_for_kvm(kvm);
 	}
 
@@ -1883,18 +1881,15 @@ static void vfio_ap_mdev_unset_kvm(struct ap_matrix_mdev *matrix_mdev)
 	struct kvm *kvm = matrix_mdev->kvm;
 
 	if (kvm && kvm->arch.crypto.crycbd) {
-		down_write(&kvm->arch.crypto.pqap_hook_rwsem);
-		kvm->arch.crypto.pqap_hook = NULL;
-		up_write(&kvm->arch.crypto.pqap_hook_rwsem);
-
 		get_update_locks_for_kvm(kvm);
+		kvm->arch.crypto.pqap_hook = NULL;
 
 		kvm_arch_crypto_clear_masks(kvm);
 		vfio_ap_mdev_reset_queues(matrix_mdev);
-		kvm_put_kvm(kvm);
 		matrix_mdev->kvm = NULL;
 
 		release_update_locks_for_kvm(kvm);
+		kvm_put_kvm(kvm);
 	}
 }
 
-- 
2.53.0

