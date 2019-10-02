Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:1406 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725852AbfJBH4s (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 2 Oct 2019 03:56:48 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x927qtGT135211
        for <linux-s390@vger.kernel.org>; Wed, 2 Oct 2019 03:56:46 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vcn1rmpdu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 02 Oct 2019 03:56:46 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Wed, 2 Oct 2019 08:56:44 +0100
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [PATCH] KVM: s390: Cleanup kvm_arch_init error path
Date: Wed,  2 Oct 2019 03:56:27 -0400
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20191002075627.3582-1-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, david@redhat.com

Both kvm_s390_gib_destroy and debug_unregister test if the needed
pointers are not NULL and hence can be called unconditionally.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 895fb2006c0d..66720d69cd24 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -458,16 +458,14 @@ static void kvm_s390_cpu_feat_init(void)
 
 int kvm_arch_init(void *opaque)
 {
-	int rc;
+	int rc = -ENOMEM;
 
 	kvm_s390_dbf = debug_register("kvm-trace", 32, 1, 7 * sizeof(long));
 	if (!kvm_s390_dbf)
 		return -ENOMEM;
 
-	if (debug_register_view(kvm_s390_dbf, &debug_sprintf_view)) {
-		rc = -ENOMEM;
-		goto out_debug_unreg;
-	}
+	if (debug_register_view(kvm_s390_dbf, &debug_sprintf_view))
+		goto out;
 
 	kvm_s390_cpu_feat_init();
 
@@ -475,19 +473,17 @@ int kvm_arch_init(void *opaque)
 	rc = kvm_register_device_ops(&kvm_flic_ops, KVM_DEV_TYPE_FLIC);
 	if (rc) {
 		pr_err("A FLIC registration call failed with rc=%d\n", rc);
-		goto out_debug_unreg;
+		goto out;
 	}
 
 	rc = kvm_s390_gib_init(GAL_ISC);
 	if (rc)
-		goto out_gib_destroy;
+		goto out;
 
 	return 0;
 
-out_gib_destroy:
-	kvm_s390_gib_destroy();
-out_debug_unreg:
-	debug_unregister(kvm_s390_dbf);
+out:
+	kvm_arch_exit();
 	return rc;
 }
 
-- 
2.20.1
