Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5F81D5AAC
	for <linux-s390@vger.kernel.org>; Wed,  8 Jan 2025 07:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736319792; cv=none; b=jVkNJEcykEL5KvOSqfqAQRZp3+YaaDYsB6zyekToo6T3cylRnLzWLLDC4mKTvTaQiFpGhqNOz5Zoxr5kBKtdPneKPJgA7YSS3K/tGw5345g2ayIBH2jERog7XYB8S8o3K1694QGDIFncSmBOzWyARs26CNFxzBXsuHBbzpD4MhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736319792; c=relaxed/simple;
	bh=gLSOIPe2CJRryLc4wKd5NXWeTP0qwE2dyCNWoD9rNdw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a1kjwMrt9n608FX/2ZqLqQY6UYHFOypw/4zV2dv8XZ7Rb1L6l7EojYEGgNqZltpT7XyPZ01E1a2J2FO9AJ4vCXT3JqADthYezbvfV7TUVa4bN4xmYY92fHPTfKG1gFTbw8XosikFFwgp/699fGHlZ7BT1I+Lcf0DuqePaNZSddg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Bc8F7GKr; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Bc8F7GKr"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2166f1e589cso27351135ad.3
        for <linux-s390@vger.kernel.org>; Tue, 07 Jan 2025 23:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1736319790; x=1736924590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SzpcYcAmR7wIjJMr9qjJ0ueu9TAADg8s+gPSbWL3su4=;
        b=Bc8F7GKrRjcHB2HIcLoYn88Woo9KON8uOwtbAdUbkiup4eT1T8q3WIrXnhHRt0eiJ7
         qkXW464TRApGLYye716AioJBoAkncAu6XIq8mD6AbrhOvou/Ukr9HvylWS35usYh4jzq
         jX46dY6H5JjJ0+Lc0wcSjBjpZEdLbZoEBFS58NVgzJhlz2v48yD6NpFxqiNtgoRTFm/5
         0a0JaCJTkonzNeBpa8VKAB52B1hA5qBdeRcW/W4zaaDV2g611bOyffVFEUYBSmWgy2S+
         iXK5sQyPa4Vs0y9zhWP8cgqkGg79a9W0iAdS9g9IICI2gSq3/OeO6CYwyO30Jz9z9W/M
         x+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736319790; x=1736924590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SzpcYcAmR7wIjJMr9qjJ0ueu9TAADg8s+gPSbWL3su4=;
        b=ihSa9iaBs38bP/ctjQF8MoK9fJht1Q3OdgFQA4C9jHApl4htItPCzXhSU/xhJ6L3Vd
         k24nW2LpiopCK5W4pU1J7eOuJoVjS+QeQYaS4rqbf2o79Ky+2SC/CP5JbHIuGiaKRjEI
         DULezOfl+fKSiGpEZ3U2QLvFZvG2/agZFmBWBww71FazL4lQkGSISSdRILU0jo3mt8Zu
         NGyd6M3r3IEjZeQUts6WRqUXmu8jnHxKUStzcExZX0ZNcSfpRGM22R6iAwoL47GKyS4r
         gbpK8aZg1y2nav4Rrbjvmm8ED6ruoklEe33FpUgoDTKT6v8WoDE0H2sK6gjKgCg0fsP1
         qNJA==
X-Forwarded-Encrypted: i=1; AJvYcCW7Y8hhygIXXrCfG8JrJBTk+JWnQ+YVWeG5RXddIJ6JrYl3wb2IybR0+sZF+YUGftCuYkw+ifU5x5lY@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5tXNAi1+H0+ujhOig0qPGBFwg9FbBYEPEs3pUBhqUtJeuNivZ
	kB0C6NFa9NFpRvTNepc4N8FuTt603BfrhdBVfPKyeCWHGmmJimW41XS0ioKsfOM=
X-Gm-Gg: ASbGnctnCHjF7hKSZW+Haw2j1kQ+uRjdMMxdhZbrldEtdR1RuY5ho3wu34mx5eu3pEh
	kYJNxxoTR8mikoJfRLnxtzgEtHZn+JtnXsX6NQyaSQirGDZxJyhD/hiUJNV5o8TrkwW7SgpTpte
	h5foWYAow0t4Gp7/ADLhfsoVa1H+z8l3Pm7wwkKfZnE7RggxMCwB0eXc2Qe2x/35C/OH+zx+tUX
	r0peGf+GKmCKqIbL8Uv3V8yzxYD0QAuvyn51wXCcQ8fnIPfOlLG59TJrusJtnok8G0/s7ILk5I+
	8oypQaQk9wxZUiU+74Oy83ZCmyg=
X-Google-Smtp-Source: AGHT+IGLH2wnugoAqXpKOjRMOcNm05e1d3DjACkQOqMsLyNNJS4LCZNqibWg6/9XtyaXTuj3byMh6A==
X-Received: by 2002:a17:902:e74f:b0:216:7cde:523 with SMTP id d9443c01a7336-21a83f6710dmr31869555ad.32.1736319789694;
        Tue, 07 Jan 2025 23:03:09 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca023a3sm320067275ad.250.2025.01.07.23.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 23:03:09 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: peterz@infradead.org,
	agordeev@linux.ibm.com,
	kevin.brodsky@arm.com,
	alex@ghiti.fr,
	andreas@gaisler.com,
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
Subject: [PATCH v5 15/17] mm: pgtable: completely move pagetable_dtor() to generic tlb_remove_table()
Date: Wed,  8 Jan 2025 14:57:31 +0800
Message-Id: <0c733ac867b287ec08190676496d1decebf49da2.1736317725.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1736317725.git.zhengqi.arch@bytedance.com>
References: <cover.1736317725.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For the generic tlb_remove_table(), it is implemented in the following two
forms:

1) CONFIG_MMU_GATHER_TABLE_FREE is enabled

tlb_remove_table
--> generic __tlb_remove_table()

2) CONFIG_MMU_GATHER_TABLE_FREE is disabled

tlb_remove_table
--> tlb_remove_page

For case 1), the pagetable_dtor() has already been moved to generic
__tlb_remove_table().

For case 2), now only arm will call tlb_remove_table()/tlb_remove_ptdesc()
when CONFIG_MMU_GATHER_TABLE_FREE is disabled. Let's move pagetable_dtor()
completely to generic tlb_remove_table(), so that the architectures can
follow more easily.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Suggested-by: Kevin Brodsky <kevin.brodsky@arm.com>
Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/arm/include/asm/tlb.h |  4 ----
 include/asm-generic/tlb.h  | 10 ++++++++--
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/tlb.h b/arch/arm/include/asm/tlb.h
index b8eebdb598631..ea4fbe7b17f6f 100644
--- a/arch/arm/include/asm/tlb.h
+++ b/arch/arm/include/asm/tlb.h
@@ -34,10 +34,6 @@ __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte, unsigned long addr)
 {
 	struct ptdesc *ptdesc = page_ptdesc(pte);
 
-#ifndef CONFIG_MMU_GATHER_TABLE_FREE
-	pagetable_dtor(ptdesc);
-#endif
-
 #ifndef CONFIG_ARM_LPAE
 	/*
 	 * With the classic ARM MMU, a pte page has two corresponding pmd
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 69de47c7ef3c5..53ae7748f555b 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -220,14 +220,20 @@ static inline void __tlb_remove_table(void *table)
 
 extern void tlb_remove_table(struct mmu_gather *tlb, void *table);
 
-#else /* !CONFIG_MMU_GATHER_HAVE_TABLE_FREE */
+#else /* !CONFIG_MMU_GATHER_TABLE_FREE */
 
+static inline void tlb_remove_page(struct mmu_gather *tlb, struct page *page);
 /*
  * Without MMU_GATHER_TABLE_FREE the architecture is assumed to have page based
  * page directories and we can use the normal page batching to free them.
  */
-#define tlb_remove_table(tlb, page) tlb_remove_page((tlb), (page))
+static inline void tlb_remove_table(struct mmu_gather *tlb, void *table)
+{
+	struct page *page = (struct page *)table;
 
+	pagetable_dtor(page_ptdesc(page));
+	tlb_remove_page(tlb, page);
+}
 #endif /* CONFIG_MMU_GATHER_TABLE_FREE */
 
 #ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE
-- 
2.20.1

