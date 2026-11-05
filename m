Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793859160;
	b=zUemTb5Gan2w895n09gDYWb0JIMI4CWJjMXv0oqJYCVVxsqh+cPUqV6ZKn6qaNEG7k1W
	 07YGlPDorDR2aG34gbz5F85uB+pXDFj5hL44xohHtlWhPsbcf7XGXZL2Wxw/i21KCM2YE
	 /98FPd2xwYr7uycAOqqHIGRFC5+wnVlCzWr/JfkdmOP/Kw30vm3XcSEPbjGk0rWL/91xo
	 xKrDBVb+/4j6x/yBhP3kH/IuY6o7fr9b7psERuWIpk0m27Q4LfKn78zp3pEoAugdZyGE1
	 LtVIYrWeYzchYEU+RE23VC9NuBiOf3hKCFle9GN7JmHENwh3JMgmLrWItjIEtsam6Xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793859160;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ZM306HbMXxWJth45MNpskHOeaLxazIrhxWXy+ExQUgY=;
	b=nfmFnYdFGTTqhpYkzMNT4N4/mQYjkw6HsDUiMpsBRSdBznBVnHL8M6w0mrPPWEOegvKj
	 2r3Szht6HOsjfISOAzqe/cD4B7WaMPAxK8hs/kEmXnHjTKHL5Hms3OE6E7W3rAwSii58u
	 y5s/oQuVA83oxcXdQC2r9NgemNWtrsAUEEjLyqP4Lz1Zk/l2Dz8DHfDjPnoPwYyJ+mNXb
	 PU8P/G7gPiNoENBIuFEFPRUXOK8S1SKkGXZi5rpaJ61BOb6NkanlK9wFbqx0x/ikx9jzL
	 R00cnvyv4jpjky/o5nZYDd8quBfV04tXgV+QgUhwt/lNo9vwSbyRbBuH7Gyk6Q/1dxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=O8eB4jY3;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2381D606A335
	for <linux-s390@vger.kernel.org>; Thu,  5 Nov 2026 06:12:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2381D606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=O8eB4jY3
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cdb5d64fb9dso84324a12.0
        for <linux-s390@vger.kernel.org>; Wed, 04 Nov 2026 22:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1793859159; x=1794463959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZM306HbMXxWJth45MNpskHOeaLxazIrhxWXy+ExQUgY=;
        b=O8eB4jY3AAk9OylRQlWvKWbFC3ooLJA2QNQBz22YQQ+cOlTr8iXjVUDwnvvJw7q9yv
         NY+vGrOmCZTUPIvkfR/ak1fLivYmB9P4fJ1FCWO6dWlrP290BwAL3NDueu3WcGhh/fnq
         Jz9uSTMouw+FL44T5eMuHEpV0/s+prhf3vSmAAKhwelTjgOlpnUkub/yvarAGqnYRd/G
         mVMf0EWQJdzav/yY7Zyy6BWvwT5vWMlcN/lG+aLMMQeaNQiX8mhcpyjJP8u+UIeg9ck1
         hazTu3hJbJ7de2EFbsS/y4sdmzUYmuAL2ZU8VNee7VLMF/xaui6Vdi9878+udFkdjrWc
         OmQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793859159; x=1794463959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZM306HbMXxWJth45MNpskHOeaLxazIrhxWXy+ExQUgY=;
        b=cF7NNJvcoIM5c3eU5MNSTuX1PIG2tVCfS6CKd3oxnKzhg3kg4s3jHgyZKFdueH+/aB
         M+wA0fD3jPmoD5IsoBPGycPCbV8iObhxjSLr0sUx4j6Y8ujRjOPJNQmOU+Bbas6B94qH
         dKSVDR8uN1IQ/YwZaaopnUFI6RU27NJzY8drrxJTXclb2VaKj7tSTPCp8rpFCKBEXoAj
         g1M3OI6mKoonRGONH8dPNziX90RIdvz6XMjPizIqjpckKlC6OqAjv6ejDsUslfJM/5JP
         rcHMKdy+/uns1xX9f8kkqyY9KhE3+wSa1oa+ADzzXiujFx4N/OhO+/yB77KSJzx4WSF8
         OuJw==
X-Forwarded-Encrypted: i=1; AKwUvBzd7158j6cJKp7h6t3w28ELmg6Q3GaASh5LFX4NmnQqsLFSEyC5lRFYC9BqIvl5i3jzLE4EUJld8anx@vger.kernel.org
X-Gm-Message-State: APuU4Z/38e/JYgvNx4VIFilurUUIOcXp4yxmr5urFigONPmbfnsgxZEK
	P9qpcnBEqM9wnQ7LuBq3s2327yRTMrkBjQys6m3cYBN0fB74vsHgJMsHcrcR5s5sUDS1bROyJQr
	IVid0vuU=
X-Gm-Gg: AYBFou21BDxylLSSekLVs75P/59m5GD88VNXesryQRfObg/C9QlypjUKVQBhJam9/sI
	friuupX0qYIUP5CgOE/7HclhA9T/NzkWuq4hxmSJDdCdpe5eTylhGkw8qYa5O/vhbNaOxhA6uGe
	XBl9/1JJ1rYZmY9+/B4/xLWQhMfByyEGz6SP55cYX89wChw8/0jqeWeZqAdQCV5/jWpFu/1BJIL
	kzsj5ZWCoVMMynk+0Ye9X9yM1hn66M2WmWRL3z7HnPsDWIYnmjXId6tECB5OmPq9dJ6lFDABISD
	UYMyEnyXDiz00WMYRe/zGyP+293eS7idirFqAAzpXO/0LXYZQl1KcG7vlM1ZKP7Z55y6TKZCoWH
	HMyvCjtJ4IeBUID8W3rGuocydYdaXAbX/q5sXH5vq8S0GJM2ZU7VLyqKDSdG/4dV6BQ0A/KcntF
	DWub8SLone0JGDtUWWzxLTnUbpPruFhx1A5p8Xd3cLZljRI6AEky3TwM/qM3QwPy7+j4uPBASSu
	BttJKpBZczi1z6OmIN3+FytET9ep89mzUPLhwBavXC4wNYbAlfedliMPmpQVhH3SoMCcQhsjkH7
	Hp3kk6MLbvBxSkV85weyn4ZrxZ9KrROm+qoSkBa5u71/opDW8g+6GD9QSu3iiAf85g==
X-Received: by 2002:a17:90b:3d4b:b0:3ad:eb4c:26fb with SMTP id 98e67ed59e1d1-3ae897c87acmr15846459a91.23.1793859159284;
        Wed, 04 Nov 2026 22:12:39 -0800 (PST)
Received: from G6L4RL2QG9.bytedance.net ([61.213.176.8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b323a1fdsm2107528a91.5.2026.11.04.22.12.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Nov 2026 22:12:38 -0800 (PST)
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
Subject: [PATCH v2 1/5] powerpc/mm: make vmemmap_populate_compound_pages() static
Date: Thu,  5 Nov 2026 14:12:13 +0800
Message-ID: <20261105061217.13302-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261105061217.13302-1-songmuchun@bytedance.com>
References: <20261105061217.13302-1-songmuchun@bytedance.com>
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

