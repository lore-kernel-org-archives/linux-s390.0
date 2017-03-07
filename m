Return-Path: <linux-arch-owner@vger.kernel.org>
From: Laura Abbott <labbott@redhat.com>
Subject: [PATCHv3 01/16] treewide: Move set_memory_* functions away from cacheflush.h
Date: Tue,  7 Mar 2017 12:55:18 -0800
Message-ID: <1488920133-27229-2-git-send-email-labbott@redhat.com>
In-Reply-To: <1488920133-27229-1-git-send-email-labbott@redhat.com>
References: <1488920133-27229-1-git-send-email-labbott@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20170307205518.jq9_DEnvx1x6LKa2HFD7hgZ4kF2guXjAqASMpmwYrdY@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Daniel Borkmann <daniel@iogearbox.net>, Jessica Yu <jeyu@redhat.com>, Takashi Iwai <tiwai@suse.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Laura Abbott <labbott@redhat.com>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>


The set_memory_* APIs came out of a desire to have a better way to
change memory attributes. Many of these attributes were linked to cache
functionality so the prototypes were put in cacheflush.h. These days,
the APIs have grown and have a much wider use than just cache APIs. To
support this growth, split off set_memory_* and friends into a separate
header file to avoid growing cacheflush.h for APIs that have nothing to
do with caches.

Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v3: No changes
---
 arch/arm/include/asm/cacheflush.h   | 21 +--------
 arch/arm/include/asm/set_memory.h   | 32 ++++++++++++++
 arch/arm64/include/asm/Kbuild       |  1 +
 arch/arm64/include/asm/cacheflush.h |  6 +--
 arch/s390/include/asm/cacheflush.h  | 28 +-----------
 arch/s390/include/asm/set_memory.h  | 31 +++++++++++++
 arch/x86/include/asm/cacheflush.h   | 86 +-----------------------------------
 arch/x86/include/asm/set_memory.h   | 87 +++++++++++++++++++++++++++++++++++++
 include/asm-generic/set_memory.h    | 12 +++++
 9 files changed, 167 insertions(+), 137 deletions(-)
 create mode 100644 arch/arm/include/asm/set_memory.h
 create mode 100644 arch/s390/include/asm/set_memory.h
 create mode 100644 arch/x86/include/asm/set_memory.h
 create mode 100644 include/asm-generic/set_memory.h

diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index 02454fa..1cb9d11 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -16,6 +16,7 @@
 #include <asm/shmparam.h>
 #include <asm/cachetype.h>
 #include <asm/outercache.h>
+#include <asm/set_memory.h>
 
 #define CACHE_COLOUR(vaddr)	((vaddr & (SHMLBA - 1)) >> PAGE_SHIFT)
 
@@ -478,26 +479,6 @@ static inline void __sync_cache_range_r(volatile void *p, size_t size)
 	: : : "r0","r1","r2","r3","r4","r5","r6","r7", \
 	      "r9","r10","lr","memory" )
 
-#ifdef CONFIG_MMU
-int set_memory_ro(unsigned long addr, int numpages);
-int set_memory_rw(unsigned long addr, int numpages);
-int set_memory_x(unsigned long addr, int numpages);
-int set_memory_nx(unsigned long addr, int numpages);
-#else
-static inline int set_memory_ro(unsigned long addr, int numpages) { return 0; }
-static inline int set_memory_rw(unsigned long addr, int numpages) { return 0; }
-static inline int set_memory_x(unsigned long addr, int numpages) { return 0; }
-static inline int set_memory_nx(unsigned long addr, int numpages) { return 0; }
-#endif
-
-#ifdef CONFIG_STRICT_KERNEL_RWX
-void set_kernel_text_rw(void);
-void set_kernel_text_ro(void);
-#else
-static inline void set_kernel_text_rw(void) { }
-static inline void set_kernel_text_ro(void) { }
-#endif
-
 void flush_uprobe_xol_access(struct page *page, unsigned long uaddr,
 			     void *kaddr, unsigned long len);
 
diff --git a/arch/arm/include/asm/set_memory.h b/arch/arm/include/asm/set_memory.h
new file mode 100644
index 0000000..5aa4315
--- /dev/null
+++ b/arch/arm/include/asm/set_memory.h
@@ -0,0 +1,32 @@
+/*
+ * Copyright (C) 1999-2002 Russell King
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _ASMARM_SET_MEMORY_H
+#define _ASMARM_SET_MEMORY_H
+
+#ifdef CONFIG_MMU
+int set_memory_ro(unsigned long addr, int numpages);
+int set_memory_rw(unsigned long addr, int numpages);
+int set_memory_x(unsigned long addr, int numpages);
+int set_memory_nx(unsigned long addr, int numpages);
+#else
+static inline int set_memory_ro(unsigned long addr, int numpages) { return 0; }
+static inline int set_memory_rw(unsigned long addr, int numpages) { return 0; }
+static inline int set_memory_x(unsigned long addr, int numpages) { return 0; }
+static inline int set_memory_nx(unsigned long addr, int numpages) { return 0; }
+#endif
+
+#ifdef CONFIG_STRICT_KERNEL_RWX
+void set_kernel_text_rw(void);
+void set_kernel_text_ro(void);
+#else
+static inline void set_kernel_text_rw(void) { }
+static inline void set_kernel_text_ro(void) { }
+#endif
+
+#endif
diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
index a12f1af..a7a97a6 100644
--- a/arch/arm64/include/asm/Kbuild
+++ b/arch/arm64/include/asm/Kbuild
@@ -29,6 +29,7 @@ generic-y += rwsem.h
 generic-y += segment.h
 generic-y += sembuf.h
 generic-y += serial.h
+generic-y += set_memory.h
 generic-y += shmbuf.h
 generic-y += simd.h
 generic-y += sizes.h
diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
index 5a2a6ee..7db6962 100644
--- a/arch/arm64/include/asm/cacheflush.h
+++ b/arch/arm64/include/asm/cacheflush.h
@@ -20,6 +20,7 @@
 #define __ASM_CACHEFLUSH_H
 
 #include <linux/mm.h>
+#include <asm/set_memory.h>
 
 /*
  * This flag is used to indicate that the page pointed to by a pte is clean
@@ -150,9 +151,4 @@ static inline void flush_cache_vunmap(unsigned long start, unsigned long end)
 {
 }
 
-int set_memory_ro(unsigned long addr, int numpages);
-int set_memory_rw(unsigned long addr, int numpages);
-int set_memory_x(unsigned long addr, int numpages);
-int set_memory_nx(unsigned long addr, int numpages);
-
 #endif
diff --git a/arch/s390/include/asm/cacheflush.h b/arch/s390/include/asm/cacheflush.h
index 0499334..afe2965 100644
--- a/arch/s390/include/asm/cacheflush.h
+++ b/arch/s390/include/asm/cacheflush.h
@@ -3,32 +3,6 @@
 
 /* Caches aren't brain-dead on the s390. */
 #include <asm-generic/cacheflush.h>
-
-#define SET_MEMORY_RO	1UL
-#define SET_MEMORY_RW	2UL
-#define SET_MEMORY_NX	4UL
-#define SET_MEMORY_X	8UL
-
-int __set_memory(unsigned long addr, int numpages, unsigned long flags);
-
-static inline int set_memory_ro(unsigned long addr, int numpages)
-{
-	return __set_memory(addr, numpages, SET_MEMORY_RO);
-}
-
-static inline int set_memory_rw(unsigned long addr, int numpages)
-{
-	return __set_memory(addr, numpages, SET_MEMORY_RW);
-}
-
-static inline int set_memory_nx(unsigned long addr, int numpages)
-{
-	return __set_memory(addr, numpages, SET_MEMORY_NX);
-}
-
-static inline int set_memory_x(unsigned long addr, int numpages)
-{
-	return __set_memory(addr, numpages, SET_MEMORY_X);
-}
+#include <asm/set_memory.h>
 
 #endif /* _S390_CACHEFLUSH_H */
diff --git a/arch/s390/include/asm/set_memory.h b/arch/s390/include/asm/set_memory.h
new file mode 100644
index 0000000..46a4db4
--- /dev/null
+++ b/arch/s390/include/asm/set_memory.h
@@ -0,0 +1,31 @@
+#ifndef _ASMS390_SET_MEMORY_H
+#define _ASMS390_SET_MEMORY_H
+
+#define SET_MEMORY_RO	1UL
+#define SET_MEMORY_RW	2UL
+#define SET_MEMORY_NX	4UL
+#define SET_MEMORY_X	8UL
+
+int __set_memory(unsigned long addr, int numpages, unsigned long flags);
+
+static inline int set_memory_ro(unsigned long addr, int numpages)
+{
+	return __set_memory(addr, numpages, SET_MEMORY_RO);
+}
+
+static inline int set_memory_rw(unsigned long addr, int numpages)
+{
+	return __set_memory(addr, numpages, SET_MEMORY_RW);
+}
+
+static inline int set_memory_nx(unsigned long addr, int numpages)
+{
+	return __set_memory(addr, numpages, SET_MEMORY_NX);
+}
+
+static inline int set_memory_x(unsigned long addr, int numpages)
+{
+	return __set_memory(addr, numpages, SET_MEMORY_X);
+}
+
+#endif
diff --git a/arch/x86/include/asm/cacheflush.h b/arch/x86/include/asm/cacheflush.h
index e7e1942..3d7db6f 100644
--- a/arch/x86/include/asm/cacheflush.h
+++ b/arch/x86/include/asm/cacheflush.h
@@ -4,94 +4,10 @@
 /* Caches aren't brain-dead on the intel. */
 #include <asm-generic/cacheflush.h>
 #include <asm/special_insns.h>
-
-/*
- * The set_memory_* API can be used to change various attributes of a virtual
- * address range. The attributes include:
- * Cachability   : UnCached, WriteCombining, WriteThrough, WriteBack
- * Executability : eXeutable, NoteXecutable
- * Read/Write    : ReadOnly, ReadWrite
- * Presence      : NotPresent
- *
- * Within a category, the attributes are mutually exclusive.
- *
- * The implementation of this API will take care of various aspects that
- * are associated with changing such attributes, such as:
- * - Flushing TLBs
- * - Flushing CPU caches
- * - Making sure aliases of the memory behind the mapping don't violate
- *   coherency rules as defined by the CPU in the system.
- *
- * What this API does not do:
- * - Provide exclusion between various callers - including callers that
- *   operation on other mappings of the same physical page
- * - Restore default attributes when a page is freed
- * - Guarantee that mappings other than the requested one are
- *   in any state, other than that these do not violate rules for
- *   the CPU you have. Do not depend on any effects on other mappings,
- *   CPUs other than the one you have may have more relaxed rules.
- * The caller is required to take care of these.
- */
-
-int _set_memory_uc(unsigned long addr, int numpages);
-int _set_memory_wc(unsigned long addr, int numpages);
-int _set_memory_wt(unsigned long addr, int numpages);
-int _set_memory_wb(unsigned long addr, int numpages);
-int set_memory_uc(unsigned long addr, int numpages);
-int set_memory_wc(unsigned long addr, int numpages);
-int set_memory_wt(unsigned long addr, int numpages);
-int set_memory_wb(unsigned long addr, int numpages);
-int set_memory_x(unsigned long addr, int numpages);
-int set_memory_nx(unsigned long addr, int numpages);
-int set_memory_ro(unsigned long addr, int numpages);
-int set_memory_rw(unsigned long addr, int numpages);
-int set_memory_np(unsigned long addr, int numpages);
-int set_memory_4k(unsigned long addr, int numpages);
-
-int set_memory_array_uc(unsigned long *addr, int addrinarray);
-int set_memory_array_wc(unsigned long *addr, int addrinarray);
-int set_memory_array_wt(unsigned long *addr, int addrinarray);
-int set_memory_array_wb(unsigned long *addr, int addrinarray);
-
-int set_pages_array_uc(struct page **pages, int addrinarray);
-int set_pages_array_wc(struct page **pages, int addrinarray);
-int set_pages_array_wt(struct page **pages, int addrinarray);
-int set_pages_array_wb(struct page **pages, int addrinarray);
-
-/*
- * For legacy compatibility with the old APIs, a few functions
- * are provided that work on a "struct page".
- * These functions operate ONLY on the 1:1 kernel mapping of the
- * memory that the struct page represents, and internally just
- * call the set_memory_* function. See the description of the
- * set_memory_* function for more details on conventions.
- *
- * These APIs should be considered *deprecated* and are likely going to
- * be removed in the future.
- * The reason for this is the implicit operation on the 1:1 mapping only,
- * making this not a generally useful API.
- *
- * Specifically, many users of the old APIs had a virtual address,
- * called virt_to_page() or vmalloc_to_page() on that address to
- * get a struct page* that the old API required.
- * To convert these cases, use set_memory_*() on the original
- * virtual address, do not use these functions.
- */
-
-int set_pages_uc(struct page *page, int numpages);
-int set_pages_wb(struct page *page, int numpages);
-int set_pages_x(struct page *page, int numpages);
-int set_pages_nx(struct page *page, int numpages);
-int set_pages_ro(struct page *page, int numpages);
-int set_pages_rw(struct page *page, int numpages);
-
+#include <asm/set_memory.h>
 
 void clflush_cache_range(void *addr, unsigned int size);
 
 #define mmio_flush_range(addr, size) clflush_cache_range(addr, size)
 
-extern int kernel_set_to_readonly;
-void set_kernel_text_rw(void);
-void set_kernel_text_ro(void);
-
 #endif /* _ASM_X86_CACHEFLUSH_H */
diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
new file mode 100644
index 0000000..eaec6c3
--- /dev/null
+++ b/arch/x86/include/asm/set_memory.h
@@ -0,0 +1,87 @@
+#ifndef _ASM_X86_SET_MEMORY_H
+#define _ASM_X86_SET_MEMORY_H
+
+#include <asm/page.h>
+#include <asm-generic/set_memory.h>
+
+/*
+ * The set_memory_* API can be used to change various attributes of a virtual
+ * address range. The attributes include:
+ * Cachability   : UnCached, WriteCombining, WriteThrough, WriteBack
+ * Executability : eXeutable, NoteXecutable
+ * Read/Write    : ReadOnly, ReadWrite
+ * Presence      : NotPresent
+ *
+ * Within a category, the attributes are mutually exclusive.
+ *
+ * The implementation of this API will take care of various aspects that
+ * are associated with changing such attributes, such as:
+ * - Flushing TLBs
+ * - Flushing CPU caches
+ * - Making sure aliases of the memory behind the mapping don't violate
+ *   coherency rules as defined by the CPU in the system.
+ *
+ * What this API does not do:
+ * - Provide exclusion between various callers - including callers that
+ *   operation on other mappings of the same physical page
+ * - Restore default attributes when a page is freed
+ * - Guarantee that mappings other than the requested one are
+ *   in any state, other than that these do not violate rules for
+ *   the CPU you have. Do not depend on any effects on other mappings,
+ *   CPUs other than the one you have may have more relaxed rules.
+ * The caller is required to take care of these.
+ */
+
+int _set_memory_uc(unsigned long addr, int numpages);
+int _set_memory_wc(unsigned long addr, int numpages);
+int _set_memory_wt(unsigned long addr, int numpages);
+int _set_memory_wb(unsigned long addr, int numpages);
+int set_memory_uc(unsigned long addr, int numpages);
+int set_memory_wc(unsigned long addr, int numpages);
+int set_memory_wt(unsigned long addr, int numpages);
+int set_memory_wb(unsigned long addr, int numpages);
+int set_memory_np(unsigned long addr, int numpages);
+int set_memory_4k(unsigned long addr, int numpages);
+
+int set_memory_array_uc(unsigned long *addr, int addrinarray);
+int set_memory_array_wc(unsigned long *addr, int addrinarray);
+int set_memory_array_wt(unsigned long *addr, int addrinarray);
+int set_memory_array_wb(unsigned long *addr, int addrinarray);
+
+int set_pages_array_uc(struct page **pages, int addrinarray);
+int set_pages_array_wc(struct page **pages, int addrinarray);
+int set_pages_array_wt(struct page **pages, int addrinarray);
+int set_pages_array_wb(struct page **pages, int addrinarray);
+
+/*
+ * For legacy compatibility with the old APIs, a few functions
+ * are provided that work on a "struct page".
+ * These functions operate ONLY on the 1:1 kernel mapping of the
+ * memory that the struct page represents, and internally just
+ * call the set_memory_* function. See the description of the
+ * set_memory_* function for more details on conventions.
+ *
+ * These APIs should be considered *deprecated* and are likely going to
+ * be removed in the future.
+ * The reason for this is the implicit operation on the 1:1 mapping only,
+ * making this not a generally useful API.
+ *
+ * Specifically, many users of the old APIs had a virtual address,
+ * called virt_to_page() or vmalloc_to_page() on that address to
+ * get a struct page* that the old API required.
+ * To convert these cases, use set_memory_*() on the original
+ * virtual address, do not use these functions.
+ */
+
+int set_pages_uc(struct page *page, int numpages);
+int set_pages_wb(struct page *page, int numpages);
+int set_pages_x(struct page *page, int numpages);
+int set_pages_nx(struct page *page, int numpages);
+int set_pages_ro(struct page *page, int numpages);
+int set_pages_rw(struct page *page, int numpages);
+
+extern int kernel_set_to_readonly;
+void set_kernel_text_rw(void);
+void set_kernel_text_ro(void);
+
+#endif /* _ASM_X86_SET_MEMORY_H */
diff --git a/include/asm-generic/set_memory.h b/include/asm-generic/set_memory.h
new file mode 100644
index 0000000..83e81f8
--- /dev/null
+++ b/include/asm-generic/set_memory.h
@@ -0,0 +1,12 @@
+#ifndef __ASM_SET_MEMORY_H
+#define __ASM_SET_MEMORY_H
+
+/*
+ * Functions to change memory attributes.
+ */
+int set_memory_ro(unsigned long addr, int numpages);
+int set_memory_rw(unsigned long addr, int numpages);
+int set_memory_x(unsigned long addr, int numpages);
+int set_memory_nx(unsigned long addr, int numpages);
+
+#endif
-- 
2.7.4
