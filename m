Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D826C07E95
	for <linux-s390@archiver.kernel.org>; Wed,  7 Jul 2021 15:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27E2D61A14
	for <linux-s390@archiver.kernel.org>; Wed,  7 Jul 2021 15:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbhGGPon (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 7 Jul 2021 11:44:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8508 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231533AbhGGPon (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 7 Jul 2021 11:44:43 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 167FX8ct049111;
        Wed, 7 Jul 2021 11:42:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=QG23hYG52Yi/ulnmjzIZ05NTkgg0sYve/OlDlJ4xacw=;
 b=lNW+e0C5yT8wqCH/nswPjRqemF7UQwVGDTkGp53NZ2mtQ5Imi/cltJCaSTa3IufxmsvR
 xVl9r7OU6LDyIeXDDkTCTDH8pd4i9PlFArxdmYnZRqcj2gwQWLhi1vjtYx0S62OZE1/a
 mkO8Gva7W9KobtL2IfyPHdPHELNREh19V2puLHPu+0xWULQjpV2nCfwzWdT6vlWle7iZ
 GGfD1OVO2nUG2TuiR1bJ/VmqrJQisdpqCTH7/vBx6Prsr8I4vgmPfmc/bvFL9czVLC3U
 7+ONaelcQOTPvlxlsJKvXkwrDyTp2lWHWORy/3aEtXyAAknD1JWKt/BsqT642405GJHA +g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39mk52n30u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jul 2021 11:42:01 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 167FZ2V4059212;
        Wed, 7 Jul 2021 11:42:01 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39mk52n30d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jul 2021 11:42:01 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 167FYNVS017954;
        Wed, 7 Jul 2021 15:42:00 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma02dal.us.ibm.com with ESMTP id 39jfhcxc8j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jul 2021 15:42:00 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 167FfwHD46203208
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 7 Jul 2021 15:41:58 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C9DF7805F;
        Wed,  7 Jul 2021 15:41:58 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5ACBE7805C;
        Wed,  7 Jul 2021 15:41:57 +0000 (GMT)
Received: from cpe-172-100-179-72.stny.res.rr.com (unknown [9.85.163.230])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  7 Jul 2021 15:41:57 +0000 (GMT)
From:   Tony Krowiak <akrowiak@linux.ibm.com>
To:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     borntraeger@de.ibm.com, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com, jgg@nvidia.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com
Subject: [PATCH] s390/vfio-ap: do not open code locks for VFIO_GROUP_NOTIFY_SET_KVM notification
Date:   Wed,  7 Jul 2021 11:41:56 -0400
Message-Id: <20210707154156.297139-1-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7RlY_vPZBtzL_3Kxa1B7wO8-u-m9DZoH
X-Proofpoint-GUID: 6BGSZkhF438vE3GhhnywFVZwDhShW9b0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-07_08:2021-07-06,2021-07-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 phishscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107070090
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The fix to resolve a lockdep splat while handling the
VFIO_GROUP_NOTIFY_SET_KVM event introduced a kvm_busy flag indicating that
the vfio_ap device driver is busy setting or unsetting the KVM pointer.
A wait queue was employed to allow functions requiring access to the KVM
pointer to wait for the kvm_busy flag to be cleared. For the duration of
the wait period, the mdev lock was unlocked then acquired again after the
kvm_busy flag was cleared.

It was pointed out during an unrelated patch review that locks should not
be open coded - i.e., writing the algorithm of a standard lock in a
function instead of using a lock from the standard library. The setting and
testing of the kvm_busy flag and sleeping on a wait_event is the same thing
a lock does. Whatever potential deadlock was found and reported via the
lockdep splat was not magically removed by going to a wait_queue; it just
removed the lockdep annotations that would identify the issue early.

To remedy the problem introduced with the open coded locks, this patch
introduces the following changes:

1. Removes the the kvm_busy flag and wait queue. These were introduced to
   prevent functions from accessing the KVM pointer while it was being
   set because the matrix_dev->lock mutex had to be given up while
   updating the guest's AP configuration in order to resolve the lockdep
   splat. Since the functions that set the KVM pointer as well as those
   that need access to it do so while holding the matrix_dev->lock mutex,
   it is not necessary to wait for the KVM pointer to be set.

2. Introduces an rwsem to protect the hook (i.e., function pointer) to the
   handler that processes interception of the PQAP instruction. A read
   lock will be taken when the PQAP instruction is intercepted, before
   calling the handler. A write lock will be taken whenever the KVM
   pointer is set since the functions that set the KVM pointer also set
   the hook.

3. Removes the lock of the matrix_dev->lock mutex from the function that
   handles interception of the PQAP instruction. Since the functions that
   set the KVM pointer and the PQAP interception handler hook as well as
   the function that calls the hook lock the rwsem, it is not necessary
   to lock the matrix_dev->lock mutex in the handler.

Fixes: 0cc00c8d4050 ("s390/vfio-ap: fix circular lockdep when setting/clearing crypto masks")
Cc: stable@vger.kernel.org
Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Reported-by: Jason Gunthorpe <jgg@nvidia.com>
---
 arch/s390/include/asm/kvm_host.h      |   8 +-
 arch/s390/kvm/kvm-s390.c              |   1 +
 arch/s390/kvm/priv.c                  |  10 +-
 drivers/s390/crypto/vfio_ap_ops.c     | 129 +++++++++++---------------
 drivers/s390/crypto/vfio_ap_private.h |   4 +-
 5 files changed, 67 insertions(+), 85 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 9b4473f76e56..f18849d259e6 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -798,14 +798,12 @@ struct kvm_s390_cpu_model {
 	unsigned short ibc;
 };
 
-struct kvm_s390_module_hook {
-	int (*hook)(struct kvm_vcpu *vcpu);
-	struct module *owner;
-};
+typedef int (*crypto_hook)(struct kvm_vcpu *vcpu);
 
 struct kvm_s390_crypto {
 	struct kvm_s390_crypto_cb *crycb;
-	struct kvm_s390_module_hook *pqap_hook;
+	struct rw_semaphore pqap_hook_rwsem;
+	crypto_hook *pqap_hook;
 	__u32 crycbd;
 	__u8 aes_kw;
 	__u8 dea_kw;
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index b655a7d82bf0..339534a0c5a5 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2641,6 +2641,7 @@ static void kvm_s390_crypto_init(struct kvm *kvm)
 			 sizeof(kvm->arch.crypto.crycb->aes_wrapping_key_mask));
 	get_random_bytes(kvm->arch.crypto.crycb->dea_wrapping_key_mask,
 			 sizeof(kvm->arch.crypto.crycb->dea_wrapping_key_mask));
+	init_rwsem(&kvm->arch.crypto.pqap_hook_rwsem);
 }
 
 static void sca_dispose(struct kvm *kvm)
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 9928f785c677..ec16c2facf7c 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -610,6 +610,7 @@ static int handle_io_inst(struct kvm_vcpu *vcpu)
 static int handle_pqap(struct kvm_vcpu *vcpu)
 {
 	struct ap_queue_status status = {};
+	crypto_hook handle_pqap;
 	unsigned long reg0;
 	int ret;
 	uint8_t fc;
@@ -657,15 +658,16 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
 	 * Verify that the hook callback is registered, lock the owner
 	 * and call the hook.
 	 */
+	down_read(&vcpu->kvm->arch.crypto.pqap_hook_rwsem);
 	if (vcpu->kvm->arch.crypto.pqap_hook) {
-		if (!try_module_get(vcpu->kvm->arch.crypto.pqap_hook->owner))
-			return -EOPNOTSUPP;
-		ret = vcpu->kvm->arch.crypto.pqap_hook->hook(vcpu);
-		module_put(vcpu->kvm->arch.crypto.pqap_hook->owner);
+		handle_pqap = *vcpu->kvm->arch.crypto.pqap_hook;
+		ret = handle_pqap(vcpu);
 		if (!ret && vcpu->run->s.regs.gprs[1] & 0x00ff0000)
 			kvm_s390_set_psw_cc(vcpu, 3);
+		up_read(&vcpu->kvm->arch.crypto.pqap_hook_rwsem);
 		return ret;
 	}
+	up_read(&vcpu->kvm->arch.crypto.pqap_hook_rwsem);
 	/*
 	 * A vfio_driver must register a hook.
 	 * No hook means no driver to enable the SIE CRYCB and no queues.
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 122c85c22469..d3447f6d83f1 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -270,6 +270,9 @@ static struct ap_queue_status vfio_ap_irq_enable(struct vfio_ap_queue *q,
  * We take the matrix_dev lock to ensure serialization on queues and
  * mediated device access.
  *
+ * Note: This function must be called with a read lock held on
+ *	 vcpu->kvm->arch.crypto.pqap_hook_rwsem.
+ *
  * Return 0 if we could handle the request inside KVM.
  * otherwise, returns -EOPNOTSUPP to let QEMU handle the fault.
  */
@@ -287,22 +290,12 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
 		return -EOPNOTSUPP;
 
 	apqn = vcpu->run->s.regs.gprs[0] & 0xffff;
-	mutex_lock(&matrix_dev->lock);
 
 	if (!vcpu->kvm->arch.crypto.pqap_hook)
 		goto out_unlock;
 	matrix_mdev = container_of(vcpu->kvm->arch.crypto.pqap_hook,
 				   struct ap_matrix_mdev, pqap_hook);
 
-	/*
-	 * If the KVM pointer is in the process of being set, wait until the
-	 * process has completed.
-	 */
-	wait_event_cmd(matrix_mdev->wait_for_kvm,
-		       !matrix_mdev->kvm_busy,
-		       mutex_unlock(&matrix_dev->lock),
-		       mutex_lock(&matrix_dev->lock));
-
 	/* If the there is no guest using the mdev, there is nothing to do */
 	if (!matrix_mdev->kvm)
 		goto out_unlock;
@@ -323,7 +316,6 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
 out_unlock:
 	memcpy(&vcpu->run->s.regs.gprs[1], &qstatus, sizeof(qstatus));
 	vcpu->run->s.regs.gprs[1] >>= 32;
-	mutex_unlock(&matrix_dev->lock);
 	return 0;
 }
 
@@ -350,10 +342,8 @@ static int vfio_ap_mdev_create(struct mdev_device *mdev)
 
 	matrix_mdev->mdev = mdev;
 	vfio_ap_matrix_init(&matrix_dev->info, &matrix_mdev->matrix);
-	init_waitqueue_head(&matrix_mdev->wait_for_kvm);
 	mdev_set_drvdata(mdev, matrix_mdev);
-	matrix_mdev->pqap_hook.hook = handle_pqap;
-	matrix_mdev->pqap_hook.owner = THIS_MODULE;
+	matrix_mdev->pqap_hook = handle_pqap;
 	mutex_lock(&matrix_dev->lock);
 	list_add(&matrix_mdev->node, &matrix_dev->mdev_list);
 	mutex_unlock(&matrix_dev->lock);
@@ -624,7 +614,7 @@ static ssize_t assign_adapter_store(struct device *dev,
 	 * If the KVM pointer is in flux or the guest is running, disallow
 	 * un-assignment of adapter
 	 */
-	if (matrix_mdev->kvm_busy || matrix_mdev->kvm) {
+	if (matrix_mdev->kvm) {
 		ret = -EBUSY;
 		goto done;
 	}
@@ -697,7 +687,7 @@ static ssize_t unassign_adapter_store(struct device *dev,
 	 * If the KVM pointer is in flux or the guest is running, disallow
 	 * un-assignment of adapter
 	 */
-	if (matrix_mdev->kvm_busy || matrix_mdev->kvm) {
+	if (matrix_mdev->kvm) {
 		ret = -EBUSY;
 		goto done;
 	}
@@ -787,7 +777,7 @@ static ssize_t assign_domain_store(struct device *dev,
 	 * If the KVM pointer is in flux or the guest is running, disallow
 	 * assignment of domain
 	 */
-	if (matrix_mdev->kvm_busy || matrix_mdev->kvm) {
+	if (matrix_mdev->kvm) {
 		ret = -EBUSY;
 		goto done;
 	}
@@ -855,7 +845,7 @@ static ssize_t unassign_domain_store(struct device *dev,
 	 * If the KVM pointer is in flux or the guest is running, disallow
 	 * un-assignment of domain
 	 */
-	if (matrix_mdev->kvm_busy || matrix_mdev->kvm) {
+	if (matrix_mdev->kvm) {
 		ret = -EBUSY;
 		goto done;
 	}
@@ -909,7 +899,7 @@ static ssize_t assign_control_domain_store(struct device *dev,
 	 * If the KVM pointer is in flux or the guest is running, disallow
 	 * assignment of control domain.
 	 */
-	if (matrix_mdev->kvm_busy || matrix_mdev->kvm) {
+	if (matrix_mdev->kvm) {
 		ret = -EBUSY;
 		goto done;
 	}
@@ -968,7 +958,7 @@ static ssize_t unassign_control_domain_store(struct device *dev,
 	 * If the KVM pointer is in flux or the guest is running, disallow
 	 * un-assignment of control domain.
 	 */
-	if (matrix_mdev->kvm_busy || matrix_mdev->kvm) {
+	if (matrix_mdev->kvm) {
 		ret = -EBUSY;
 		goto done;
 	}
@@ -1108,26 +1098,31 @@ static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev,
 {
 	struct ap_matrix_mdev *m;
 
-	if (kvm->arch.crypto.crycbd) {
-		list_for_each_entry(m, &matrix_dev->mdev_list, node) {
-			if (m != matrix_mdev && m->kvm == kvm)
-				return -EPERM;
-		}
+	if (!kvm->arch.crypto.crycbd)
+		return 0;
 
-		kvm_get_kvm(kvm);
-		matrix_mdev->kvm_busy = true;
-		mutex_unlock(&matrix_dev->lock);
-		kvm_arch_crypto_set_masks(kvm,
-					  matrix_mdev->matrix.apm,
-					  matrix_mdev->matrix.aqm,
-					  matrix_mdev->matrix.adm);
-		mutex_lock(&matrix_dev->lock);
-		kvm->arch.crypto.pqap_hook = &matrix_mdev->pqap_hook;
-		matrix_mdev->kvm = kvm;
-		matrix_mdev->kvm_busy = false;
-		wake_up_all(&matrix_mdev->wait_for_kvm);
+	down_write(&kvm->arch.crypto.pqap_hook_rwsem);
+	mutex_lock(&matrix_dev->lock);
+
+	list_for_each_entry(m, &matrix_dev->mdev_list, node) {
+		if (m != matrix_mdev && m->kvm == kvm) {
+			up_read(&kvm->arch.crypto.pqap_hook_rwsem);
+			mutex_unlock(&matrix_dev->lock);
+			return -EPERM;
+		}
 	}
 
+	kvm_get_kvm(kvm);
+	matrix_mdev->kvm = kvm;
+	kvm->arch.crypto.pqap_hook = &matrix_mdev->pqap_hook;
+	mutex_unlock(&matrix_dev->lock);
+
+	kvm_arch_crypto_set_masks(kvm,
+				  matrix_mdev->matrix.apm,
+				  matrix_mdev->matrix.aqm,
+				  matrix_mdev->matrix.adm);
+	up_write(&kvm->arch.crypto.pqap_hook_rwsem);
+
 	return 0;
 }
 
@@ -1164,6 +1159,7 @@ static int vfio_ap_mdev_iommu_notifier(struct notifier_block *nb,
  * vfio_ap_mdev_unset_kvm
  *
  * @matrix_mdev: a matrix mediated device
+ * @kvm: the KVM guest state object
  *
  * Performs clean-up of resources no longer needed by @matrix_mdev.
  *
@@ -1175,29 +1171,30 @@ static int vfio_ap_mdev_iommu_notifier(struct notifier_block *nb,
  * done under the @matrix_mdev->lock.
  *
  */
-static void vfio_ap_mdev_unset_kvm(struct ap_matrix_mdev *matrix_mdev)
+static void vfio_ap_mdev_unset_kvm(struct ap_matrix_mdev *matrix_mdev,
+				   struct kvm *kvm)
 {
-	/*
-	 * If the KVM pointer is in the process of being set, wait until the
-	 * process has completed.
-	 */
-	wait_event_cmd(matrix_mdev->wait_for_kvm,
-		       !matrix_mdev->kvm_busy,
-		       mutex_unlock(&matrix_dev->lock),
-		       mutex_lock(&matrix_dev->lock));
+	if (!kvm)
+		return;
 
-	if (matrix_mdev->kvm) {
-		matrix_mdev->kvm_busy = true;
+	down_write(&kvm->arch.crypto.pqap_hook_rwsem);
+	mutex_lock(&matrix_dev->lock);
+	if ((!matrix_mdev->kvm) || (!matrix_mdev->kvm->arch.crypto.crycbd)) {
+		up_write(&kvm->arch.crypto.pqap_hook_rwsem);
 		mutex_unlock(&matrix_dev->lock);
-		kvm_arch_crypto_clear_masks(matrix_mdev->kvm);
-		mutex_lock(&matrix_dev->lock);
-		vfio_ap_mdev_reset_queues(matrix_mdev->mdev);
-		matrix_mdev->kvm->arch.crypto.pqap_hook = NULL;
-		kvm_put_kvm(matrix_mdev->kvm);
-		matrix_mdev->kvm = NULL;
-		matrix_mdev->kvm_busy = false;
-		wake_up_all(&matrix_mdev->wait_for_kvm);
+		return;
 	}
+	mutex_unlock(&matrix_dev->lock);
+
+	kvm_arch_crypto_clear_masks(kvm);
+
+	mutex_lock(&matrix_dev->lock);
+	vfio_ap_mdev_reset_queues(matrix_mdev->mdev);
+	kvm_put_kvm(kvm);
+	kvm->arch.crypto.pqap_hook = NULL;
+	matrix_mdev->kvm = NULL;
+	mutex_unlock(&matrix_dev->lock);
+	up_write(&kvm->arch.crypto.pqap_hook_rwsem);
 }
 
 static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
@@ -1209,16 +1206,13 @@ static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
 	if (action != VFIO_GROUP_NOTIFY_SET_KVM)
 		return NOTIFY_OK;
 
-	mutex_lock(&matrix_dev->lock);
 	matrix_mdev = container_of(nb, struct ap_matrix_mdev, group_notifier);
 
 	if (!data)
-		vfio_ap_mdev_unset_kvm(matrix_mdev);
+		vfio_ap_mdev_unset_kvm(matrix_mdev, matrix_mdev->kvm);
 	else if (vfio_ap_mdev_set_kvm(matrix_mdev, data))
 		notify_rc = NOTIFY_DONE;
 
-	mutex_unlock(&matrix_dev->lock);
-
 	return notify_rc;
 }
 
@@ -1352,14 +1346,12 @@ static void vfio_ap_mdev_release(struct mdev_device *mdev)
 {
 	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
 
-	mutex_lock(&matrix_dev->lock);
-	vfio_ap_mdev_unset_kvm(matrix_mdev);
-	mutex_unlock(&matrix_dev->lock);
-
 	vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
 				 &matrix_mdev->iommu_notifier);
 	vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
 				 &matrix_mdev->group_notifier);
+
+	vfio_ap_mdev_unset_kvm(matrix_mdev, matrix_mdev->kvm);
 	module_put(THIS_MODULE);
 }
 
@@ -1401,15 +1393,6 @@ static ssize_t vfio_ap_mdev_ioctl(struct mdev_device *mdev,
 			break;
 		}
 
-		/*
-		 * If the KVM pointer is in the process of being set, wait until
-		 * the process has completed.
-		 */
-		wait_event_cmd(matrix_mdev->wait_for_kvm,
-			       !matrix_mdev->kvm_busy,
-			       mutex_unlock(&matrix_dev->lock),
-			       mutex_lock(&matrix_dev->lock));
-
 		ret = vfio_ap_mdev_reset_queues(mdev);
 		break;
 	default:
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index f82a6396acae..22d2e0ca3ae5 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -83,10 +83,8 @@ struct ap_matrix_mdev {
 	struct ap_matrix matrix;
 	struct notifier_block group_notifier;
 	struct notifier_block iommu_notifier;
-	bool kvm_busy;
-	wait_queue_head_t wait_for_kvm;
 	struct kvm *kvm;
-	struct kvm_s390_module_hook pqap_hook;
+	crypto_hook pqap_hook;
 	struct mdev_device *mdev;
 };
 
-- 
2.30.2

