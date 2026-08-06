Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE61437AA78;
	Thu,  6 Aug 2026 17:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786037685; cv=none; b=KycIKJkMEfK+h7KnEYOPsH+Wmtel9u7kPOxizL+HFTpXeMDWgz3g7NMEfvHFBCakPkG+BnhbZUHWJ3VNXNIk+u9kx350YsxaeJR3CBf9DmHh5B+B+oVT4xpFld6pF5okoklkY9uKJqX8cFb027SxU81fJTt86zjr5N8QGOrH3uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786037685; c=relaxed/simple;
	bh=7GorEvF/jVOLDZIzs1L7CU4lZAyoLfkklW8N2M3cMcc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pylvtFyomps7/dOTu0HIrIj/WkSAH1HM6A1m48HRF88A+bvUlQTpKAHqPaOX8fH8pR0nQ410TwYxDDRBw4id2oYIDytrxGi0aZZrebtOs8IW8JNV8rJognB6NXwaEBvEegLZUvM6I464uJehIosPYjbobaI+9GkcwfJjZbWlY1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LPyRZCUe; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LPyRZCUe"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676HIBQ13199575;
	Thu, 6 Aug 2026 17:34:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=MmZEs0KHbXR7hApoZg4ASB60bne8zhEhk5RCSoNhD
	Dw=; b=LPyRZCUeUg/t/OCh2+K9jeyh9fyp4VJDkdmJGnb7yXMVVz59cejKHWlO3
	DvqaTnBA5zo4EnRuxLX25/CibbTNeeBgZzZl97chu5O8uLGbad2rD9lTNGLM5eYZ
	kL6BxTvWSNX9cJvUfJqShpPD0dpP0n/G4kcwwZKJwqRQ4NZjwaRdCy33CaBprott
	8DYoZkbcE6Q0AsYHWZI1zAnwYAun5KPebc5UxbukkYenyHrQp+Wq1dtBxwrDYv3z
	sYiJUKVE3mdYyVXYJIIOATVdswlzMVkkApwmNgMXFw0LzixR0l/aNlmQqQlFly9F
	PaOsU7D0T7x9NdsLjolQ9chs6rrRA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67j17y5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 17:34:39 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 676HQcbD013762;
	Thu, 6 Aug 2026 17:34:39 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugwcatv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 17:34:39 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 676HYbKa13173494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 17:34:37 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A13658054;
	Thu,  6 Aug 2026 17:34:37 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E1C158050;
	Thu,  6 Aug 2026 17:34:36 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.80.66])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 17:34:35 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        stable@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH v5] s390/vfio-ap: fix stale pqap_hook pointer on error in vfio_ap_mdev_set_kvm()
Date: Thu,  6 Aug 2026 13:34:35 -0400
Message-ID: <20260806173435.105044-1-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEzNSBTYWx0ZWRfX6Zben0ZGlMpc
 GtAylaAmcmEvIyNjUjv0mHrLjEuhz/OpZC2bb/IQn2fnnWC8f8uk+SYwjtFRHF3WKF756G8CF+c
 jCwdKKBi8b8W9Lx4zpzyZFLUfs/SAa8=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a74c5af cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=RxNNRKBWKq487C2d6-kA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEzNSBTYWx0ZWRfX0fEIr9NWwrgh
 /dneuq1MoVg57M72AvIxHA7ie7dtGudgOgbDtVn5rZeriFjmUnJAZa467fKJJejVQcvuon78dlH
 NykapbfKrCz7C8kZf84LbpXkrgVXpnbWnR38Tof/Cu8prH2FfSDuMy/z3qhiVmrdcM0eBHoXsaB
 6rutp0eSCPSZg8+3zUgjdcUA0kpQzPpTuWeTwGzSP58L7YZBdtuVleVYcsxiXkNPe0l3anvDkPL
 pmWOvbrU1CJsdn7+1QA/9NQWeeg1WTN3XJDO/5QzIQeohnB+GkK89Jqmd7iMoEsDrb43q02sEO/
 MfErmCIW8qxjs1NIXGqzqofV+dbC9WvoE6A4iOI5EgxQkA0zK3R+3Ba1oacagtaFfAtryobe2/K
 XzNx9/Gi+HnmPj+EMn77en+yMMg6P0MspCzGmqVRdZFw3FOFePT6YmgfdQZaO7zAzYKuKyFCJ04
 VStDu+D/cfhk2ikqWjA==
X-Proofpoint-ORIG-GUID: mdBoVvT0mfTv-m9EF0_2FKKRv7fTrDaM
X-Proofpoint-GUID: mdBoVvT0mfTv-m9EF0_2FKKRv7fTrDaM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060135

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
Co-developed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
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

