Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D8C14D43D
	for <linux-s390@vger.kernel.org>; Sat, 14 Dec 2024 09:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734167055; cv=none; b=aThYODZ0F66fjInz45QGDvvhf40E3nAEL50RnnACPp9ZsTeQcybUmd1Q0WHUBlx8HU5kYC1/BLszJ/bHrBWQBQcIIlNWuU4Rgu2nKCN27tamepUXqYOTnzRWYKi2cQLoIRHh3nN8F3/b8f/1n7AZ0BAJN4Pm5ezb5acpj46je0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734167055; c=relaxed/simple;
	bh=WunXdhU7qtQHmUT93eVkt+8JRouSIOc5FLEynmCEfmU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PWzpjT9N9f2UGnud/BoWlbPrpHl3Z7mS/qdpznmtI0ryxUiCTKNkOna63n7NPXwUz1X5hWvDf1BJN4AsdcY/mClcPKcYH47qDnzFUHOr5o/AtAP5fzOi9mn5oRBva9Q1YVFa/dWyqKDyUYNoEDn4sZHE8rRe5GQxSiPCU5T9WHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=QX9pEfn0; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="QX9pEfn0"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ee709715d9so1714686a91.3
        for <linux-s390@vger.kernel.org>; Sat, 14 Dec 2024 01:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734167053; x=1734771853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PLGKRzIB8HXo0VMNVO8Y1nbnLVdnH3jBTxV4FtFLzdM=;
        b=QX9pEfn0hCffAO5eIM3JGCbr0eL2BLuIky+xnV1G9vki5vBIdJPLGhkiTvvQmWaezb
         faHyzqqGyUK2Xpg6uMaUlvIaMnEm2DVKuFlqnFRZVIo8i5TBlLfHY6vRYNkde6HK2U2C
         3jzLLlH/n2OIN6ECiNS3+vJGd4fcbyPr7EhtqokLe0Zanx990yglNCX+MnIr4jS96hW3
         IHF++IWi5zKcpoOLcInhoSGYR2Ro/pxefyPo5jZAQ4tmmJiWLuOzmXLDxNaX30sy+TIa
         HVVzq+G/E0cI/Bcg9jXpt8hNAk02Ar2LFV8UBCzbdsEvbH/rb67kVxvpSucIkY77jbNj
         fwxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734167053; x=1734771853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PLGKRzIB8HXo0VMNVO8Y1nbnLVdnH3jBTxV4FtFLzdM=;
        b=jKHefxTNLwulARxZM7QSgiFT7i0auCbCnwJyy2Uo353sViGVtY5gmUJzIskQwt4QD2
         Y2/hKbdmxxdFOvUrTH9QanIRo17CN/inCDyWw1s8oNy1aTfzhwFtUO62DxAT1lc7lvY7
         ijFKxuGEjlDW9l7WpCXIS4a7ZmAR3VXnK37oDzNbGF5r0jpjkQ6iAW1rDenun5v85jMp
         xm0ql7mlMTqjIxGBMQWNdM2iLlxZuUNBQUt61vEwwNcJDG40mP/oQYoDSkm20BX51KtG
         x0zg/M7MDbNVz7IatR+tK4qqoQbwlqHj7ivIKgY56PQm/rkaTnu+lNUXM6EkkWFSgTwr
         BQkg==
X-Forwarded-Encrypted: i=1; AJvYcCXtoK0gx7SUFBn65iOm+ZYuPG3l/ykUC6FRY4JFFLGlfLO2puyLbsrM5Ri0f6Rn3tWPVPou+Le+lLbl@vger.kernel.org
X-Gm-Message-State: AOJu0YzFiGVmAy5ULh+64dOS2MEniy1H5i4ziazxVXW8z+GXalhjyljM
	kyylP8VMWStQpSkwx7E3P3WQPSPoYMx4qWJDIFYVEfWkbKe7uha7Qwgn4WzwMak=
X-Gm-Gg: ASbGncsVq5AufqUH/zkpUFbVAffxWBobbPR/8fLNkPxLJXInJexioudgO+o1VulSyEw
	ulGAR3qfCC4/WG+Rf7D9FF4skELfF6pon7liUT2DuMLfTV5BZir+ESX6SrP3sWYK3/piXhZ9Ikq
	LRi+Kk7D/cui04ES6rHXEnKv2jc5gB+EcDM3UwwRbnNa+dSsuWSH0kHwVHfB5gez7aExL90YLtW
	YLLSf5g2HWwdGNVNQ7imes1u7OkvUnZdMDZfGA4Qn+Bj5tGxDythBmlmCXYJ9MiZxXELB+fg1lY
	YJ6FtAnSZH4NveqtkfeZoTQcboqNlg==
X-Google-Smtp-Source: AGHT+IEUuhlzMDGPbhHcy72Znz6SKiudYIj5PWGCvj9lWM7sC/HnXgPB6JSnynFl46+kyeoAQCdvNg==
X-Received: by 2002:a17:90b:3848:b0:2ee:d797:408b with SMTP id 98e67ed59e1d1-2f28fa55c45mr8606530a91.2.1734167053262;
        Sat, 14 Dec 2024 01:04:13 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([2409:8a28:f4f:a9a4:5d46:4ef0:daa9:1db8])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5a90ba0sm905731a12.16.2024.12.14.01.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 01:04:12 -0800 (PST)
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
Subject: [PATCH 04/12] s390: pgtable: add statistics for PUD and P4D level page table
Date: Sat, 14 Dec 2024 17:02:50 +0800
Message-Id: <fd4223519c6300160cde2fce1c85a1ea0661b116.1734164094.git.zhengqi.arch@bytedance.com>
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

Like PMD and PTE level page table, also add statistics for PUD and P4D
page table.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
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

