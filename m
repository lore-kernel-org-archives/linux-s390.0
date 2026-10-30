Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793369316;
	b=49btQDuJ1XEcz569gJmeK8Gg5qZYiZVZkw9ARpNIPyXl9HB8lnRC6pVPn5kpRsMNQ5sE
	 Uq3jp8MLB17oGachFptVk1Uw51wyfU1SDiG4JGsnk+Cn8YmD3iAU8F5pLIUDOCrHXLOyc
	 3XBxxinL+xkLqEjUJ4DwNRnXd3khfkf+CPS41niqCDihKrHPJYsMPaqU84u+fTCQil9ed
	 DAqm5ruJDyVO6y8OGSA6ltUXYGwUrL/WAud2UqI9aQ6L91pgDlcu+Mh3EDKe+BMczlWOb
	 Xd7BcQjVp6ZmpIvGK7J+xDKiF+CuGK98rSuNkP4vmc9AcLQZm4xd4ZEYnogBZK5W16g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793369316;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ZM306HbMXxWJth45MNpskHOeaLxazIrhxWXy+ExQUgY=;
	b=IiG8gr04vd64MlDYVlf2Dx9s744G+qry3hkpynYGQUunZVreHy7igGpAhINSK7oU2yME
	 /CTC4Lh1Iavp+dJew7nVANemnhrq3lFCvTzaonBl7LYEdp8l1xIuO5BrpWQV4ZmhPu0cD
	 qXor1IYKn/5+++3/7d7vqZ1MTswLXDrwUwzMw8q26ELgRshxOtYorEBIdPztDn4IHjUXC
	 GAUvkdccDn8sjihQdTdh8b50bwcz4rnafyZQAnCe0iM9k96/f+79Wg1hFCztSc+yEH9n+
	 lHbJmGbm/4Lve7XLaJR7b8aBdYwESUk1+i60iMqTIwr6pvupPik39J8UmZOcOgSaxTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=gbSSMoj+;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BC2606A31C
	for <linux-s390@vger.kernel.org>; Fri, 30 Oct 2026 14:08:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46BC2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=gbSSMoj+
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e985106c0cso7144905ad.2
        for <linux-s390@vger.kernel.org>; Fri, 30 Oct 2026 07:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1793369315; x=1793974115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZM306HbMXxWJth45MNpskHOeaLxazIrhxWXy+ExQUgY=;
        b=gbSSMoj+i+3E3lV5kkiiczjkNZLjr/tmaMTSNaSbzTd4mZAKoNkUe5ffN+kezZM5ts
         YkVFw7JMIjQB2NxlpAFRbBZb3Q0iU5xNLpu0dzXD55wQBzjqU9ffyxGPmbYGdlvnuF1h
         BrGZGQ/1y8SO8JrslKd6dJDwtXp114IM0UqkUI9tYuHHA/aCwFcCKYEa4YJpeH2WsfYe
         Qnzgzuuan7JOt8ba+xvsn2cdiNkCczfKU05jCWFOpJ6tkiPPtWz7h7LDijJaSoSG2yjF
         ccuGEAZmliuDvVE+QUOLjdmwNsqkc1tp/6S0vC1TEGesyF2cQmJmy7Knh41Dfj/C8W/Z
         o7TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793369315; x=1793974115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZM306HbMXxWJth45MNpskHOeaLxazIrhxWXy+ExQUgY=;
        b=zjpI9yeJpryGrenCroq4nOjR+iYbGQz88KwAzgWbTi/kTZ3SJDjdtyxiFcu90+KrL+
         cmL2yg06pEd1gS+wMipZycb2+5uRhK4ZLhAuf2TyEprhtOX07WwrRZTdVkwDWpSj0DSw
         MEHNdaNabBfUX5402GwbTTUy451DlHB/YWRL/ReiSGkH1018FiikOauIF3QV5cUMbflr
         RZmdQ5yvlSWTcQvpifN1ZNLzxv/Wl+Zx7km3M3jDj307RDZ0d0unBdyZ7RvngLZ+UjYn
         m4j/GOnVVp2nYDlU1NTw1tDCvv4F4ww+EONqCJpJSjlPi+S1A+EMTwk7lIT85NFalpGt
         Q75Q==
X-Forwarded-Encrypted: i=1; AKwUvBwY64wWh+EvX042yaBRCpPjP5EOQI6dgixy0AGcwWUZzgUFXAuRT92tJidxX8O/RfYhz22x1XRQejwN@vger.kernel.org
X-Gm-Message-State: AFq9FYJW+01NeBnJwEwj6nlz7hbG4CgogZucz/Rc5+6WSInV8eF1M/n+
	HwgdjKH9Pw7IGZnUKhYknrkYzoWtyXWBbC0eq5gtzU9m3pfLYsjNhJIKzDL3tia2vso=
X-Gm-Gg: AYBFou0gu3FRkFOVS3IEH1aAFozLOvcUVN+gC/YCpSCnFnq1+zxjCKjLE2i+IniSa8M
	86jx4UPyunILeGZXpHo3fH0JugoRNMBG3C18CYrsQ0NHKK9yiYLdrxu/9yhuiss/TRcWsvyFFQ4
	9THdpraTYT0jYxbqDrZrMoynUHWluEYwRpmBILiDOzWaSexGTxfRSo5QXdA4DmXMaKN7/276Ww3
	euWJrDApIoNBdUUbm3jUgglSkzwGdrMN99Su0xoVnUBXBo5HJm8EiOdgVKE9CZWVu+gxxuAeo1x
	mVsndEw8pG1N1PjhmvnXYRbzMDziabdtNEWVUedp3hbSPvtJ8TeYE/MinFqE8aUer/MP/Qu9eb8
	0CGfmITquhXAid4X0ce3E2+7GlFAfZYrOj8aAQnA01cloz1eOP3SLw8IpeI9icySV0lyZYLFwt9
	UITi29KZ0eSZb/rFtf8vPk5ySSJX9biwTjZZb711Og46Jgi0VWpQHAEH9QLmbvE1HXJ4yTMNOT3
	5KLmHZr3G7QPkN0YuYqN5wrPg7iWPVPDyfunRVXBq0G2nzHiaxgVpwK/cuXCFsB44HnBnyx+//u
	0xYdFo4+ChoNMXn3F0xXK9vjQ9A2iChX0apMQ+dZhVhJi3IF6Lo=
X-Received: by 2002:a17:902:e5c1:b0:2d6:e9f3:9305 with SMTP id d9443c01a7336-2eb36414ef0mr26789535ad.5.1793369315295;
        Fri, 30 Oct 2026 07:08:35 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.100])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb3929b27bsm7601795ad.62.2026.10.30.07.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 07:08:34 -0700 (PDT)
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
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	x86@kernel.org,
	loongarch@lists.linux.dev,
	linux-s390@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 1/4] powerpc/mm: make vmemmap_populate_compound_pages() static
Date: Fri, 30 Oct 2026 22:07:17 +0800
Message-ID: <20261030140720.1256062-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261030140720.1256062-1-songmuchun@bytedance.com>
References: <20261030140720.1256062-1-songmuchun@bytedance.com>
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

