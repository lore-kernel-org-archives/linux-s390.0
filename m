Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E7628E7;
	Sun, 13 Apr 2025 04:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744518234; cv=none; b=Qfqh+3i+LTJuVmjbuS6xPCLYeUOeY7hpVyOuCd1B+sndUWbnJ1Zlj0lbOpCPYJJ424rKCFZZa0U1466/6mYoBo9etID3gaYLIEyVdyhNiFqHMKLEQRp1P5dE5J12rqS+93nwi02aJB/9HQc8/pnWd2e07eKSTHwE18sZyuTjHhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744518234; c=relaxed/simple;
	bh=hqXeRxYMroc4DJEL6wM5Qk4Aah8r2O9oGYMxz+3fvoE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k02m00G0Xzt8aIRuKM+id9FrYLs3c/E2FDO38TQJRfQZeByXVqUmGlDrlF2HsVYiAIcJiGOqQtC1n3+puWs/FUt4Eu9riMlqKkQEFRjflPPaw/b1DySnNmdL0jnEzecTA0OAag8LoWXpjF6gkxpxr7kuE738gXQtoDdsyJ9RU4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRIfJwiw; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRIfJwiw"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7376dd56f60so2264184b3a.3;
        Sat, 12 Apr 2025 21:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744518232; x=1745123032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1AS2H+/PIPI3NYMlr10CLL/3dv7YPjYADwcNGHTbPO0=;
        b=eRIfJwiw6fUvtGsVg6+ubj1rMsYAQgP7T+okfIQx41pjJd8j804jm8brPS2LjW3lzD
         eSzj0GUuuP33dJyLSbKXnNKmp8SWlO1pAAgdILYUO9OqCrFSRrnZYOkLOPJMIDb17Tzh
         BizYeqwY7LmS8PlR9XbxJ7wjglhjcD1emh9xNAVThQule029p6UhwGvkUb3Kxt1WOFx1
         yC4hpIemjVWKd97pv2y2mhNdYm9KA4Qsv0Z7DWgbompxcOn/83loO3hcQ9tNIVRpAD8S
         v8qDudG/rRaWODgbWKUQXTBrKjTMtBQEGQbGGUX1Kk9dEaSnEzja6p39acKoxCHX0Eqw
         2CLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744518232; x=1745123032;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1AS2H+/PIPI3NYMlr10CLL/3dv7YPjYADwcNGHTbPO0=;
        b=c85gcqgF2Xu9Ys2YikLTskMRJOXOv82mzTywVGhHkcHmu73bgcw0wDDTTSuG+feRnx
         C7LAMvwDI6is02HtAbr9E7TqmKxyajpFkQ1KaUwKOGoc4uTGkF3EHAFOY6YdvBjTYYlD
         8i64DUUqKzAsXd0cUDBtXm7oBlwGEL0QNYGtu5UYOpV3Amkxnf2ss2Od9fif6+oI3u/Z
         ZN9/jLyt60g5QHn/2hhTYnXj8X/wqAtBb6+67ywVg/uXA5gVH9xF27X3TsuFSN/am3jg
         LrCQRel/Ph+2NCDxCR+MvU2mvmzb3wSTFh2lkshqn2sgBI/XABjJv+yuBOBs8BKjC5qA
         5pvA==
X-Forwarded-Encrypted: i=1; AJvYcCUpUEZfdI2EEBhfIQdipvjsrN5FIY6h3gogyIC5M9nGQMe9BKVSJ1FisKEZurFpDrHd5Kk0ct7iAw3+ZdY=@vger.kernel.org, AJvYcCV6C/l3v7W5mJaOLjh5Bz8khqNmSjLOlmAHw2VLhrDt89CkwZMwqRQuCSb/IXkxxXWqONEyVnc1kIplpw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqpyjf3hgMm0UbE3fjtjcgA/hV4PzsrALVchWhli1bhmJK2zlG
	z3VRHUzJUBVACLvcx/i8e31Dfr8GbyZxlPVYWFWshWTCkGtbiKOM
X-Gm-Gg: ASbGncvmaEv/5ePbstACvBoYpaiGaMY44H0mKA19QLgsBYBFJfmjrAKp+7kfRNptKOm
	lG12A1C/bCfgYJFeQKXg1j9SU2qGzMZiDDe4ExgPMfok6NglZQoTTDisayTV09Agqzj4cfz27AT
	v87W8VYg+F65pLNXlUvuXE7QX7k5fwlwc/qMohXMkus1OLx1z2X9CmEVx2U2BYm1D7ys6Cbv4nG
	DSGe7q53Zio+M30jClmITNzQe4xjG/bQBjFKHwn6iJfu+VaXwHvZZVLhUZsOr5Ni0pGhCkDkPfG
	4lL6LqUShx1/tjEOzLL+NwFF4Fs51HSmvR22b7kBBbuQQQ8T4S84HjNZ
X-Google-Smtp-Source: AGHT+IGdCOnxdewEJNBYQH13wJswSBADISfBNiUR36v8dulkNBEpxas6SlgPzhnmT1diOhe2pjAACw==
X-Received: by 2002:a05:6a21:339d:b0:1f3:33bf:6640 with SMTP id adf61e73a8af0-2017979bf66mr10683683637.18.1744518231647;
        Sat, 12 Apr 2025 21:23:51 -0700 (PDT)
Received: from localhost.localdomain ([2601:646:8f03:9fee:5e33:e006:dcd5:852d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd230db26sm4394079b3a.134.2025.04.12.21.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Apr 2025 21:23:51 -0700 (PDT)
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
Subject: [PATCH v2] mm: Introduce free_folio_and_swap_cache() to replace free_page_and_swap_cache()
Date: Sat, 12 Apr 2025 21:22:21 -0700
Message-ID: <20250413042316.533763-1-nifan.cxl@gmail.com>
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

Introduce free_folio_and_swap_cache(), which takes folio as input to
replace free_page_and_swap_cache().  And apply it to all occurrences
where free_page_and_swap_cache() was used.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Acked-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/s390/include/asm/tlb.h | 4 ++--
 include/linux/swap.h        | 6 +++---
 mm/huge_memory.c            | 2 +-
 mm/khugepaged.c             | 2 +-
 mm/swap_state.c             | 8 +++-----
 5 files changed, 10 insertions(+), 12 deletions(-)

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
index db46b25a65ae..ef76f65686ee 100644
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
@@ -522,8 +522,8 @@ static inline void put_swap_device(struct swap_info_struct *si)
 	do { (val)->freeswap = (val)->totalswap = 0; } while (0)
 /* only sparc can not include linux/pagemap.h in this file
  * so leave put_page and release_pages undeclared... */
-#define free_page_and_swap_cache(page) \
-	put_page(page)
+#define free_folio_and_swap_cache(folio) \
+	folio_put(folio)
 #define free_pages_and_swap_cache(pages, nr) \
 	release_pages((pages), (nr));
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 28c87e0e036f..65a5ddf60ec7 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3640,7 +3640,7 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
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
index 68fd981b514f..ac4e0994931c 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -232,13 +232,11 @@ void free_swap_cache(struct folio *folio)
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

