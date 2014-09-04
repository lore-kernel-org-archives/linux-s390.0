From: frank.blaschka@de.ibm.com
Subject: [RFC][patch 1/6] s390: cio: chsc function to register GIB
Date: Thu, 04 Sep 2014 12:52:24 +0200
Message-ID: <20140904105336.864332732@de.ibm.com>
References: <20140904105223.336503578@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline; filename=002-s390_chsc_gib-3.16.patch
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel@nongnu.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: aik@ozlabs.ru, pbonzini@redhat.com, agraf@suse.de
List-ID: <linux-s390.vger.kernel.org>

From: Frank Blaschka <frank.blaschka@de.ibm.com>

This patch provides a new chsc function to register/unregister
a GIB (Guest Information Block).

Signed-off-by: Frank Blaschka <frank.blaschka@de.ibm.com>
---
 arch/s390/include/asm/cio.h |    1 
 drivers/s390/cio/chsc.c     |   50 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

--- a/arch/s390/include/asm/cio.h
+++ b/arch/s390/include/asm/cio.h
@@ -311,5 +311,6 @@ extern int cio_get_iplinfo(struct cio_ip
 /* Function from drivers/s390/cio/chsc.c */
 int chsc_sstpc(void *page, unsigned int op, u16 ctrl);
 int chsc_sstpi(void *page, void *result, size_t size);
+int chsc_sgib(u32 gibo);
 
 #endif
--- a/drivers/s390/cio/chsc.c
+++ b/drivers/s390/cio/chsc.c
@@ -1188,6 +1188,56 @@ out:
 EXPORT_SYMBOL_GPL(chsc_siosl);
 
 /**
+ * chsc_sgib() - register guest information block
+ * @gibo: guest information block
+ *
+ * gibo must be allocated in low memory
+ *
+ * Returns 0 on success.
+ */
+int chsc_sgib(u32 gibo)
+{
+	struct {
+		struct chsc_header request;
+		u16 operation_code;
+		u16 : 16;
+		u32 : 4;
+		u32 fmt : 4;
+		u32 : 24;
+		u32 : 32;
+		u32 : 32;
+		u32 gibo;
+		u64 : 64;
+		u32 : 16;
+		u32 aix : 8;
+		u32 : 8;
+		u32 reserved[1007];
+		struct chsc_header response;
+	} __packed *scssc;
+	unsigned long flags;
+	int rc;
+
+	spin_lock_irqsave(&chsc_page_lock, flags);
+	memset(chsc_page, 0, PAGE_SIZE);
+	scssc = chsc_page;
+
+	scssc->request.length = 0x0fe0;
+	scssc->request.code = 0x0021;
+	scssc->operation_code = 1;
+	scssc->gibo = gibo;
+
+	rc = chsc(scssc);
+	if (rc)
+		rc = -EIO;
+	else
+		rc = chsc_error_from_response(scssc->response.code);
+
+	spin_unlock_irqrestore(&chsc_page_lock, flags);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(chsc_sgib);
+
+/**
  * chsc_scm_info() - store SCM information (SSI)
  * @scm_area: request and response block for SSI
  * @token: continuation token
