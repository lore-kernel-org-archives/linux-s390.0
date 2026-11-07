Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794025927;
	b=rdqDea92TWXbSAwjZ1Bz4YqHsj8BXdQawIoZ3lzd9eSfFOXQmHvSQoYn1AUCcsF17ob5
	 IqskBYq9yS7kQxvQY6mZRfeLJrVw1r5lQiwTYMgkSjSXUbjTfU8ZZdDI//YyBZZGK4ns9
	 vU0POWRHRZTWfgrENkxiE4v57nqaCkIYT3ZKNNco8+mokL2DsJQAp685hgjp0CoQNtzs9
	 pt5wIjrJkznmucnV9/6vo6Jxb/mkFV1tRxyIdceA/EV3PKcDfC0JZ1l9S2DP1PMzx3MNm
	 4yjFdf3IJo6pWI4QDoR0GpFrOYUMGfnGVyKiuNaAbElTUirNOZswCft6p0IvXzG6YzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794025927;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=K3n9ukDrxII5BXz/7vbmrUFxcX10DGV7r2as+LtHfBI=;
	b=VUnBsOSw4Iu2Zo8vJi5cjOq+PD3pAu2vdsCp4B2ho/4m+2Y7vZz70W+eKubJoH4fp1Sg
	 B7+85erhtxEL6uUy6/Nj2BKmcGvASWAJL6uzdcqLaQh3K40O2s+R32jg5+kTAFlwUcrZi
	 y1Q9unVWYfTlmtceDZ92DGwl9zfWOiH3leGapZf91DBLiOzw5cA6hhacev3QmD4iHku3G
	 kuYhcUsgEZlw77JBd4dbwqwEvSchST7gxzSPxFbxrvMdumg0mFcJRWoQhXpAvL9p7PS4d
	 YEq4F9LoSjvHxtIZx9iRgsZFt1v1l3u0aTAY70lLh5tLlvYDmhzn8UPE4XnkMPafLaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=gfoL6gbz;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F19606A338
	for <linux-s390@vger.kernel.org>; Sat,  7 Nov 2026 04:32:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02F19606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=gfoL6gbz
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ed0b03ce3eso4812115ad.3
        for <linux-s390@vger.kernel.org>; Fri, 06 Nov 2026 20:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1794025926; x=1794630726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K3n9ukDrxII5BXz/7vbmrUFxcX10DGV7r2as+LtHfBI=;
        b=gfoL6gbz7sC+4qaUUzZU3F5sKIoW7fiqAv6KRiZYSBWtSgSYfRDkFrOtv+KD5f29IN
         DsaAXTM+KeptHJPCBqWi3utmin35YdsAQ2ImiexJJqwlRvawZvZW22oIPzcBZ89cK+Ld
         o3ySrqHddjsknuvfg8VRVgnVHkZQnRGf+Z4aL2rDfPGatJztN5qCWEOquj34aI0/ETgo
         NxryZentDCQo2RAeVimSoDybXeGHScW9+bF0BN2G9rX3J4UaOHpRbXv8OC3DT3tjjy28
         70RV80ChiyVGHnMB60dp1NZYTa31hWk0cYcUKLVTkK6OcHm4ubfX3k5HLd7fDHcCR34Z
         RRvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794025926; x=1794630726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=K3n9ukDrxII5BXz/7vbmrUFxcX10DGV7r2as+LtHfBI=;
        b=m/fEPkrZTJvlrOV03Hd0N2YvriwRyPB/r4JjQsC4/InCH2ALdXJxOqr9ZAODyzYsgI
         vGY/kLhJddXNs4WPZFA5nTLud9uxJajF81/+LGp0nnT8+JWJWnzaLz+qLI0KcWnThnx1
         SeQ+2iVy+9P/LdzymG5hWGeR5uyBJpGqYI6HOdrCVHr+o7JugW/IvNrJHbP51eLju3BV
         WIwrhp2SdaKngQ3eGjyJdt+3XXuO6xDb5BE7/T+TGngZ/5wQIwmaAV3V08bY2dmp68Va
         nGfMD9xyTCO6DBdSzNH6rjMC+z1Yfdpt3j4lE4A/gV3wK6qFAALktINoXRx8gOn2ab17
         S+qg==
X-Forwarded-Encrypted: i=1; AL+hErG75X1hoQTTcbk8iiQIJqNJtJDfVF3ZSdkUM7oN/zLq6XIsevYn7OuSl/fnR66547mHqj3HWjIOEz/f@vger.kernel.org
X-Gm-Message-State: APuU4Z8x9s7b+EslO0MZbmXMlYE9OxoHOqBMU++IC1yjY4nCl9uTp1DD
	DzayY90OAre5K8PIx2akyVdwSOmyWflr9JX2Jb8U4LRveS1lBcuTdCuK3KHD9mcB7gw=
X-Gm-Gg: AYBFou3FM3fKevzA2OKjwMqStH9FtwjegEEp92N8mPLFuUFcj2R3SbYEEUkj1hF8tCp
	YeUSL5NDpTco1isRbnOW3S94NqBsRpzLPGgcw+VOn1VvlGbIXE1srEb+6Fk2T74qGj9fBLxPg61
	a6fZZnlYaR2ON5dBqi7qcpfwIi00VTjY8P9oBFyAGeUsWoPbhmqVIEXk6N8ILjp7XgmrxKAqhHy
	4g26IMPK83AHE6HWIEYRQa8RP6Xy7wlhbrIsJqSizdEZ5XORh2wfIxW1mZxw9Ty7Eq4jWy1gZje
	cMCgGt33buzyma8kpVa3+Hwix+fZh/UlFIVEibRZDsdkwkNrLcBYVLlrvK4uACqu9uH/gvQ2O/I
	Ot5d0i3XDIet0a9jbG4hK6w+9AX61aul1ucHGlcc7+0RXYUqKU1QXfS4isCu00IzaL0BMHEiCiP
	qIVxw8zDJljl4yW0+xSwHEgpyG1p9wZXWxazAtpK78Y2KuV45o7foTySPrYHi3XyS0LPca8R90F
	y6i/Vb2pyC0we9U4pgdP8bK1vM9v2YTdruBgkTpFjDKyp/GL8rmjo3lhvTuTnI0gLCKkV4d2NtZ
	YBYaZi8r1vGth27Zh52Trl0713dg00ycfnhnqeWOYo4VYIeBg5XimtvZAlu7
X-Received: by 2002:a17:90a:c107:b0:3ab:36c4:b4ff with SMTP id 98e67ed59e1d1-3b0db6b8083mr4981632a91.24.1794025926246;
        Fri, 06 Nov 2026 20:32:06 -0800 (PST)
Received: from G6L4RL2QG9 ([2409:8a00:1832:6900:c8de:13da:804b:a0fa])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b10584b66bsm1578451a91.14.2026.11.06.20.31.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Nov 2026 20:32:04 -0800 (PST)
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
Subject: [PATCH v3 1/5] powerpc/mm: make vmemmap_populate_compound_pages() static
Date: Sat,  7 Nov 2026 12:31:18 +0800
Message-ID: <20261107043122.25650-2-songmuchun@bytedance.com>
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

vmemmap_populate_compound_pages() is no longer used outside
radix_pgtable.c.

Make it static and drop the unused dev_pagemap argument from
its only remaining caller to simplify the code.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Qi Zheng <qi.zheng@linux.dev>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
---
v3:
- Collect Reviewed-by from Lance Yang
---
 arch/powerpc/include/asm/book3s/64/radix.h |  6 ------
 arch/powerpc/mm/book3s64/radix_pgtable.c   | 13 +++++++------
 2 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index da954e779744..8452a2714cb1 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -356,11 +356,5 @@ int radix__remove_section_mapping(unsigned long start, unsigned long end);
 #define vmemmap_can_optimize vmemmap_can_optimize
 bool vmemmap_can_optimize(struct vmem_altmap *altmap, struct dev_pagemap *pgmap);
 #endif
-
-#define vmemmap_populate_compound_pages vmemmap_populate_compound_pages
-int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
-					      unsigned long start,
-					      unsigned long end, int node,
-					      struct dev_pagemap *pgmap);
 #endif /* __ASSEMBLER__ */
 #endif
diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index ebac5f9058f6..2924604fbb38 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -1117,7 +1117,9 @@ static inline pte_t *vmemmap_pte_alloc(pmd_t *pmdp, int node,
 	return pte_offset_kernel(pmdp, address);
 }
 
-
+static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
+						     unsigned long start,
+						     unsigned long end, int node);
 
 int __meminit radix__vmemmap_populate(unsigned long start, unsigned long end, int node,
 				      struct vmem_altmap *altmap)
@@ -1132,7 +1134,7 @@ int __meminit radix__vmemmap_populate(unsigned long start, unsigned long end, in
 	unsigned long pfn = page_to_pfn((struct page *)start);
 
 	if (vmemmap_optimizable_order(pfn_to_section_compound_order(pfn)))
-		return vmemmap_populate_compound_pages(pfn, start, end, node, NULL);
+		return vmemmap_populate_compound_pages(pfn, start, end, node);
 	/*
 	 * If altmap is present, Make sure we align the start vmemmap addr
 	 * to PAGE_SIZE so that we calculate the correct start_pfn in
@@ -1228,10 +1230,9 @@ int __meminit radix__vmemmap_populate(unsigned long start, unsigned long end, in
 	return 0;
 }
 
-int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
-					      unsigned long start,
-					      unsigned long end, int node,
-					      struct dev_pagemap *pgmap)
+static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
+						     unsigned long start,
+						     unsigned long end, int node)
 {
 	/*
 	 * we want to map things as base page size mapping so that
-- 
2.54.0

