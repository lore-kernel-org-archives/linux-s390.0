Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87607C4320A
	for <linux-s390@archiver.kernel.org>; Mon, 23 Aug 2021 21:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70DEF6126A
	for <linux-s390@archiver.kernel.org>; Mon, 23 Aug 2021 21:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbhHWVV6 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 23 Aug 2021 17:21:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7978 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232952AbhHWVVz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 23 Aug 2021 17:21:55 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17NL2TFm034769;
        Mon, 23 Aug 2021 17:21:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=345MxAZgMyfeAfgF2WdI6bk5ut8sLifSms1usLuw4fM=;
 b=IuRDoQGNtqzuQt6rxODBd79RZfwBw2GQepUhVu3joJYjTlJYTsK4IW3q5Ohhn0qFx4JZ
 rFMSxCOsiMUrOqzyno0FIMIPqhfoH9PsZYKv6OzIVyxjK4EgZ9T5jPpwaZUxdKWGGCLP
 1oIxZXJ/yq1zecNht/mkeGro9KCzaS10KA2RX/JzppjK/Fg1xkWvI78ouBECPD0q0rC4
 d7jhQMcAr2VqHEAIaExru21xyBmCaz4tb7664FGWeiDgzucMQ/RJk6nEd+DBkcpurytV
 7IcvFRMZhjeKlmDtbb7dBaOnf8/B8uYoIyMejw3pISxyCBwvSISqcMw+aQc/zHhGJ/d7 7g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3amffqx9c5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Aug 2021 17:21:11 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17NL52om045181;
        Mon, 23 Aug 2021 17:21:10 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3amffqx9bu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Aug 2021 17:21:10 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17NLDIv3031326;
        Mon, 23 Aug 2021 21:21:10 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma01wdc.us.ibm.com with ESMTP id 3ajs4bcsde-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Aug 2021 21:21:10 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17NLL96911010408
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Aug 2021 21:21:09 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ECD0ABE06A;
        Mon, 23 Aug 2021 21:21:08 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2FBDABE069;
        Mon, 23 Aug 2021 21:21:05 +0000 (GMT)
Received: from cpe-172-100-181-211.stny.res.rr.com.com (unknown [9.160.182.229])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 23 Aug 2021 21:21:05 +0000 (GMT)
From:   Tony Krowiak <akrowiak@linux.ibm.com>
To:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     borntraeger@de.ibm.com, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com, jgg@nvidia.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com
Subject: [PATCH v2 2/2] s390/vfio-ap: replace open coded locks for VFIO_GROUP_NOTIFY_SET_KVM notification
Date:   Mon, 23 Aug 2021 17:20:47 -0400
Message-Id: <20210823212047.1476436-3-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210823212047.1476436-1-akrowiak@linux.ibm.com>
References: <20210823212047.1476436-1-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: L6lvtja12u0dZnsv1IRDVloai0Ao78d2
X-Proofpoint-ORIG-GUID: uKtvr1ast_OlwG5bNz80EdT3MQLh3xbc
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-23_04:2021-08-23,2021-08-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 impostorscore=0 spamscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108230144
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
Acked-by: Halil Pasic <pasic@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c              |  31 +++++-
 drivers/s390/crypto/vfio_ap_ops.c     | 132 ++++++++------------------
 drivers/s390/crypto/vfio_ap_private.h |   2 -
 3 files changed, 67 insertions(+), 98 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 5c4f559bcd60..efda0615741f 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2559,12 +2559,26 @@ static void kvm_s390_set_crycb_format(struct kvm *kvm)
 		kvm->arch.crypto.crycbd |= CRYCB_FORMAT1;
 }
 
+/*
+ * kvm_arch_crypto_set_masks
+ *
+ * @kvm: pointer to the target guest's KVM struct containing the crypto masks
+ *	 to be set.
+ * @apm: the mask identifying the accessible AP adapters
+ * @aqm: the mask identifying the accessible AP domains
+ * @adm: the mask identifying the accessible AP control domains
+ *
+ * Set the masks that identify the adapters, domains and control domains to
+ * which the KVM guest is granted access.
+ *
+ * Note: The kvm->lock mutex must be locked by the caller before invoking this
+ *	 function.
+ */
 void kvm_arch_crypto_set_masks(struct kvm *kvm, unsigned long *apm,
 			       unsigned long *aqm, unsigned long *adm)
 {
 	struct kvm_s390_crypto_cb *crycb = kvm->arch.crypto.crycb;
 
-	mutex_lock(&kvm->lock);
 	kvm_s390_vcpu_block_all(kvm);
 
 	switch (kvm->arch.crypto.crycbd & CRYCB_FORMAT_MASK) {
@@ -2595,13 +2609,23 @@ void kvm_arch_crypto_set_masks(struct kvm *kvm, unsigned long *apm,
 	/* recreate the shadow crycb for each vcpu */
 	kvm_s390_sync_request_broadcast(kvm, KVM_REQ_VSIE_RESTART);
 	kvm_s390_vcpu_unblock_all(kvm);
-	mutex_unlock(&kvm->lock);
 }
 EXPORT_SYMBOL_GPL(kvm_arch_crypto_set_masks);
 
+/*
+ * kvm_arch_crypto_clear_masks
+ *
+ * @kvm: pointer to the target guest's KVM struct containing the crypto masks
+ *	 to be cleared.
+ *
+ * Clear the masks that identify the adapters, domains and control domains to
+ * which the KVM guest is granted access.
+ *
+ * Note: The kvm->lock mutex must be locked by the caller before invoking this
+ *	 function.
+ */
 void kvm_arch_crypto_clear_masks(struct kvm *kvm)
 {
-	mutex_lock(&kvm->lock);
 	kvm_s390_vcpu_block_all(kvm);
 
 	memset(&kvm->arch.crypto.crycb->apcb0, 0,
@@ -2613,7 +2637,6 @@ void kvm_arch_crypto_clear_masks(struct kvm *kvm)
 	/* recreate the shadow crycb for each vcpu */
 	kvm_s390_sync_request_broadcast(kvm, KVM_REQ_VSIE_RESTART);
 	kvm_s390_vcpu_unblock_all(kvm);
-	mutex_unlock(&kvm->lock);
 }
 EXPORT_SYMBOL_GPL(kvm_arch_crypto_clear_masks);
 
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 439ca7768eb7..c46937de5758 100644
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
+	if (kvm && kvm->arch.crypto.crycbd) {
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
 
@@ -1363,14 +1323,11 @@ static void vfio_ap_mdev_close_device(struct mdev_device *mdev)
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
2.31.1

