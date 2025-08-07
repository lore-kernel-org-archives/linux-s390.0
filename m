Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3797A22B8C2;
	Thu,  7 Aug 2025 19:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754595628; cv=none; b=PNCGHxE1VJdZrG0QRun4lwqAjv8zOwcjJwMNSXOACcixri3Iq9W78xJ4x0jF9oa5jLx5PsAMpa2I115vVqxQsVLt+3h0ivG2IPmafuj1Agyz2zMYzYgOULkt8xsfq3yCufUokqw2UHoKekkmdMHn0bMPlb1+8ypilssepdGOmuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754595628; c=relaxed/simple;
	bh=G+gaLLdtfvxZeukIZH84FJUeGvj7+PaB3Zfh32O8Ebc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XLMenvjmo+yKt/2/bMOi8ZWzPPy0KR6Qv1o7bFsl579McYmBsDsDExQn672NHAfNb97BXRVHuDloa02t6GORbng4EFNalnnEA/2PZasOR81Nk7xO15yTt+1nzYKuho+KMB8p9GT4I8tjuBGDD2ly8oXNlHdGYYXjN8uUSTDQKPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nmkopNTl; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmkopNTl"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-55b8bf653dfso1598164e87.0;
        Thu, 07 Aug 2025 12:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754595623; x=1755200423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2DbfBGTvZLLq0ttKoSCsFatguSHfxza7xfUfeZ6hh5c=;
        b=nmkopNTlYjrBsoe4dKRNDPlxc1wf7BHh/1bNQK6iNGA9kfCt8PHiiKj+fS9uTatDTR
         I4e28nC7roTpPsmgOHUG/rEx5EOeb/VH3+At+jkKjqkaku3xVulx1ugCwyetNOPOJarq
         G8qqwWPd51Be/UvMDskyVdu0JBVYqEnuA69cEkwKVIFZdL4DdnBXv67B4jqXNvPvbFgN
         EdFVnE+bayt+qjiUQJpUzZZzjTJY0FtqZ0xV5M+bFWuQDlUqrPoUqaopeytwLWNTPpJT
         7DGghbR5jp5EOgDgNiSC961A0FyhnwZ629Rrdmc7yucB8QnCIAPXd2P9pONfphf/n2co
         3Jwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754595623; x=1755200423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2DbfBGTvZLLq0ttKoSCsFatguSHfxza7xfUfeZ6hh5c=;
        b=SpWwoDHXBXA82iUYDDOpQoEbbbvHNitE0rtfqBXJqh6ayEZYuRykxDV8oLJtRCrp2W
         OeertQjdwgIhkAsw9OkPd8LEPzpaFuPnGco45KWBAAD1mdroIf9j7s5bez3gAc9VcnV0
         OzeRSXi4kA7IYKQalnx5P0q2YOMbAFVC6ta+iLYedUrgF/QIkK0lQxDHMUpyBCc/XjRa
         vxXdfd+m4hbD81Nvi2M8CYwrNwoOFluhK7hAlvxlJydyZHFulxu3JrcwYZ10Tw3uGpAw
         G80s0KqC0oeFC3q6CBkAmqAZ4coGc3rgDmIkLEOlzIGGbdBwd9aHLwGFkoWIJxI7B2jI
         Qirg==
X-Forwarded-Encrypted: i=1; AJvYcCU2/Rpi9E5z9E/6hmtto+MYSqshB8Y1epN9ktHRXOAZuGvpMXiRyH1I7QusfANqf6Y9t3ZlWX3Bud4vX2c=@vger.kernel.org, AJvYcCVnu0BnOv10rEl7VXsVoE6+p2AVGhSnJFqKjbu/+vo/fvvGtNsC/kSAPch2Mj6l5F27uXjUmf2P50lUBA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwkBGEz6jg6U7B/nvhiR6srtntc6GRJTZglk0teTVUSY005SJhf
	XYwfwn+X9Yj32yRFts8JfFIiUXHNRciY7fvtxFMT1lwLfRemipm2Nprf
X-Gm-Gg: ASbGncsedqriEts9+IIbZzEuO8vWrlULInYc6uxYpfvX5GdQo/hunxzkMwKOPIsNp1E
	diSh94q8bHyzUwnZRhUpBmZQZt/LWkwhn4o1WESx8wexM+z762R6oAeQFVVDOjg9bp91YZGBKKJ
	9TKhpkYdNmb2wZZOGLsPmMBy6lzdMAsHRWLWlrUtpx6G7zVzYEAtKetheyd4gF/aQK4zuUC3AiF
	bFIjmMuOD5qhpx+ydKOt/g4jeQd0OGzfbpi3RsdkMwe6BP726XwVc80tuzwX83hcr29cLYyeWVO
	sH8/9jr5h0WkkX6RwkNvU+rzpyoSqdxTznu8CRwfvRSwR/+rx4q7XKw2CuauvZdfYe8PSMCui/r
	lRNsMNnMeG5AwVgxEeqA2QGg2LViW8Bo0lcz1hD45dTdqs+doCQPj5hAwgVNg84DjZY2L7g==
X-Google-Smtp-Source: AGHT+IFRe5TH5UxPaXG4pwR+ZzT71hP9gkI3If4nREh0zO/0YhbgqAGusbPVyt1+sk+N384E5cIRdg==
X-Received: by 2002:a05:6512:15a4:b0:55c:bf3c:e7ee with SMTP id 2adb3069b0e04-55cc00b003emr12512e87.3.1754595622849;
        Thu, 07 Aug 2025 12:40:22 -0700 (PDT)
Received: from localhost.localdomain (178.90.89.143.dynamic.telecom.kz. [178.90.89.143])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88c98c2asm2793570e87.77.2025.08.07.12.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 12:40:22 -0700 (PDT)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: ryabinin.a.a@gmail.com,
	bhe@redhat.com,
	hca@linux.ibm.com,
	christophe.leroy@csgroup.eu,
	andreyknvl@gmail.com,
	akpm@linux-foundation.org,
	zhangqing@loongson.cn,
	chenhuacai@loongson.cn,
	davidgow@google.co,
	glider@google.com,
	dvyukov@google.com
Cc: alex@ghiti.fr,
	agordeev@linux.ibm.com,
	vincenzo.frascino@arm.com,
	elver@google.com,
	kasan-dev@googlegroups.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-mm@kvack.org,
	snovitoll@gmail.com
Subject: [PATCH v5 1/2] kasan: introduce ARCH_DEFER_KASAN and unify static key across modes
Date: Fri,  8 Aug 2025 00:40:11 +0500
Message-Id: <20250807194012.631367-2-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250807194012.631367-1-snovitoll@gmail.com>
References: <20250807194012.631367-1-snovitoll@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce CONFIG_ARCH_DEFER_KASAN to identify architectures [1] that need
to defer KASAN initialization until shadow memory is properly set up,
and unify the static key infrastructure across all KASAN modes.

[1] PowerPC, UML, LoongArch selects ARCH_DEFER_KASAN.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217049
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
Changes in v5:
- Unified patches where arch (powerpc, UML, loongarch) selects
  ARCH_DEFER_KASAN in the first patch not to break
  bisectability
- Removed kasan_arch_is_ready completely as there is no user
- Removed __wrappers in v4, left only those where it's necessary
  due to different implementations

Changes in v4:
- Fixed HW_TAGS static key functionality (was broken in v3)
- Merged configuration and implementation for atomicity
---
 arch/loongarch/Kconfig                 |  1 +
 arch/loongarch/include/asm/kasan.h     |  7 ------
 arch/loongarch/mm/kasan_init.c         |  8 +++----
 arch/powerpc/Kconfig                   |  1 +
 arch/powerpc/include/asm/kasan.h       | 12 ----------
 arch/powerpc/mm/kasan/init_32.c        |  2 +-
 arch/powerpc/mm/kasan/init_book3e_64.c |  2 +-
 arch/powerpc/mm/kasan/init_book3s_64.c |  6 +----
 arch/um/Kconfig                        |  1 +
 arch/um/include/asm/kasan.h            |  5 ++--
 arch/um/kernel/mem.c                   | 10 ++++++--
 include/linux/kasan-enabled.h          | 32 ++++++++++++++++++--------
 include/linux/kasan.h                  |  6 +++++
 lib/Kconfig.kasan                      |  8 +++++++
 mm/kasan/common.c                      | 17 ++++++++++----
 mm/kasan/generic.c                     | 19 +++++++++++----
 mm/kasan/hw_tags.c                     |  9 +-------
 mm/kasan/kasan.h                       |  8 ++++++-
 mm/kasan/shadow.c                      | 12 +++++-----
 mm/kasan/sw_tags.c                     |  1 +
 mm/kasan/tags.c                        |  2 +-
 21 files changed, 100 insertions(+), 69 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index f0abc38c40a..cd64b2bc12d 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -9,6 +9,7 @@ config LOONGARCH
 	select ACPI_PPTT if ACPI
 	select ACPI_SYSTEM_POWER_STATES_SUPPORT	if ACPI
 	select ARCH_BINFMT_ELF_STATE
+	select ARCH_DEFER_KASAN if KASAN
 	select ARCH_DISABLE_KASAN_INLINE
 	select ARCH_ENABLE_MEMORY_HOTPLUG
 	select ARCH_ENABLE_MEMORY_HOTREMOVE
diff --git a/arch/loongarch/include/asm/kasan.h b/arch/loongarch/include/asm/kasan.h
index 62f139a9c87..0e50e5b5e05 100644
--- a/arch/loongarch/include/asm/kasan.h
+++ b/arch/loongarch/include/asm/kasan.h
@@ -66,7 +66,6 @@
 #define XKPRANGE_WC_SHADOW_OFFSET	(KASAN_SHADOW_START + XKPRANGE_WC_KASAN_OFFSET)
 #define XKVRANGE_VC_SHADOW_OFFSET	(KASAN_SHADOW_START + XKVRANGE_VC_KASAN_OFFSET)
 
-extern bool kasan_early_stage;
 extern unsigned char kasan_early_shadow_page[PAGE_SIZE];
 
 #define kasan_mem_to_shadow kasan_mem_to_shadow
@@ -75,12 +74,6 @@ void *kasan_mem_to_shadow(const void *addr);
 #define kasan_shadow_to_mem kasan_shadow_to_mem
 const void *kasan_shadow_to_mem(const void *shadow_addr);
 
-#define kasan_arch_is_ready kasan_arch_is_ready
-static __always_inline bool kasan_arch_is_ready(void)
-{
-	return !kasan_early_stage;
-}
-
 #define addr_has_metadata addr_has_metadata
 static __always_inline bool addr_has_metadata(const void *addr)
 {
diff --git a/arch/loongarch/mm/kasan_init.c b/arch/loongarch/mm/kasan_init.c
index d2681272d8f..170da98ad4f 100644
--- a/arch/loongarch/mm/kasan_init.c
+++ b/arch/loongarch/mm/kasan_init.c
@@ -40,11 +40,9 @@ static pgd_t kasan_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
 #define __pte_none(early, pte) (early ? pte_none(pte) : \
 ((pte_val(pte) & _PFN_MASK) == (unsigned long)__pa(kasan_early_shadow_page)))
 
-bool kasan_early_stage = true;
-
 void *kasan_mem_to_shadow(const void *addr)
 {
-	if (!kasan_arch_is_ready()) {
+	if (!kasan_enabled()) {
 		return (void *)(kasan_early_shadow_page);
 	} else {
 		unsigned long maddr = (unsigned long)addr;
@@ -298,7 +296,8 @@ void __init kasan_init(void)
 	kasan_populate_early_shadow(kasan_mem_to_shadow((void *)VMALLOC_START),
 					kasan_mem_to_shadow((void *)KFENCE_AREA_END));
 
-	kasan_early_stage = false;
+	/* Enable KASAN here before kasan_mem_to_shadow(). */
+	kasan_init_generic();
 
 	/* Populate the linear mapping */
 	for_each_mem_range(i, &pa_start, &pa_end) {
@@ -329,5 +328,4 @@ void __init kasan_init(void)
 
 	/* At this point kasan is fully initialized. Enable error messages */
 	init_task.kasan_depth = 0;
-	pr_info("KernelAddressSanitizer initialized.\n");
 }
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 93402a1d9c9..a324dcdb8eb 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -122,6 +122,7 @@ config PPC
 	# Please keep this list sorted alphabetically.
 	#
 	select ARCH_32BIT_OFF_T if PPC32
+	select ARCH_DEFER_KASAN			if KASAN && PPC_RADIX_MMU
 	select ARCH_DISABLE_KASAN_INLINE	if PPC_RADIX_MMU
 	select ARCH_DMA_DEFAULT_COHERENT	if !NOT_COHERENT_CACHE
 	select ARCH_ENABLE_MEMORY_HOTPLUG
diff --git a/arch/powerpc/include/asm/kasan.h b/arch/powerpc/include/asm/kasan.h
index b5bbb94c51f..957a57c1db5 100644
--- a/arch/powerpc/include/asm/kasan.h
+++ b/arch/powerpc/include/asm/kasan.h
@@ -53,18 +53,6 @@
 #endif
 
 #ifdef CONFIG_KASAN
-#ifdef CONFIG_PPC_BOOK3S_64
-DECLARE_STATIC_KEY_FALSE(powerpc_kasan_enabled_key);
-
-static __always_inline bool kasan_arch_is_ready(void)
-{
-	if (static_branch_likely(&powerpc_kasan_enabled_key))
-		return true;
-	return false;
-}
-
-#define kasan_arch_is_ready kasan_arch_is_ready
-#endif
 
 void kasan_early_init(void);
 void kasan_mmu_init(void);
diff --git a/arch/powerpc/mm/kasan/init_32.c b/arch/powerpc/mm/kasan/init_32.c
index 03666d790a5..1d083597464 100644
--- a/arch/powerpc/mm/kasan/init_32.c
+++ b/arch/powerpc/mm/kasan/init_32.c
@@ -165,7 +165,7 @@ void __init kasan_init(void)
 
 	/* At this point kasan is fully initialized. Enable error messages */
 	init_task.kasan_depth = 0;
-	pr_info("KASAN init done\n");
+	kasan_init_generic();
 }
 
 void __init kasan_late_init(void)
diff --git a/arch/powerpc/mm/kasan/init_book3e_64.c b/arch/powerpc/mm/kasan/init_book3e_64.c
index 60c78aac0f6..0d3a73d6d4b 100644
--- a/arch/powerpc/mm/kasan/init_book3e_64.c
+++ b/arch/powerpc/mm/kasan/init_book3e_64.c
@@ -127,7 +127,7 @@ void __init kasan_init(void)
 
 	/* Enable error messages */
 	init_task.kasan_depth = 0;
-	pr_info("KASAN init done\n");
+	kasan_init_generic();
 }
 
 void __init kasan_late_init(void) { }
diff --git a/arch/powerpc/mm/kasan/init_book3s_64.c b/arch/powerpc/mm/kasan/init_book3s_64.c
index 7d959544c07..dcafa641804 100644
--- a/arch/powerpc/mm/kasan/init_book3s_64.c
+++ b/arch/powerpc/mm/kasan/init_book3s_64.c
@@ -19,8 +19,6 @@
 #include <linux/memblock.h>
 #include <asm/pgalloc.h>
 
-DEFINE_STATIC_KEY_FALSE(powerpc_kasan_enabled_key);
-
 static void __init kasan_init_phys_region(void *start, void *end)
 {
 	unsigned long k_start, k_end, k_cur;
@@ -92,11 +90,9 @@ void __init kasan_init(void)
 	 */
 	memset(kasan_early_shadow_page, 0, PAGE_SIZE);
 
-	static_branch_inc(&powerpc_kasan_enabled_key);
-
 	/* Enable error messages */
 	init_task.kasan_depth = 0;
-	pr_info("KASAN init done\n");
+	kasan_init_generic();
 }
 
 void __init kasan_early_init(void) { }
diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 9083bfdb773..a12cc072ab1 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -5,6 +5,7 @@ menu "UML-specific options"
 config UML
 	bool
 	default y
+	select ARCH_DEFER_KASAN if STATIC_LINK
 	select ARCH_WANTS_DYNAMIC_TASK_STRUCT
 	select ARCH_HAS_CACHE_LINE_SIZE
 	select ARCH_HAS_CPU_FINALIZE_INIT
diff --git a/arch/um/include/asm/kasan.h b/arch/um/include/asm/kasan.h
index f97bb1f7b85..b54a4e937fd 100644
--- a/arch/um/include/asm/kasan.h
+++ b/arch/um/include/asm/kasan.h
@@ -24,10 +24,9 @@
 
 #ifdef CONFIG_KASAN
 void kasan_init(void);
-extern int kasan_um_is_ready;
 
-#ifdef CONFIG_STATIC_LINK
-#define kasan_arch_is_ready() (kasan_um_is_ready)
+#if defined(CONFIG_STATIC_LINK) && defined(CONFIG_KASAN_INLINE)
+#error UML does not work in KASAN_INLINE mode with STATIC_LINK enabled!
 #endif
 #else
 static inline void kasan_init(void) { }
diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index 76bec7de81b..261fdcd21be 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -21,9 +21,9 @@
 #include <os.h>
 #include <um_malloc.h>
 #include <linux/sched/task.h>
+#include <linux/kasan.h>
 
 #ifdef CONFIG_KASAN
-int kasan_um_is_ready;
 void kasan_init(void)
 {
 	/*
@@ -32,7 +32,10 @@ void kasan_init(void)
 	 */
 	kasan_map_memory((void *)KASAN_SHADOW_START, KASAN_SHADOW_SIZE);
 	init_task.kasan_depth = 0;
-	kasan_um_is_ready = true;
+	/* Since kasan_init() is called before main(),
+	 * KASAN is initialized but the enablement is deferred after
+	 * jump_label_init(). See arch_mm_preinit().
+	 */
 }
 
 static void (*kasan_init_ptr)(void)
@@ -58,6 +61,9 @@ static unsigned long brk_end;
 
 void __init arch_mm_preinit(void)
 {
+	/* Safe to call after jump_label_init(). Enables KASAN. */
+	kasan_init_generic();
+
 	/* clear the zero-page */
 	memset(empty_zero_page, 0, PAGE_SIZE);
 
diff --git a/include/linux/kasan-enabled.h b/include/linux/kasan-enabled.h
index 6f612d69ea0..9eca967d852 100644
--- a/include/linux/kasan-enabled.h
+++ b/include/linux/kasan-enabled.h
@@ -4,32 +4,46 @@
 
 #include <linux/static_key.h>
 
-#ifdef CONFIG_KASAN_HW_TAGS
-
+#if defined(CONFIG_ARCH_DEFER_KASAN) || defined(CONFIG_KASAN_HW_TAGS)
+/*
+ * Global runtime flag for KASAN modes that need runtime control.
+ * Used by ARCH_DEFER_KASAN architectures and HW_TAGS mode.
+ */
 DECLARE_STATIC_KEY_FALSE(kasan_flag_enabled);
 
+/*
+ * Runtime control for shadow memory initialization or HW_TAGS mode.
+ * Uses static key for architectures that need deferred KASAN or HW_TAGS.
+ */
 static __always_inline bool kasan_enabled(void)
 {
 	return static_branch_likely(&kasan_flag_enabled);
 }
 
-static inline bool kasan_hw_tags_enabled(void)
+static inline void kasan_enable(void)
 {
-	return kasan_enabled();
+	static_branch_enable(&kasan_flag_enabled);
 }
-
-#else /* CONFIG_KASAN_HW_TAGS */
-
-static inline bool kasan_enabled(void)
+#else
+/* For architectures that can enable KASAN early, use compile-time check. */
+static __always_inline bool kasan_enabled(void)
 {
 	return IS_ENABLED(CONFIG_KASAN);
 }
 
+static inline void kasan_enable(void) {}
+#endif /* CONFIG_ARCH_DEFER_KASAN || CONFIG_KASAN_HW_TAGS */
+
+#ifdef CONFIG_KASAN_HW_TAGS
+static inline bool kasan_hw_tags_enabled(void)
+{
+	return kasan_enabled();
+}
+#else
 static inline bool kasan_hw_tags_enabled(void)
 {
 	return false;
 }
-
 #endif /* CONFIG_KASAN_HW_TAGS */
 
 #endif /* LINUX_KASAN_ENABLED_H */
diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 890011071f2..51a8293d1af 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -543,6 +543,12 @@ void kasan_report_async(void);
 
 #endif /* CONFIG_KASAN_HW_TAGS */
 
+#ifdef CONFIG_KASAN_GENERIC
+void __init kasan_init_generic(void);
+#else
+static inline void kasan_init_generic(void) { }
+#endif
+
 #ifdef CONFIG_KASAN_SW_TAGS
 void __init kasan_init_sw_tags(void);
 #else
diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index f82889a830f..38456560c85 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -19,6 +19,14 @@ config ARCH_DISABLE_KASAN_INLINE
 	  Disables both inline and stack instrumentation. Selected by
 	  architectures that do not support these instrumentation types.
 
+config ARCH_DEFER_KASAN
+	bool
+	help
+	  Architectures should select this if they need to defer KASAN
+	  initialization until shadow memory is properly set up. This
+	  enables runtime control via static keys. Otherwise, KASAN uses
+	  compile-time constants for better performance.
+
 config CC_HAS_KASAN_GENERIC
 	def_bool $(cc-option, -fsanitize=kernel-address)
 
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 9142964ab9c..d9d389870a2 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -32,6 +32,15 @@
 #include "kasan.h"
 #include "../slab.h"
 
+#if defined(CONFIG_ARCH_DEFER_KASAN) || defined(CONFIG_KASAN_HW_TAGS)
+/*
+ * Definition of the unified static key declared in kasan-enabled.h.
+ * This provides consistent runtime enable/disable across KASAN modes.
+ */
+DEFINE_STATIC_KEY_FALSE(kasan_flag_enabled);
+EXPORT_SYMBOL(kasan_flag_enabled);
+#endif
+
 struct slab *kasan_addr_to_slab(const void *addr)
 {
 	if (virt_addr_valid(addr))
@@ -246,7 +255,7 @@ static inline void poison_slab_object(struct kmem_cache *cache, void *object,
 bool __kasan_slab_pre_free(struct kmem_cache *cache, void *object,
 				unsigned long ip)
 {
-	if (!kasan_arch_is_ready() || is_kfence_address(object))
+	if (is_kfence_address(object))
 		return false;
 	return check_slab_allocation(cache, object, ip);
 }
@@ -254,7 +263,7 @@ bool __kasan_slab_pre_free(struct kmem_cache *cache, void *object,
 bool __kasan_slab_free(struct kmem_cache *cache, void *object, bool init,
 		       bool still_accessible)
 {
-	if (!kasan_arch_is_ready() || is_kfence_address(object))
+	if (is_kfence_address(object))
 		return false;
 
 	/*
@@ -293,7 +302,7 @@ bool __kasan_slab_free(struct kmem_cache *cache, void *object, bool init,
 
 static inline bool check_page_allocation(void *ptr, unsigned long ip)
 {
-	if (!kasan_arch_is_ready())
+	if (!kasan_enabled())
 		return false;
 
 	if (ptr != page_address(virt_to_head_page(ptr))) {
@@ -522,7 +531,7 @@ bool __kasan_mempool_poison_object(void *ptr, unsigned long ip)
 		return true;
 	}
 
-	if (is_kfence_address(ptr) || !kasan_arch_is_ready())
+	if (is_kfence_address(ptr))
 		return true;
 
 	slab = folio_slab(folio);
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index d54e89f8c3e..b413c46b3e0 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -36,6 +36,17 @@
 #include "kasan.h"
 #include "../slab.h"
 
+/*
+ * Initialize Generic KASAN and enable runtime checks.
+ * This should be called from arch kasan_init() once shadow memory is ready.
+ */
+void __init kasan_init_generic(void)
+{
+	kasan_enable();
+
+	pr_info("KernelAddressSanitizer initialized (generic)\n");
+}
+
 /*
  * All functions below always inlined so compiler could
  * perform better optimizations in each of __asan_loadX/__assn_storeX
@@ -165,7 +176,7 @@ static __always_inline bool check_region_inline(const void *addr,
 						size_t size, bool write,
 						unsigned long ret_ip)
 {
-	if (!kasan_arch_is_ready())
+	if (!kasan_enabled())
 		return true;
 
 	if (unlikely(size == 0))
@@ -193,7 +204,7 @@ bool kasan_byte_accessible(const void *addr)
 {
 	s8 shadow_byte;
 
-	if (!kasan_arch_is_ready())
+	if (!kasan_enabled())
 		return true;
 
 	shadow_byte = READ_ONCE(*(s8 *)kasan_mem_to_shadow(addr));
@@ -495,7 +506,7 @@ static void release_alloc_meta(struct kasan_alloc_meta *meta)
 
 static void release_free_meta(const void *object, struct kasan_free_meta *meta)
 {
-	if (!kasan_arch_is_ready())
+	if (!kasan_enabled())
 		return;
 
 	/* Check if free meta is valid. */
@@ -562,7 +573,7 @@ void kasan_save_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags)
 	kasan_save_track(&alloc_meta->alloc_track, flags);
 }
 
-void kasan_save_free_info(struct kmem_cache *cache, void *object)
+void __kasan_save_free_info(struct kmem_cache *cache, void *object)
 {
 	struct kasan_free_meta *free_meta;
 
diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index 9a6927394b5..c8289a3feab 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -45,13 +45,6 @@ static enum kasan_arg kasan_arg __ro_after_init;
 static enum kasan_arg_mode kasan_arg_mode __ro_after_init;
 static enum kasan_arg_vmalloc kasan_arg_vmalloc __initdata;
 
-/*
- * Whether KASAN is enabled at all.
- * The value remains false until KASAN is initialized by kasan_init_hw_tags().
- */
-DEFINE_STATIC_KEY_FALSE(kasan_flag_enabled);
-EXPORT_SYMBOL(kasan_flag_enabled);
-
 /*
  * Whether the selected mode is synchronous, asynchronous, or asymmetric.
  * Defaults to KASAN_MODE_SYNC.
@@ -260,7 +253,7 @@ void __init kasan_init_hw_tags(void)
 	kasan_init_tags();
 
 	/* KASAN is now initialized, enable it. */
-	static_branch_enable(&kasan_flag_enabled);
+	kasan_enable();
 
 	pr_info("KernelAddressSanitizer initialized (hw-tags, mode=%s, vmalloc=%s, stacktrace=%s)\n",
 		kasan_mode_info(),
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 129178be5e6..8a9d8a6ea71 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -398,7 +398,13 @@ depot_stack_handle_t kasan_save_stack(gfp_t flags, depot_flags_t depot_flags);
 void kasan_set_track(struct kasan_track *track, depot_stack_handle_t stack);
 void kasan_save_track(struct kasan_track *track, gfp_t flags);
 void kasan_save_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags);
-void kasan_save_free_info(struct kmem_cache *cache, void *object);
+
+void __kasan_save_free_info(struct kmem_cache *cache, void *object);
+static inline void kasan_save_free_info(struct kmem_cache *cache, void *object)
+{
+	if (kasan_enabled())
+		__kasan_save_free_info(cache, object);
+}
 
 #ifdef CONFIG_KASAN_GENERIC
 bool kasan_quarantine_put(struct kmem_cache *cache, void *object);
diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index d2c70cd2afb..2e126cb21b6 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -125,7 +125,7 @@ void kasan_poison(const void *addr, size_t size, u8 value, bool init)
 {
 	void *shadow_start, *shadow_end;
 
-	if (!kasan_arch_is_ready())
+	if (!kasan_enabled())
 		return;
 
 	/*
@@ -150,7 +150,7 @@ EXPORT_SYMBOL_GPL(kasan_poison);
 #ifdef CONFIG_KASAN_GENERIC
 void kasan_poison_last_granule(const void *addr, size_t size)
 {
-	if (!kasan_arch_is_ready())
+	if (!kasan_enabled())
 		return;
 
 	if (size & KASAN_GRANULE_MASK) {
@@ -390,7 +390,7 @@ int kasan_populate_vmalloc(unsigned long addr, unsigned long size)
 	unsigned long shadow_start, shadow_end;
 	int ret;
 
-	if (!kasan_arch_is_ready())
+	if (!kasan_enabled())
 		return 0;
 
 	if (!is_vmalloc_or_module_addr((void *)addr))
@@ -560,7 +560,7 @@ void kasan_release_vmalloc(unsigned long start, unsigned long end,
 	unsigned long region_start, region_end;
 	unsigned long size;
 
-	if (!kasan_arch_is_ready())
+	if (!kasan_enabled())
 		return;
 
 	region_start = ALIGN(start, KASAN_MEMORY_PER_SHADOW_PAGE);
@@ -611,7 +611,7 @@ void *__kasan_unpoison_vmalloc(const void *start, unsigned long size,
 	 * with setting memory tags, so the KASAN_VMALLOC_INIT flag is ignored.
 	 */
 
-	if (!kasan_arch_is_ready())
+	if (!kasan_enabled())
 		return (void *)start;
 
 	if (!is_vmalloc_or_module_addr(start))
@@ -636,7 +636,7 @@ void *__kasan_unpoison_vmalloc(const void *start, unsigned long size,
  */
 void __kasan_poison_vmalloc(const void *start, unsigned long size)
 {
-	if (!kasan_arch_is_ready())
+	if (!kasan_enabled())
 		return;
 
 	if (!is_vmalloc_or_module_addr(start))
diff --git a/mm/kasan/sw_tags.c b/mm/kasan/sw_tags.c
index b9382b5b6a3..c75741a7460 100644
--- a/mm/kasan/sw_tags.c
+++ b/mm/kasan/sw_tags.c
@@ -44,6 +44,7 @@ void __init kasan_init_sw_tags(void)
 		per_cpu(prng_state, cpu) = (u32)get_cycles();
 
 	kasan_init_tags();
+	kasan_enable();
 
 	pr_info("KernelAddressSanitizer initialized (sw-tags, stacktrace=%s)\n",
 		str_on_off(kasan_stack_collection_enabled()));
diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
index d65d48b85f9..b9f31293622 100644
--- a/mm/kasan/tags.c
+++ b/mm/kasan/tags.c
@@ -142,7 +142,7 @@ void kasan_save_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags)
 	save_stack_info(cache, object, flags, false);
 }
 
-void kasan_save_free_info(struct kmem_cache *cache, void *object)
+void __kasan_save_free_info(struct kmem_cache *cache, void *object)
 {
 	save_stack_info(cache, object, 0, true);
 }
-- 
2.34.1

