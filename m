Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164DEC07E9B
	for <linux-s390@archiver.kernel.org>; Mon, 19 Jul 2021 23:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC5326113E
	for <linux-s390@archiver.kernel.org>; Mon, 19 Jul 2021 23:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345509AbhGSWgA (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 19 Jul 2021 18:36:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27042 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1357645AbhGSSyx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 19 Jul 2021 14:54:53 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16JJXHd2011656;
        Mon, 19 Jul 2021 15:35:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=eM5L9+wo+Q5LbOP9+C6/CbBBiG8ffEjHnJM6A3xBHGE=;
 b=JrPfq9nMIZvehrS24qQCfi6RDhRKMya3Nka39iLxLSuUdemgkmXyGjwaQ7rJ+4sT05gF
 w5owq04PS4CIyJD8bAUEXS5vHOOBlbXZQCfgquJRou6lm0srBQaVSWi1P1R9wf6ANs81
 jqVaQ7ikPz3w+Ec2WQQOLiQwnO8R4ONXBYd19wW4/Q/wbjsArF7rumazi1MiSVx3d/jN
 07u4sg25mAweoJiuLadpKjVDlZUzOpwQGnfqYU54MrVRzjbJlm8zEpNZiV64+eVUF5V4
 ol1XhkNjoit4N/UDmGY+ui42SXg83bBKlhH2WZg90F03HBYMdZv6EDTQSmY5nxJ9dDor kg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39w8yb74b1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jul 2021 15:35:08 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16JJXg2o013010;
        Mon, 19 Jul 2021 15:35:08 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39w8yb74a8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jul 2021 15:35:08 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16JJROMS030502;
        Mon, 19 Jul 2021 19:35:06 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma03wdc.us.ibm.com with ESMTP id 39vqdts8pk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jul 2021 19:35:06 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16JJZ64S16843164
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Jul 2021 19:35:06 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6EE82112062;
        Mon, 19 Jul 2021 19:35:06 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5BD15112065;
        Mon, 19 Jul 2021 19:35:05 +0000 (GMT)
Received: from fedora.ibmuc.com (unknown [9.85.184.30])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 19 Jul 2021 19:35:05 +0000 (GMT)
From:   Tony Krowiak <akrowiak@linux.ibm.com>
To:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     borntraeger@de.ibm.com, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com, jgg@nvidia.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com, david@redhat.com
Subject: [PATCH 1/2] s390/vfio-ap: r/w lock for PQAP interception handler function pointer
Date:   Mon, 19 Jul 2021 15:35:02 -0400
Message-Id: <20210719193503.793910-2-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210719193503.793910-1-akrowiak@linux.ibm.com>
References: <20210719193503.793910-1-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VVdmu4Q9vy7I4EOzGeFSrIr1sjp3tSsm
X-Proofpoint-ORIG-GUID: eCQ9j720jpR7hF15tWSW-GfmvzGQhBsg
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-19_09:2021-07-19,2021-07-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0
 clxscore=1015 adultscore=0 mlxscore=0 spamscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107190111
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
 arch/s390/include/asm/kvm_host.h      |  8 +++-----
 arch/s390/kvm/kvm-s390.c              |  1 +
 arch/s390/kvm/priv.c                  | 10 ++++++----
 drivers/s390/crypto/vfio_ap_ops.c     | 23 +++++++++++++++++------
 drivers/s390/crypto/vfio_ap_private.h |  2 +-
 5 files changed, 28 insertions(+), 16 deletions(-)

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
index b655a7d82bf0..a08f242a9f27 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2630,6 +2630,7 @@ static void kvm_s390_crypto_init(struct kvm *kvm)
 {
 	kvm->arch.crypto.crycb = &kvm->arch.sie_page2->crycb;
 	kvm_s390_set_crycb_format(kvm);
+	init_rwsem(&kvm->arch.crypto.pqap_hook_rwsem);
 
 	if (!test_kvm_facility(kvm, 76))
 		return;
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 9928f785c677..6bed9406c1f3 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -610,6 +610,7 @@ static int handle_io_inst(struct kvm_vcpu *vcpu)
 static int handle_pqap(struct kvm_vcpu *vcpu)
 {
 	struct ap_queue_status status = {};
+	crypto_hook pqap_hook;
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
+		pqap_hook = *vcpu->kvm->arch.crypto.pqap_hook;
+		ret = pqap_hook(vcpu);
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
index 122c85c22469..742277bc8d1c 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -352,8 +352,7 @@ static int vfio_ap_mdev_create(struct mdev_device *mdev)
 	vfio_ap_matrix_init(&matrix_dev->info, &matrix_mdev->matrix);
 	init_waitqueue_head(&matrix_mdev->wait_for_kvm);
 	mdev_set_drvdata(mdev, matrix_mdev);
-	matrix_mdev->pqap_hook.hook = handle_pqap;
-	matrix_mdev->pqap_hook.owner = THIS_MODULE;
+	matrix_mdev->pqap_hook = handle_pqap;
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
index f82a6396acae..e12218e5a629 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -86,7 +86,7 @@ struct ap_matrix_mdev {
 	bool kvm_busy;
 	wait_queue_head_t wait_for_kvm;
 	struct kvm *kvm;
-	struct kvm_s390_module_hook pqap_hook;
+	crypto_hook pqap_hook;
 	struct mdev_device *mdev;
 };
 
-- 
2.30.2

