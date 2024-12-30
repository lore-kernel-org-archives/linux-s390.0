Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4141A23AC
	for <linux-s390@vger.kernel.org>; Mon, 30 Dec 2024 09:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735549798; cv=none; b=a2A+equmOshG1mkF4oV1I4jMhXo6YtMRW5JfIMiqrNwh8gDQ831xM+kEAvZMdFeF1WuGAsbdyhwFC0NILL18VRWpNHF4RLuqHhvRH7pCvLm2S/HsF7+LLngyMYA7Rydy2jQAw1AWazWgq5Tx6nLDQqa1910B/0xOJT8zGFXOfNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735549798; c=relaxed/simple;
	bh=gsn2MxaDHMIkVDeNJoAZ1GXzg4UbDMQdMp9AlgDJXWI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G9mJ3scanhehlacZFF3JAOKHo/dd8ILp49OVpNDUA5SUL3vsHuXsRu0gIuQdxchJeu7MxkT4o1xSKi3JR0vV99bU8xmZC+9lpgOffevcAd4vLgCASg4ZdHiyO4ZNYkhGQDJtPsvURZdfv6j8Z03mzyQ55VovC4qYPxTbCnlX618=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZdDBIIoe; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZdDBIIoe"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21654fdd5daso108563425ad.1
        for <linux-s390@vger.kernel.org>; Mon, 30 Dec 2024 01:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1735549795; x=1736154595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xY41yoAggnrpKZDOvMIy0+FhpPRF9QFn+bDK7HKPzWw=;
        b=ZdDBIIoelCJjmLBiAvvITNIgs9m6LIoCNsC5x8RDr8WBQ/EfIiCbfp7WwIxMKjwY13
         m9Tu8tZuobXFHMie0svrZpxYb810XVGhwhsiiFS8xegb+19Z0mkzzb6zr1p06EpCB00q
         ASZJz5wujN5irKhpTpcdgLubw2t3o2KQodRClOS/h3Ch9DQG7pEEEnWG3WtPDFMqw8rC
         nNxn6lZW81uNhA+v5NPe4AAUVn5YS88g8RFWQfjtOk6+dQE5QtB7LKV33ORmBrFTGqvO
         8qJ/Ug6fXbwNi5F9KypqIzGrAMB6Bip/zuS4djeXVdQoQSpnGTP6oQghkUwh/iEST0vl
         KI6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735549795; x=1736154595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xY41yoAggnrpKZDOvMIy0+FhpPRF9QFn+bDK7HKPzWw=;
        b=d03k0pu6p/Ne+45tKKJD6PtZHwvUVd5adCKGzuavSK1wEvvYrVaqAkhC8uM6vzov5k
         XIDyDvpUyW9f8fxbbCpRHudInparG+Z03fZ63KucgKEcWli1R6lUZwjwdVMil4Vs1SmN
         wVR2CJNNccUS+j1Od1yZli/fL8RlBysi5/k/9tp6MTXyscquKBYj/P1WTeGe5qVs1C8x
         KH9yJbVZrDXpD+9tN/ylrIKPEGg7QPa254uE9MMbbfenDX0la6cLrCT5wS9UNT+eY5hJ
         iHVzplGAB5HoZLA9kztveoIWTM8GEZcUAB/JwBc18M+Rgq2AUSzfaEhv10SNMWFz6vYY
         TbWA==
X-Forwarded-Encrypted: i=1; AJvYcCXJ0v8PSlE47zvkBAqFUGH5UYaHLffwMTOEhApWs2YPHKQXT/fQdz/OiJGw8eIkrrpYxbRce8LG9mIE@vger.kernel.org
X-Gm-Message-State: AOJu0YyOnCaRNxeQQnuV9kjVrtFk+I+ogFsvTqvyfV/9B6FByrlCER48
	O4sXVa5DEoQyJI6Y3xLlb5oR032y4coKfJkV3acoIOJY1ANr+j9rlzJIMk48keo=
X-Gm-Gg: ASbGncuzOibDqKUHSF9eGBz3dSW6W4fBFSOfc+Q6NXS+7b+CVR8QXCUf9SCTElsqkBR
	n9OxAvDe6x12wvQGTjRp3BipvTGytHc/H4Z6eRD5dxs+SLkOD+pAcFM7wcNokfu2xke5pLfXhys
	PU8IdMGyuAgQQJllgORCTzyvyg6aCwwrVxtpgOkRWEGHP0+o9CYhb3DsqeDmqzKyjxb02neWufs
	Q8Jtf85vz0xVRGjW2RQ9Nh/iMriodwR9aHPPwD/Jj/QrbWD5oJ+TAXUF8uXkhtZxnLEVWbn4eWB
	5/0ZAXS/WI23mgDhuQRMsw==
X-Google-Smtp-Source: AGHT+IGnRshrEAoIvJb/W9ouyd0xHkDgdKkbYKOXyUcaItniQPw/Z8/M3j6tdqefIia4rt8bUMG2kg==
X-Received: by 2002:a05:6a21:328d:b0:1db:f68a:d943 with SMTP id adf61e73a8af0-1e5e0461b11mr51051580637.17.1735549795427;
        Mon, 30 Dec 2024 01:09:55 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842aba72f7csm17057841a12.4.2024.12.30.01.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 01:09:54 -0800 (PST)
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
Subject: [PATCH v4 06/15] s390: pgtable: add statistics for PUD and P4D level page table
Date: Mon, 30 Dec 2024 17:07:41 +0800
Message-Id: <35be22a2b1666df729a9fc108c2da5cce266e4be.1735549103.git.zhengqi.arch@bytedance.com>
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

Like PMD and PTE level page table, also add statistics for PUD and P4D
page table.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: linux-s390@vger.kernel.org
---
 arch/s390/include/asm/pgalloc.h | 29 +++++++++++++++++++-------
 arch/s390/include/asm/tlb.h     | 37 +++++++++++++++++----------------
 2 files changed, 40 insertions(+), 26 deletions(-)

diff --git a/arch/s390/include/asm/pgalloc.h b/arch/s390/include/asm/pgalloc.h
index 7b84ef6dc4b6d..a0c1ca5d8423c 100644
--- a/arch/s390/include/asm/pgalloc.h
+++ b/arch/s390/include/asm/pgalloc.h
@@ -53,29 +53,42 @@ static inline p4d_t *p4d_alloc_one(struct mm_struct *mm, unsigned long address)
 {
 	unsigned long *table = crst_table_alloc(mm);
 
-	if (table)
-		crst_table_init(table, _REGION2_ENTRY_EMPTY);
+	if (!table)
+		return NULL;
+	crst_table_init(table, _REGION2_ENTRY_EMPTY);
+	pagetable_p4d_ctor(virt_to_ptdesc(table));
+
 	return (p4d_t *) table;
 }
 
 static inline void p4d_free(struct mm_struct *mm, p4d_t *p4d)
 {
-	if (!mm_p4d_folded(mm))
-		crst_table_free(mm, (unsigned long *) p4d);
+	if (mm_p4d_folded(mm))
+		return;
+
+	pagetable_p4d_dtor(virt_to_ptdesc(p4d));
+	crst_table_free(mm, (unsigned long *) p4d);
 }
 
 static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long address)
 {
 	unsigned long *table = crst_table_alloc(mm);
-	if (table)
-		crst_table_init(table, _REGION3_ENTRY_EMPTY);
+
+	if (!table)
+		return NULL;
+	crst_table_init(table, _REGION3_ENTRY_EMPTY);
+	pagetable_pud_ctor(virt_to_ptdesc(table));
+
 	return (pud_t *) table;
 }
 
 static inline void pud_free(struct mm_struct *mm, pud_t *pud)
 {
-	if (!mm_pud_folded(mm))
-		crst_table_free(mm, (unsigned long *) pud);
+	if (mm_pud_folded(mm))
+		return;
+
+	pagetable_pud_dtor(virt_to_ptdesc(pud));
+	crst_table_free(mm, (unsigned long *) pud);
 }
 
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long vmaddr)
diff --git a/arch/s390/include/asm/tlb.h b/arch/s390/include/asm/tlb.h
index e95b2c8081eb8..b946964afce8e 100644
--- a/arch/s390/include/asm/tlb.h
+++ b/arch/s390/include/asm/tlb.h
@@ -110,24 +110,6 @@ static inline void pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
 	tlb_remove_ptdesc(tlb, pmd);
 }
 
-/*
- * p4d_free_tlb frees a pud table and clears the CRSTE for the
- * region second table entry from the tlb.
- * If the mm uses a four level page table the single p4d is freed
- * as the pgd. p4d_free_tlb checks the asce_limit against 8PB
- * to avoid the double free of the p4d in this case.
- */
-static inline void p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d,
-				unsigned long address)
-{
-	if (mm_p4d_folded(tlb->mm))
-		return;
-	__tlb_adjust_range(tlb, address, PAGE_SIZE);
-	tlb->mm->context.flush_mm = 1;
-	tlb->freed_tables = 1;
-	tlb_remove_ptdesc(tlb, p4d);
-}
-
 /*
  * pud_free_tlb frees a pud table and clears the CRSTE for the
  * region third table entry from the tlb.
@@ -140,11 +122,30 @@ static inline void pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
 {
 	if (mm_pud_folded(tlb->mm))
 		return;
+	pagetable_pud_dtor(virt_to_ptdesc(pud));
 	tlb->mm->context.flush_mm = 1;
 	tlb->freed_tables = 1;
 	tlb->cleared_p4ds = 1;
 	tlb_remove_ptdesc(tlb, pud);
 }
 
+/*
+ * p4d_free_tlb frees a p4d table and clears the CRSTE for the
+ * region second table entry from the tlb.
+ * If the mm uses a four level page table the single p4d is freed
+ * as the pgd. p4d_free_tlb checks the asce_limit against 8PB
+ * to avoid the double free of the p4d in this case.
+ */
+static inline void p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d,
+				unsigned long address)
+{
+	if (mm_p4d_folded(tlb->mm))
+		return;
+	pagetable_p4d_dtor(virt_to_ptdesc(p4d));
+	__tlb_adjust_range(tlb, address, PAGE_SIZE);
+	tlb->mm->context.flush_mm = 1;
+	tlb->freed_tables = 1;
+	tlb_remove_ptdesc(tlb, p4d);
+}
 
 #endif /* _S390_TLB_H */
-- 
2.20.1

