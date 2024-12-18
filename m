Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A781ACECE
	for <linux-s390@vger.kernel.org>; Wed, 18 Dec 2024 13:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734527142; cv=none; b=PmCzJhoVWGuBsVH7yImv2XWbzuH5J7+ig534Gq9c/vlFNHYcdFbPYtyr6nY6a0GqxxRSIZP8wkNK3brrz5HsCXxItUf3HZnmhZURf2Qz3Its9+MhoB07xUZArgqD7K+o1vTJwMrdWCjcx/TiRU/uC+SKw+9YUCL3JhY1vA432qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734527142; c=relaxed/simple;
	bh=gsn2MxaDHMIkVDeNJoAZ1GXzg4UbDMQdMp9AlgDJXWI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qfq2efBZYcoSG+Fe9e32MBhBigP02ynh0M9sT1OnNaElDACECTwK+uNCYkRJFucOTpj0sEOfKUF/m06ogxE9sb9FkZkOAksDMmrAXGPT6Vpbry/b44ek6FvN9peo9H6AxQJ7SyuC9jJGxtr+IoFiogyV7k0mEU/fu0hVIUZ83ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=IivdJq3z; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="IivdJq3z"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2163bd70069so65617735ad.0
        for <linux-s390@vger.kernel.org>; Wed, 18 Dec 2024 05:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734527139; x=1735131939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xY41yoAggnrpKZDOvMIy0+FhpPRF9QFn+bDK7HKPzWw=;
        b=IivdJq3zwTbBWUsPy2MsCP/5HmRbrv/2yQa+fwmHxKVx0Yvj7bbyZ80AM6lvy9O285
         cUHneJFlqIG4sTmzj56M7TR87h1kU76i285aRYZtELUEy9prvihgOoxnn1rzDquUwui5
         IUAQuYQP90EfzAVlIp26nn/r5g74vfIWxi6zcway74EXyO2FM+W5y5bUscUWk5KJYWsy
         TEHR7M5ONoh7GK4a1bgRANf/YF0yBUh3XaaMGUQvYkdTLxq4+BXBk0+6RYinhkeb69xQ
         EdqWqNtultUYStJrcbEKa8esFMU2sF87VBupLBTawrjDcGA0XuK/I/0AqiD8xozFaW8M
         XuIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734527139; x=1735131939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xY41yoAggnrpKZDOvMIy0+FhpPRF9QFn+bDK7HKPzWw=;
        b=Ou+FgF+ogArJTYjpkLz1uzcyjyuLRglbSNl21+79eZSGIzRwHT2oZBaePany64UzHH
         l8OiGPuc+cetXUficXSbHStw4thZ/7xghNQ+8aRNmcscVNGaUUHecRXGBil6um+xIEq4
         GHGpVLd/lD33NoR/eYMO5MHBPwVqIajx7ngs+G3OJchG0SFcezHBvc68ieSOmMfYGYPZ
         d4uSiTlD6ehaFIv5Gp3CafQZw5W6adRUUIaMtZBfJLiqlEgSF/Ah6ncF1hIkMztHxpXA
         +VP+W9W0MM25oFQykhsAa6kXlSLcBcJoaB+ytbF4CvlLG3esoruHTQnfwvK2dBdUnC+I
         GDXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUr0d7ibW4phihTQ9UM9/rWuyeOzFehA0+6xWfg+DxmBqjAXEf3wtE3lIfZkSS9+75M73QXI+7Ym5cG@vger.kernel.org
X-Gm-Message-State: AOJu0YzMWMdiswZ91/pJ7Jnqt8dWrp5mueVU/ifbC6qwJsuaSAdXNNUP
	NdBy33MxsVZEaXMprDfGE0k7KsTpimXXyvyZqXQrqNsMkHdkDU7V0L2VoX0XvFk=
X-Gm-Gg: ASbGncsPZJ2rQq68adzcUKwJTunSjwmoOXVRmOkCbz1YdYfNmNUBAqn/dpeLbi4AHlk
	KeAXORf9if1YiAUoIjjxRi5+byRUK7teTE+xA7NcaNG2OzGlp6S1rIJGXUdh3PhapS0ny9x8ql2
	zOhUuVm6BFojm5Zjw+okotd6YPSVvb5erlAfVnIDPCjEDQcYJqLuJIAU7EOKdcMefr2E/UtpEmV
	EsakEnG3Q/KIPMbaKJe+jGzOL5OmxWTTGbs/Fk8PpiHIte01RKtwM95Ls0zevcuc030cgaWodVn
	ws5RXgwF4EDimDYdqiHMpQ==
X-Google-Smtp-Source: AGHT+IEBex3adiI4KuoLgCHeY1D81j9Q6JTE0T6gwcWqf4Lz8nOg8PmUUMxAQoz8nfmNTBwOZklCxg==
X-Received: by 2002:a17:903:2448:b0:216:6769:9eea with SMTP id d9443c01a7336-218d72477d0mr41450855ad.37.1734527138569;
        Wed, 18 Dec 2024 05:05:38 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1db755dsm75751825ad.42.2024.12.18.05.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 05:05:37 -0800 (PST)
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
Subject: [PATCH v2 04/15] s390: pgtable: add statistics for PUD and P4D level page table
Date: Wed, 18 Dec 2024 21:04:40 +0800
Message-Id: <64401d867f3a965f60e9c8d09099b42f21749a47.1734526570.git.zhengqi.arch@bytedance.com>
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

