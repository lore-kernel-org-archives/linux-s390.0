Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A8818E028
	for <linux-s390@vger.kernel.org>; Sat, 14 Dec 2024 09:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734167111; cv=none; b=hRgrgp1xoEL4PYooeqmky1iNjKsPewkEZz11S+fHKPjroQLAgyghZRIQgQn/1N6JhY0JdAyf5B25GF7xYU21Ms7sOKQDQ/RzRwyv930Z84Vj/gRJbEavK1HlVozIDzGr3vVhS4//xgvviHSWIfhjgd1WqnY9a0VI1X0QPPupczM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734167111; c=relaxed/simple;
	bh=dUn22uFUF/7Q2aX8/sTNpsqlDbyw/AbPrg+Ofum3Ioc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SCSlbzE0O1c9o9T116b3UgyV+QU1E4hrhlXaxOZS/7up/0TDpcq/Ex7fXEHI5TowVSqlq8U+llEimBrKmZtiwDUr1rxoiTzlk3SVoZVUnn4yi/SM1iU6VMKyQz+SUrLOrpKF/L1Aeau9IafRUj1Kv4DlnGLGxvXktYQqfG2swdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=EkJs1S40; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="EkJs1S40"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-725dac69699so2193758b3a.0
        for <linux-s390@vger.kernel.org>; Sat, 14 Dec 2024 01:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734167109; x=1734771909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eMqrm4pkcrZJ7adK/0JGqqs1dXiKNR49XOWaF/ar7JI=;
        b=EkJs1S40b36UBcQ5tUf9/vhozXD4UmwBoav0utIjGg4O6vI87BIvXEcRBESTFU0jxA
         kinWKUyncOnTcS0i9Fbv0ON6LZZX9H33oWjAbCGrS1HkbiftT8zr+ReTpScQbaInnsm2
         dvBp553B55mShlO/mo39Tii4GpIsm9L5IYJT2RC1ZQ8SpkAfpLtJeJK1qvvf0+oXa6Ok
         T5sf1ovXb1U9w5v9psnSDheggAZUErRkndv/Bf8dg1aEDjfuwwLCl/Fq1vu+6SiXxogC
         F59pck4XW8mkJT9Y+MhBSTwlMxeCOmM6HK+O3ylpUZKdHyg16Hezfi5S7o7cmroCjbLA
         urTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734167109; x=1734771909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eMqrm4pkcrZJ7adK/0JGqqs1dXiKNR49XOWaF/ar7JI=;
        b=XRlcuEPkV9eOqqHwbP2+R2BqkA7iEd9lGWk6Oyqay8j508SbcLiqaaYR0oJ/OcU1/F
         XOONi6D8fNfrLd2k8eivJNCJX0sLgCzUIzz/ZIgKmPTXDclEmJMNWkFFYgrPak6njxaB
         4de9BxyQ59Kj74YmYLCQk2k5oXfqDXa/JtUkPk7yoiGxHwJqhOgUwLbNxI7LJnglowVy
         J0mgihuCMzgbXr5bK52vSh4hTDfKc4e3ZeQeoM7YpWbyxRqb3Hxh7Rn919JqpQRQtxqt
         7VdiqYs1mhyarjMkUTBNzzyiSKLP6p6URHbi6sCKmAbSbPMvp3vFpuwkzMI4iSzDANgb
         c1fA==
X-Forwarded-Encrypted: i=1; AJvYcCWAIS7uaSrSjDmMmkkpkMPL9SZi1HvAbCgMANyxi1m3BNhFt01u5wXd2oO42iSA1N6d2oPX0Ae5//TM@vger.kernel.org
X-Gm-Message-State: AOJu0Yx49HRqDKgYY/9bufZYqeLXoLnlj8L6C30HLEE+U5Mi2g9OMUzc
	HwVRp6ToU6p7ZKzVZqYGK32UJVqZvceLJCmh8vCKQ8IavkPsahtQhc0B8RdrKJA=
X-Gm-Gg: ASbGnctGltU5YaYMrdW7vLyqno/iQzDry34rEQFi23H8QxZ9hnx/hQICjmRmR3EOu+5
	Xz07prBsVIylOFMA6eQdwGHiAigNP7GrE944pjBtPUd8IAn9Mol8fKYgN0gIm3iZCMvMiidpxyu
	KK60sGnYDBq/+WqjBit+R2+4ylQwEb3Y0EU9ZkJiST3SN8CJOiVknd799ycdkboGkYw6YftFtN0
	i68AXQHClMtdOR4CsafZa3Lg5PpvS4z25x780qPcqZNR9us0WxXn3IQTawXLeTY7mx8T+V4t/v1
	1XfJpd6CB8rq0y+byuzJNSFeuU1y8Q==
X-Google-Smtp-Source: AGHT+IE/1mbbP4uNRetgOIypjg2bvSDj3GWH/cGEc/xqzPLinfL2kdCDxCigFtQu4L9Hg/0wQ4NEdw==
X-Received: by 2002:a05:6a20:a123:b0:1e1:96d9:a7db with SMTP id adf61e73a8af0-1e1dfbfc129mr8345681637.4.1734167109554;
        Sat, 14 Dec 2024 01:05:09 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([2409:8a28:f4f:a9a4:5d46:4ef0:daa9:1db8])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5a90ba0sm905731a12.16.2024.12.14.01.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 01:05:08 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: peterz@infradead.org,
	tglx@linutronix.de,
	david@redhat.com,
	jannh@google.com,
	hughd@google.com,
	yuzhao@google.com,
	willy@infradead.org,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	lorenzo.stoakes@oracle.com,
	akpm@linux-foundation.org,
	rientjes@google.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	linux-s390@vger.kernel.org
Subject: [PATCH 10/12] s390: pgtable: also move pagetable_dtor() of PxD to __tlb_remove_table()
Date: Sat, 14 Dec 2024 17:02:56 +0800
Message-Id: <1e87efe43e9b8b679384e947dd8503715dd9faf0.1734164094.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1734164094.git.zhengqi.arch@bytedance.com>
References: <cover.1734164094.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In s390, the pagetable_dtor() of PTE has long been moved to
__tlb_remove_table(). So similarly, also move the pagetable_dtor() of
PMD|PUD|P4D to __tlb_remove_table(). This prevents the use-after-free
problem where the ptlock is freed immediately but the page table pages
is freed later via RCU.

By the way, rename pagetable_pte_dtor_free() to pagetable_dtor_free().

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: linux-s390@vger.kernel.org
---
 arch/s390/include/asm/tlb.h |  3 ---
 arch/s390/mm/pgalloc.c      | 14 ++++----------
 2 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/arch/s390/include/asm/tlb.h b/arch/s390/include/asm/tlb.h
index 74b6fba4c2ee3..79df7c0932c56 100644
--- a/arch/s390/include/asm/tlb.h
+++ b/arch/s390/include/asm/tlb.h
@@ -102,7 +102,6 @@ static inline void pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
 {
 	if (mm_pmd_folded(tlb->mm))
 		return;
-	pagetable_dtor(virt_to_ptdesc(pmd));
 	__tlb_adjust_range(tlb, address, PAGE_SIZE);
 	tlb->mm->context.flush_mm = 1;
 	tlb->freed_tables = 1;
@@ -122,7 +121,6 @@ static inline void pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
 {
 	if (mm_pud_folded(tlb->mm))
 		return;
-	pagetable_dtor(virt_to_ptdesc(pud));
 	tlb->mm->context.flush_mm = 1;
 	tlb->freed_tables = 1;
 	tlb->cleared_p4ds = 1;
@@ -141,7 +139,6 @@ static inline void p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d,
 {
 	if (mm_p4d_folded(tlb->mm))
 		return;
-	pagetable_dtor(virt_to_ptdesc(p4d));
 	__tlb_adjust_range(tlb, address, PAGE_SIZE);
 	tlb->mm->context.flush_mm = 1;
 	tlb->freed_tables = 1;
diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index 569de24d33761..c73b89811a264 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -180,7 +180,7 @@ unsigned long *page_table_alloc(struct mm_struct *mm)
 	return table;
 }
 
-static void pagetable_pte_dtor_free(struct ptdesc *ptdesc)
+static void pagetable_dtor_free(struct ptdesc *ptdesc)
 {
 	pagetable_dtor(ptdesc);
 	pagetable_free(ptdesc);
@@ -190,20 +190,14 @@ void page_table_free(struct mm_struct *mm, unsigned long *table)
 {
 	struct ptdesc *ptdesc = virt_to_ptdesc(table);
 
-	pagetable_pte_dtor_free(ptdesc);
+	pagetable_dtor_free(ptdesc);
 }
 
 void __tlb_remove_table(void *table)
 {
 	struct ptdesc *ptdesc = virt_to_ptdesc(table);
-	struct page *page = ptdesc_page(ptdesc);
 
-	if (compound_order(page) == CRST_ALLOC_ORDER) {
-		/* pmd, pud, or p4d */
-		pagetable_free(ptdesc);
-		return;
-	}
-	pagetable_pte_dtor_free(ptdesc);
+	pagetable_dtor_free(ptdesc);
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
@@ -211,7 +205,7 @@ static void pte_free_now(struct rcu_head *head)
 {
 	struct ptdesc *ptdesc = container_of(head, struct ptdesc, pt_rcu_head);
 
-	pagetable_pte_dtor_free(ptdesc);
+	pagetable_dtor_free(ptdesc);
 }
 
 void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable)
-- 
2.20.1

