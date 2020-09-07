Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27602 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729238AbgIGMr3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 7 Sep 2020 08:47:29 -0400
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [PATCH v2 1/2] s390x: uv: Add destroy page call
Date: Mon,  7 Sep 2020 08:46:59 -0400
Message-Id: <20200907124700.10374-2-frankja@linux.ibm.com>
In-Reply-To: <20200907124700.10374-1-frankja@linux.ibm.com>
References: <20200907124700.10374-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-s390@vger.kernel.org
Cc: borntraeger@de.ibm.com, gor@linux.ibm.com, imbrenda@linux.ibm.com, kvm@vger.kernel.org, david@redhat.com, hca@linux.ibm.com

We don't need to export pages if we destroy the VM configuration
afterwards anyway. Instead we can destroy the page which will zero it
and then make it accessible to the host.

Destroying is about twice as fast as the export.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/include/asm/uv.h |  7 +++++++
 arch/s390/kernel/uv.c      | 20 ++++++++++++++++++++
 arch/s390/mm/gmap.c        |  2 +-
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
index cff4b4c99b75..0325fc0469b7 100644
--- a/arch/s390/include/asm/uv.h
+++ b/arch/s390/include/asm/uv.h
@@ -33,6 +33,7 @@
 #define UVC_CMD_DESTROY_SEC_CPU		0x0121
 #define UVC_CMD_CONV_TO_SEC_STOR	0x0200
 #define UVC_CMD_CONV_FROM_SEC_STOR	0x0201
+#define UVC_CMD_DESTR_SEC_STOR		0x0202
 #define UVC_CMD_SET_SEC_CONF_PARAMS	0x0300
 #define UVC_CMD_UNPACK_IMG		0x0301
 #define UVC_CMD_VERIFY_IMG		0x0302
@@ -344,6 +345,7 @@ static inline int is_prot_virt_host(void)
 }
 
 int gmap_make_secure(struct gmap *gmap, unsigned long gaddr, void *uvcb);
+int uv_destroy_page(unsigned long paddr);
 int uv_convert_from_secure(unsigned long paddr);
 int gmap_convert_to_secure(struct gmap *gmap, unsigned long gaddr);
 
@@ -354,6 +356,11 @@ void adjust_to_uv_max(unsigned long *vmax);
 static inline void setup_uv(void) {}
 static inline void adjust_to_uv_max(unsigned long *vmax) {}
 
+static inline int uv_destroy_page(unsigned long paddr)
+{
+	return 0;
+}
+
 static inline int uv_convert_from_secure(unsigned long paddr)
 {
 	return 0;
diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index c296e5c8dbf9..d3399b8a9b23 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -118,6 +118,26 @@ static int uv_pin_shared(unsigned long paddr)
 	return 0;
 }
 
+/*
+ * Requests the Ultravisor to destroy a guest page and make it
+ * accessible to the host. The destroy clears the page instead of
+ * exporting.
+ *
+ * @paddr: Absolute host address of page to be destroyed
+ */
+int uv_destroy_page(unsigned long paddr)
+{
+	struct uv_cb_cfs uvcb = {
+		.header.cmd = UVC_CMD_DESTR_SEC_STOR,
+		.header.len = sizeof(uvcb),
+		.paddr = paddr
+	};
+
+	if (uv_call(0, (u64)&uvcb))
+		return -EINVAL;
+	return 0;
+}
+
 /*
  * Requests the Ultravisor to encrypt a guest page and make it
  * accessible to the host for paging (export).
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 373542ca1113..cfb0017f33a7 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -2679,7 +2679,7 @@ static int __s390_reset_acc(pte_t *ptep, unsigned long addr,
 	pte_t pte = READ_ONCE(*ptep);
 
 	if (pte_present(pte))
-		WARN_ON_ONCE(uv_convert_from_secure(pte_val(pte) & PAGE_MASK));
+		WARN_ON_ONCE(uv_destroy_page(pte_val(pte) & PAGE_MASK));
 	return 0;
 }
 
-- 
2.25.1
