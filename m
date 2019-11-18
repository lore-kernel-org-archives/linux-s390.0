Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38410 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726626AbfKRIgL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 18 Nov 2019 03:36:11 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAI8WvD3113192
        for <linux-s390@vger.kernel.org>; Mon, 18 Nov 2019 03:36:10 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wayafu4gm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 18 Nov 2019 03:36:09 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 18 Nov 2019 08:36:08 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 2/5] KVM: s390: Cleanup kvm_arch_init error path
Date: Mon, 18 Nov 2019 09:35:59 +0100
In-Reply-To: <20191118083602.15835-1-borntraeger@de.ibm.com>
References: <20191118083602.15835-1-borntraeger@de.ibm.com>
Message-Id: <20191118083602.15835-3-borntraeger@de.ibm.com>
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>

From: Janosch Frank <frankja@linux.ibm.com>

Both kvm_s390_gib_destroy and debug_unregister test if the needed
pointers are not NULL and hence can be called unconditionally.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Link: https://lore.kernel.org/kvm/20191002075627.3582-1-frankja@linux.ibm.com
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index f6db0f1bc867..40af442b2e15 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -453,16 +453,14 @@ static void kvm_s390_cpu_feat_init(void)
 
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
 
@@ -470,19 +468,17 @@ int kvm_arch_init(void *opaque)
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
2.21.0
