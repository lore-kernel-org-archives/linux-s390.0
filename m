Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58FA9C48BCD
	for <linux-s390@archiver.kernel.org>; Wed,  9 Jun 2021 22:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E318613CB
	for <linux-s390@archiver.kernel.org>; Wed,  9 Jun 2021 22:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhFIWsu (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 9 Jun 2021 18:48:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21518 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230151AbhFIWsr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 9 Jun 2021 18:48:47 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 159MXUWq179966;
        Wed, 9 Jun 2021 18:46:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=xD2msWe+uNo4Zjs0CRiPh7dQ7ROBU66G7IdwJE0t2ck=;
 b=jRpk1u8MPmBPN65Tc4hudRw8Wc0eYFzBUNAfxP0QOeIM8t5gy2MqCcTnQDYj4h2s/hvJ
 aEm3h8SvVo3obZaPKLAXj1fwEFZbkh3c2yLu7VqkMLHKR9tgtcMM2AlCEAmS71qTz2ZT
 PLmQZGKl31dgAGixKPMb3xhCcH/nGYMEI7djO9BKQ9BAdDr+vtqC3GmTRqYg6/7n5Xw0
 DyJ/N72nmXV/FAWv7Lac0yZk5QF5qqnjOFrDTY0NAZQpMfwXwKFE1vxc9w+9Q40mey8h
 zIBEOmxCOvhkTCbDNepyWOaWv1DIe+T1swd/K0dc59je4DGV2kSJl9z3fyV7cxbyET9i KQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3935xcs1hs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Jun 2021 18:46:49 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 159MZvj6185098;
        Wed, 9 Jun 2021 18:46:48 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3935xcs1hp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Jun 2021 18:46:48 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 159MflSk030376;
        Wed, 9 Jun 2021 22:46:48 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma04dal.us.ibm.com with ESMTP id 3900w9v5nu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Jun 2021 22:46:48 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 159MkkiN35783094
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Jun 2021 22:46:46 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4E82BC6059;
        Wed,  9 Jun 2021 22:46:46 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8F846C6055;
        Wed,  9 Jun 2021 22:46:44 +0000 (GMT)
Received: from cpe-172-100-179-72.stny.res.rr.com (unknown [9.85.129.35])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  9 Jun 2021 22:46:44 +0000 (GMT)
From:   Tony Krowiak <akrowiak@linux.ibm.com>
To:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     borntraeger@de.ibm.com, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com, jgg@nvidia.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com
Subject: [PATCH 2/3] s390/vfio-ap: introduce two new r/w locks to replace wait_queue_head_t
Date:   Wed,  9 Jun 2021 18:46:33 -0400
Message-Id: <20210609224634.575156-3-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210609224634.575156-1-akrowiak@linux.ibm.com>
References: <20210609224634.575156-1-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: A8h3pd94T9KrsHEbPP6XM69p-dy0_-mg
X-Proofpoint-ORIG-GUID: 48DUXrvedTfA8rpiY20hNTRpjRKDGo4f
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-09_07:2021-06-04,2021-06-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 priorityscore=1501 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106090120
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

This patch introduces two new r/w locks to replace the wait_queue_head_t
that was introduced to fix a lockdep splat reported when testing
pass-through of AP queues to a Secure Execution guest. This was the
abbreviated dependency chain reported by lockdep that was fixed using
a wait queue:

kvm_arch_crypto_set_masks+0x4a/0x2b8 [kvm]        kvm->lock
vfio_ap_mdev_group_notifier+0x154/0x170 [vfio_ap] matrix_dev->lock

handle_pqap+0x56/0x1d0 [vfio_ap]    matrix_dev->lock
kvm_vcpu_ioctl+0x2cc/0x898 [kvm]    vcpu->mutex

kvm_s390_cpus_to_pv+0x4e/0xf8 [kvm]   vcpu->mutex
kvm_arch_vm_ioctl+0x3ec/0x550 [kvm]   kvm->lock

The handle_pqap function handles interception of the PQAP instruction
issued on the guest to enable interrupts for each queue assigned to the
KVM guest. The kvm_arch_crypto_set_masks function sets the bits in the
KVM guest's AP Control Block (APCB) that supplies the AP configuration to
the guest. It is called by the group notifier that responds to the event
indicating that the KVM pointer has been set (i.e., the guest has been
started).

The idea behind the use of the wait_queue_head_t is to set a flag
indicating whether the KVM pointer is being set or not. The flag is set
when the KVM pointer is in the process of being set. All functions
that require access to the KVM pointer must wait until the pointer is set.
This allows the vfio_ap device driver to give up the matrix_dev->lock
while the kvm_arch_crypto_set_masks function is executing which circumvents
the lockdep splat.

It was pointed out by Jason Gunthorpe that this merely defeats lockdep
analysis and ought to be replaced by a proper rwsem. This patch attempts
to do just that; however, a single rw_semaphore will not do the trick by
itself. Consequently, two semaphores are introduced to control access to
the data contained within struct ap_matrix_mdev:

* An rw_semaphore is added to struct ap_matrix_mdev. The purpose of this
  lock is to control access to all data contained within
  struct ap_matrix_mdev, including the bitmaps specifying the
  AP configuration for a KVM guest.

* An rw_semaphore is added to struct ap_matrix to control access to the
  bitmaps specifying the AP configuration for a KVM guest. The primary
  reason for this lock is to prevent write access while the bitmaps are
  being read to update the KVM guest's AP control block (APCB) that
  supplies the AP configuration for the guest. If we provide a lock only
  for struct ap_matrix_mdev and hold that lock while the KVM guest's
  APCB is being updated, we'll end up with a lockdep splat similar to that
  resolved by the wait queue because the kvm->lock is held for the APCB
  update. This lock enables the driver to give up the
  rw_semaphore in struct ap_matrix_mdev while the KVM guest's AP config
  is being updated and therefore avoid the lockdep splat. In order to edit
  struct ap_matrix - as is done when adapters and domains are assigned to
  or unassigned from the mdev - both the semaphores must be locked: A read
  lock on the semaphore in struct ap_matrix_mdev and a write lock on
  ap_matrix.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c     | 356 ++++++++++----------------
 drivers/s390/crypto/vfio_ap_private.h |   8 +-
 2 files changed, 148 insertions(+), 216 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 122c85c22469..d65a5728153b 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -286,27 +286,14 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
 	if (!(vcpu->arch.sie_block->eca & ECA_AIV))
 		return -EOPNOTSUPP;
 
-	apqn = vcpu->run->s.regs.gprs[0] & 0xffff;
-	mutex_lock(&matrix_dev->lock);
-
 	if (!vcpu->kvm->arch.crypto.pqap_hook)
-		goto out_unlock;
+		goto done;
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
-	/* If the there is no guest using the mdev, there is nothing to do */
-	if (!matrix_mdev->kvm)
-		goto out_unlock;
+	down_read(&matrix_mdev->rwsem);
 
+	apqn = vcpu->run->s.regs.gprs[0] & 0xffff;
 	q = vfio_ap_get_queue(matrix_mdev, apqn);
 	if (!q)
 		goto out_unlock;
@@ -321,9 +308,10 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
 		qstatus = vfio_ap_irq_disable(q);
 
 out_unlock:
+	up_read(&matrix_mdev->rwsem);
+done:
 	memcpy(&vcpu->run->s.regs.gprs[1], &qstatus, sizeof(qstatus));
 	vcpu->run->s.regs.gprs[1] >>= 32;
-	mutex_unlock(&matrix_dev->lock);
 	return 0;
 }
 
@@ -333,6 +321,7 @@ static void vfio_ap_matrix_init(struct ap_config_info *info,
 	matrix->apm_max = info->apxa ? info->Na : 63;
 	matrix->aqm_max = info->apxa ? info->Nd : 15;
 	matrix->adm_max = info->apxa ? info->Nd : 15;
+	init_rwsem(&matrix->rwsem);
 }
 
 static int vfio_ap_mdev_create(struct mdev_device *mdev)
@@ -350,10 +339,11 @@ static int vfio_ap_mdev_create(struct mdev_device *mdev)
 
 	matrix_mdev->mdev = mdev;
 	vfio_ap_matrix_init(&matrix_dev->info, &matrix_mdev->matrix);
-	init_waitqueue_head(&matrix_mdev->wait_for_kvm);
+	init_rwsem(&matrix_mdev->rwsem);
 	mdev_set_drvdata(mdev, matrix_mdev);
 	matrix_mdev->pqap_hook.hook = handle_pqap;
 	matrix_mdev->pqap_hook.owner = THIS_MODULE;
+
 	mutex_lock(&matrix_dev->lock);
 	list_add(&matrix_mdev->node, &matrix_dev->mdev_list);
 	mutex_unlock(&matrix_dev->lock);
@@ -366,13 +356,14 @@ static int vfio_ap_mdev_remove(struct mdev_device *mdev)
 	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
 
 	mutex_lock(&matrix_dev->lock);
-	vfio_ap_mdev_reset_queues(mdev);
 	list_del(&matrix_mdev->node);
-	kfree(matrix_mdev);
-	mdev_set_drvdata(mdev, NULL);
 	atomic_inc(&matrix_dev->available_instances);
 	mutex_unlock(&matrix_dev->lock);
 
+	vfio_ap_mdev_reset_queues(matrix_mdev->mdev);
+	kfree(matrix_mdev);
+	mdev_set_drvdata(mdev, NULL);
+
 	return 0;
 }
 
@@ -577,6 +568,30 @@ static int vfio_ap_mdev_verify_no_sharing(struct ap_matrix_mdev *matrix_mdev)
 	return 0;
 }
 
+static int vfio_ap_mdev_matrix_store_lock(struct ap_matrix_mdev *matrix_mdev)
+{
+	if (!down_write_trylock(&matrix_mdev->rwsem))
+		return -EBUSY;
+
+	if (matrix_mdev->kvm) {
+		up_write(&matrix_mdev->rwsem);
+		return -EBUSY;
+	}
+
+	if (!down_write_trylock(&matrix_mdev->matrix.rwsem)) {
+		up_write(&matrix_mdev->rwsem);
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+static void vfio_ap_mdev_matrix_store_unlock(struct ap_matrix_mdev *matrix_mdev)
+{
+	up_write(&matrix_mdev->rwsem);
+	up_write(&matrix_mdev->matrix.rwsem);
+}
+
 /**
  * assign_adapter_store
  *
@@ -618,31 +633,17 @@ static ssize_t assign_adapter_store(struct device *dev,
 	struct mdev_device *mdev = mdev_from_dev(dev);
 	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
 
-	mutex_lock(&matrix_dev->lock);
-
-	/*
-	 * If the KVM pointer is in flux or the guest is running, disallow
-	 * un-assignment of adapter
-	 */
-	if (matrix_mdev->kvm_busy || matrix_mdev->kvm) {
-		ret = -EBUSY;
-		goto done;
-	}
-
 	ret = kstrtoul(buf, 0, &apid);
 	if (ret)
-		goto done;
+		return ret;
 
-	if (apid > matrix_mdev->matrix.apm_max) {
-		ret = -ENODEV;
-		goto done;
-	}
+	if (apid > matrix_mdev->matrix.apm_max)
+		return -ENODEV;
+
+	ret = vfio_ap_mdev_matrix_store_lock(matrix_mdev);
+	if (ret)
+		return ret;
 
-	/*
-	 * Set the bit in the AP mask (APM) corresponding to the AP adapter
-	 * number (APID). The bits in the mask, from most significant to least
-	 * significant bit, correspond to APIDs 0-255.
-	 */
 	ret = vfio_ap_mdev_verify_queues_reserved_for_apid(matrix_mdev, apid);
 	if (ret)
 		goto done;
@@ -659,7 +660,7 @@ static ssize_t assign_adapter_store(struct device *dev,
 share_err:
 	clear_bit_inv(apid, matrix_mdev->matrix.apm);
 done:
-	mutex_unlock(&matrix_dev->lock);
+	vfio_ap_mdev_matrix_store_unlock(matrix_mdev);
 
 	return ret;
 }
@@ -691,31 +692,21 @@ static ssize_t unassign_adapter_store(struct device *dev,
 	struct mdev_device *mdev = mdev_from_dev(dev);
 	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
 
-	mutex_lock(&matrix_dev->lock);
-
-	/*
-	 * If the KVM pointer is in flux or the guest is running, disallow
-	 * un-assignment of adapter
-	 */
-	if (matrix_mdev->kvm_busy || matrix_mdev->kvm) {
-		ret = -EBUSY;
-		goto done;
-	}
-
 	ret = kstrtoul(buf, 0, &apid);
 	if (ret)
-		goto done;
+		return ret;
 
-	if (apid > matrix_mdev->matrix.apm_max) {
-		ret = -ENODEV;
-		goto done;
-	}
+	if (apid > matrix_mdev->matrix.apm_max)
+		return -ENODEV;
+
+	ret = vfio_ap_mdev_matrix_store_lock(matrix_mdev);
+	if (ret)
+		return ret;
 
 	clear_bit_inv((unsigned long)apid, matrix_mdev->matrix.apm);
-	ret = count;
-done:
-	mutex_unlock(&matrix_dev->lock);
-	return ret;
+	vfio_ap_mdev_matrix_store_unlock(matrix_mdev);
+
+	return count;
 }
 static DEVICE_ATTR_WO(unassign_adapter);
 
@@ -781,24 +772,15 @@ static ssize_t assign_domain_store(struct device *dev,
 	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
 	unsigned long max_apqi = matrix_mdev->matrix.aqm_max;
 
-	mutex_lock(&matrix_dev->lock);
-
-	/*
-	 * If the KVM pointer is in flux or the guest is running, disallow
-	 * assignment of domain
-	 */
-	if (matrix_mdev->kvm_busy || matrix_mdev->kvm) {
-		ret = -EBUSY;
-		goto done;
-	}
-
 	ret = kstrtoul(buf, 0, &apqi);
 	if (ret)
-		goto done;
-	if (apqi > max_apqi) {
-		ret = -ENODEV;
-		goto done;
-	}
+		return ret;
+	if (apqi > max_apqi)
+		return -ENODEV;
+
+	ret = vfio_ap_mdev_matrix_store_lock(matrix_mdev);
+	if (ret)
+		return ret;
 
 	ret = vfio_ap_mdev_verify_queues_reserved_for_apqi(matrix_mdev, apqi);
 	if (ret)
@@ -816,7 +798,7 @@ static ssize_t assign_domain_store(struct device *dev,
 share_err:
 	clear_bit_inv(apqi, matrix_mdev->matrix.aqm);
 done:
-	mutex_unlock(&matrix_dev->lock);
+	vfio_ap_mdev_matrix_store_unlock(matrix_mdev);
 
 	return ret;
 }
@@ -849,32 +831,21 @@ static ssize_t unassign_domain_store(struct device *dev,
 	struct mdev_device *mdev = mdev_from_dev(dev);
 	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
 
-	mutex_lock(&matrix_dev->lock);
-
-	/*
-	 * If the KVM pointer is in flux or the guest is running, disallow
-	 * un-assignment of domain
-	 */
-	if (matrix_mdev->kvm_busy || matrix_mdev->kvm) {
-		ret = -EBUSY;
-		goto done;
-	}
-
 	ret = kstrtoul(buf, 0, &apqi);
 	if (ret)
-		goto done;
+		return ret;
 
-	if (apqi > matrix_mdev->matrix.aqm_max) {
-		ret = -ENODEV;
-		goto done;
-	}
+	if (apqi > matrix_mdev->matrix.aqm_max)
+		return -ENODEV;
+
+	ret = vfio_ap_mdev_matrix_store_lock(matrix_mdev);
+	if (ret)
+		return ret;
 
 	clear_bit_inv((unsigned long)apqi, matrix_mdev->matrix.aqm);
-	ret = count;
+	vfio_ap_mdev_matrix_store_unlock(matrix_mdev);
 
-done:
-	mutex_unlock(&matrix_dev->lock);
-	return ret;
+	return count;
 }
 static DEVICE_ATTR_WO(unassign_domain);
 
@@ -903,25 +874,16 @@ static ssize_t assign_control_domain_store(struct device *dev,
 	struct mdev_device *mdev = mdev_from_dev(dev);
 	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
 
-	mutex_lock(&matrix_dev->lock);
-
-	/*
-	 * If the KVM pointer is in flux or the guest is running, disallow
-	 * assignment of control domain.
-	 */
-	if (matrix_mdev->kvm_busy || matrix_mdev->kvm) {
-		ret = -EBUSY;
-		goto done;
-	}
-
 	ret = kstrtoul(buf, 0, &id);
 	if (ret)
-		goto done;
+		return ret;
 
-	if (id > matrix_mdev->matrix.adm_max) {
-		ret = -ENODEV;
-		goto done;
-	}
+	if (id > matrix_mdev->matrix.adm_max)
+		return -ENODEV;
+
+	ret = vfio_ap_mdev_matrix_store_lock(matrix_mdev);
+	if (ret)
+		return ret;
 
 	/* Set the bit in the ADM (bitmask) corresponding to the AP control
 	 * domain number (id). The bits in the mask, from most significant to
@@ -929,10 +891,9 @@ static ssize_t assign_control_domain_store(struct device *dev,
 	 * number of control domains that can be assigned.
 	 */
 	set_bit_inv(id, matrix_mdev->matrix.adm);
-	ret = count;
-done:
-	mutex_unlock(&matrix_dev->lock);
-	return ret;
+	vfio_ap_mdev_matrix_store_unlock(matrix_mdev);
+
+	return count;
 }
 static DEVICE_ATTR_WO(assign_control_domain);
 
@@ -962,30 +923,20 @@ static ssize_t unassign_control_domain_store(struct device *dev,
 	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
 	unsigned long max_domid =  matrix_mdev->matrix.adm_max;
 
-	mutex_lock(&matrix_dev->lock);
-
-	/*
-	 * If the KVM pointer is in flux or the guest is running, disallow
-	 * un-assignment of control domain.
-	 */
-	if (matrix_mdev->kvm_busy || matrix_mdev->kvm) {
-		ret = -EBUSY;
-		goto done;
-	}
-
 	ret = kstrtoul(buf, 0, &domid);
 	if (ret)
-		goto done;
-	if (domid > max_domid) {
-		ret = -ENODEV;
-		goto done;
-	}
+		return ret;
+	if (domid > max_domid)
+		return -ENODEV;
+
+	ret = vfio_ap_mdev_matrix_store_lock(matrix_mdev);
+	if (ret)
+		return ret;
 
 	clear_bit_inv(domid, matrix_mdev->matrix.adm);
-	ret = count;
-done:
-	mutex_unlock(&matrix_dev->lock);
-	return ret;
+	vfio_ap_mdev_matrix_store_unlock(matrix_mdev);
+
+	return count;
 }
 static DEVICE_ATTR_WO(unassign_control_domain);
 
@@ -1001,13 +952,13 @@ static ssize_t control_domains_show(struct device *dev,
 	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
 	unsigned long max_domid = matrix_mdev->matrix.adm_max;
 
-	mutex_lock(&matrix_dev->lock);
+	down_read(&matrix_mdev->rwsem);
 	for_each_set_bit_inv(id, matrix_mdev->matrix.adm, max_domid + 1) {
 		n = sprintf(bufpos, "%04lx\n", id);
 		bufpos += n;
 		nchars += n;
 	}
-	mutex_unlock(&matrix_dev->lock);
+	up_read(&matrix_mdev->rwsem);
 
 	return nchars;
 }
@@ -1028,11 +979,10 @@ static ssize_t matrix_show(struct device *dev, struct device_attribute *attr,
 	int nchars = 0;
 	int n;
 
+	down_read(&matrix_mdev->rwsem);
 	apid1 = find_first_bit_inv(matrix_mdev->matrix.apm, napm_bits);
 	apqi1 = find_first_bit_inv(matrix_mdev->matrix.aqm, naqm_bits);
 
-	mutex_lock(&matrix_dev->lock);
-
 	if ((apid1 < napm_bits) && (apqi1 < naqm_bits)) {
 		for_each_set_bit_inv(apid, matrix_mdev->matrix.apm, napm_bits) {
 			for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm,
@@ -1057,7 +1007,7 @@ static ssize_t matrix_show(struct device *dev, struct device_attribute *attr,
 		}
 	}
 
-	mutex_unlock(&matrix_dev->lock);
+	up_read(&matrix_mdev->rwsem);
 
 	return nchars;
 }
@@ -1090,15 +1040,8 @@ static const struct attribute_group *vfio_ap_mdev_attr_groups[] = {
  * @matrix_mdev: a mediated matrix device
  * @kvm: reference to KVM instance
  *
- * Sets all data for @matrix_mdev that are needed to manage AP resources
- * for the guest whose state is represented by @kvm.
- *
- * Note: The matrix_dev->lock must be taken prior to calling
- * this function; however, the lock will be temporarily released while the
- * guest's AP configuration is set to avoid a potential lockdep splat.
- * The kvm->lock is taken to set the guest's AP configuration which, under
- * certain circumstances, will result in a circular lock dependency if this is
- * done under the @matrix_mdev->lock.
+ * Verifies no other mediated matrix device has @kvm and sets a reference to
+ * it in @matrix_mdev->kvm.
  *
  * Return 0 if no other mediated matrix device has a reference to @kvm;
  * otherwise, returns an -EPERM.
@@ -1108,24 +1051,32 @@ static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev,
 {
 	struct ap_matrix_mdev *m;
 
-	if (kvm->arch.crypto.crycbd) {
-		list_for_each_entry(m, &matrix_dev->mdev_list, node) {
-			if (m != matrix_mdev && m->kvm == kvm)
-				return -EPERM;
+	mutex_lock(&matrix_dev->lock);
+	list_for_each_entry(m, &matrix_dev->mdev_list, node) {
+		if ((m != matrix_mdev) && (m->kvm == kvm)) {
+			mutex_unlock(&matrix_dev->lock);
+			return -EPERM;
 		}
+	}
+	mutex_unlock(&matrix_dev->lock);
+
+	down_write(&matrix_mdev->rwsem);
+	matrix_mdev->kvm = kvm;
+	kvm_get_kvm(kvm);
+	kvm->arch.crypto.pqap_hook = &matrix_mdev->pqap_hook;
+	up_write(&matrix_mdev->rwsem);
 
-		kvm_get_kvm(kvm);
-		matrix_mdev->kvm_busy = true;
-		mutex_unlock(&matrix_dev->lock);
+	/*
+	 * If there is no CRYCB pointer, then there is no need to set the
+	 * masks for the KVM guest
+	 */
+	if (kvm->arch.crypto.crycbd) {
+		down_read(&matrix_mdev->matrix.rwsem);
 		kvm_arch_crypto_set_masks(kvm,
 					  matrix_mdev->matrix.apm,
 					  matrix_mdev->matrix.aqm,
 					  matrix_mdev->matrix.adm);
-		mutex_lock(&matrix_dev->lock);
-		kvm->arch.crypto.pqap_hook = &matrix_mdev->pqap_hook;
-		matrix_mdev->kvm = kvm;
-		matrix_mdev->kvm_busy = false;
-		wake_up_all(&matrix_mdev->wait_for_kvm);
+		up_read(&matrix_mdev->matrix.rwsem);
 	}
 
 	return 0;
@@ -1165,60 +1116,48 @@ static int vfio_ap_mdev_iommu_notifier(struct notifier_block *nb,
  *
  * @matrix_mdev: a matrix mediated device
  *
- * Performs clean-up of resources no longer needed by @matrix_mdev.
- *
- * Note: The matrix_dev->lock must be taken prior to calling
- * this function; however, the lock will be temporarily released while the
- * guest's AP configuration is cleared to avoid a potential lockdep splat.
- * The kvm->lock is taken to clear the guest's AP configuration which, under
- * certain circumstances, will result in a circular lock dependency if this is
- * done under the @matrix_mdev->lock.
- *
+ * Unplugs the adapters, domains and control domains from the guest, clears
+ * the KVM pointer from @matrix_mdev and nullifies the pqap_hook pointer.
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
-
 	if (matrix_mdev->kvm) {
-		matrix_mdev->kvm_busy = true;
-		mutex_unlock(&matrix_dev->lock);
-		kvm_arch_crypto_clear_masks(matrix_mdev->kvm);
-		mutex_lock(&matrix_dev->lock);
-		vfio_ap_mdev_reset_queues(matrix_mdev->mdev);
+		if (matrix_mdev->kvm->arch.crypto.crycbd)
+			kvm_arch_crypto_clear_masks(matrix_mdev->kvm);
+
+		down_write(&matrix_mdev->rwsem);
 		matrix_mdev->kvm->arch.crypto.pqap_hook = NULL;
+		vfio_ap_mdev_reset_queues(matrix_mdev->mdev);
 		kvm_put_kvm(matrix_mdev->kvm);
 		matrix_mdev->kvm = NULL;
-		matrix_mdev->kvm_busy = false;
-		wake_up_all(&matrix_mdev->wait_for_kvm);
+		up_write(&matrix_mdev->rwsem);
 	}
 }
 
 static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
 				       unsigned long action, void *data)
 {
-	int notify_rc = NOTIFY_OK;
+	int ret, notify_rc = NOTIFY_OK;
 	struct ap_matrix_mdev *matrix_mdev;
 
 	if (action != VFIO_GROUP_NOTIFY_SET_KVM)
 		return NOTIFY_OK;
 
-	mutex_lock(&matrix_dev->lock);
 	matrix_mdev = container_of(nb, struct ap_matrix_mdev, group_notifier);
 
-	if (!data)
-		vfio_ap_mdev_unset_kvm(matrix_mdev);
-	else if (vfio_ap_mdev_set_kvm(matrix_mdev, data))
-		notify_rc = NOTIFY_DONE;
+	if (!data) {
+		if (matrix_mdev->kvm)
+			vfio_ap_mdev_unset_kvm(matrix_mdev);
+		goto notify_done;
+	}
 
-	mutex_unlock(&matrix_dev->lock);
+	ret = vfio_ap_mdev_set_kvm(matrix_mdev, data);
+	if (ret) {
+		notify_rc = NOTIFY_DONE;
+		goto notify_done;
+	}
 
+notify_done:
 	return notify_rc;
 }
 
@@ -1321,7 +1260,6 @@ static int vfio_ap_mdev_open(struct mdev_device *mdev)
 	unsigned long events;
 	int ret;
 
-
 	if (!try_module_get(THIS_MODULE))
 		return -ENODEV;
 
@@ -1352,14 +1290,13 @@ static void vfio_ap_mdev_release(struct mdev_device *mdev)
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
+
 	module_put(THIS_MODULE);
 }
 
@@ -1389,7 +1326,6 @@ static ssize_t vfio_ap_mdev_ioctl(struct mdev_device *mdev,
 	int ret;
 	struct ap_matrix_mdev *matrix_mdev;
 
-	mutex_lock(&matrix_dev->lock);
 	switch (cmd) {
 	case VFIO_DEVICE_GET_INFO:
 		ret = vfio_ap_mdev_get_device_info(arg);
@@ -1401,22 +1337,14 @@ static ssize_t vfio_ap_mdev_ioctl(struct mdev_device *mdev,
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
+		down_read(&matrix_mdev->rwsem);
 		ret = vfio_ap_mdev_reset_queues(mdev);
+		up_read(&matrix_mdev->rwsem);
 		break;
 	default:
 		ret = -EOPNOTSUPP;
 		break;
 	}
-	mutex_unlock(&matrix_dev->lock);
 
 	return ret;
 }
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index f82a6396acae..a163ac04ff8a 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -59,6 +59,8 @@ extern struct ap_matrix_dev *matrix_dev;
  * @aqm identifies the AP queues (domains) in the matrix
  * @adm_max: max domain number in @adm
  * @adm identifies the AP control domains in the matrix
+ * @rwsem: semaphore to ensure integrity when making changes to the @apm, @aqm
+ *	   and @adm while the guest's AP matrix is being updated.
  */
 struct ap_matrix {
 	unsigned long apm_max;
@@ -67,6 +69,7 @@ struct ap_matrix {
 	DECLARE_BITMAP(aqm, 256);
 	unsigned long adm_max;
 	DECLARE_BITMAP(adm, 256);
+	struct rw_semaphore rwsem;
 };
 
 /**
@@ -76,6 +79,8 @@ struct ap_matrix {
  *		mediated matrix device.
  * @group_notifier: notifier block used for specifying callback function for
  *		    handling the VFIO_GROUP_NOTIFY_SET_KVM event
+ * @rwsem	a semaphore to ensure integrity when making changes to the
+ *		structure's attribute values.
  * @kvm:	the struct holding guest's state
  */
 struct ap_matrix_mdev {
@@ -83,8 +88,7 @@ struct ap_matrix_mdev {
 	struct ap_matrix matrix;
 	struct notifier_block group_notifier;
 	struct notifier_block iommu_notifier;
-	bool kvm_busy;
-	wait_queue_head_t wait_for_kvm;
+	struct rw_semaphore rwsem;
 	struct kvm *kvm;
 	struct kvm_s390_module_hook pqap_hook;
 	struct mdev_device *mdev;
-- 
2.30.2

