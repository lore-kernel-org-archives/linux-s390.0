Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794025935;
	b=Rbg9zl6llbVCGulOI1gJlJgtr4S1dBTfg2wvTBsytWAdZn2sWuje+ZlSskeOXQP5dZbt
	 /f1DdktImLc9/Pa3pgNhNv/63ZHb3IUdKwN3V7Flesu/mxRciwC0N7JaoSFw0tbEBtwax
	 nFborkDTdEWbtLpiLh89ThdWtNXXLIupVTWL9LNRWQlqQaowLTwPTR1S4JNNcXCjbKZ9u
	 yLIZeiETUzp7/6i1NT3o1W/O6bzHrOSbQAOd1RNKsv9axfF+N63nIMDyxW7EFT8wURK4D
	 xtQKuzJpQvELEtfquJFIJUT38CgCEJz3d8tJCvrteEuS33KHgu0QNx9OWflzHidbIIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794025935;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=EjmiDhGTyjFqhaR2vuKwqHt93n+hCHkzTadeMRKHv0k=;
	b=RR86V2yb9ptJg7tVXWX6sOziBGC/yVPHgdWeZxPgj8r0vsWni97owqmZXdDkdtY8jkTn
	 h5inigWqdZRlqJvzwFg8BdaP0G1K8++WilzVohjDCw/145uHm457guS4u/Qhm5GCYFxir
	 A6CAdBwtNFe9HF9/G6IoEEcEriKCVkLV94OBSHLvpXTqi/Ag7l87dCaoqR7UhO2YjQ+R/
	 BfYUASKIeXKDyNIyPNrFwXKk9dneZpEx5C8yIfw56Zi2bK1djEjAmZzUnrxFTUMEJR1ha
	 Wb7PC14KEhOLAtVxG0rwnFVSP4S9WLW/WRXo1vRHrbYXG8AsjKEPZKNjgb+sm9erpog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=f79yToSS;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037E1606A330
	for <linux-s390@vger.kernel.org>; Sat,  7 Nov 2026 04:32:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 037E1606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=f79yToSS
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e9d7791b00so9354075ad.0
        for <linux-s390@vger.kernel.org>; Fri, 06 Nov 2026 20:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1794025934; x=1794630734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EjmiDhGTyjFqhaR2vuKwqHt93n+hCHkzTadeMRKHv0k=;
        b=f79yToSSurSiSMzxtroGBlJVoRi4X7WKuiNGjCBzhzOemiudbhjz3nISauTB2d6R++
         mliwvp/FpOAnU6ddLBopbgEGAxbUJh2aMR3iq1f9vqU66Fg0BDk+sHkNE1nvtS7susms
         PRrS/qtywCqBnxydb3Ino6xoNIq4UPklnwQ05UQzFqqXYlsDd57TftswkQN7CrNLxP51
         XUovR2yISU/0D/Ck6qFHnC1C0ZISkE1bcMoSWHa4tfX8mKMt9/l94D/JYJP0EmVNtfm3
         YiotHxF0jHsibURsIqdd/IrpvqdTzO3lT7W5Ty0kFUSa3JMrOLTE7bWFQLg2WoYKmwoB
         bSxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794025934; x=1794630734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EjmiDhGTyjFqhaR2vuKwqHt93n+hCHkzTadeMRKHv0k=;
        b=ryaIWFKGOKCvip12G2hLywnYo+DI6I7d97YH1uieNPPrrO4Fk3IUizCb3HKZHky37J
         xxX/1gT9rPXez/DC8ML2E5hBWdppHY/s0gd/G0bwEPAOTcYim7VjOlr89fjD8kNXjAtn
         TLckJslPZXvihz8jOytS/fc3Q77ZKO9aJTgqdOq15xCqWZUBCYiqkDqIr7r8bOoWqO8m
         oKobgr+MQ6P/h+DwWEmQ2o1K1Zt2Ulj585d2FxFc38zzW0r2hBW0yhwxRTtFV2Vmwe8O
         OlEAZsymgyKQMlV9xCiB16O/5gdhCa9VfJh1BoaexY3C3BM8SfyS5Bpv6mFJ7QkQ13up
         rwVA==
X-Forwarded-Encrypted: i=1; AL+hErEPXSHg1dlxjF2zTW7XG5bnwd5NupaHexjMfFpoLgC1VqpxUPxNFeVrow3huWaujyAGNnSM0VROYKYq@vger.kernel.org
X-Gm-Message-State: APuU4Z/GeCwCIUUxdq+ufgD1VSOFdRIb9KjLz5JFnvLC7dDDZYSxJLLi
	SbGuH0JLI6gK5dJbVFGFEXK2Mt4j+kNhjVSs9AJlj3WbTw/t9qfNSZtAEG00aDp3fYM=
X-Gm-Gg: AYBFou3H6PGIejl2YGHaRAkdrhgUW/wcicHJazg+DcdK9oVAlgkSZq4faN8d5wihBHX
	HQ5FXg0wp/EN+7hy1E9ZU3q+/skDy5tk+xxtsdShvmWcMwkgPygXhlk4MjbD9ile6WqOw6py/l2
	DSYezld3AffOLIgN8Bb8IYw/FxwFyViN3n0J/nugD5mVboCgTnaCyHC6JEf/EWrBVPc3CIkVuQw
	BIXlcCHKcxMxNIZX4esgUyjfkycIu1ZFw7dcHNF+2WwI0PYJOOPcCFxFe+tMAyswvpLP+DovJHl
	xfSg5ccY4yUMcuQQ/67a2FCQKSnFcOdeis7ynJQGKDQLjhvGQm6exo6ABvChO1WYAMJYcp3CFhH
	/W12Wi/Vr2fTJ04xCj58WIss0p3UDQxb1GWmHzHgcOqRe4pbne/s0mpnf9RvuT1HDPha1f9qgcl
	NRKyM0fy+uxVjKIyMwfQcOTAxC2FMYy4kW4ETI6zVuWcJnE4TDyYXjBKQAi1/pVfboM/Z2yFR9E
	sPgU4W9LLEVjbWXkqBjVQqVbrWtyH08crPAwQ0yqS5slp7VCgkcPUYv11q8rErdiQnWAFhxtFgz
	uxk4rfZsGV9ceMWp9C3DoFv+LvN8ly1uAV1itbysMwFE9bJu3Ctw/gTaJEQO
X-Received: by 2002:a17:90b:28c4:b0:3ac:8897:7baa with SMTP id 98e67ed59e1d1-3b0db7114f1mr4190441a91.40.1794025934315;
        Fri, 06 Nov 2026 20:32:14 -0800 (PST)
Received: from G6L4RL2QG9 ([2409:8a00:1832:6900:c8de:13da:804b:a0fa])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b10584b66bsm1578451a91.14.2026.11.06.20.32.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Nov 2026 20:32:13 -0800 (PST)
From: Muchun Song <songmuchun@bytedance.com>
To: David Hildenbrand <david@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Lance Yang <lance.yang@linux.dev>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Oscar Salvador <osalvador@suse.de>,
	Qi Zheng <qi.zheng@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	x86@kernel.org,
	loongarch@lists.linux.dev,
	linux-s390@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 2/5] powerpc/mm: drop powerpc vmemmap_can_optimize()
Date: Sat,  7 Nov 2026 12:31:19 +0800
Message-ID: <20261107043122.25650-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261107043122.25650-1-songmuchun@bytedance.com>
References: <20261107043122.25650-1-songmuchun@bytedance.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Whether the optimized mapping can be used is now decided in the
architecture-specific vmemmap_populate() path. When PowerPC has to fall
back, such as on Hash MMU, it can disable optimization for the populated
vmemmap range there.

Add section_vmemmap_optimization_disable() to centralize this fallback,
use it in the Hash MMU path, and drop the radix-specific
vmemmap_can_optimize() override.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
v3:
- Move section_vmemmap_optimization_disable() to mm/sparse-vmemmap.c
  to avoid the LoongArch header dependency (reported by Sashiko)

v2:
- Add section_vmemmap_optimization_disable() for architecture fallbacks
- Use the helper for the PowerPC Hash MMU path
- Include vmemmap-optimization.h directly (reported by Sashiko)
---
 arch/powerpc/include/asm/book3s/64/radix.h |  5 -----
 arch/powerpc/mm/book3s64/radix_pgtable.c   | 10 ----------
 arch/powerpc/mm/init_64.c                  |  2 ++
 include/linux/vmemmap-optimization.h       |  6 ++++++
 mm/sparse-vmemmap.c                        | 17 +++++++++++++++++
 5 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index 8452a2714cb1..df67209b0c5b 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -351,10 +351,5 @@ int radix__create_section_mapping(unsigned long start, unsigned long end,
 				  int nid, pgprot_t prot);
 int radix__remove_section_mapping(unsigned long start, unsigned long end);
 #endif /* CONFIG_MEMORY_HOTPLUG */
-
-#ifdef CONFIG_ARCH_WANT_OPTIMIZE_DAX_VMEMMAP
-#define vmemmap_can_optimize vmemmap_can_optimize
-bool vmemmap_can_optimize(struct vmem_altmap *altmap, struct dev_pagemap *pgmap);
-#endif
 #endif /* __ASSEMBLER__ */
 #endif
diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index 2924604fbb38..63f369d296b4 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -978,16 +978,6 @@ int __meminit radix__vmemmap_create_mapping(unsigned long start,
 	return 0;
 }
 
-#ifdef CONFIG_ARCH_WANT_OPTIMIZE_DAX_VMEMMAP
-bool vmemmap_can_optimize(struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
-{
-	if (radix_enabled())
-		return __vmemmap_can_optimize(altmap, pgmap);
-
-	return false;
-}
-#endif
-
 int __meminit vmemmap_check_pmd(pmd_t *pmdp, int node,
 				unsigned long addr, unsigned long next)
 {
diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index 0e777d7dc332..7329fcacdaf4 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -24,6 +24,7 @@
 #include <linux/types.h>
 #include <linux/mman.h>
 #include <linux/mm.h>
+#include <linux/vmemmap-optimization.h>
 #include <linux/swap.h>
 #include <linux/stddef.h>
 #include <linux/vmalloc.h>
@@ -281,6 +282,7 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 	if (radix_enabled())
 		return radix__vmemmap_populate(start, end, node, altmap);
 #endif
+	section_vmemmap_optimization_disable(start, end);
 
 	return __vmemmap_populate(start, end, node, altmap);
 }
diff --git a/include/linux/vmemmap-optimization.h b/include/linux/vmemmap-optimization.h
index 858311a71b0c..22e5a322be0b 100644
--- a/include/linux/vmemmap-optimization.h
+++ b/include/linux/vmemmap-optimization.h
@@ -63,6 +63,7 @@ static inline unsigned int pfn_to_section_compound_order(unsigned long pfn)
 }
 
 struct page *vmemmap_shared_tail_page(unsigned int order, struct zone *zone);
+void section_vmemmap_optimization_disable(unsigned long start, unsigned long end);
 #else
 static inline unsigned int section_compound_order(const struct mem_section *section)
 {
@@ -79,6 +80,11 @@ static inline void section_set_compound_order_range(unsigned long pfn,
 {
 }
 
+static inline void section_vmemmap_optimization_disable(unsigned long start,
+		unsigned long end)
+{
+}
+
 static inline unsigned int pfn_to_section_compound_order(unsigned long pfn)
 {
 	return 0;
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index b8b55e12f5ba..57aa5c2d8034 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -232,6 +232,23 @@ struct page __ref *vmemmap_shared_tail_page(unsigned int order, struct zone *zon
 
 	return page;
 }
+
+void __meminit section_vmemmap_optimization_disable(unsigned long start,
+		unsigned long end)
+{
+	unsigned long pfn = page_to_pfn((struct page *)start);
+	unsigned long nr_pages = (end - start) / sizeof(struct page);
+	struct mem_section *section = __pfn_to_section(pfn);
+
+	if (nr_pages < PAGES_PER_SECTION) {
+		VM_WARN_ON_ONCE(section_vmemmap_optimizable(section));
+		return;
+	}
+
+	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn, PAGES_PER_SECTION));
+	VM_WARN_ON_ONCE(nr_pages != PAGES_PER_SECTION);
+	section_set_compound_order(section, 0);
+}
 #endif
 
 static __meminit void *vmemmap_alloc_pte(unsigned long pfn, int node,
-- 
2.54.0

