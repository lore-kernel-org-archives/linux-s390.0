Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27980 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727833AbgBNW1Q (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 14 Feb 2020 17:27:16 -0500
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH v2 08/42] KVM: s390: add new variants of UV CALL
Date: Fri, 14 Feb 2020 17:26:24 -0500
Message-Id: <20200214222658.12946-9-borntraeger@de.ibm.com>
In-Reply-To: <20200214222658.12946-1-borntraeger@de.ibm.com>
References: <20200214222658.12946-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

From: Janosch Frank <frankja@linux.ibm.com>

This adds two new helper functions for doing UV CALLs.

The first variant handles UV CALLs that might have longer busy
conditions or just need longer when doing partial completion. We should
schedule when necessary.

The second variant handles UV CALLs that only need the handle but have
no payload (e.g. destroying a VM). We can provide a simple wrapper for
those.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
[borntraeger@de.ibm.com: patch merging, splitting, fixing]
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/uv.h | 65 +++++++++++++++++++++++++++++++++++---
 1 file changed, 60 insertions(+), 5 deletions(-)

diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
index e45963cc7f40..bc452a15ac3f 100644
--- a/arch/s390/include/asm/uv.h
+++ b/arch/s390/include/asm/uv.h
@@ -14,6 +14,7 @@
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/bug.h>
+#include <linux/sched.h>
 #include <asm/page.h>
 #include <asm/gmap.h>
 
@@ -91,6 +92,19 @@ struct uv_cb_cfs {
 	u64 paddr;
 } __packed __aligned(8);
 
+/*
+ * A common UV call struct for calls that take no payload
+ * Examples:
+ * Destroy cpu/config
+ * Verify
+ */
+struct uv_cb_nodata {
+	struct uv_cb_header header;
+	u64 reserved08[2];
+	u64 handle;
+	u64 reserved20[4];
+} __packed __aligned(8);
+
 struct uv_cb_share {
 	struct uv_cb_header header;
 	u64 reserved08[3];
@@ -98,21 +112,62 @@ struct uv_cb_share {
 	u64 reserved28;
 } __packed __aligned(8);
 
-static inline int uv_call(unsigned long r1, unsigned long r2)
+static inline int __uv_call(unsigned long r1, unsigned long r2)
 {
 	int cc;
 
 	asm volatile(
-		"0:	.insn rrf,0xB9A40000,%[r1],%[r2],0,0\n"
-		"		brc	3,0b\n"
-		"		ipm	%[cc]\n"
-		"		srl	%[cc],28\n"
+		"	.insn rrf,0xB9A40000,%[r1],%[r2],0,0\n"
+		"	ipm	%[cc]\n"
+		"	srl	%[cc],28\n"
 		: [cc] "=d" (cc)
 		: [r1] "a" (r1), [r2] "a" (r2)
 		: "memory", "cc");
 	return cc;
 }
 
+static inline int uv_call(unsigned long r1, unsigned long r2)
+{
+	int cc;
+
+	do {
+		cc = __uv_call(r1, r2);
+	} while (cc > 1);
+	return cc;
+}
+
+/* Low level uv_call that avoids stalls for long running busy conditions  */
+static inline int uv_call_sched(unsigned long r1, unsigned long r2)
+{
+	int cc;
+
+	do {
+		cc = __uv_call(r1, r2);
+		cond_resched();
+	} while (cc > 1);
+	return cc;
+}
+
+/*
+ * special variant of uv_call that only transports the cpu or guest
+ * handle and the command, like destroy or verify.
+ */
+static inline int uv_cmd_nodata(u64 handle, u16 cmd, u16 *rc, u16 *rrc)
+{
+	struct uv_cb_nodata uvcb = {
+		.header.cmd = cmd,
+		.header.len = sizeof(uvcb),
+		.handle = handle,
+	};
+	int cc;
+
+	WARN(!handle, "No handle provided to Ultravisor call cmd %x\n", cmd);
+	cc = uv_call_sched(0, (u64)&uvcb);
+	*rc = uvcb.header.rc;
+	*rrc = uvcb.header.rrc;
+	return cc ? -EINVAL : 0;
+}
+
 struct uv_info {
 	unsigned long inst_calls_list[4];
 	unsigned long uv_base_stor_len;
-- 
2.25.0
