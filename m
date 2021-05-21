Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBBD1C4707F
	for <linux-s390@archiver.kernel.org>; Fri, 21 May 2021 19:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A44AC613D9
	for <linux-s390@archiver.kernel.org>; Fri, 21 May 2021 19:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239110AbhEUTiY (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 21 May 2021 15:38:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64344 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232214AbhEUTiW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 21 May 2021 15:38:22 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14LJXMJs068122;
        Fri, 21 May 2021 15:36:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Fmp38c63X1f5SaQ9vWdFMWavj+ityeNPYfwbcTIYb88=;
 b=H/xm2lTzXFocWhD42F749KNzGcupleYQ6rcDSou/vTX1WA+9OmsIcblEL6d1Q+AYUOJR
 LP+yyrfcyvZs+CK2BZwn+Ih4YboYNGVpzkQTyd6iIRM8zadSOZ159+RYXolUy/hH/vAs
 kl9FEaoVOGEkiJ8FG8cfYIdu2hwc0+GWbou32yNtTIwA/06IhEyoTHqVI44CBjrdlfgh
 A9L01CXrxNzI4AjwOMrDXrGJ9IKB7zK5jAs4Z1v4GlUenBoALSk5b7H/z4JlrGBt4JGN
 TUQOdSB/1B7aI4WyRcv0MzqXeVlXgkbwAPQAZHAZHgY6J57KxdhiRN6It2OwkDbPJAcg vw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38pjw1gasw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 May 2021 15:36:57 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14LJZd3l076819;
        Fri, 21 May 2021 15:36:57 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38pjw1gasp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 May 2021 15:36:57 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14LJa0Em013572;
        Fri, 21 May 2021 19:36:56 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma03dal.us.ibm.com with ESMTP id 38j5xaen44-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 May 2021 19:36:56 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14LJas1r33292738
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 19:36:55 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DDE476E052;
        Fri, 21 May 2021 19:36:54 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D90A6E04C;
        Fri, 21 May 2021 19:36:53 +0000 (GMT)
Received: from cpe-172-100-179-72.stny.res.rr.com (unknown [9.85.177.219])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 21 May 2021 19:36:53 +0000 (GMT)
From:   Tony Krowiak <akrowiak@linux.ibm.com>
To:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     borntraeger@de.ibm.com, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com, jgg@nvidia.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com
Subject: [PATCH v4 2/2] s390/vfio-ap: control access to PQAP(AQIC) interception handler
Date:   Fri, 21 May 2021 15:36:48 -0400
Message-Id: <20210521193648.940864-3-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210521193648.940864-1-akrowiak@linux.ibm.com>
References: <20210521193648.940864-1-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0CCahU1GVqt_PgEJzAm1SKIITG4vyJKL
X-Proofpoint-ORIG-GUID: ZG-y-4d3eGW9P3zQZwNQy1OPJCDzfaiT
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-21_09:2021-05-20,2021-05-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 malwarescore=0 impostorscore=0 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105210103
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The function pointer to the handler that processes interception of the
PQAP instruction is contained in the mdev. If the mdev is removed and
its storage de-allocated during the processing of the PQAP instruction,
the function pointer could get wiped out before the function is called
because there is currently nothing that controls access to it.

This patch introduces two new functions:
* The kvm_arch_crypto_register_hook() function registers a function pointer
  for processing intercepted crypto instructions.
* The kvm_arch_crypto_register_hook() function un-registers a function
  pointer that was previously registered.

Registration and unregistration of function pointers is protected by a
mutex lock. This lock is also employed when the hook is retrieved and the
hook function is called to protect against losing access to the function
while an intercepted crypto instruction is being processed.

The PQAP instruction handler function pointer is registered at the time
the vfio_ap module is loaded and unregistered when it is unloaded; so,
the lifespan of the function pointer is concurrent with the lifespan of
the vfio_ap module.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host.h      | 13 +++--
 arch/s390/kvm/priv.c                  | 70 +++++++++++++++++++++++++--
 drivers/s390/crypto/vfio_ap_ops.c     | 37 +++++++++++---
 drivers/s390/crypto/vfio_ap_private.h |  1 -
 4 files changed, 105 insertions(+), 16 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 8925f3969478..d59b9309a6b8 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -803,14 +803,19 @@ struct kvm_s390_cpu_model {
 	unsigned short ibc;
 };
 
-struct kvm_s390_module_hook {
-	int (*hook)(struct kvm_vcpu *vcpu);
+enum kvm_s390_crypto_hook_type {
+	PQAP_HOOK
+};
+
+struct kvm_s390_crypto_hook {
+	enum kvm_s390_crypto_hook_type type;
 	struct module *owner;
+	int (*hook_fcn)(struct kvm_vcpu *vcpu);
+	struct list_head node;
 };
 
 struct kvm_s390_crypto {
 	struct kvm_s390_crypto_cb *crycb;
-	struct kvm_s390_module_hook *pqap_hook;
 	__u32 crycbd;
 	__u8 aes_kw;
 	__u8 dea_kw;
@@ -996,6 +1001,8 @@ static inline void kvm_arch_async_page_present_queued(struct kvm_vcpu *vcpu) {}
 void kvm_arch_crypto_clear_masks(struct kvm *kvm);
 void kvm_arch_crypto_set_masks(struct kvm *kvm, unsigned long *apm,
 			       unsigned long *aqm, unsigned long *adm);
+extern int kvm_arch_crypto_register_hook(struct kvm_s390_crypto_hook *hook);
+extern int kvm_arch_crypto_unregister_hook(struct kvm_s390_crypto_hook *hook);
 
 extern int sie64a(struct kvm_s390_sie_block *, u64 *);
 extern char sie_exit;
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 9928f785c677..1221c04f6f6a 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -12,6 +12,7 @@
 #include <linux/gfp.h>
 #include <linux/errno.h>
 #include <linux/compat.h>
+#include <linux/list.h>
 #include <linux/mm_types.h>
 #include <linux/pgtable.h>
 
@@ -31,6 +32,63 @@
 #include "kvm-s390.h"
 #include "trace.h"
 
+DEFINE_MUTEX(crypto_hooks_lock);
+static struct list_head crypto_hooks = { &(crypto_hooks), &(crypto_hooks) };
+
+static struct kvm_s390_crypto_hook
+*kvm_arch_crypto_find_hook(enum kvm_s390_crypto_hook_type type)
+{
+	struct kvm_s390_crypto_hook *crypto_hook;
+
+	list_for_each_entry(crypto_hook, &crypto_hooks, node) {
+		if (crypto_hook->type == type)
+			return crypto_hook;
+	}
+
+	return NULL;
+}
+
+int kvm_arch_crypto_register_hook(struct kvm_s390_crypto_hook *hook)
+{
+	struct kvm_s390_crypto_hook *crypto_hook;
+
+	mutex_lock(&crypto_hooks_lock);
+	crypto_hook = kvm_arch_crypto_find_hook(hook->type);
+	if (crypto_hook) {
+		if (crypto_hook->owner != hook->owner)
+			return -EACCES;
+		list_replace(&crypto_hook->node, &hook->node);
+	} else {
+		list_add(&hook->node, &crypto_hooks);
+	}
+	mutex_unlock(&crypto_hooks_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(kvm_arch_crypto_register_hook);
+
+int kvm_arch_crypto_unregister_hook(struct kvm_s390_crypto_hook *hook)
+{
+	struct kvm_s390_crypto_hook *crypto_hook;
+
+	mutex_lock(&crypto_hooks_lock);
+	crypto_hook = kvm_arch_crypto_find_hook(hook->type);
+
+	if (crypto_hook) {
+		if (crypto_hook->owner != hook->owner)
+			return -EACCES;
+		if (crypto_hook->hook_fcn != hook->hook_fcn)
+			return -EFAULT;
+		list_del(&crypto_hook->node);
+	} else {
+		return -ENODEV;
+	}
+	mutex_unlock(&crypto_hooks_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(kvm_arch_crypto_unregister_hook);
+
 static int handle_ri(struct kvm_vcpu *vcpu)
 {
 	vcpu->stat.instruction_ri++;
@@ -610,6 +668,7 @@ static int handle_io_inst(struct kvm_vcpu *vcpu)
 static int handle_pqap(struct kvm_vcpu *vcpu)
 {
 	struct ap_queue_status status = {};
+	struct kvm_s390_crypto_hook *pqap_hook;
 	unsigned long reg0;
 	int ret;
 	uint8_t fc;
@@ -657,15 +716,16 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
 	 * Verify that the hook callback is registered, lock the owner
 	 * and call the hook.
 	 */
-	if (vcpu->kvm->arch.crypto.pqap_hook) {
-		if (!try_module_get(vcpu->kvm->arch.crypto.pqap_hook->owner))
-			return -EOPNOTSUPP;
-		ret = vcpu->kvm->arch.crypto.pqap_hook->hook(vcpu);
-		module_put(vcpu->kvm->arch.crypto.pqap_hook->owner);
+	mutex_lock(&crypto_hooks_lock);
+	pqap_hook = kvm_arch_crypto_find_hook(PQAP_HOOK);
+	if (pqap_hook) {
+		ret = pqap_hook->hook_fcn(vcpu);
 		if (!ret && vcpu->run->s.regs.gprs[1] & 0x00ff0000)
 			kvm_s390_set_psw_cc(vcpu, 3);
+		mutex_unlock(&crypto_hooks_lock);
 		return ret;
 	}
+	mutex_unlock(&crypto_hooks_lock);
 	/*
 	 * A vfio_driver must register a hook.
 	 * No hook means no driver to enable the SIE CRYCB and no queues.
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index f90c9103dac2..3466ceffc46a 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -64,6 +64,21 @@ static struct vfio_ap_queue *vfio_ap_get_queue(
 	return q;
 }
 
+static struct ap_matrix_mdev *vfio_ap_find_mdev_for_apqn(int apqn)
+{
+	struct ap_matrix_mdev *matrix_mdev;
+	unsigned long apid = AP_QID_CARD(apqn);
+	unsigned long apqi = AP_QID_QUEUE(apqn);
+
+	list_for_each_entry(matrix_mdev, &matrix_dev->mdev_list, node) {
+		if (test_bit_inv(apid, matrix_mdev->matrix.apm) &&
+		    test_bit_inv(apqi, matrix_mdev->matrix.aqm))
+			return matrix_mdev;
+	}
+
+	return NULL;
+}
+
 /**
  * vfio_ap_wait_for_irqclear
  * @apqn: The AP Queue number
@@ -287,13 +302,13 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
 	if (!(vcpu->arch.sie_block->eca & ECA_AIV))
 		return -EOPNOTSUPP;
 
+
 	apqn = vcpu->run->s.regs.gprs[0] & 0xffff;
 	mutex_lock(&matrix_dev->lock);
 
-	if (!vcpu->kvm->arch.crypto.pqap_hook)
+	matrix_mdev = vfio_ap_find_mdev_for_apqn(apqn);
+	if (!matrix_mdev)
 		goto out_unlock;
-	matrix_mdev = container_of(vcpu->kvm->arch.crypto.pqap_hook,
-				   struct ap_matrix_mdev, pqap_hook);
 
 	/*
 	 * If the KVM pointer is in the process of being set, wait until the
@@ -353,8 +368,6 @@ static int vfio_ap_mdev_create(struct mdev_device *mdev)
 	vfio_ap_matrix_init(&matrix_dev->info, &matrix_mdev->matrix);
 	init_waitqueue_head(&matrix_mdev->wait_for_kvm);
 	mdev_set_drvdata(mdev, matrix_mdev);
-	matrix_mdev->pqap_hook.hook = handle_pqap;
-	matrix_mdev->pqap_hook.owner = THIS_MODULE;
 	mutex_lock(&matrix_dev->lock);
 	list_add(&matrix_mdev->node, &matrix_dev->mdev_list);
 	mutex_unlock(&matrix_dev->lock);
@@ -1123,7 +1136,6 @@ static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev,
 					  matrix_mdev->matrix.aqm,
 					  matrix_mdev->matrix.adm);
 		mutex_lock(&matrix_dev->lock);
-		kvm->arch.crypto.pqap_hook = &matrix_mdev->pqap_hook;
 		matrix_mdev->kvm = kvm;
 		matrix_mdev->kvm_busy = false;
 		wake_up_all(&matrix_mdev->wait_for_kvm);
@@ -1193,7 +1205,6 @@ static void vfio_ap_mdev_unset_kvm(struct ap_matrix_mdev *matrix_mdev)
 		kvm_arch_crypto_clear_masks(matrix_mdev->kvm);
 		mutex_lock(&matrix_dev->lock);
 		vfio_ap_mdev_reset_queues(matrix_mdev->mdev);
-		matrix_mdev->kvm->arch.crypto.pqap_hook = NULL;
 		kvm_put_kvm(matrix_mdev->kvm);
 		matrix_mdev->kvm = NULL;
 		matrix_mdev->kvm_busy = false;
@@ -1433,14 +1444,26 @@ static const struct mdev_parent_ops vfio_ap_matrix_ops = {
 	.ioctl			= vfio_ap_mdev_ioctl,
 };
 
+static struct kvm_s390_crypto_hook pqap_hook = {
+	.type = PQAP_HOOK,
+	.owner = THIS_MODULE,
+	.hook_fcn = handle_pqap
+};
+
 int vfio_ap_mdev_register(void)
 {
+	int ret;
 	atomic_set(&matrix_dev->available_instances, MAX_ZDEV_ENTRIES_EXT);
 
+	ret = kvm_arch_crypto_register_hook(&pqap_hook);
+	if (ret)
+		return ret;
+
 	return mdev_register_device(&matrix_dev->device, &vfio_ap_matrix_ops);
 }
 
 void vfio_ap_mdev_unregister(void)
 {
+	WARN_ON(kvm_arch_crypto_unregister_hook(&pqap_hook));
 	mdev_unregister_device(&matrix_dev->device);
 }
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index f82a6396acae..542259b57972 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -86,7 +86,6 @@ struct ap_matrix_mdev {
 	bool kvm_busy;
 	wait_queue_head_t wait_for_kvm;
 	struct kvm *kvm;
-	struct kvm_s390_module_hook pqap_hook;
 	struct mdev_device *mdev;
 };
 
-- 
2.30.2

