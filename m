Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A500E1E9B04;
	Wed, 16 Apr 2025 20:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744834659; cv=none; b=uyOfvPLPuMOKFMp5qtIL0CbBZNvRu6PUI8vy+TOlLrVxYXq2YuAri/v+zUgFkbRCYVkQNuepjiJ1ImdN9oKwXXpLjYP2GOOHJ7JRGxX/U3BkukUJYKR9ExUtZgGSGCwYIkrYb1XqCDhBWaoUEucYv0+hzeQabcIaf5mb2L9eS5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744834659; c=relaxed/simple;
	bh=99zRorP8cOkcXThC1Qaj8lC6JNXD/pvBFsE1oF1v4UA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gzNaCeIfC1yF5TWlJqyWhP58RRKnUxfJsnAsiy/merMveaDT1H9+Nh4DXh/xuxYa8k4UdcwfgeQxMzP2vHIlq7G4jVtUxFH8uijWQLfh2drbVAmEsWsxC5YJohKoXLZT/TmXx4WL+iqO2WzZP+qTauYRxU9C/dVYTaElnTy7grc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a0QMCywE; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0QMCywE"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e461015fbd4so81600276.2;
        Wed, 16 Apr 2025 13:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744834656; x=1745439456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CflYkpCwmcNHOZhPPaWFtrcabnpu0tQed65YHPVcA00=;
        b=a0QMCywE5oUkJmZtO4zflJp/SfLsLc1PJ2/8RLyWxVD3hgmsRVVBU7NgVIhI9QuKPq
         vfdoBZ4Jk0zXI1CboeivrtKYtQOHgnmV94ijDOOkkfxqfKvek7DRILktmZDzhMYCkt3K
         pJg4tXzqJnIJc47zx8srk+e5x+OG65EXvdXRc76GFyKT1rl5lHYI/LzI4lCuNyEiJiCP
         Vex/xg+lJAgVfHS3SSamSvPP8vTqJ3spoYLLS5UDgUvouzey6VghGXUNw96Ca+dKPSfP
         O5swKYjdjxPP/sKn00h3kTKcuoWlouzddWFzDyYIEDMlacha4ew+9bBXort0j3CwiVuP
         1a4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744834656; x=1745439456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CflYkpCwmcNHOZhPPaWFtrcabnpu0tQed65YHPVcA00=;
        b=gNdv3APklisvGJOKW95UWaLphnk0cjc81GgLmBEVcSalkb5rQ5rTu/jyrtjDEBSEhc
         +FXVEoSTmLoWLI5uYq8gYH2a0DJfJbyrbaksVtoIdyZoXR+JymHwC0QNzfPXouZljHQN
         gVfHjyA866YBhoNOlHNJ1mgJ6fdXVD0mZrXYw9DdbiA+aLLoO9uxQwbTVpqOMyhR8VcK
         VHJGZXzoUSpm9kpAyxHLU+txIHkREpPv/iE1HdbOXh8EDvnIlLic73/HhyHwg9QSEwzP
         lvoU+4P58TNdRXcu3aNQU+AiUzc2EzOTPaiKgaTiq+s3LEM14cZqsprrAhw0oKbjSwV/
         6Qug==
X-Forwarded-Encrypted: i=1; AJvYcCUrEV/4bokxh4T4u0agSQs3t4Yrcj60PvsIAg+xsVQMLGWa/3/UxvnoHekXwcV/+/2IFIODZYPM3T5d3w==@vger.kernel.org, AJvYcCVg7rwNsfGjxfztaTzUWAlBnBj7memUkyOwAIoaGcgbbEOwwCTI0Qz1dJNkNQbYiX68COVHUQfxUh6c5z8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVlJPMBImGpRosaDZesAL4Imq4Wo12ENDGOWivpLETHgMq1roG
	mGQJbV/pzfcBjG/tf4gpDmuE3wDRtTHDrwpNSFCX6RJC4xWE7+lR
X-Gm-Gg: ASbGncuPHuBIu7sI8T6kxQog1Loh1zwSpn9pN5wMbEVeP2H3i+UIGmSSlHqpo+2saKy
	MqYk14PRqFvPCjppAlJRs58aF5x6mgWQuQel03vJxe/6u6xCqGLbwa+SYun8SnxDTNRE340lZ+U
	zukwsakI24aLCQNJ888veQhZW9aFFFkmSlY/hUbAqP2HO3K/vYLmNulZUzP0IxPAeTT3F6XkJc9
	vdlphzS/M1rlwEkot6Nmp7C+cuhW6vbT9Z5SeWcipjVdM3VTMDqwVVBH4Ofl3TvP2li7vOzYI/2
	D/o1pOMI8vLINV4F2ty40THDQMcpzKaE4LIHYnm2cOad7ShCeOM=
X-Google-Smtp-Source: AGHT+IFFXzgbUYgP60nqbnEnfLWEDGbfDou4lsJyEpl6suKqcdpb+qylOcokWL9qWwzjfiOf9tXo/A==
X-Received: by 2002:a05:6902:2681:b0:e5b:1b55:1325 with SMTP id 3f1490d57ef6-e7275967f68mr4277783276.25.1744834656400;
        Wed, 16 Apr 2025 13:17:36 -0700 (PDT)
Received: from localhost.localdomain ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e7032783effsm3887699276.56.2025.04.16.13.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 13:17:35 -0700 (PDT)
From: nifan.cxl@gmail.com
To: willy@infradead.org
Cc: mcgrof@kernel.org,
	a.manzanares@samsung.com,
	dave@stgolabs.net,
	akpm@linux-foundation.org,
	david@redhat.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	linux-s390@vger.kernel.org,
	ziy@nvidia.com,
	Fan Ni <fan.ni@samsung.com>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH] mm: Convert free_page_and_swap_cache() to free_folio_and_swap_cache()
Date: Wed, 16 Apr 2025 13:12:15 -0700
Message-ID: <20250416201720.41678-1-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Ni <fan.ni@samsung.com>

The function free_page_and_swap_cache() takes a struct page pointer as
input parameter, but it will immediately convert it to folio and all
operations following within use folio instead of page.  It makes more
sense to pass in folio directly.

Convert free_page_and_swap_cache() to free_folio_and_swap_cache() to
consume folio directly.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
Acked-by: Davidlohr Bueso <dave@stgolabs.net>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
v3: Rephase the commit log, apply reviewed-by and Acked-by tags, and remove
    comments on sparc.
v2: https://lore.kernel.org/linux-mm/20250413042316.533763-1-nifan.cxl@gmail.com/
v1: https://lore.kernel.org/linux-mm/20250410180254.164118-1-nifan.cxl@gmail.com/
---
 arch/s390/include/asm/tlb.h | 4 ++--
 include/linux/swap.h        | 8 +++-----
 mm/huge_memory.c            | 2 +-
 mm/khugepaged.c             | 2 +-
 mm/swap_state.c             | 8 +++-----
 5 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/arch/s390/include/asm/tlb.h b/arch/s390/include/asm/tlb.h
index f20601995bb0..e5103e8e697d 100644
--- a/arch/s390/include/asm/tlb.h
+++ b/arch/s390/include/asm/tlb.h
@@ -40,7 +40,7 @@ static inline bool __tlb_remove_folio_pages(struct mmu_gather *tlb,
 /*
  * Release the page cache reference for a pte removed by
  * tlb_ptep_clear_flush. In both flush modes the tlb for a page cache page
- * has already been freed, so just do free_page_and_swap_cache.
+ * has already been freed, so just do free_folio_and_swap_cache.
  *
  * s390 doesn't delay rmap removal.
  */
@@ -49,7 +49,7 @@ static inline bool __tlb_remove_page_size(struct mmu_gather *tlb,
 {
 	VM_WARN_ON_ONCE(delay_rmap);
 
-	free_page_and_swap_cache(page);
+	free_folio_and_swap_cache(page_folio(page));
 	return false;
 }
 
diff --git a/include/linux/swap.h b/include/linux/swap.h
index db46b25a65ae..4e4e27d3ce3d 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -450,7 +450,7 @@ static inline unsigned long total_swapcache_pages(void)
 }
 
 void free_swap_cache(struct folio *folio);
-void free_page_and_swap_cache(struct page *);
+void free_folio_and_swap_cache(struct folio *folio);
 void free_pages_and_swap_cache(struct encoded_page **, int);
 /* linux/mm/swapfile.c */
 extern atomic_long_t nr_swap_pages;
@@ -520,10 +520,8 @@ static inline void put_swap_device(struct swap_info_struct *si)
 
 #define si_swapinfo(val) \
 	do { (val)->freeswap = (val)->totalswap = 0; } while (0)
-/* only sparc can not include linux/pagemap.h in this file
- * so leave put_page and release_pages undeclared... */
-#define free_page_and_swap_cache(page) \
-	put_page(page)
+#define free_folio_and_swap_cache(folio) \
+	folio_put(folio)
 #define free_pages_and_swap_cache(pages, nr) \
 	release_pages((pages), (nr));
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index e97a97586478..0d28da37f826 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3648,7 +3648,7 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
 		 * requires taking the lru_lock so we do the put_page
 		 * of the tail pages after the split is complete.
 		 */
-		free_page_and_swap_cache(&new_folio->page);
+		free_folio_and_swap_cache(new_folio);
 	}
 	return ret;
 }
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index b8838ba8207a..5cf204ab6af0 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -746,7 +746,7 @@ static void __collapse_huge_page_copy_succeeded(pte_t *pte,
 			ptep_clear(vma->vm_mm, address, _pte);
 			folio_remove_rmap_pte(src, src_page, vma);
 			spin_unlock(ptl);
-			free_page_and_swap_cache(src_page);
+			free_folio_and_swap_cache(src);
 		}
 	}
 
diff --git a/mm/swap_state.c b/mm/swap_state.c
index ec2b1c9c9926..c354435a0923 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -231,13 +231,11 @@ void free_swap_cache(struct folio *folio)
 }
 
 /*
- * Perform a free_page(), also freeing any swap cache associated with
- * this page if it is the last user of the page.
+ * Freeing a folio and also freeing any swap cache associated with
+ * this folio if it is the last user.
  */
-void free_page_and_swap_cache(struct page *page)
+void free_folio_and_swap_cache(struct folio *folio)
 {
-	struct folio *folio = page_folio(page);
-
 	free_swap_cache(folio);
 	if (!is_huge_zero_folio(folio))
 		folio_put(folio);
-- 
2.47.2

