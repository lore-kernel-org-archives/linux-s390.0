Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61020 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727445AbfKMOCJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 13 Nov 2019 09:02:09 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xADDx6fk129933
        for <linux-s390@vger.kernel.org>; Wed, 13 Nov 2019 09:02:05 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2w8hk24nu3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 13 Nov 2019 09:02:04 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Wed, 13 Nov 2019 14:02:01 -0000
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [PATCH] Fix unpack
Date: Wed, 13 Nov 2019 09:03:06 -0500
In-Reply-To: <07705597-8e8f-28d4-f9a1-d3d5dc9a4555@redhat.com>
References: <07705597-8e8f-28d4-f9a1-d3d5dc9a4555@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20191113140306.2952-1-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com

That should be easier to read :)

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/kvm/pv.c | 60 +++++++++++++++++++++++++++-------------------
 1 file changed, 35 insertions(+), 25 deletions(-)

diff --git a/arch/s390/kvm/pv.c b/arch/s390/kvm/pv.c
index 94cf16f40f25..fd73afb33b20 100644
--- a/arch/s390/kvm/pv.c
+++ b/arch/s390/kvm/pv.c
@@ -195,43 +195,53 @@ int kvm_s390_pv_set_sec_parms(struct kvm *kvm,
 	return 0;
 }
 
-int kvm_s390_pv_unpack(struct kvm *kvm, unsigned long addr, unsigned long size,
-		       unsigned long tweak)
+static int unpack_one(struct kvm *kvm, unsigned long addr, u64 tweak[2])
 {
-	int i, rc = 0;
+	int rc;
 	struct uv_cb_unp uvcb = {
 		.header.cmd = UVC_CMD_UNPACK_IMG,
 		.header.len = sizeof(uvcb),
 		.guest_handle = kvm_s390_pv_handle(kvm),
-		.tweak[0] = tweak
+		.gaddr = addr,
+		.tweak[0] = tweak[0],
+		.tweak[1] = tweak[1],
 	};
 
-	if (addr & ~PAGE_MASK || size & ~PAGE_MASK)
-		return -EINVAL;
+	rc = uv_call(0, (u64)&uvcb);
+	if (!rc)
+		return rc;
+	if (uvcb.header.rc == 0x10a) {
+		/* If not yet mapped fault and retry */
+		rc = gmap_fault(kvm->arch.gmap, uvcb.gaddr,
+				FAULT_FLAG_WRITE);
+		if (!rc)
+			return -EAGAIN;
+	}
+	VM_EVENT(kvm, 3, "PROTVIRT VM UNPACK: failed addr %llx rc %x rrc %x",
+		 uvcb.gaddr, uvcb.header.rc, uvcb.header.rrc);
+	return rc;
+}
 
+int kvm_s390_pv_unpack(struct kvm *kvm, unsigned long addr, unsigned long size,
+		       unsigned long tweak)
+{
+	int rc = 0;
+	u64 tw[2] = {tweak, 0};
+
+	if (addr & ~PAGE_MASK || !size || size & ~PAGE_MASK)
+		return -EINVAL;
 
 	VM_EVENT(kvm, 3, "PROTVIRT VM UNPACK: start addr %lx size %lx",
 		 addr, size);
-	for (i = 0; i < size / PAGE_SIZE; i++) {
-		uvcb.gaddr = addr + i * PAGE_SIZE;
-		uvcb.tweak[1] = i * PAGE_SIZE;
-retry:
-		rc = uv_call(0, (u64)&uvcb);
-		if (!rc)
+	while (tw[1] < size) {
+		rc = unpack_one(kvm, addr, tw);
+		if (rc == -EAGAIN)
 			continue;
-		/* If not yet mapped fault and retry */
-		if (uvcb.header.rc == 0x10a) {
-			rc = gmap_fault(kvm->arch.gmap, uvcb.gaddr,
-					FAULT_FLAG_WRITE);
-			if (rc)
-				return rc;
-			goto retry;
-		}
-		VM_EVENT(kvm, 3, "PROTVIRT VM UNPACK: failed addr %llx rc %x rrc %x",
-			 uvcb.gaddr, uvcb.header.rc, uvcb.header.rrc);
-		break;
+		if (rc)
+			break;
+		addr += PAGE_SIZE;
+		tw[1] += PAGE_SIZE;
 	}
-	VM_EVENT(kvm, 3, "PROTVIRT VM UNPACK: finished with rc %x rrc %x",
-		 uvcb.header.rc, uvcb.header.rrc);
+	VM_EVENT(kvm, 3, "PROTVIRT VM UNPACK: finished rc %x", rc);
 	return rc;
 }
-- 
2.20.1
