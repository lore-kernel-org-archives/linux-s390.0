Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0274318DF80
	for <linux-s390@vger.kernel.org>; Mon, 16 Jun 2025 02:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750041021; cv=none; b=NfrBrfiPf6XHmTQwLgu6Tk3ttXltosovDQWP/93M9AV2bWcOnvrsV9XfcYvbcunqjYTA1P3Uc6bVQOSBxl9w0E53YrtkpzNDK+v8iMGTD0EfOn4Y0PefWXoUL5jmohFZsUp43RgcfL9gNOtcs0udO5gGvutNUr3JKFFiD9PNqrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750041021; c=relaxed/simple;
	bh=DLg7jR/HwT4NCqG6p+WfFEeT2droSNr6aBN+7EbQuIE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jhEIFC8teGGzViE/IutGBb1dtIU1xPyXceGf9SCd+amzDFcRxkNbG5uhfKohCe27WOY2sbFFDiqJ6HP14i3bZqy2oCQYsREAR3S1Zh/7S7b+P5tBroaqSi3uy/0Kh9cq7y5oyQauM/NO9FAtkE4J7b9dxzlXsRyF01grHALV2TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G1nsNB40; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G1nsNB40"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750041016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TwaFPyIkk+e4dx1cWe+AhOCnypnekR9FeQe3heGaETY=;
	b=G1nsNB403+jLLhmsMsa83nMOPV15GspnvXLjv/x1jEbGPHiXpQ5aonlDOWgJ5wOgolDj3X
	odcqhWwE/bLnF71FVMAxtsVuVQovfQsMd1PcpRs27GGlEETJacLNTFJ+Bv/MVsE/rWsCE+
	9ugUOwqUkn5vVH5RM727QiSIbuyyD44=
From: Hao Ge <hao.ge@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Mike Rapoport <rppt@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-s390@vger.kernel.org,
	Hao Ge <hao.ge@linux.dev>,
	Hao Ge <gehao@kylinos.cn>
Subject: [PATCH v3 1/2] mm: Optimize the ARCH_NEEDS_WEAK_PER_CPU logic for s390/alpha architectures
Date: Mon, 16 Jun 2025 10:29:17 +0800
Message-Id: <57e110be6d8387e403b4ef1f3b10714c36afbb51.1750040317.git.gehao@kylinos.cn>
In-Reply-To: <cover.1750040317.git.gehao@kylinos.cn>
References: <cover.1750040317.git.gehao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hao Ge <gehao@kylinos.cn>

Recently discovered this entry while checking kallsyms on ARM64:
ffff800083e509c0 D _shared_alloc_tag

If ARCH_NEEDS_WEAK_PER_CPU is not defined((it is only defined for
s390 and alpha architectures),there's no need to statically define
the percpu variable _shared_alloc_tag.

Therefore,we need to implement isolation for this purpose.

However,currently ARCH_NEEDS_WEAK_PER_CPU is a #define and
is enclosed within the #if defined(MODULE) conditional block.

When building the core kernel code for s390 or alpha architectures,
ARCH_NEEDS_WEAK_PER_CPU remains undefined (as it is gated
by #if defined(MODULE)).However,when building modules for these
architectures,the macro is explicitly defined.

Therefore,we need to make ARCH_NEEDS_WEAK_PER_CPU a Kconfig option.
And replace all instances of ARCH_NEEDS_WEAK_PER_CPU in the kernel
code with MODULE_NEEDS_WEAK_PER_CPU,MODULE_NEEDS_WEAK_PER_CPU might
be a more accurate description,because it was only needed for modules.
Then,when defining the percpu variable _shared_alloc_tag,wrap it
with the CONFIG_ARCH_NEEDS_WEAK_PER_CPU condition.

Therefore, this patch does the following things:
Add the ARCH_NEEDS_WEAK_PER_CPU option to the mm Kconfig file
and enable it for the s390 and alpha architectures.
And replace all instances of ARCH_NEEDS_WEAK_PER_CPU
in the kernel code with MODULE_NEEDS_WEAK_PER_CPU.

Suggested-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
 arch/alpha/Kconfig              | 1 +
 arch/alpha/include/asm/percpu.h | 2 +-
 arch/s390/Kconfig               | 1 +
 arch/s390/include/asm/percpu.h  | 2 +-
 include/linux/alloc_tag.h       | 6 +++---
 include/linux/percpu-defs.h     | 4 ++--
 mm/Kconfig                      | 4 ++++
 7 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 109a4cddcd13..ce9bc842e384 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -7,6 +7,7 @@ config ALPHA
 	select ARCH_HAS_DMA_OPS if PCI
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
+	select ARCH_NEEDS_WEAK_PER_CPU
 	select ARCH_NO_PREEMPT
 	select ARCH_NO_SG_CHAIN
 	select ARCH_USE_CMPXCHG_LOCKREF
diff --git a/arch/alpha/include/asm/percpu.h b/arch/alpha/include/asm/percpu.h
index 6923249f2d49..b164d3720e9e 100644
--- a/arch/alpha/include/asm/percpu.h
+++ b/arch/alpha/include/asm/percpu.h
@@ -11,7 +11,7 @@
  * Always use weak definitions for percpu variables in modules.
  */
 #if defined(MODULE) && defined(CONFIG_SMP)
-#define ARCH_NEEDS_WEAK_PER_CPU
+#define MODULE_NEEDS_WEAK_PER_CPU
 #endif
 
 #include <asm-generic/percpu.h>
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 0c16dc443e2f..716031d22346 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -132,6 +132,7 @@ config S390
 	select ARCH_INLINE_WRITE_UNLOCK_IRQ
 	select ARCH_INLINE_WRITE_UNLOCK_IRQRESTORE
 	select ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
+	select ARCH_NEEDS_WEAK_PER_CPU
 	select ARCH_STACKWALK
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_DEBUG_PAGEALLOC
diff --git a/arch/s390/include/asm/percpu.h b/arch/s390/include/asm/percpu.h
index 84f6b8357b45..0afc7ce9c26f 100644
--- a/arch/s390/include/asm/percpu.h
+++ b/arch/s390/include/asm/percpu.h
@@ -18,7 +18,7 @@
  * generate external references.
  */
 #if defined(MODULE)
-#define ARCH_NEEDS_WEAK_PER_CPU
+#define MODULE_NEEDS_WEAK_PER_CPU
 #endif
 
 /*
diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
index 8f7931eb7d16..f349cca0ebed 100644
--- a/include/linux/alloc_tag.h
+++ b/include/linux/alloc_tag.h
@@ -88,7 +88,7 @@ static inline struct alloc_tag *ct_to_alloc_tag(struct codetag *ct)
 	return container_of(ct, struct alloc_tag, ct);
 }
 
-#ifdef ARCH_NEEDS_WEAK_PER_CPU
+#ifdef MODULE_NEEDS_WEAK_PER_CPU
 /*
  * When percpu variables are required to be defined as weak, static percpu
  * variables can't be used inside a function (see comments for DECLARE_PER_CPU_SECTION).
@@ -102,7 +102,7 @@ DECLARE_PER_CPU(struct alloc_tag_counters, _shared_alloc_tag);
 		.ct = CODE_TAG_INIT,						\
 		.counters = &_shared_alloc_tag };
 
-#else /* ARCH_NEEDS_WEAK_PER_CPU */
+#else /* MODULE_NEEDS_WEAK_PER_CPU */
 
 #ifdef MODULE
 
@@ -123,7 +123,7 @@ DECLARE_PER_CPU(struct alloc_tag_counters, _shared_alloc_tag);
 
 #endif /* MODULE */
 
-#endif /* ARCH_NEEDS_WEAK_PER_CPU */
+#endif /* MODULE_NEEDS_WEAK_PER_CPU */
 
 DECLARE_STATIC_KEY_MAYBE(CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT,
 			mem_alloc_profiling_key);
diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
index 0aeb0e276a3e..b4ecfc3a7b2b 100644
--- a/include/linux/percpu-defs.h
+++ b/include/linux/percpu-defs.h
@@ -64,13 +64,13 @@
  * 2. Static percpu variables cannot be defined inside a function.
  *
  * Archs which need weak percpu definitions should define
- * ARCH_NEEDS_WEAK_PER_CPU in asm/percpu.h when necessary.
+ * MODULE_NEEDS_WEAK_PER_CPU in asm/percpu.h when necessary.
  *
  * To ensure that the generic code observes the above two
  * restrictions, if CONFIG_DEBUG_FORCE_WEAK_PER_CPU is set weak
  * definition is used for all cases.
  */
-#if defined(ARCH_NEEDS_WEAK_PER_CPU) || defined(CONFIG_DEBUG_FORCE_WEAK_PER_CPU)
+#if defined(MODULE_NEEDS_WEAK_PER_CPU) || defined(CONFIG_DEBUG_FORCE_WEAK_PER_CPU)
 /*
  * __pcpu_scope_* dummy variable is used to enforce scope.  It
  * receives the static modifier when it's used in front of
diff --git a/mm/Kconfig b/mm/Kconfig
index e113f713b493..2f55cc95cfcb 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -929,6 +929,10 @@ config ARCH_SUPPORTS_PUD_PFNMAP
 	def_bool y
 	depends on ARCH_SUPPORTS_HUGE_PFNMAP && HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
 
+# s390 and alpha should be enabled,see comments for DECLARE_PER_CPU_SECTION
+config ARCH_NEEDS_WEAK_PER_CPU
+       bool
+
 #
 # UP and nommu archs use km based percpu allocator
 #
-- 
2.25.1

