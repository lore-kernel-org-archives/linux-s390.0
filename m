Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13484 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726076AbfHFEug (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 6 Aug 2019 00:50:36 -0400
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [PATCH v4 6/6] s390/mm: Remove sev_active() function
Date: Tue,  6 Aug 2019 01:49:19 -0300
Message-Id: <20190806044919.10622-7-bauerman@linux.ibm.com>
In-Reply-To: <20190806044919.10622-1-bauerman@linux.ibm.com>
References: <20190806044919.10622-1-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: x86@kernel.org
Cc: iommu@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Alexey Dobriyan <adobriyan@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Halil Pasic <pasic@linux.ibm.com>, Lianbo Jiang <lijiang@redhat.com>, Mike Anderson <andmike@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>

All references to sev_active() were moved to arch/x86 so we don't need to
define it for s390 anymore.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
---
 arch/s390/include/asm/mem_encrypt.h | 1 -
 arch/s390/mm/init.c                 | 7 +------
 2 files changed, 1 insertion(+), 7 deletions(-)

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
index 20340a03ad90..a124f19f7b3c 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -156,14 +156,9 @@ int set_memory_decrypted(unsigned long addr, int numpages)
 }
 
 /* are we a protected virtualization guest? */
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
