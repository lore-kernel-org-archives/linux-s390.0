Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4420 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388047AbfGRDcI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 17 Jul 2019 23:32:08 -0400
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [PATCH v3 6/6] s390/mm: Remove sev_active() function
Date: Thu, 18 Jul 2019 00:28:58 -0300
Message-Id: <20190718032858.28744-7-bauerman@linux.ibm.com>
In-Reply-To: <20190718032858.28744-1-bauerman@linux.ibm.com>
References: <20190718032858.28744-1-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: x86@kernel.org
Cc: iommu@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Alexey Dobriyan <adobriyan@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Halil Pasic <pasic@linux.ibm.com>, Mike Anderson <andmike@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>

All references to sev_active() were moved to arch/x86 so we don't need to
define it for s390 anymore.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 arch/s390/include/asm/mem_encrypt.h | 1 -
 arch/s390/mm/init.c                 | 8 +-------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/s390/include/asm/mem_encrypt.h b/arch/s390/include/asm/mem_encrypt.h
index ff813a56bc30..2542cbf7e2d1 100644
--- a/arch/s390/include/asm/mem_encrypt.h
+++ b/arch/s390/include/asm/mem_encrypt.h
@@ -5,7 +5,6 @@
 #ifndef __ASSEMBLY__
 
 static inline bool mem_encrypt_active(void) { return false; }
-extern bool sev_active(void);
 
 int set_memory_encrypted(unsigned long addr, int numpages);
 int set_memory_decrypted(unsigned long addr, int numpages);
diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index 78c319c5ce48..6286eb3e815b 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -155,15 +155,9 @@ int set_memory_decrypted(unsigned long addr, int numpages)
 	return 0;
 }
 
-/* are we a protected virtualization guest? */
-bool sev_active(void)
-{
-	return is_prot_virt_guest();
-}
-
 bool force_dma_unencrypted(struct device *dev)
 {
-	return sev_active();
+	return is_prot_virt_guest();
 }
 
 /* protected virtualization */
