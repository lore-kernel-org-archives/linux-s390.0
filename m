Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B9DC48BCF
	for <linux-s390@archiver.kernel.org>; Wed,  9 Jun 2021 22:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FF94613CB
	for <linux-s390@archiver.kernel.org>; Wed,  9 Jun 2021 22:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbhFIWsu (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 9 Jun 2021 18:48:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:14966 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229534AbhFIWsr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 9 Jun 2021 18:48:47 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 159MYpGB193419;
        Wed, 9 Jun 2021 18:46:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=DUWGTenahoe88ph+YYFrFLf4JQdzXRWAsBnG4l62zu0=;
 b=ZpHkYA9iWD/KCKm5cu/frgAArcOCwp+D2LmA0grUUlaB9zabYCsWYI5sStoevCJG9O66
 LGMbX6K6iKF3rFY2d110ktwTu90mX18vLKFOmgAqQ3kFTXLyO7mfreHsXUnqbu6m5A0y
 YN3doABO4yJOdMDeqhnuezMucg6BNm41jn4MgxNsIpaY3qmm4kwv5hlm1HSJSzuCNN1B
 GSTRVhxBG4faHxAILyqapZ6sJcbTZaa4H1g928vZ+tvF6m9Jz2//v+HHVrWy2WaRVC7+
 /xlwT+vDYIN0k6sA7XE0NSepenI8z9nhejTl13Fk1scRK4FY/nVKSiGXBRwdNB5H3Pni WQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39368e8k2b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Jun 2021 18:46:51 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 159MZ9sP193851;
        Wed, 9 Jun 2021 18:46:51 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39368e8k23-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Jun 2021 18:46:51 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 159Mh04q007255;
        Wed, 9 Jun 2021 22:46:49 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma05wdc.us.ibm.com with ESMTP id 3900w9ubjq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Jun 2021 22:46:49 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 159MkmEf29098466
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Jun 2021 22:46:48 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 97B50C6059;
        Wed,  9 Jun 2021 22:46:48 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 788B0C6055;
        Wed,  9 Jun 2021 22:46:46 +0000 (GMT)
Received: from cpe-172-100-179-72.stny.res.rr.com (unknown [9.85.129.35])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  9 Jun 2021 22:46:46 +0000 (GMT)
From:   Tony Krowiak <akrowiak@linux.ibm.com>
To:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     borntraeger@de.ibm.com, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com, jgg@nvidia.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com
Subject: [PATCH 3/3] s390/vfio-ap: r/w lock for PQAP interception handler function pointer
Date:   Wed,  9 Jun 2021 18:46:34 -0400
Message-Id: <20210609224634.575156-4-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210609224634.575156-1-akrowiak@linux.ibm.com>
References: <20210609224634.575156-1-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: u4ou6AY5cwi8jkju6FUhdRiRTlDjfbI8
X-Proofpoint-GUID: acqgHt_nDl9ZmPl4Sqs_aJKl31HFfVKh
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-09_07:2021-06-04,2021-06-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=980
 impostorscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 mlxscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106090120
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
---
 arch/s390/include/asm/kvm_host.h      |  6 +++---
 arch/s390/kvm/kvm-s390.c              |  1 +
 arch/s390/kvm/priv.c                  |  6 +++---
 drivers/s390/crypto/vfio_ap_ops.c     | 14 ++++++++++----
 drivers/s390/crypto/vfio_ap_private.h |  2 +-
 5 files changed, 18 insertions(+), 11 deletions(-)

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
index d65a5728153b..2998c1b53ab9 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -342,7 +342,6 @@ static int vfio_ap_mdev_create(struct mdev_device *mdev)
 	init_rwsem(&matrix_mdev->rwsem);
 	mdev_set_drvdata(mdev, matrix_mdev);
 	matrix_mdev->pqap_hook.hook = handle_pqap;
-	matrix_mdev->pqap_hook.owner = THIS_MODULE;
 
 	mutex_lock(&matrix_dev->lock);
 	list_add(&matrix_mdev->node, &matrix_dev->mdev_list);
@@ -1063,7 +1062,6 @@ static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev,
 	down_write(&matrix_mdev->rwsem);
 	matrix_mdev->kvm = kvm;
 	kvm_get_kvm(kvm);
-	kvm->arch.crypto.pqap_hook = &matrix_mdev->pqap_hook;
 	up_write(&matrix_mdev->rwsem);
 
 	/*
@@ -1071,6 +1069,10 @@ static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev,
 	 * masks for the KVM guest
 	 */
 	if (kvm->arch.crypto.crycbd) {
+		down_write(&matrix_mdev->kvm->arch.crypto.pqap_hook_rwsem);
+		kvm->arch.crypto.pqap_hook = &matrix_mdev->pqap_hook;
+		up_write(&matrix_mdev->kvm->arch.crypto.pqap_hook_rwsem);
+
 		down_read(&matrix_mdev->matrix.rwsem);
 		kvm_arch_crypto_set_masks(kvm,
 					  matrix_mdev->matrix.apm,
@@ -1122,11 +1124,15 @@ static int vfio_ap_mdev_iommu_notifier(struct notifier_block *nb,
 static void vfio_ap_mdev_unset_kvm(struct ap_matrix_mdev *matrix_mdev)
 {
 	if (matrix_mdev->kvm) {
-		if (matrix_mdev->kvm->arch.crypto.crycbd)
+		if (matrix_mdev->kvm->arch.crypto.crycbd) {
+			down_write(&matrix_mdev->kvm->arch.crypto.pqap_hook_rwsem);
+			matrix_mdev->kvm->arch.crypto.pqap_hook = NULL;
+			up_write(&matrix_mdev->kvm->arch.crypto.pqap_hook_rwsem);
+
 			kvm_arch_crypto_clear_masks(matrix_mdev->kvm);
+		}
 
 		down_write(&matrix_mdev->rwsem);
-		matrix_mdev->kvm->arch.crypto.pqap_hook = NULL;
 		vfio_ap_mdev_reset_queues(matrix_mdev->mdev);
 		kvm_put_kvm(matrix_mdev->kvm);
 		matrix_mdev->kvm = NULL;
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index a163ac04ff8a..3d6afd0faaaf 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -90,7 +90,7 @@ struct ap_matrix_mdev {
 	struct notifier_block iommu_notifier;
 	struct rw_semaphore rwsem;
 	struct kvm *kvm;
-	struct kvm_s390_module_hook pqap_hook;
+	struct kvm_s390_crypto_hook pqap_hook;
 	struct mdev_device *mdev;
 };
 
-- 
2.30.2

