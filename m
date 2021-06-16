Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DD3C48BE8
	for <linux-s390@archiver.kernel.org>; Wed, 16 Jun 2021 14:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11EA460200
	for <linux-s390@archiver.kernel.org>; Wed, 16 Jun 2021 14:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbhFPOSa (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 16 Jun 2021 10:18:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32044 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232694AbhFPOSa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 16 Jun 2021 10:18:30 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15GE3hAA115193;
        Wed, 16 Jun 2021 10:16:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=RW2GbZF3syhiO8+9u7tJawwRETYPJ/hp0GJjpm5DuI0=;
 b=qtlQYfDCznJ46f9IeFnPtQV5TeIVH+lBXJErrgsZUgLAzK/oXT+kmjFJLoSBanVy3zuT
 0yhJ0NkHHGWWIqhY0Ty0w+B0em6bTJ9MfO+s63peJQ+a+aOvM2C3ecmFrTlks7KfNIdP
 fyQA1tKijkQXwZyc1+6VZcRY1xIW5fRXCEP6nZPZZp7u6nQCfuFyOLsnPG6xVu0zbsLS
 1zP28SNUR4VEzCg9aU6U3cv/TJAbATkRDX/LmTrvpwB1eaWs4s7Yb0XH0VQMHE5bj0yE
 WqtxEFr8M+zuXoMQNVk9N+a3m0NtRuUl3seZ/cyTgchsdt4R0PyQ/HsMGRcm5L6d3xWU Jg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 397hdy3h3v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Jun 2021 10:16:22 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15GE4vAK128442;
        Wed, 16 Jun 2021 10:16:22 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 397hdy3h36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Jun 2021 10:16:22 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15GECABx016445;
        Wed, 16 Jun 2021 14:16:21 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma02dal.us.ibm.com with ESMTP id 394mja10xg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Jun 2021 14:16:21 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15GEGKoL25493934
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jun 2021 14:16:21 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C33FC28060;
        Wed, 16 Jun 2021 14:16:20 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5046428058;
        Wed, 16 Jun 2021 14:16:20 +0000 (GMT)
Received: from cpe-172-100-179-72.stny.res.rr.com (unknown [9.85.128.252])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 16 Jun 2021 14:16:20 +0000 (GMT)
From:   Tony Krowiak <akrowiak@linux.ibm.com>
To:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     borntraeger@de.ibm.com, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com, jgg@nvidia.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com
Subject: [PATCH v5 2/2] s390/vfio-ap: r/w lock for PQAP interception handler function pointer
Date:   Wed, 16 Jun 2021 10:16:18 -0400
Message-Id: <20210616141618.938494-3-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210616141618.938494-1-akrowiak@linux.ibm.com>
References: <20210616141618.938494-1-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8QupOTHGevn8aNTZY50XrAg2UC5m-bFt
X-Proofpoint-ORIG-GUID: hpbwI44RdZWjMdwkLTkjQH3dNi4gV6Y7
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-16_07:2021-06-15,2021-06-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 spamscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106160082
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The function pointer to the interception handler for the PQAP instruction
can get changed during the interception process. Let's add a
semaphore to struct kvm_s390_crypto to control read/write access to the
function pointer contained therein.

The semaphore must be locked for write access by the vfio_ap device driver
when notified that the KVM pointer has been set or cleared. It must be
locked for read access by the interception framework when the PQAP
instruction is intercepted.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 arch/s390/include/asm/kvm_host.h      |  6 +++---
 arch/s390/kvm/kvm-s390.c              |  1 +
 arch/s390/kvm/priv.c                  |  6 +++---
 drivers/s390/crypto/vfio_ap_ops.c     | 21 ++++++++++++++++-----
 drivers/s390/crypto/vfio_ap_private.h |  2 +-
 5 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 8925f3969478..58edaa3f9602 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -803,14 +803,14 @@ struct kvm_s390_cpu_model {
 	unsigned short ibc;
 };
 
-struct kvm_s390_module_hook {
+struct kvm_s390_crypto_hook {
 	int (*hook)(struct kvm_vcpu *vcpu);
-	struct module *owner;
 };
 
 struct kvm_s390_crypto {
 	struct kvm_s390_crypto_cb *crycb;
-	struct kvm_s390_module_hook *pqap_hook;
+	struct rw_semaphore pqap_hook_rwsem;
+	struct kvm_s390_crypto_hook *pqap_hook;
 	__u32 crycbd;
 	__u8 aes_kw;
 	__u8 dea_kw;
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 1296fc10f80c..418d910df569 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2606,6 +2606,7 @@ static void kvm_s390_crypto_init(struct kvm *kvm)
 {
 	kvm->arch.crypto.crycb = &kvm->arch.sie_page2->crycb;
 	kvm_s390_set_crycb_format(kvm);
+	init_rwsem(&kvm->arch.crypto.pqap_hook_rwsem);
 
 	if (!test_kvm_facility(kvm, 76))
 		return;
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 9928f785c677..bbbd84ffe239 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -657,15 +657,15 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
 	 * Verify that the hook callback is registered, lock the owner
 	 * and call the hook.
 	 */
+	down_read(&vcpu->kvm->arch.crypto.pqap_hook_rwsem);
 	if (vcpu->kvm->arch.crypto.pqap_hook) {
-		if (!try_module_get(vcpu->kvm->arch.crypto.pqap_hook->owner))
-			return -EOPNOTSUPP;
 		ret = vcpu->kvm->arch.crypto.pqap_hook->hook(vcpu);
-		module_put(vcpu->kvm->arch.crypto.pqap_hook->owner);
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
index 122c85c22469..d8abe5a11e49 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -353,7 +353,6 @@ static int vfio_ap_mdev_create(struct mdev_device *mdev)
 	init_waitqueue_head(&matrix_mdev->wait_for_kvm);
 	mdev_set_drvdata(mdev, matrix_mdev);
 	matrix_mdev->pqap_hook.hook = handle_pqap;
-	matrix_mdev->pqap_hook.owner = THIS_MODULE;
 	mutex_lock(&matrix_dev->lock);
 	list_add(&matrix_mdev->node, &matrix_dev->mdev_list);
 	mutex_unlock(&matrix_dev->lock);
@@ -1115,15 +1114,20 @@ static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev,
 		}
 
 		kvm_get_kvm(kvm);
+		matrix_mdev->kvm = kvm;
 		matrix_mdev->kvm_busy = true;
 		mutex_unlock(&matrix_dev->lock);
+
+		down_write(&matrix_mdev->kvm->arch.crypto.pqap_hook_rwsem);
+		kvm->arch.crypto.pqap_hook = &matrix_mdev->pqap_hook;
+		up_write(&matrix_mdev->kvm->arch.crypto.pqap_hook_rwsem);
+
 		kvm_arch_crypto_set_masks(kvm,
 					  matrix_mdev->matrix.apm,
 					  matrix_mdev->matrix.aqm,
 					  matrix_mdev->matrix.adm);
+
 		mutex_lock(&matrix_dev->lock);
-		kvm->arch.crypto.pqap_hook = &matrix_mdev->pqap_hook;
-		matrix_mdev->kvm = kvm;
 		matrix_mdev->kvm_busy = false;
 		wake_up_all(&matrix_mdev->wait_for_kvm);
 	}
@@ -1189,10 +1193,17 @@ static void vfio_ap_mdev_unset_kvm(struct ap_matrix_mdev *matrix_mdev)
 	if (matrix_mdev->kvm) {
 		matrix_mdev->kvm_busy = true;
 		mutex_unlock(&matrix_dev->lock);
-		kvm_arch_crypto_clear_masks(matrix_mdev->kvm);
+
+		if (matrix_mdev->kvm->arch.crypto.crycbd) {
+			down_write(&matrix_mdev->kvm->arch.crypto.pqap_hook_rwsem);
+			matrix_mdev->kvm->arch.crypto.pqap_hook = NULL;
+			up_write(&matrix_mdev->kvm->arch.crypto.pqap_hook_rwsem);
+
+			kvm_arch_crypto_clear_masks(matrix_mdev->kvm);
+		}
+
 		mutex_lock(&matrix_dev->lock);
 		vfio_ap_mdev_reset_queues(matrix_mdev->mdev);
-		matrix_mdev->kvm->arch.crypto.pqap_hook = NULL;
 		kvm_put_kvm(matrix_mdev->kvm);
 		matrix_mdev->kvm = NULL;
 		matrix_mdev->kvm_busy = false;
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index f82a6396acae..5d4fe6efbc73 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -86,7 +86,7 @@ struct ap_matrix_mdev {
 	bool kvm_busy;
 	wait_queue_head_t wait_for_kvm;
 	struct kvm *kvm;
-	struct kvm_s390_module_hook pqap_hook;
+	struct kvm_s390_crypto_hook pqap_hook;
 	struct mdev_device *mdev;
 };
 
-- 
2.30.2

