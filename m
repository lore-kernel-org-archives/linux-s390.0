Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7648419CC31
	for <linux-s390@vger.kernel.org>; Wed, 18 Dec 2024 13:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734527181; cv=none; b=aeYSyFees0vbNniT5dWpvcSDVbFrrntl8BSLtK+wTSNzro3Rzd25UvxsGjYytpht3qKulARYLY0cjDM6XqY1iZn0iK3skIAH7kz6FYegV1raxNHklWrRshWfRnQZ5ynmJYSMC5tnBLmRbzPmtsL2gZ+Fsy8H2iTBaVqkY3ags/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734527181; c=relaxed/simple;
	bh=EkdNyEu/xMej7Pyo7zL4QlgTElqHC2seEuKnGSW3Tk8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IPnpxkYKlz41Owa+ay0M7x1EtvIVkpef6k+cEltmmBrMqQPgc1L/Je0M3FD/A6NKecFidM1UUvfUTpg7MyU/SbUnz6NlPwSnsVby+HUAtoAfGmZMZCqRoSV68vnoFP71m8bUZ7Wpc9at59nhFGFGgmhOfEo/ALjpjg7mW36oEi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=MH0oF+G1; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="MH0oF+G1"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2164b662090so51901075ad.1
        for <linux-s390@vger.kernel.org>; Wed, 18 Dec 2024 05:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734527179; x=1735131979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Ahoctd41Xu7L+7olWYCaTwfCpap8BqbvCHiRFQm2vo=;
        b=MH0oF+G1vSbumryty/6/5cVbka9T1WBVFiQ49sPhATE4mEsSnV4mzYmEGUHSrkqPCw
         t12Ni1OsgKWI4/MOsnwRZMZeIFt/VDBenHhFz4pfXGM4IhCIXlXj7o61h+nLpnnL8H+Z
         Oc7SFnpCxlrhpld3STpkcYj8kXoOjOqLwSZu64A52vgjYVM/FRmMRxT809cN1pBTxjH9
         Q5fqENHAk1TaTLopc0Rm5r5n1MxrYeiosxbaZNzm1osWXXA8ByC/Ye9X9CIqazR9UqEA
         f4FFoOGPny6kkPAXZio+UcW0q4YDhG4+9Rd35LDB5NJW85CgTupRtltdCDRzIM1tueW7
         1aOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734527179; x=1735131979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Ahoctd41Xu7L+7olWYCaTwfCpap8BqbvCHiRFQm2vo=;
        b=gX0XEP9lX5P05S8Azans40Qbu3VefDJnnHS/Giz6maDAZTBU5fEOTETV3yULNfnvFv
         4MYymum/zsS0rVsuR2bvHcTSX0qbPbdd4F22znQ5bFr9VqYUyXG8yPb9ehIbQB58UJm/
         oaOrebhg5imvIVUfXFzMMOJFkZbObzQz7oZsqXJoNQrAheXwe16TImc/KMHFpjA82oDx
         NypOSnwJN8W+uOlFkw++i4IarqtRoWlJtoAU1y5alqIzcLahBUORRE4XDjz1tSZpaxlg
         NXNdCX0k98cduYENmKcDN6//cSTJMAB73locptIG0b/51SVWE0afoHm3mte2SRbAdIJV
         oEvg==
X-Forwarded-Encrypted: i=1; AJvYcCVsOP5+xnJByP/tpo2n0jCFIJjHichWc+rKpbZ2PIqtbW1rcRhIi9ho0ruvvT7u2a8XuY/t7Lb6JkAO@vger.kernel.org
X-Gm-Message-State: AOJu0YyNSw/WwZjIc8NbJo+zcXy9hOxfvxx591Q/N/XzdRhGVFebd4Fo
	VkPPcDo2/OIkz5jIk/NZSOWErFIj60UyaWmXakr0/Sw4YfoQDSkv02JW8zGidso=
X-Gm-Gg: ASbGncsmYD4VlSSzIhoiytx5g68JH4f69gQMm7tzxWLndVVG88DBwbx8P0RaNvh8j/t
	x229ETTxewmIpKv+B97wRKrZ7d1wIDBocXO63MLzRcjkSEXBDkXZTbfblwNnX9w+IBd6nrL3hkO
	3AERADzTaQd9jHTirrZrS3tGFFYsyxDJ8k/HoL8XKw72x8CVf7gqCvP+WcQh6tJW5pjncyUJZBO
	bX+HVrlohRFb4qJxfiDeN1eZLZ3Gii/ABvyEgTNcnZl/9lhhnZOhs/5++yeQpxq7Q92d3rMiJbA
	icxF/vMZpIcQXFOPm8T8BA==
X-Google-Smtp-Source: AGHT+IErwrhCem5fzBI6a6wl06mNTQ9yKVlkmz7hDOEqq4HxfcsAp66u7+2R+nQ/CreR8BGTw2JG1g==
X-Received: by 2002:a17:902:f646:b0:216:393b:23c9 with SMTP id d9443c01a7336-218d71fd765mr39074785ad.29.1734527178847;
        Wed, 18 Dec 2024 05:06:18 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1db755dsm75751825ad.42.2024.12.18.05.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 05:06:17 -0800 (PST)
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
	rientjes@google.com,
	vishal.moola@gmail.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	linux-s390@vger.kernel.org
Subject: [PATCH v2 10/15] s390: pgtable: also move pagetable_dtor() of PxD to __tlb_remove_table()
Date: Wed, 18 Dec 2024 21:04:46 +0800
Message-Id: <0a6caf8305409173b5d41dccb6ecd46460cf9c1c.1734526570.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1734526570.git.zhengqi.arch@bytedance.com>
References: <cover.1734526570.git.zhengqi.arch@bytedance.com>
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
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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

