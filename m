Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22400 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727049AbgBGLkH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 7 Feb 2020 06:40:07 -0500
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 07/35] KVM: s390: add new variants of UV CALL
Date: Fri,  7 Feb 2020 06:39:30 -0500
Message-Id: <20200207113958.7320-8-borntraeger@de.ibm.com>
In-Reply-To: <20200207113958.7320-1-borntraeger@de.ibm.com>
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

From: Janosch Frank <frankja@linux.ibm.com>

This add 2 new variants of the UV CALL.

The first variant handles UV CALLs that might have longer busy
conditions or just need longer when doing partial completion. We should
schedule when necessary.

The second variant handles UV CALLs that only need the handle but have
no payload (e.g. destroying a VM). We can provide a simple wrapper for
those.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
[borntraeger@de.ibm.com: patch merging, splitting, fixing]
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/uv.h | 59 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
index 1b97230a57ba..e1cef772fde1 100644
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
@@ -98,6 +112,31 @@ struct uv_cb_share {
 	u64 reserved28;
 } __packed __aligned(8);
 
+/*
+ * Low level uv_call that takes r1 and r2 as parameter and avoids
+ * stalls for long running busy conditions by doing schedule
+ */
+static inline int uv_call_sched(unsigned long r1, unsigned long r2)
+{
+	int cc;
+
+	do {
+		asm volatile(
+			"0:	.insn rrf,0xB9A40000,%[r1],%[r2],0,0\n"
+			"		ipm	%[cc]\n"
+			"		srl	%[cc],28\n"
+			: [cc] "=d" (cc)
+			: [r1] "d" (r1), [r2] "d" (r2)
+			: "memory", "cc");
+		if (need_resched())
+			schedule();
+	} while (cc > 1);
+	return cc;
+}
+
+/*
+ * Low level uv_call that takes r1 and r2 as parameter
+ */
 static inline int uv_call(unsigned long r1, unsigned long r2)
 {
 	int cc;
@@ -113,6 +152,26 @@ static inline int uv_call(unsigned long r1, unsigned long r2)
 	return cc;
 }
 
+/*
+ * special variant of uv_call that only transports the cpu or guest
+ * handle and the command, like destroy or verify.
+ */
+static inline int uv_cmd_nodata(u64 handle, u16 cmd, u32 *ret)
+{
+	int rc;
+	struct uv_cb_nodata uvcb = {
+		.header.cmd = cmd,
+		.header.len = sizeof(uvcb),
+		.handle = handle,
+	};
+
+	WARN(!handle, "No handle provided to Ultravisor call cmd %x\n", cmd);
+	rc = uv_call_sched(0, (u64)&uvcb);
+	if (ret)
+		*ret = *(u32 *)&uvcb.header.rc;
+	return rc ? -EINVAL : 0;
+}
+
 struct uv_info {
 	unsigned long inst_calls_list[4];
 	unsigned long uv_base_stor_len;
-- 
2.24.0
