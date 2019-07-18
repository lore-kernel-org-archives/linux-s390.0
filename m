Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45732 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389502AbfGRD3r (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 17 Jul 2019 23:29:47 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6I3S7ks092086
        for <linux-s390@vger.kernel.org>; Wed, 17 Jul 2019 23:29:46 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ttg4g1dwm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 17 Jul 2019 23:29:46 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Thu, 18 Jul 2019 04:29:45 +0100
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [PATCH v3 5/6] fs/core/vmcore: Move sev_active() reference to x86 arch code
Date: Thu, 18 Jul 2019 00:28:57 -0300
In-Reply-To: <20190718032858.28744-1-bauerman@linux.ibm.com>
References: <20190718032858.28744-1-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20190718032858.28744-6-bauerman@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: x86@kernel.org
Cc: iommu@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Alexey Dobriyan <adobriyan@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Halil Pasic <pasic@linux.ibm.com>, Mike Anderson <andmike@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>

Secure Encrypted Virtualization is an x86-specific feature, so it shouldn't
appear in generic kernel code because it forces non-x86 architectures to
define the sev_active() function, which doesn't make a lot of sense.

To solve this problem, add an x86 elfcorehdr_read() function to override
the generic weak implementation. To do that, it's necessary to make
read_from_oldmem() public so that it can be used outside of vmcore.c.

Also, remove the export for sev_active() since it's only used in files that
won't be built as modules.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 arch/x86/kernel/crash_dump_64.c |  5 +++++
 arch/x86/mm/mem_encrypt.c       |  1 -
 fs/proc/vmcore.c                |  8 ++++----
 include/linux/crash_dump.h      | 14 ++++++++++++++
 include/linux/mem_encrypt.h     |  1 -
 5 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/crash_dump_64.c b/arch/x86/kernel/crash_dump_64.c
index 22369dd5de3b..045e82e8945b 100644
--- a/arch/x86/kernel/crash_dump_64.c
+++ b/arch/x86/kernel/crash_dump_64.c
@@ -70,3 +70,8 @@ ssize_t copy_oldmem_page_encrypted(unsigned long pfn, char *buf, size_t csize,
 {
 	return __copy_oldmem_page(pfn, buf, csize, offset, userbuf, true);
 }
+
+ssize_t elfcorehdr_read(char *buf, size_t count, u64 *ppos)
+{
+	return read_from_oldmem(buf, count, ppos, 0, sev_active());
+}
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 7139f2f43955..b1e823441093 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -349,7 +349,6 @@ bool sev_active(void)
 {
 	return sme_me_mask && sev_enabled;
 }
-EXPORT_SYMBOL(sev_active);
 
 /* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRYPTED */
 bool force_dma_unencrypted(struct device *dev)
diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 57957c91c6df..ca1f20bedd8c 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -100,9 +100,9 @@ static int pfn_is_ram(unsigned long pfn)
 }
 
 /* Reads a page from the oldmem device from given offset. */
-static ssize_t read_from_oldmem(char *buf, size_t count,
-				u64 *ppos, int userbuf,
-				bool encrypted)
+ssize_t read_from_oldmem(char *buf, size_t count,
+			 u64 *ppos, int userbuf,
+			 bool encrypted)
 {
 	unsigned long pfn, offset;
 	size_t nr_bytes;
@@ -166,7 +166,7 @@ void __weak elfcorehdr_free(unsigned long long addr)
  */
 ssize_t __weak elfcorehdr_read(char *buf, size_t count, u64 *ppos)
 {
-	return read_from_oldmem(buf, count, ppos, 0, sev_active());
+	return read_from_oldmem(buf, count, ppos, 0, false);
 }
 
 /*
diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
index f774c5eb9e3c..4664fc1871de 100644
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -115,4 +115,18 @@ static inline int vmcore_add_device_dump(struct vmcoredd_data *data)
 	return -EOPNOTSUPP;
 }
 #endif /* CONFIG_PROC_VMCORE_DEVICE_DUMP */
+
+#ifdef CONFIG_PROC_VMCORE
+ssize_t read_from_oldmem(char *buf, size_t count,
+			 u64 *ppos, int userbuf,
+			 bool encrypted);
+#else
+static inline ssize_t read_from_oldmem(char *buf, size_t count,
+				       u64 *ppos, int userbuf,
+				       bool encrypted)
+{
+	return -EOPNOTSUPP;
+}
+#endif /* CONFIG_PROC_VMCORE */
+
 #endif /* LINUX_CRASHDUMP_H */
diff --git a/include/linux/mem_encrypt.h b/include/linux/mem_encrypt.h
index 0c5b0ff9eb29..5c4a18a91f89 100644
--- a/include/linux/mem_encrypt.h
+++ b/include/linux/mem_encrypt.h
@@ -19,7 +19,6 @@
 #else	/* !CONFIG_ARCH_HAS_MEM_ENCRYPT */
 
 static inline bool mem_encrypt_active(void) { return false; }
-static inline bool sev_active(void) { return false; }
 
 #endif	/* CONFIG_ARCH_HAS_MEM_ENCRYPT */
 
