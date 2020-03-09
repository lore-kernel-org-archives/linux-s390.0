Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47338 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726528AbgCIIvh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 9 Mar 2020 04:51:37 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0298pAlf071404
        for <linux-s390@vger.kernel.org>; Mon, 9 Mar 2020 04:51:36 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ym91dmfb1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 09 Mar 2020 04:51:35 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 9 Mar 2020 08:51:33 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 07/36] KVM: s390: protvirt: Add UV debug trace
Date: Mon,  9 Mar 2020 09:50:57 +0100
In-Reply-To: <20200309085126.3334302-1-borntraeger@de.ibm.com>
References: <20200309085126.3334302-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200309085126.3334302-8-borntraeger@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Ulrich Weigand <uweigand@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>

From: Janosch Frank <frankja@linux.ibm.com>

Let's have some debug traces which stay around for longer than the
guest.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
[borntraeger@de.ibm.com: patch merging, splitting, fixing]
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 11 +++++++++--
 arch/s390/kvm/kvm-s390.h | 13 ++++++++++++-
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index d7ff30e45589..7e4a982bfea3 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2,7 +2,7 @@
 /*
  * hosting IBM Z kernel virtual machines (s390x)
  *
- * Copyright IBM Corp. 2008, 2018
+ * Copyright IBM Corp. 2008, 2020
  *
  *    Author(s): Carsten Otte <cotte@de.ibm.com>
  *               Christian Borntraeger <borntraeger@de.ibm.com>
@@ -220,6 +220,7 @@ static struct kvm_s390_vm_cpu_subfunc kvm_s390_available_subfunc;
 static struct gmap_notifier gmap_notifier;
 static struct gmap_notifier vsie_gmap_notifier;
 debug_info_t *kvm_s390_dbf;
+debug_info_t *kvm_s390_dbf_uv;
 
 /* Section: not file related */
 int kvm_arch_hardware_enable(void)
@@ -460,7 +461,12 @@ int kvm_arch_init(void *opaque)
 	if (!kvm_s390_dbf)
 		return -ENOMEM;
 
-	if (debug_register_view(kvm_s390_dbf, &debug_sprintf_view))
+	kvm_s390_dbf_uv = debug_register("kvm-uv", 32, 1, 7 * sizeof(long));
+	if (!kvm_s390_dbf_uv)
+		goto out;
+
+	if (debug_register_view(kvm_s390_dbf, &debug_sprintf_view) ||
+	    debug_register_view(kvm_s390_dbf_uv, &debug_sprintf_view))
 		goto out;
 
 	kvm_s390_cpu_feat_init();
@@ -487,6 +493,7 @@ void kvm_arch_exit(void)
 {
 	kvm_s390_gib_destroy();
 	debug_unregister(kvm_s390_dbf);
+	debug_unregister(kvm_s390_dbf_uv);
 }
 
 /* Section: device related */
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 6d9448dbd052..be55b4b99bd3 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -2,7 +2,7 @@
 /*
  * definition for kvm on s390
  *
- * Copyright IBM Corp. 2008, 2009
+ * Copyright IBM Corp. 2008, 2020
  *
  *    Author(s): Carsten Otte <cotte@de.ibm.com>
  *               Christian Borntraeger <borntraeger@de.ibm.com>
@@ -25,6 +25,17 @@
 #define IS_ITDB_VALID(vcpu)	((*(char *)vcpu->arch.sie_block->itdba == TDB_FORMAT1))
 
 extern debug_info_t *kvm_s390_dbf;
+extern debug_info_t *kvm_s390_dbf_uv;
+
+#define KVM_UV_EVENT(d_kvm, d_loglevel, d_string, d_args...)\
+do { \
+	debug_sprintf_event((d_kvm)->arch.dbf, d_loglevel, d_string "\n", \
+	  d_args); \
+	debug_sprintf_event(kvm_s390_dbf_uv, d_loglevel, \
+			    "%d: " d_string "\n", (d_kvm)->userspace_pid, \
+			    d_args); \
+} while (0)
+
 #define KVM_EVENT(d_loglevel, d_string, d_args...)\
 do { \
 	debug_sprintf_event(kvm_s390_dbf, d_loglevel, d_string "\n", \
-- 
2.24.1
