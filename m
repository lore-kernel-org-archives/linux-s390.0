Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160EEC2B9F4
	for <linux-s390@archiver.kernel.org>; Fri, 25 Jun 2021 22:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1A46613B7
	for <linux-s390@archiver.kernel.org>; Fri, 25 Jun 2021 22:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbhFYWKZ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 25 Jun 2021 18:10:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7750 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229531AbhFYWKZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 25 Jun 2021 18:10:25 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15PM4GnZ134050;
        Fri, 25 Jun 2021 18:08:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=BOtCVlAgK/FbT7pSFt8J5WNDMKvwby6ZMOw2KtOKS6k=;
 b=h+zDQiD02evD9aRhRa/abnf2G+dCd/ERBqO6cumi6XebuD6FRCGqALqoOP2ktFskzfDa
 HKaCp+CxEkYgqfc0hIYbtBlHKMj82Kp9sgiN5t1a1bvhmf9D5HcRfBbgem0PUWvaAnEg
 dMAYL5qg+tvrnyRAKdLF9ZQjJcOayC6vviurF2vNuc24Xtj2d8oXvET3KegHF33VoV99
 lrvB0dKqRfuuZwfkQVfIuHnwDsScEoUkJwRb4AEaGNKaq1Lwys+V9RajkMbySGxMUSRn
 fLkRZt8bcigxINeqsfacsfl0ekcyOhiASOt133hzcwSAGgmp8ZL7LghPmSCRlw/Nq0co jw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39dpvv1bdq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Jun 2021 18:08:02 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15PM4Jme134307;
        Fri, 25 Jun 2021 18:08:01 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39dpvv1bda-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Jun 2021 18:08:01 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15PM7AI8029936;
        Fri, 25 Jun 2021 22:08:01 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma04wdc.us.ibm.com with ESMTP id 39987a7csk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Jun 2021 22:08:01 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15PM80sm39518524
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jun 2021 22:08:00 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5F94928092;
        Fri, 25 Jun 2021 22:08:00 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 920432808C;
        Fri, 25 Jun 2021 22:07:59 +0000 (GMT)
Received: from cpe-172-100-179-72.stny.res.rr.com.com (unknown [9.85.148.87])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 25 Jun 2021 22:07:59 +0000 (GMT)
From:   Tony Krowiak <akrowiak@linux.ibm.com>
To:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     borntraeger@de.ibm.com, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com, jgg@nvidia.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com
Subject: [PATCH] s390/vfio-ap: do not use open locks during VFIO_GROUP_NOTIFY_SET_KVM notification
Date:   Fri, 25 Jun 2021 18:07:58 -0400
Message-Id: <20210625220758.80365-1-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GU_uFyBMHxSUgy4WJfBd8NE3zygYmEkE
X-Proofpoint-ORIG-GUID: lqKi420sJ4lpY-yWMB07ZipBcqG7TIyq
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-25_11:2021-06-25,2021-06-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015 phishscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106250137
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The fix to resolve a lockdep splat while handling the
VFIO_GROUP_NOTIFY_SET_KVM event introduced a kvm_busy flag indicating that
the vfio_ap device driver is busy setting or unsetting the KVM pointer.
A wait queue was employed to allow functions requiring access to the KVM
pointer to wait for the kvm_busy flag to be cleared. For the duration of
the wait period, the mdev lock was unlocked then acquired again after the
kvm_busy flag was cleared. This got rid of the lockdep report, but didn't
really resolve the problem.

This patch removes the the kvm_busy flag and wait queue as they are not
necessary to resolve the lockdep splat problem. The wait queue was
introduced to prevent changes to the matrix used to update the guest's
AP configuration. The idea was that whenever an adapter, domain or control
domain was being assigned to or unassigned from the matrix, the function
would wait until the group notifier function was no longer busy with the
KVM pointer.

The thing is, the KVM pointer value (matrix_mdev->kvm) is always set and
cleared while holding the matrix_dev->lock mutex. The assignment and
unassignment interfaces also lock the matrix_dev->lock mutex prior to
checking whether the matrix_mdev->kvm pointer is set and if so, returns
the -EBUSY error from the function. Consequently, there is no chance for
an update to the matrix to occur while the guest's AP configuration is
being updated.

Fixes: 0cc00c8d4050 ("s390/vfio-ap: fix circular lockdep when setting/clearing crypto masks")
Cc: stable@vger.kernel.org
Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c     | 77 +++++++--------------------
 drivers/s390/crypto/vfio_ap_private.h |  2 -
 2 files changed, 20 insertions(+), 59 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 742277bc8d1c..99a58f54c076 100644
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
@@ -623,7 +613,7 @@ static ssize_t assign_adapter_store(struct device *dev,
 	 * If the KVM pointer is in flux or the guest is running, disallow
 	 * un-assignment of adapter
 	 */
-	if (matrix_mdev->kvm_busy || matrix_mdev->kvm) {
+	if (matrix_mdev->kvm) {
 		ret = -EBUSY;
 		goto done;
 	}
@@ -696,7 +686,7 @@ static ssize_t unassign_adapter_store(struct device *dev,
 	 * If the KVM pointer is in flux or the guest is running, disallow
 	 * un-assignment of adapter
 	 */
-	if (matrix_mdev->kvm_busy || matrix_mdev->kvm) {
+	if (matrix_mdev->kvm) {
 		ret = -EBUSY;
 		goto done;
 	}
@@ -786,7 +776,7 @@ static ssize_t assign_domain_store(struct device *dev,
 	 * If the KVM pointer is in flux or the guest is running, disallow
 	 * assignment of domain
 	 */
-	if (matrix_mdev->kvm_busy || matrix_mdev->kvm) {
+	if (matrix_mdev->kvm) {
 		ret = -EBUSY;
 		goto done;
 	}
@@ -854,7 +844,7 @@ static ssize_t unassign_domain_store(struct device *dev,
 	 * If the KVM pointer is in flux or the guest is running, disallow
 	 * un-assignment of domain
 	 */
-	if (matrix_mdev->kvm_busy || matrix_mdev->kvm) {
+	if (matrix_mdev->kvm) {
 		ret = -EBUSY;
 		goto done;
 	}
@@ -908,7 +898,7 @@ static ssize_t assign_control_domain_store(struct device *dev,
 	 * If the KVM pointer is in flux or the guest is running, disallow
 	 * assignment of control domain.
 	 */
-	if (matrix_mdev->kvm_busy || matrix_mdev->kvm) {
+	if (matrix_mdev->kvm) {
 		ret = -EBUSY;
 		goto done;
 	}
@@ -967,7 +957,7 @@ static ssize_t unassign_control_domain_store(struct device *dev,
 	 * If the KVM pointer is in flux or the guest is running, disallow
 	 * un-assignment of control domain.
 	 */
-	if (matrix_mdev->kvm_busy || matrix_mdev->kvm) {
+	if (matrix_mdev->kvm) {
 		ret = -EBUSY;
 		goto done;
 	}
@@ -1108,14 +1098,17 @@ static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev,
 	struct ap_matrix_mdev *m;
 
 	if (kvm->arch.crypto.crycbd) {
+		mutex_lock(&matrix_dev->lock);
+
 		list_for_each_entry(m, &matrix_dev->mdev_list, node) {
-			if (m != matrix_mdev && m->kvm == kvm)
+			if (m != matrix_mdev && m->kvm == kvm) {
+				mutex_unlock(&matrix_dev->lock);
 				return -EPERM;
+			}
 		}
 
 		kvm_get_kvm(kvm);
 		matrix_mdev->kvm = kvm;
-		matrix_mdev->kvm_busy = true;
 		mutex_unlock(&matrix_dev->lock);
 
 		down_write(&matrix_mdev->kvm->arch.crypto.pqap_hook_rwsem);
@@ -1126,10 +1119,6 @@ static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev,
 					  matrix_mdev->matrix.apm,
 					  matrix_mdev->matrix.aqm,
 					  matrix_mdev->matrix.adm);
-
-		mutex_lock(&matrix_dev->lock);
-		matrix_mdev->kvm_busy = false;
-		wake_up_all(&matrix_mdev->wait_for_kvm);
 	}
 
 	return 0;
@@ -1181,33 +1170,21 @@ static int vfio_ap_mdev_iommu_notifier(struct notifier_block *nb,
  */
 static void vfio_ap_mdev_unset_kvm(struct ap_matrix_mdev *matrix_mdev)
 {
-	/*
-	 * If the KVM pointer is in the process of being set, wait until the
-	 * process has completed.
-	 */
-	wait_event_cmd(matrix_mdev->wait_for_kvm,
-		       !matrix_mdev->kvm_busy,
-		       mutex_unlock(&matrix_dev->lock),
-		       mutex_lock(&matrix_dev->lock));
+	mutex_lock(&matrix_dev->lock);
 
-	if (matrix_mdev->kvm) {
-		matrix_mdev->kvm_busy = true;
+	if ((matrix_mdev->kvm) && (matrix_mdev->kvm->arch.crypto.crycbd)) {
 		mutex_unlock(&matrix_dev->lock);
+		down_write(&matrix_mdev->kvm->arch.crypto.pqap_hook_rwsem);
+		matrix_mdev->kvm->arch.crypto.pqap_hook = NULL;
+		up_write(&matrix_mdev->kvm->arch.crypto.pqap_hook_rwsem);
 
-		if (matrix_mdev->kvm->arch.crypto.crycbd) {
-			down_write(&matrix_mdev->kvm->arch.crypto.pqap_hook_rwsem);
-			matrix_mdev->kvm->arch.crypto.pqap_hook = NULL;
-			up_write(&matrix_mdev->kvm->arch.crypto.pqap_hook_rwsem);
-
-			kvm_arch_crypto_clear_masks(matrix_mdev->kvm);
-		}
+		kvm_arch_crypto_clear_masks(matrix_mdev->kvm);
 
 		mutex_lock(&matrix_dev->lock);
 		vfio_ap_mdev_reset_queues(matrix_mdev->mdev);
 		kvm_put_kvm(matrix_mdev->kvm);
 		matrix_mdev->kvm = NULL;
-		matrix_mdev->kvm_busy = false;
-		wake_up_all(&matrix_mdev->wait_for_kvm);
+		mutex_unlock(&matrix_dev->lock);
 	}
 }
 
@@ -1220,7 +1197,6 @@ static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
 	if (action != VFIO_GROUP_NOTIFY_SET_KVM)
 		return NOTIFY_OK;
 
-	mutex_lock(&matrix_dev->lock);
 	matrix_mdev = container_of(nb, struct ap_matrix_mdev, group_notifier);
 
 	if (!data)
@@ -1228,8 +1204,6 @@ static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
 	else if (vfio_ap_mdev_set_kvm(matrix_mdev, data))
 		notify_rc = NOTIFY_DONE;
 
-	mutex_unlock(&matrix_dev->lock);
-
 	return notify_rc;
 }
 
@@ -1363,14 +1337,12 @@ static void vfio_ap_mdev_release(struct mdev_device *mdev)
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
+	vfio_ap_mdev_unset_kvm(matrix_mdev);
 	module_put(THIS_MODULE);
 }
 
@@ -1412,15 +1384,6 @@ static ssize_t vfio_ap_mdev_ioctl(struct mdev_device *mdev,
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

