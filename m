Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA3E1A239B
	for <linux-s390@vger.kernel.org>; Mon, 30 Dec 2024 09:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735549847; cv=none; b=cIcKNmRiKZkV8RzhKdoOimBE8W2eFaYxNI28WyPSXnd5tkGVlBhZe7pizB+ySY4XpkFDJlIB5tpBJz3+pws2rDEN2mIa1bIR4Ys4wMc4I80tUaWuLiP2ckgPXQd2okQJaj/7VyW2qNPA52EZak4cvoSvl+YwW3nySUjxBXFZw9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735549847; c=relaxed/simple;
	bh=d8h9y7EmWepeeSdJqmfwFJOw7y0NPJCnETYa2k/Hjdk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a+/693HmvzGpoFOx3fC250JlHw3pxFl7mxWAIf56D5QkrGa3eaYLLUprXj3hnFHjwRBF7EyJ24+ecE6FpqnpJRzLzMxzKCBWGazmbDnyc14rv0cjaOB7Ai4FQkkms+gDa/aKgEzHRznstbU0wdQGyVWKJt0gnNPjp4VmR6coYJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=E0YV3z1o; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="E0YV3z1o"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21636268e43so17195285ad.2
        for <linux-s390@vger.kernel.org>; Mon, 30 Dec 2024 01:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1735549845; x=1736154645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=76YtbImY0jPwdXnQQVs9oYKl35yZZ81uc4A2YpilpOk=;
        b=E0YV3z1o6J88dE+BZfcXArcljLAUcY1glPwY/nABe6LJjkR4TYX34yIv7UCBMoHL/v
         56Kx1oTLY1MOnZZTPkZU6gpbhhMZ//gdkYO0oS8E5KQTELKjm6nhkSUS7HUOYf4P615j
         fIe1YOqDVFnQ06oRVjT/A0AZ9vh6ZYcn9bpxcPRg/OyBQUM7glJiutzJnlXrBZRpdbji
         jQpGD35lWzcMr4V1rUHTuYfnIvzZaGIdwwHy9AQs+b31VM73IKNIOgjuvjuywhS2Tl+v
         iWdRFp/QS3MYhcfai3DREA901AzzowHG/liMw44dfKSxLGFJixByBePS3gntApnYlbEP
         uTBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735549845; x=1736154645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=76YtbImY0jPwdXnQQVs9oYKl35yZZ81uc4A2YpilpOk=;
        b=XZ3od2HG8ln+Q0njiQQrBPuFSR9xmHkrGRgrKiTHqn8t2al9I6gCfGw82ikZCLMGfz
         t+EBV+C2OWec9rxG+I+7P/gT4dxM45Wog6E567QWr8KonWBbDMp9x3mH/5keLsi6i7o4
         sI3UKSl2lncrHdw1cMQRg6f78GG10/r+ZkjR5bYUfBQRpeDfF4Zqo8R8rswcZQ/PyDP0
         E8BQNjv90qj+5SHs6QEQpinVPv3KbIFlHPMluHIKR3x8ojp23ACUlMruGG5fouYnEEqj
         yUE9xqHfT6puxuR2i89RlhBD7moUNNKRRADwnYSSu5DwHEiD6V9aZceo/xhstR3USXz2
         ATTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkivmQ7kVAxAe4HErmDJG1ZnNHWAFAweziqNjrTIoalwEFgubhYDQxySt4uj0kEcdtk00R688ynx3V@vger.kernel.org
X-Gm-Message-State: AOJu0YzIEumFmeMaA9HoKRkfVf5LSt9Qwltqv96GT6goMpIdlfOwCldA
	gsOzY18TeyR7Em+pWljuQ/FFLS6I1k5SQfHYdlLwyA637GBTm4r+MEw7zsNCRrE=
X-Gm-Gg: ASbGncuuN6qKN4D8Nk4MM2naudj0wscDtqjy0gdBcumhsZR8lW4ilAfitz12vKFxDdN
	PzNKu8b3i45am2px0+hnLy92qtT7C709snygpb5ceCdF/1hJwWU5VuudK2Mb/Hr0u0e4zKCfVVs
	RSw3bgutnp4fauEu6GdHCbOmoszQH6SusEnC7g+VQmt9/Wru5+b6zf1HJQuGt/n8ghSXNYdPYx0
	4ar5HBDCx536GhuWwLnAQ7XwRgsBXvirnQSFzPwT9y7WxEWc35Ic7xMONnhsYHvGerTrb+CYejr
	szclIWzhCSvZDPdxaE0qfw==
X-Google-Smtp-Source: AGHT+IE9evGbD+yEfyO2G41S4amTNhC2vfWaq9UYV9WQJrC+a4l06PyKmdWx4KtX6MVeEx+cVngAAA==
X-Received: by 2002:a05:6a20:c91b:b0:1e1:d22d:cf38 with SMTP id adf61e73a8af0-1e5e05b06bbmr51533885637.21.1735549844993;
        Mon, 30 Dec 2024 01:10:44 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842aba72f7csm17057841a12.4.2024.12.30.01.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 01:10:44 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: peterz@infradead.org,
	agordeev@linux.ibm.com,
	kevin.brodsky@arm.com,
	palmer@dabbelt.com,
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
	vishal.moola@gmail.com,
	arnd@arndb.de,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	dave.hansen@linux.intel.com,
	rppt@kernel.org,
	ryan.roberts@arm.com
Cc: linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-arch@vger.kernel.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-um@lists.infradead.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v4 10/15] riscv: pgtable: move pagetable_dtor() to __tlb_remove_table()
Date: Mon, 30 Dec 2024 17:07:45 +0800
Message-Id: <0e8f0b3835c15e99145e0006ac1020ae45a2b166.1735549103.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1735549103.git.zhengqi.arch@bytedance.com>
References: <cover.1735549103.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move pagetable_dtor() to __tlb_remove_table(), so that ptlock and page
table pages can be freed together (regardless of whether RCU is used).
This prevents the use-after-free problem where the ptlock is freed
immediately but the page table pages is freed later via RCU.

Page tables shouldn't have swap cache, so use pagetable_free() instead of
free_page_and_swap_cache() to free page table pages.

By the way, move the comment above __tlb_remove_table() to
riscv_tlb_remove_ptdesc(), it will be more appropriate.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: linux-riscv@lists.infradead.org
---
 arch/riscv/include/asm/pgalloc.h | 38 ++++++++++++++------------------
 arch/riscv/include/asm/tlb.h     | 14 ++++--------
 2 files changed, 21 insertions(+), 31 deletions(-)

diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
index b6793c5c99296..c8907b8317115 100644
--- a/arch/riscv/include/asm/pgalloc.h
+++ b/arch/riscv/include/asm/pgalloc.h
@@ -15,12 +15,22 @@
 #define __HAVE_ARCH_PUD_FREE
 #include <asm-generic/pgalloc.h>
 
+/*
+ * While riscv platforms with riscv_ipi_for_rfence as true require an IPI to
+ * perform TLB shootdown, some platforms with riscv_ipi_for_rfence as false use
+ * SBI to perform TLB shootdown. To keep software pagetable walkers safe in this
+ * case we switch to RCU based table free (MMU_GATHER_RCU_TABLE_FREE). See the
+ * comment below 'ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE' in include/asm-generic/tlb.h
+ * for more details.
+ */
 static inline void riscv_tlb_remove_ptdesc(struct mmu_gather *tlb, void *pt)
 {
-	if (riscv_use_sbi_for_rfence())
+	if (riscv_use_sbi_for_rfence()) {
 		tlb_remove_ptdesc(tlb, pt);
-	else
+	} else {
+		pagetable_dtor(pt);
 		tlb_remove_page_ptdesc(tlb, pt);
+	}
 }
 
 static inline void pmd_populate_kernel(struct mm_struct *mm,
@@ -97,23 +107,15 @@ static inline void pud_free(struct mm_struct *mm, pud_t *pud)
 static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
 				  unsigned long addr)
 {
-	if (pgtable_l4_enabled) {
-		struct ptdesc *ptdesc = virt_to_ptdesc(pud);
-
-		pagetable_dtor(ptdesc);
-		riscv_tlb_remove_ptdesc(tlb, ptdesc);
-	}
+	if (pgtable_l4_enabled)
+		riscv_tlb_remove_ptdesc(tlb, virt_to_ptdesc(pud));
 }
 
 static inline void __p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d,
 				  unsigned long addr)
 {
-	if (pgtable_l5_enabled) {
-		struct ptdesc *ptdesc = virt_to_ptdesc(p4d);
-
-		pagetable_dtor(ptdesc);
+	if (pgtable_l5_enabled)
 		riscv_tlb_remove_ptdesc(tlb, virt_to_ptdesc(p4d));
-	}
 }
 #endif /* __PAGETABLE_PMD_FOLDED */
 
@@ -142,10 +144,7 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
 				  unsigned long addr)
 {
-	struct ptdesc *ptdesc = virt_to_ptdesc(pmd);
-
-	pagetable_dtor(ptdesc);
-	riscv_tlb_remove_ptdesc(tlb, ptdesc);
+	riscv_tlb_remove_ptdesc(tlb, virt_to_ptdesc(pmd));
 }
 
 #endif /* __PAGETABLE_PMD_FOLDED */
@@ -153,10 +152,7 @@ static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
 static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
 				  unsigned long addr)
 {
-	struct ptdesc *ptdesc = page_ptdesc(pte);
-
-	pagetable_dtor(ptdesc);
-	riscv_tlb_remove_ptdesc(tlb, ptdesc);
+	riscv_tlb_remove_ptdesc(tlb, page_ptdesc(pte));
 }
 #endif /* CONFIG_MMU */
 
diff --git a/arch/riscv/include/asm/tlb.h b/arch/riscv/include/asm/tlb.h
index 1f6c38420d8e0..ded8724b3c4f7 100644
--- a/arch/riscv/include/asm/tlb.h
+++ b/arch/riscv/include/asm/tlb.h
@@ -11,19 +11,13 @@ struct mmu_gather;
 static void tlb_flush(struct mmu_gather *tlb);
 
 #ifdef CONFIG_MMU
-#include <linux/swap.h>
 
-/*
- * While riscv platforms with riscv_ipi_for_rfence as true require an IPI to
- * perform TLB shootdown, some platforms with riscv_ipi_for_rfence as false use
- * SBI to perform TLB shootdown. To keep software pagetable walkers safe in this
- * case we switch to RCU based table free (MMU_GATHER_RCU_TABLE_FREE). See the
- * comment below 'ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE' in include/asm-generic/tlb.h
- * for more details.
- */
 static inline void __tlb_remove_table(void *table)
 {
-	free_page_and_swap_cache(table);
+	struct ptdesc *ptdesc = (struct ptdesc *)table;
+
+	pagetable_dtor(ptdesc);
+	pagetable_free(ptdesc);
 }
 
 #endif /* CONFIG_MMU */
-- 
2.20.1

