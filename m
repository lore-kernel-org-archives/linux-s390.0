Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF24199FD3
	for <linux-s390@vger.kernel.org>; Mon, 23 Dec 2024 09:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734947139; cv=none; b=QHwhL05HjJVZYamI8hUGvD+pMiWhMHHS0xEySdD52/8hhYIC7HpEyS93DHSBYDIfZzGZ/wls0gGDHUCc4Ntrw1fGw56lpadOJn7mqRbt6f4WP7b2SKS5InJ/udTXAKk5xJvKugXYmI1clJyjNZg9MJI9Qcq4H22PXuSd0u6WN3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734947139; c=relaxed/simple;
	bh=ySnIl2i3Fo/t1YN/rcwyhGqxWwlx1TNUJRz33ZWxlkE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VlDIjXeAQEAccCB0Wke86+qRkAIjU5UgPF0K91eW58dsibpK7PPyzteRpco6tZIjhVSulXN7Kzj/IaIqBlIIneIvNRHP6M8EAtpLZ+GZZsHYZD/Xh8eAsZ4+Ct1tN/5MRI2VeSLRp3xLVD05YBwKMA1yhoYLDmPu0g0mZxBzxeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=hNXfuXhw; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="hNXfuXhw"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-728f337a921so4004067b3a.3
        for <linux-s390@vger.kernel.org>; Mon, 23 Dec 2024 01:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734947136; x=1735551936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jyEzElX2/Cl2Hb0vACePBo9dDp7jwROhL3d0Mq9f7ig=;
        b=hNXfuXhwOhMw48dr3r+kXqLcQkoMoJLhWGchERDwoRDWksmqZlRFv+Oz9JnGvA2DC0
         EEdOZUaAluEAmL2UkJgPwm8D00T+9KbKF3ayO9AR3J2xXA7CFtbfj+ein9qm2KdFiutZ
         Q3WBGuzlwc2HK1qfSDR+g87FWzXgYvdIjSJFMtD0+D+M2nu2F7k/P/ZF5SMuhvz+4n3x
         1C1NTbrsci9IoG5KhcKoTYYafOYim+JLiM5lnFlmQBUdihZqpyQmx86jTa6RnYhMLDMN
         ZOTOExH3hfPksb5AY+fMCK1ICcynq6/VHeJ6UvnoyOUJaarTElG5s3Cm16dwoNsZo+XA
         40kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734947136; x=1735551936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jyEzElX2/Cl2Hb0vACePBo9dDp7jwROhL3d0Mq9f7ig=;
        b=j9wyDLbt5qjIapaI0ZmnyzPECZTlsNeq5CB9DnNK6EbKLWwmW4oXJR+tBHWeJtkRWH
         yVVlHKMVws53XJzoUk/7iGtHPyMnU0PfttIMNSqmUthgi5C3xthdXEpT5hHkqEFedIhA
         pv7H2PGyC4OyPA2nokk98m1NJ2/G3jVZAyH5pcZG76gmOnm0ptVMpvAQ/ynbGKsTJy40
         bycmaMigOczmUxcROrsDD3zLT6k7RFRa66ZML05tedplTNbU1nAklOSjAUugij6J/CLD
         xBPRxOyC7NQ5aVIrhpwawizjuEpRY/wzZKor4SIIwjVq53fRtkrrU2wcGziNBub73SFJ
         KOXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTTFqM8oFdOfuTo5p5BCLupXOtv2cYcuNou2rIeaW2csI0vcGTH75hguXZEk4DASO4XQYIRAEfiii2@vger.kernel.org
X-Gm-Message-State: AOJu0YzDECIZ7oZTh3BzXWs1IrESZj1BWZSs2GbqsyzOLiXqT4cSH8Oo
	vTae+8QRXAlT4SNRWyB9wcbyEE2IwwX5jgCTQudzxzBDsaOcfDm4pOK/aKDRK8w=
X-Gm-Gg: ASbGncuG5JErhIMYRuS2CR8CD6lqLIa0X8mdgR/4dUZT6HZ9SGfFssgEjzsgmdMQJZy
	zjCWG6LnfrHE79uKprlmH/lTB9j5uZAS6nHASK4TuAv5ptEKzy3Jd35kmzWAZnZvzhk0umvB/+y
	dRG3k8izxg+SYtq5bMttaoBnBOroSuJ4Zwb0xXvpKky9gPEI8TTRVDcToriri1ka5x7MqZKUseO
	POIcviRhle+fdPYKIMDBtkMPN3CcQeJJZp7p4rfw1d5DwMP+zcuDZCjxBnoYTwSelIVu9rL7wi7
	vBmHPN4kdjCjdAnk8kMc/Q==
X-Google-Smtp-Source: AGHT+IFFxsa0Y8D8QMIcsR8+VA1yaCfovsoDpuS31clip0UDjebZ+1TP8q/TeJDt5eTrdc0wzKH4iQ==
X-Received: by 2002:a05:6a00:399a:b0:725:b7dd:e668 with SMTP id d2e1a72fcca58-72abdebb868mr13954007b3a.17.1734947136545;
        Mon, 23 Dec 2024 01:45:36 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8486c6sm7468309b3a.85.2024.12.23.01.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 01:45:36 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: peterz@infradead.org,
	agordeev@linux.ibm.com,
	kevin.brodsky@arm.com,
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
Subject: [PATCH v3 12/17] s390: pgtable: also move pagetable_dtor() of PxD to __tlb_remove_table()
Date: Mon, 23 Dec 2024 17:40:58 +0800
Message-Id: <ad21b9392096336cf15aee46f68f9989a9cf877e.1734945104.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1734945104.git.zhengqi.arch@bytedance.com>
References: <cover.1734945104.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To unify the PxD and PTE TLB free path, also move the pagetable_dtor() of
PMD|PUD|P4D to __tlb_remove_table().

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

