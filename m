Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794025943;
	b=1UFO5PNean1JSARk+lXHwChkfIHL9O1yXJPrZ6D/0WX48CnC0KMoDw19cb4zYU8e8GTS
	 HYxWbf/U4zOEi94sqcX9/hP4aJgpl4UJQzJozrwGz9a0rYavZPQhaZQZOOh3z2OX6B6Ej
	 EnQWdP9j60nFfST0B3Tjd2km0/6QQGWucdabtCbTc1Y/HlTHPKmd86EkuxDw5hgaaw4m5
	 nv7B0wYlULy15alHSoiUXC/gVLPJ8CpN7tnlRvvIPOuWaKl/vELW2NzFAG5g9Ef1x+oU9
	 DFVD8gbD7Cyt6eXyGW66MTUFTlBlheqKWp9NVI0crfp2oPHqf1lRxAYm5yK+uOo6znA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794025943;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=/SKim++0/v959SqW2Qj0ZN00Ia9M3Z26xYKJjxKUd6k=;
	b=Hviu4TGld9sLvaCBrej7gbyFz5+DLHPAHpAWMuT9uk11QLzsYYOooCNrgEGUvId4l7go
	 p+mpA5+ZSPnZBnU6lI7bSfHU5vjMcczeIaVye9qyHCGhde0kH2OJ7N2CR8bu+DgdMlDHH
	 6jQxpVVFBc63aKXfMTg/prxc4D4um86o94LvxRP7LgdYBKGEpOBnxa/GQgHqIZU2GxAhm
	 rGj2rRZwEZnaDUr+8yBkKJxn28Qm78Kqi+ULN6kKjGKKq3TrHg6XkPSgJxLLxesdRgFhZ
	 WdHZ8zZRzDimY5xuuFFxKtCZSte6akFtOTz7B1FkuwbfES0E0XK0D08olPyTlRdPTGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=loVf2gVI;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88762606A332
	for <linux-s390@vger.kernel.org>; Sat,  7 Nov 2026 04:32:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88762606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=loVf2gVI
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc758830601so859629a12.2
        for <linux-s390@vger.kernel.org>; Fri, 06 Nov 2026 20:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1794025943; x=1794630743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/SKim++0/v959SqW2Qj0ZN00Ia9M3Z26xYKJjxKUd6k=;
        b=loVf2gVIFOLlAe/RHEvexPPlHCmveUBZYdCWclU1V7yikOIfY0XBtPbgjJikM+EbnY
         oKEQijHnEEdUhi6Iu6UNRc7mHSVd7iD3uu4O+huZf11+ONHFPo1ohF1fZib0/NXXT3Vx
         roFf/pEH0bOwjyPJoAykXDs7KI3hTS6HXy6v87eoDmZBGpzqHACbZ1ZLvLHcayRA2usC
         BqDI2G/OI00G9eDeQJlmY9kow6p6brs38TvGMu0AwiqAdzR8DsOIg227sYIhTX73WOwQ
         cOCd2GWISVedBqx28YIoyNUgNWSJg4+A3YljMBf8g4hYMc3okwzCZTvvcK7wrNx01B6O
         ZCow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794025943; x=1794630743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/SKim++0/v959SqW2Qj0ZN00Ia9M3Z26xYKJjxKUd6k=;
        b=rXRLI46iNoAvF9ZGGPIPD4QXNKOoEh1mbkjl40tdCmPEyf5QbCY3U6ODQP1NNA3AT7
         1iQZS7lpaoM3LZ31Z9oEOSD8yS65cKqQ7+fjRj7bVJZn+ORFyZtSD8sNnG6M6Qg5uUhR
         RzXFI0Mtd25Nb7Ou7OdPWm2dK+biDU9JRg563tk3lTG7AcXAQ3kWa+2PwbPIELc+ZALs
         Z/aHpouoPhQ+WaRslUmU38fddllBCyNt/KZPHDr4m8FAgSFIm3wBgeQbrCFnTLyIHJrn
         NUwBshhHW7Lomzu1PfeRYTZJGOLwZj7oiCRvHnGpdlXi/owKvfX8I7Q+7CJR3hanDAEH
         Tbcg==
X-Forwarded-Encrypted: i=1; AL+hErFacIk6TEF1MgPtkvvKxxc2uuCYazA9OOrb83ifzHP7pR74ZqjMdLeZ4F1CVS955QgCMCvzNCAfpP54@vger.kernel.org
X-Gm-Message-State: APuU4Z+1Hyn6HsFrExoQasSA11jhyYfs5hLSNHZoiua1A5OwMZ6adwq+
	ldyG5xerQ15TZ1u793laKO4Regb05mzlLtgGa0SztSIeD3q1ETO6Um9HhjKsjdY6F/c=
X-Gm-Gg: AYBFou2qlPj9fa5hXCke78CeNz8twJw8S9GXW3dDwmSoOiIHKUDSVrg/WqP8MDu7/VP
	qhH+BMWp1O+zen978u2nT1OxlcaKns/9IZeNtwDSVrUliOIARxn5hKuKYTf8iDPDfBGwxaX5KhG
	bpgG4PD2mbG+z1URgYSZVf63OqsPiXiAsmklX7eBD/VaTWLY4d2J/sorkOAE92PBQ/p8vV16YAW
	Q61R8I4mNcLOHxlh9NaJSDWlH5qlKVlw2YPxryuIM0ynAxBhJWEmXhMBFA47Ad45R0lX0kNQxZ1
	jHQsgCyqehm4Yc3e0MTaZ/PFgCrznJPU5lwKXfIkzLC8rh58l+zJQ0zjK1c2A4W0ZOGh8CMcgBJ
	G8ZB8zHF7YQupxgBfIF3sO+S1kbp2vUQ2vtjM4+Lbkc+qMXCT/4nAg3y7S98VzDQguPwqHBzsFu
	+g8yQsilT2D5ffOI7lOoHY5Ud/4Rs13Ah1S8RpPLzpxplMQ5WiuUC4edYBpGX0Z8iRumZg+w9eb
	XjLfCNGIE/uOLEwxYdCfa7g8okfhABd0SSFpiQJ+nkj+lIIyE06eN7QwF10DO5uL/X8X0C1gnmv
	WBNf3m46YiCr9g//PIg4i1MfKDnlpvjYKQmR8818qdWZtDhsSora9qoY5yWA
X-Received: by 2002:a17:90b:5608:b0:3ac:c024:b275 with SMTP id 98e67ed59e1d1-3b0db605906mr4825186a91.9.1794025942667;
        Fri, 06 Nov 2026 20:32:22 -0800 (PST)
Received: from G6L4RL2QG9 ([2409:8a00:1832:6900:c8de:13da:804b:a0fa])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b10584b66bsm1578451a91.14.2026.11.06.20.32.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Nov 2026 20:32:22 -0800 (PST)
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
Subject: [PATCH v3 3/5] loongarch/mm: disable device DAX vmemmap optimization
Date: Sat,  7 Nov 2026 12:31:20 +0800
Message-ID: <20261107043122.25650-4-songmuchun@bytedance.com>
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

LoongArch selects ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP but not
ARCH_WANT_OPTIMIZE_DAX_VMEMMAP. Its vmemmap_free() implementation is also
empty, so it cannot tear down optimized Device DAX mappings.

A later change removes the generic Device DAX architecture gate and lets
vmemmap_populate() decide whether a section can use optimization. Clear the
section compound order in the LoongArch path so Device DAX keeps using
unoptimized mappings.

This does not affect HugeTLB HVO: LoongArch does not support gigantic
pages, so HugeTLB does not use section-based vmemmap optimization there.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
v2:
- New patch using section_vmemmap_optimization_disable() to keep Device
  DAX vmemmap optimization disabled on LoongArch (reported by Sashiko)
---
 arch/loongarch/mm/init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
index f801f7097f03..ea769e479241 100644
--- a/arch/loongarch/mm/init.c
+++ b/arch/loongarch/mm/init.c
@@ -15,6 +15,7 @@
 #include <linux/memblock.h>
 #include <linux/memremap.h>
 #include <linux/mm.h>
+#include <linux/vmemmap-optimization.h>
 #include <linux/mman.h>
 #include <linux/highmem.h>
 #include <linux/swap.h>
@@ -143,6 +144,7 @@ void __meminit vmemmap_set_pmd(pmd_t *pmd, void *p, int node,
 int __meminit vmemmap_populate(unsigned long start, unsigned long end,
 			       int node, struct vmem_altmap *altmap)
 {
+	section_vmemmap_optimization_disable(start, end);
 #if CONFIG_PGTABLE_LEVELS == 2
 	return vmemmap_populate_basepages(start, end, node, NULL);
 #else
-- 
2.54.0

