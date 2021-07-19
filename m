Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31796C07E95
	for <linux-s390@archiver.kernel.org>; Mon, 19 Jul 2021 23:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D11D6113A
	for <linux-s390@archiver.kernel.org>; Mon, 19 Jul 2021 23:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345530AbhGSWgD (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 19 Jul 2021 18:36:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28084 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1357659AbhGSSyx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 19 Jul 2021 14:54:53 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16JJYOAD143360;
        Mon, 19 Jul 2021 15:35:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=pqXKtbghbMmf3w30LRhE86ngmSMhfRpwYwu99K3exj8=;
 b=JqoAHktx0TUG9A8Zpq5oFl9QwnqbYSddDws+LQS5QIIsXsAIPSBM+0GHjTZnKb3J8Bz5
 8po6EX+4tMXjjYDTXM5qqwUpOYtrnhyCAE+l3H+OlTVohFIDXOCt2x85AvzdsQYptiEe
 9sze+TyqWza2aS2JI2cqOnM95E8Jd5NtpG59UDhrwUHLehBQz4dMQvpdbydNqCrdaNIs
 5yXkaLPWBakOcKWxLkPSOpdF70JZjvLbdsC5CfjckU4btfWvyaYojWU3iaGby8zyMwvT
 sc9P8CDa1Rmc7f7SUtolhOjAl0bhumwvLweZEHhwhIKNVN5APpQ5dYVxP8KvGxDixexj Iw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39wegna56u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jul 2021 15:35:09 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16JJZ9hp147260;
        Mon, 19 Jul 2021 15:35:09 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39wegna565-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jul 2021 15:35:09 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16JJRZdS016043;
        Mon, 19 Jul 2021 19:35:08 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma05wdc.us.ibm.com with ESMTP id 39upuajb8m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jul 2021 19:35:08 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16JJZ7G031719716
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Jul 2021 19:35:07 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B301B112065;
        Mon, 19 Jul 2021 19:35:07 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 93F3D112061;
        Mon, 19 Jul 2021 19:35:06 +0000 (GMT)
Received: from fedora.ibmuc.com (unknown [9.85.184.30])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 19 Jul 2021 19:35:06 +0000 (GMT)
From:   Tony Krowiak <akrowiak@linux.ibm.com>
To:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     borntraeger@de.ibm.com, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com, jgg@nvidia.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com, david@redhat.com
Subject: [PATCH 2/2] s390/vfio-ap: replace open coded locks for VFIO_GROUP_NOTIFY_SET_KVM notification
Date:   Mon, 19 Jul 2021 15:35:03 -0400
Message-Id: <20210719193503.793910-3-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210719193503.793910-1-akrowiak@linux.ibm.com>
References: <20210719193503.793910-1-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OXFR4Jagve8VTtBtzgo7NJYaWmVdMQa4
X-Proofpoint-ORIG-GUID: Ov19bRVWx8f9IhY9ON2iESbe4ZlWVSEV
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-19_09:2021-07-19,2021-07-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107190111
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

It was pointed out during an unrelated patch review that locks should not
be open coded - i.e., writing the algorithm of a standard lock in a
function instead of using a lock from the standard library. The setting and
testing of a busy flag and sleeping on a wait_event is the same thing
a lock does. The open coded locks are invisible to lockdep, so potential
locking problems are not detected.

This patch removes the open coded locks used during
VFIO_GROUP_NOTIFY_SET_KVM notification. The busy flag
and wait queue were introduced to resolve a possible circular locking
dependency reported by lockdep when starting a secure execution guest
configured with AP adapters and domains. Reversing the order in which
the kvm->lock mutex and matrix_dev->lock mutex are locked resolves the
issue reported by lockdep, thus enabling the removal of the open coded
locks.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c              |  27 +++++-
 drivers/s390/crypto/vfio_ap_ops.c     | 132 ++++++++------------------
 drivers/s390/crypto/vfio_ap_private.h |   2 -
 3 files changed, 63 insertions(+), 98 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index a08f242a9f27..4d2ef3a3286e 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2559,12 +2559,24 @@ static void kvm_s390_set_crycb_format(struct kvm *kvm)
 		kvm->arch.crypto.crycbd |= CRYCB_FORMAT1;
 }
 
+/*
+ * kvm_arch_crypto_set_masks
+ *
+ * @kvm: a pointer to the object containing the crypto masks
+ * @apm: the mask identifying the accessible AP adapters
+ * @aqm: the mask identifying the accessible AP domains
+ * @adm: the mask identifying the accessible AP control domains
+ *
+ * Set the masks that identify the adapters, domains and control domains to
+ * which the KVM guest is granted access.
+ *
+ * Note: The kvm->lock mutex must be locked by the caller.
+ */
 void kvm_arch_crypto_set_masks(struct kvm *kvm, unsigned long *apm,
 			       unsigned long *aqm, unsigned long *adm)
 {
 	struct kvm_s390_crypto_cb *crycb = kvm->arch.crypto.crycb;
 
-	mutex_lock(&kvm->lock);
 	kvm_s390_vcpu_block_all(kvm);
 
 	switch (kvm->arch.crypto.crycbd & CRYCB_FORMAT_MASK) {
@@ -2595,13 +2607,21 @@ void kvm_arch_crypto_set_masks(struct kvm *kvm, unsigned long *apm,
 	/* recreate the shadow crycb for each vcpu */
 	kvm_s390_sync_request_broadcast(kvm, KVM_REQ_VSIE_RESTART);
 	kvm_s390_vcpu_unblock_all(kvm);
-	mutex_unlock(&kvm->lock);
 }
 EXPORT_SYMBOL_GPL(kvm_arch_crypto_set_masks);
 
+/*
+ * kvm_arch_crypto_set_masks
+ *
+ * @kvm: a pointer to the object containing the crypto masks
+ *
+ * Clear the masks that identify the adapters, domains and control domains to
+ * which the KVM guest is granted access.
+ *
+ * Note: The kvm->lock mutex must be locked by the caller.
+ */
 void kvm_arch_crypto_clear_masks(struct kvm *kvm)
 {
-	mutex_lock(&kvm->lock);
 	kvm_s390_vcpu_block_all(kvm);
 
 	memset(&kvm->arch.crypto.crycb->apcb0, 0,
@@ -2613,7 +2633,6 @@ void kvm_arch_crypto_clear_masks(struct kvm *kvm)
 	/* recreate the shadow crycb for each vcpu */
 	kvm_s390_sync_request_broadcast(kvm, KVM_REQ_VSIE_RESTART);
 	kvm_s390_vcpu_unblock_all(kvm);
-	mutex_unlock(&kvm->lock);
 }
 EXPORT_SYMBOL_GPL(kvm_arch_crypto_clear_masks);
 
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 742277bc8d1c..a9c041d3b95f 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -294,15 +294,6 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
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
@@ -350,7 +341,6 @@ static int vfio_ap_mdev_create(struct mdev_device *mdev)
 
 	matrix_mdev->mdev = mdev;
 	vfio_ap_matrix_init(&matrix_dev->info, &matrix_mdev->matrix);
-	init_waitqueue_head(&matrix_mdev->wait_for_kvm);
 	mdev_set_drvdata(mdev, matrix_mdev);
 	matrix_mdev->pqap_hook = handle_pqap;
 	mutex_lock(&matrix_dev->lock);
@@ -619,11 +609,8 @@ static ssize_t assign_adapter_store(struct device *dev,
 
 	mutex_lock(&matrix_dev->lock);
 
-	/*
-	 * If the KVM pointer is in flux or the guest is running, disallow
-	 * un-assignment of adapter
-	 */
-	if (matrix_mdev->kvm_busy || matrix_mdev->kvm) {
+	/* If the KVM guest is running, disallow assignment of adapter */
+	if (matrix_mdev->kvm) {
 		ret = -EBUSY;
 		goto done;
 	}
@@ -692,11 +679,8 @@ static ssize_t unassign_adapter_store(struct device *dev,
 
 	mutex_lock(&matrix_dev->lock);
 
-	/*
-	 * If the KVM pointer is in flux or the guest is running, disallow
-	 * un-assignment of adapter
-	 */
-	if (matrix_mdev->kvm_busy || matrix_mdev->kvm) {
+	/* If the KVM guest is running, disallow unassignment of adapter */
+	if (matrix_mdev->kvm) {
 		ret = -EBUSY;
 		goto done;
 	}
@@ -782,11 +766,8 @@ static ssize_t assign_domain_store(struct device *dev,
 
 	mutex_lock(&matrix_dev->lock);
 
-	/*
-	 * If the KVM pointer is in flux or the guest is running, disallow
-	 * assignment of domain
-	 */
-	if (matrix_mdev->kvm_busy || matrix_mdev->kvm) {
+	/* If the KVM guest is running, disallow assignment of domain */
+	if (matrix_mdev->kvm) {
 		ret = -EBUSY;
 		goto done;
 	}
@@ -850,11 +831,8 @@ static ssize_t unassign_domain_store(struct device *dev,
 
 	mutex_lock(&matrix_dev->lock);
 
-	/*
-	 * If the KVM pointer is in flux or the guest is running, disallow
-	 * un-assignment of domain
-	 */
-	if (matrix_mdev->kvm_busy || matrix_mdev->kvm) {
+	/* If the KVM guest is running, disallow unassignment of domain */
+	if (matrix_mdev->kvm) {
 		ret = -EBUSY;
 		goto done;
 	}
@@ -904,11 +882,8 @@ static ssize_t assign_control_domain_store(struct device *dev,
 
 	mutex_lock(&matrix_dev->lock);
 
-	/*
-	 * If the KVM pointer is in flux or the guest is running, disallow
-	 * assignment of control domain.
-	 */
-	if (matrix_mdev->kvm_busy || matrix_mdev->kvm) {
+	/* If the KVM guest is running, disallow assignment of control domain */
+	if (matrix_mdev->kvm) {
 		ret = -EBUSY;
 		goto done;
 	}
@@ -963,11 +938,8 @@ static ssize_t unassign_control_domain_store(struct device *dev,
 
 	mutex_lock(&matrix_dev->lock);
 
-	/*
-	 * If the KVM pointer is in flux or the guest is running, disallow
-	 * un-assignment of control domain.
-	 */
-	if (matrix_mdev->kvm_busy || matrix_mdev->kvm) {
+	/* If a KVM guest is running, disallow unassignment of control domain */
+	if (matrix_mdev->kvm) {
 		ret = -EBUSY;
 		goto done;
 	}
@@ -1108,28 +1080,30 @@ static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev,
 	struct ap_matrix_mdev *m;
 
 	if (kvm->arch.crypto.crycbd) {
+		down_write(&kvm->arch.crypto.pqap_hook_rwsem);
+		kvm->arch.crypto.pqap_hook = &matrix_mdev->pqap_hook;
+		up_write(&kvm->arch.crypto.pqap_hook_rwsem);
+
+		mutex_lock(&kvm->lock);
+		mutex_lock(&matrix_dev->lock);
+
 		list_for_each_entry(m, &matrix_dev->mdev_list, node) {
-			if (m != matrix_mdev && m->kvm == kvm)
+			if (m != matrix_mdev && m->kvm == kvm) {
+				mutex_unlock(&kvm->lock);
+				mutex_unlock(&matrix_dev->lock);
 				return -EPERM;
+			}
 		}
 
 		kvm_get_kvm(kvm);
 		matrix_mdev->kvm = kvm;
-		matrix_mdev->kvm_busy = true;
-		mutex_unlock(&matrix_dev->lock);
-
-		down_write(&matrix_mdev->kvm->arch.crypto.pqap_hook_rwsem);
-		kvm->arch.crypto.pqap_hook = &matrix_mdev->pqap_hook;
-		up_write(&matrix_mdev->kvm->arch.crypto.pqap_hook_rwsem);
-
 		kvm_arch_crypto_set_masks(kvm,
 					  matrix_mdev->matrix.apm,
 					  matrix_mdev->matrix.aqm,
 					  matrix_mdev->matrix.adm);
 
-		mutex_lock(&matrix_dev->lock);
-		matrix_mdev->kvm_busy = false;
-		wake_up_all(&matrix_mdev->wait_for_kvm);
+		mutex_unlock(&kvm->lock);
+		mutex_unlock(&matrix_dev->lock);
 	}
 
 	return 0;
@@ -1179,35 +1153,24 @@ static int vfio_ap_mdev_iommu_notifier(struct notifier_block *nb,
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
-
-	if (matrix_mdev->kvm) {
-		matrix_mdev->kvm_busy = true;
-		mutex_unlock(&matrix_dev->lock);
-
-		if (matrix_mdev->kvm->arch.crypto.crycbd) {
-			down_write(&matrix_mdev->kvm->arch.crypto.pqap_hook_rwsem);
-			matrix_mdev->kvm->arch.crypto.pqap_hook = NULL;
-			up_write(&matrix_mdev->kvm->arch.crypto.pqap_hook_rwsem);
-
-			kvm_arch_crypto_clear_masks(matrix_mdev->kvm);
-		}
+	if (kvm->arch.crypto.crycbd) {
+		down_write(&kvm->arch.crypto.pqap_hook_rwsem);
+		kvm->arch.crypto.pqap_hook = NULL;
+		up_write(&kvm->arch.crypto.pqap_hook_rwsem);
 
+		mutex_lock(&kvm->lock);
 		mutex_lock(&matrix_dev->lock);
+
+		kvm_arch_crypto_clear_masks(kvm);
 		vfio_ap_mdev_reset_queues(matrix_mdev->mdev);
-		kvm_put_kvm(matrix_mdev->kvm);
+		kvm_put_kvm(kvm);
 		matrix_mdev->kvm = NULL;
-		matrix_mdev->kvm_busy = false;
-		wake_up_all(&matrix_mdev->wait_for_kvm);
+
+		mutex_unlock(&kvm->lock);
+		mutex_unlock(&matrix_dev->lock);
 	}
 }
 
@@ -1220,16 +1183,13 @@ static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
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
 
@@ -1363,14 +1323,11 @@ static void vfio_ap_mdev_release(struct mdev_device *mdev)
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
+	vfio_ap_mdev_unset_kvm(matrix_mdev, matrix_mdev->kvm);
 	module_put(THIS_MODULE);
 }
 
@@ -1412,15 +1369,6 @@ static ssize_t vfio_ap_mdev_ioctl(struct mdev_device *mdev,
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
index e12218e5a629..22d2e0ca3ae5 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -83,8 +83,6 @@ struct ap_matrix_mdev {
 	struct ap_matrix matrix;
 	struct notifier_block group_notifier;
 	struct notifier_block iommu_notifier;
-	bool kvm_busy;
-	wait_queue_head_t wait_for_kvm;
 	struct kvm *kvm;
 	crypto_hook pqap_hook;
 	struct mdev_device *mdev;
-- 
2.30.2

