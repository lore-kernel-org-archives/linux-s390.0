Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919CE18FC80
	for <linux-s390@vger.kernel.org>; Tue, 17 Jun 2025 07:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750144327; cv=none; b=bKvnFeh7unORRVOFgfORJpPaSggFuwi5rCkoqUtKUxAmHDP1sT7Ef7O3QUK/jyAqy9bRqzrqgjI0JxO0c6e7wcxJ3/1DGPpEiteKbKwiqJ+TWYUsSAdjp/n51w2vC4HASe5x0I6wwU72NUk0nTRibjTt7dn3dZhduDEvdjWRhiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750144327; c=relaxed/simple;
	bh=YWnBxnuc1USSWpP7g8iTovW2z5lSLAgum3XnacGTcRQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V5AdlKrkgYWGNFC2t4/kl2SxDpiBrTVCqCKTtIVrEQrH3VPER0dhX7sVwOjzXCDDlTchC8EgKG/anEDWDVOQ2b5kbB/3EXpkj8y0Bbzm4iLwSrbQJqyNr4XQ/zjKTui0ohK7KewJq9V35Z7oAp/Ey8kxcXcN0wupozQlKHkxLRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wo9EzbQL; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wo9EzbQL"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750144321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iWkqbsRsMPadMowH6GNW9aiYIyRsuY18VyS9juVdeNA=;
	b=wo9EzbQLBhFL4CX4cZvMKamgUfd/1J2xlDdmC/ZrSs/1GhqKR91N4H0M9O5Xw1rHpgknOE
	Nibg0+KaxJVEF94R2vJgnrF+ow7XnhK2gV19gvdp9zIE6CKVcryGeFmQ+EMZYuxw+gGrYp
	x+NE6RM8AqhVHJip7978shEGWj4HyVQ=
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
Subject: [PATCH v5 1/1] mm/percpu: Conditionally define _shared_alloc_tag via CONFIG_ARCH_MODULE_NEEDS_WEAK_PER_CPU
Date: Tue, 17 Jun 2025 15:10:52 +0800
Message-Id: <7b912b54cdc12a3437edbd50dbadfc45545641b7.1750143986.git.gehao@kylinos.cn>
In-Reply-To: <cover.1750143986.git.gehao@kylinos.cn>
References: <cover.1750143986.git.gehao@kylinos.cn>
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

If ARCH_NEEDS_WEAK_PER_CPU is not defined(it is only defined for
s390 and alpha architectures), there's no need to statically define
the percpu variable _shared_alloc_tag.

Therefore, we need to implement isolation for this purpose.

When building the core kernel code for s390 or alpha architectures,
ARCH_NEEDS_WEAK_PER_CPU remains undefined (as it is gated
by #if defined(MODULE)). However, when building modules for these
architectures, the macro is explicitly defined.

Therefore, we remove all instances of ARCH_NEEDS_WEAK_PER_CPU from
the code and introduced CONFIG_ARCH_MODULE_NEEDS_WEAK_PER_CPU to
replace the relevant logic. We can now conditionally define the perpcu
variable _shared_alloc_tag based on CONFIG_ARCH_MODULE_NEEDS_WEAK_PER_CPU.
This allows architectures (such as s390/alpha) that require weak
definitions for percpu variables in modules to include the definition,
while others can omit it via compile-time exclusion.

Suggested-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
 arch/alpha/Kconfig              | 1 +
 arch/alpha/include/asm/percpu.h | 5 ++---
 arch/s390/Kconfig               | 1 +
 arch/s390/include/asm/percpu.h  | 5 ++---
 include/linux/alloc_tag.h       | 6 +++---
 include/linux/percpu-defs.h     | 7 ++++---
 lib/alloc_tag.c                 | 2 ++
 mm/Kconfig                      | 7 +++++++
 8 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 109a4cddcd13..80367f2cf821 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -7,6 +7,7 @@ config ALPHA
 	select ARCH_HAS_DMA_OPS if PCI
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
+	select ARCH_MODULE_NEEDS_WEAK_PER_CPU if SMP
 	select ARCH_NO_PREEMPT
 	select ARCH_NO_SG_CHAIN
 	select ARCH_USE_CMPXCHG_LOCKREF
diff --git a/arch/alpha/include/asm/percpu.h b/arch/alpha/include/asm/percpu.h
index 6923249f2d49..4383d66341dc 100644
--- a/arch/alpha/include/asm/percpu.h
+++ b/arch/alpha/include/asm/percpu.h
@@ -9,10 +9,9 @@
  * way above 4G.
  *
  * Always use weak definitions for percpu variables in modules.
+ * Therefore, we have enabled CONFIG_ARCH_MODULE_NEEDS_WEAK_PER_CPU
+ * in the Kconfig.
  */
-#if defined(MODULE) && defined(CONFIG_SMP)
-#define ARCH_NEEDS_WEAK_PER_CPU
-#endif
 
 #include <asm-generic/percpu.h>
 
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 0c16dc443e2f..b652cb952f31 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -132,6 +132,7 @@ config S390
 	select ARCH_INLINE_WRITE_UNLOCK_IRQ
 	select ARCH_INLINE_WRITE_UNLOCK_IRQRESTORE
 	select ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
+	select ARCH_MODULE_NEEDS_WEAK_PER_CPU
 	select ARCH_STACKWALK
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_DEBUG_PAGEALLOC
diff --git a/arch/s390/include/asm/percpu.h b/arch/s390/include/asm/percpu.h
index 84f6b8357b45..96af7d964014 100644
--- a/arch/s390/include/asm/percpu.h
+++ b/arch/s390/include/asm/percpu.h
@@ -16,10 +16,9 @@
  * For 64 bit module code, the module may be more than 4G above the
  * per cpu area, use weak definitions to force the compiler to
  * generate external references.
+ * Therefore, we have enabled CONFIG_ARCH_MODULE_NEEDS_WEAK_PER_CPU
+ * in the Kconfig.
  */
-#if defined(MODULE)
-#define ARCH_NEEDS_WEAK_PER_CPU
-#endif
 
 /*
  * We use a compare-and-swap loop since that uses less cpu cycles than
diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
index 8f7931eb7d16..9ef2633e2c08 100644
--- a/include/linux/alloc_tag.h
+++ b/include/linux/alloc_tag.h
@@ -88,7 +88,7 @@ static inline struct alloc_tag *ct_to_alloc_tag(struct codetag *ct)
 	return container_of(ct, struct alloc_tag, ct);
 }
 
-#ifdef ARCH_NEEDS_WEAK_PER_CPU
+#if defined(CONFIG_ARCH_MODULE_NEEDS_WEAK_PER_CPU) && defined(MODULE)
 /*
  * When percpu variables are required to be defined as weak, static percpu
  * variables can't be used inside a function (see comments for DECLARE_PER_CPU_SECTION).
@@ -102,7 +102,7 @@ DECLARE_PER_CPU(struct alloc_tag_counters, _shared_alloc_tag);
 		.ct = CODE_TAG_INIT,						\
 		.counters = &_shared_alloc_tag };
 
-#else /* ARCH_NEEDS_WEAK_PER_CPU */
+#else /* CONFIG_ARCH_MODULE_NEEDS_WEAK_PER_CPU && MODULE */
 
 #ifdef MODULE
 
@@ -123,7 +123,7 @@ DECLARE_PER_CPU(struct alloc_tag_counters, _shared_alloc_tag);
 
 #endif /* MODULE */
 
-#endif /* ARCH_NEEDS_WEAK_PER_CPU */
+#endif /* CONFIG_ARCH_MODULE_NEEDS_WEAK_PER_CPU && MODULE */
 
 DECLARE_STATIC_KEY_MAYBE(CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT,
 			mem_alloc_profiling_key);
diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
index 0aeb0e276a3e..5931fcad9a91 100644
--- a/include/linux/percpu-defs.h
+++ b/include/linux/percpu-defs.h
@@ -63,14 +63,15 @@
  * 1. The symbol must be globally unique, even the static ones.
  * 2. Static percpu variables cannot be defined inside a function.
  *
- * Archs which need weak percpu definitions should define
- * ARCH_NEEDS_WEAK_PER_CPU in asm/percpu.h when necessary.
+ * Archs which need weak percpu definitions should set
+ * CONFIG_ARCH_MODULE_NEEDS_WEAK_PER_CPU when necessary.
  *
  * To ensure that the generic code observes the above two
  * restrictions, if CONFIG_DEBUG_FORCE_WEAK_PER_CPU is set weak
  * definition is used for all cases.
  */
-#if defined(ARCH_NEEDS_WEAK_PER_CPU) || defined(CONFIG_DEBUG_FORCE_WEAK_PER_CPU)
+#if defined(CONFIG_ARCH_MODULE_NEEDS_WEAK_PER_CPU) && defined(MODULE) || \
+	defined(CONFIG_DEBUG_FORCE_WEAK_PER_CPU)
 /*
  * __pcpu_scope_* dummy variable is used to enforce scope.  It
  * receives the static modifier when it's used in front of
diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index c7f602fa7b23..ab0936ebf38e 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -24,8 +24,10 @@ static bool mem_profiling_support;
 
 static struct codetag_type *alloc_tag_cttype;
 
+#ifdef CONFIG_ARCH_MODULE_NEEDS_WEAK_PER_CPU
 DEFINE_PER_CPU(struct alloc_tag_counters, _shared_alloc_tag);
 EXPORT_SYMBOL(_shared_alloc_tag);
+#endif
 
 DEFINE_STATIC_KEY_MAYBE(CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT,
 			mem_alloc_profiling_key);
diff --git a/mm/Kconfig b/mm/Kconfig
index e113f713b493..00514df3eae4 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -929,6 +929,13 @@ config ARCH_SUPPORTS_PUD_PFNMAP
 	def_bool y
 	depends on ARCH_SUPPORTS_HUGE_PFNMAP && HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
 
+#
+# Architectures that always use weak definitions for percpu
+# variables in modules should set this.
+#
+config ARCH_MODULE_NEEDS_WEAK_PER_CPU
+       bool
+
 #
 # UP and nommu archs use km based percpu allocator
 #
-- 
2.25.1

