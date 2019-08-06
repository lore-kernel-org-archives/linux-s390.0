Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [PATCH v4 4/6] x86,s390/mm: Move sme_active() and sme_me_mask to x86-specific header
Date: Tue,  6 Aug 2019 01:49:17 -0300
Message-Id: <20190806044919.10622-5-bauerman@linux.ibm.com>
In-Reply-To: <20190806044919.10622-1-bauerman@linux.ibm.com>
References: <20190806044919.10622-1-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: x86@kernel.org
Cc: iommu@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Alexey Dobriyan <adobriyan@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Halil Pasic <pasic@linux.ibm.com>, Lianbo Jiang <lijiang@redhat.com>, Mike Anderson <andmike@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, Tom Lendacky <thomas.lendacky@amd.com>

Now that generic code doesn't reference them, move sme_active() and
sme_me_mask to x86's <asm/mem_encrypt.h>.

Also remove the export for sme_active() since it's only used in files that
won't be built as modules. sme_me_mask on the other hand is used in
arch/x86/kvm/svm.c (via __sme_set() and __psp_pa()) which can be built as a
module so its export needs to stay.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/s390/include/asm/mem_encrypt.h |  4 +---
 arch/x86/include/asm/mem_encrypt.h  | 10 ++++++++++
 arch/x86/mm/mem_encrypt.c           |  1 -
 include/linux/mem_encrypt.h         | 14 +-------------
 4 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/arch/s390/include/asm/mem_encrypt.h b/arch/s390/include/asm/mem_encrypt.h
index 3eb018508190..ff813a56bc30 100644
--- a/arch/s390/include/asm/mem_encrypt.h
+++ b/arch/s390/include/asm/mem_encrypt.h
@@ -4,9 +4,7 @@
 
 #ifndef __ASSEMBLY__
 
-#define sme_me_mask	0ULL
-
-static inline bool sme_active(void) { return false; }
+static inline bool mem_encrypt_active(void) { return false; }
 extern bool sev_active(void);
 
 int set_memory_encrypted(unsigned long addr, int numpages);
diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index 0c196c47d621..848ce43b9040 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -92,6 +92,16 @@ early_set_memory_encrypted(unsigned long vaddr, unsigned long size) { return 0;
 
 extern char __start_bss_decrypted[], __end_bss_decrypted[], __start_bss_decrypted_unused[];
 
+static inline bool mem_encrypt_active(void)
+{
+	return sme_me_mask;
+}
+
+static inline u64 sme_get_me_mask(void)
+{
+	return sme_me_mask;
+}
+
 #endif	/* __ASSEMBLY__ */
 
 #endif	/* __X86_MEM_ENCRYPT_H__ */
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index fece30ca8b0c..94da5a88abe6 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -344,7 +344,6 @@ bool sme_active(void)
 {
 	return sme_me_mask && !sev_enabled;
 }
-EXPORT_SYMBOL(sme_active);
 
 bool sev_active(void)
 {
diff --git a/include/linux/mem_encrypt.h b/include/linux/mem_encrypt.h
index 470bd53a89df..0c5b0ff9eb29 100644
--- a/include/linux/mem_encrypt.h
+++ b/include/linux/mem_encrypt.h
@@ -18,23 +18,11 @@
 
 #else	/* !CONFIG_ARCH_HAS_MEM_ENCRYPT */
 
-#define sme_me_mask	0ULL
-
-static inline bool sme_active(void) { return false; }
+static inline bool mem_encrypt_active(void) { return false; }
 static inline bool sev_active(void) { return false; }
 
 #endif	/* CONFIG_ARCH_HAS_MEM_ENCRYPT */
 
-static inline bool mem_encrypt_active(void)
-{
-	return sme_me_mask;
-}
-
-static inline u64 sme_get_me_mask(void)
-{
-	return sme_me_mask;
-}
-
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 /*
  * The __sme_set() and __sme_clr() macros are useful for adding or removing
