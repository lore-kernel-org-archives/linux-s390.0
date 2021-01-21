Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63084 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728508AbhAUJOP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 21 Jan 2021 04:14:15 -0500
From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v4 1/3] s390x: pv: implement routine to share/unshare memory
Date: Thu, 21 Jan 2021 10:13:10 +0100
Message-Id: <1611220392-22628-2-git-send-email-pmorel@linux.ibm.com>
In-Reply-To: <1611220392-22628-1-git-send-email-pmorel@linux.ibm.com>
References: <1611220392-22628-1-git-send-email-pmorel@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com, cohuck@redhat.com, imbrenda@linux.ibm.com, drjones@redhat.com, pbonzini@redhat.com

When communicating with the host we need to share part of
the memory.

Let's implement the ultravisor calls for this.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Suggested-by: Janosch Frank <frankja@linux.ibm.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Acked-by: Thomas Huth <thuth@redhat.com>
---
 lib/s390x/asm/uv.h | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/lib/s390x/asm/uv.h b/lib/s390x/asm/uv.h
index 4c2fc48..8400026 100644
--- a/lib/s390x/asm/uv.h
+++ b/lib/s390x/asm/uv.h
@@ -71,4 +71,42 @@ static inline int uv_call(unsigned long r1, unsigned long r2)
 	return cc;
 }
 
+static inline int share(unsigned long addr, u16 cmd)
+{
+	struct uv_cb_share uvcb = {
+		.header.cmd = cmd,
+		.header.len = sizeof(uvcb),
+		.paddr = addr
+	};
+	int cc;
+
+	cc = uv_call(0, (u64)&uvcb);
+	if (!cc && uvcb.header.rc == 0x0001)
+		return 0;
+
+	report_info("cc %d response code: %04x", cc, uvcb.header.rc);
+	return -1;
+}
+
+/*
+ * Guest 2 request to the Ultravisor to make a page shared with the
+ * hypervisor for IO.
+ *
+ * @addr: Real or absolute address of the page to be shared
+ */
+static inline int uv_set_shared(unsigned long addr)
+{
+	return share(addr, UVC_CMD_SET_SHARED_ACCESS);
+}
+
+/*
+ * Guest 2 request to the Ultravisor to make a page unshared.
+ *
+ * @addr: Real or absolute address of the page to be unshared
+ */
+static inline int uv_remove_shared(unsigned long addr)
+{
+	return share(addr, UVC_CMD_REMOVE_SHARED_ACCESS);
+}
+
 #endif
-- 
2.17.1
