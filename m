Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B454503B;
	Thu, 10 Apr 2025 18:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744308212; cv=none; b=Ap3w6yPr3ss+8bN6rSYU9aV9sB8mgRSLdO9T562B1lXCfFltVGMO5LQB4EboFPe/ZrV+GATst7YR60+omtL6rQlVpF38pPf3Fdz8yTUA/dOC6ToFbkjoYllgMuIqzi+cnGWcTC0ZG3btP18Zn6yczLuJtIqYu0gVr7A3luHDyDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744308212; c=relaxed/simple;
	bh=4aWbed7EtQgLSXk51YT4NxpZ+Qur5bbbpTCLnW+5LHA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IvASCZ3wiLgexbpZK2UiBd18iuLqQXRy6YWvRU1ngx0QoNHuva8hfNOtrHHG6hb78t47NPha+OnrGiYF2kW4rMn13elAnwWWN0AMky0T4iaIAeLylRbHzCykYL/Ojav5D3T/pHV1t7isT1KEtyKY3vPGtjGLHYUTJ1n34Np8WWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BNRfKsb/; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BNRfKsb/"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-739525d4e12so1096027b3a.3;
        Thu, 10 Apr 2025 11:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744308210; x=1744913010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9KspzWYWRsyEbnP31/SlUBhB9lF2Qj2qHmHRt0zLbBU=;
        b=BNRfKsb/graCk44+65PCeq1i05nBDS1W/KIdENTNueJA7omymlELaURHJgjM2UDhkd
         nAXkGmrqcTVILBcET1iKCoFpyifGAp/T6t+0p3JllV8XJGdfIx2KSHZ1qC3TOfV+WpT7
         cQrsTFS12V/9iE15DO/LJZ5RNJJdOxm6EW9MmFOY0NjoPFQ9PU18ZTIrc5+4PWG5O0l7
         VZFM4PNG5x4mMVuFd94OuUG9+pe0oVMRHNgdWHer/Z1I5ceDkzJ9uzesFQqFtK3OVGvG
         m5sWRpqnxQ4SwJAhsXCn7QLrpqzY50Ds1P4w5ul0tr/cyVksVzXF0sh3ImSOPRrGON07
         AL5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744308210; x=1744913010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9KspzWYWRsyEbnP31/SlUBhB9lF2Qj2qHmHRt0zLbBU=;
        b=sU9J+6gO3Fz4dinvFJuR5u1yN2gp4f+855FmLcXAyRPhXzkF6yncTzoM5V91yNA8hH
         HwMvtMnFUtCJqKXvfNvomtktNxRPgw84i/9dOP0Vpt+Ia65Bd9Z1zn9LY8roH3Feb5ko
         5K7oWwvJlcrFS5r5vHDeIipSx/AGNLn/oIqRBitM7Cs5eOxuCQjH/Al6Fc74MIcwcDBh
         UUVStwYczUgmym5GJcOEVebvp/ZLfUVxW0+XoXnGaehbMgaxoit4ja5mSwUokvdDRnup
         fup2ztYHSIbS9ifX5Q7zq6XN3F+PB8G7ElNISnsD2HpBWlwkL4G+D1tNTWByYsDdlRuG
         dtXg==
X-Forwarded-Encrypted: i=1; AJvYcCU/kyKrOEgaqnIwJMf4MzQgOjs+FRxGI+rO25sUGiBU2jngaQ2Y+0vW+c9HVvsZ52bDTHnSJ7YtsnAScg==@vger.kernel.org, AJvYcCWO4VZtoLY9t1kVELc6TBifKXkE4GTpbNPcizquFFAId0aGJxpiJKgLsiAZOMDQvE48d1suAxvy+0MZpR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcZezSEMFJZdbgk683mNm3fL0+NWXhmlOL6c/PBc2T7ZezMFzs
	WKDOjPjkeaOPl3jPd99RCitud3V6Ah414lUk7XRwUa3DQpuCIBKZ
X-Gm-Gg: ASbGncsldj8PvjNBoqsn9VhYIYLCbWhVKH5/V8B5ZPPuPxnnYSQCz/dwgqfQgWE+w7f
	A8SMUh0VM2ZSsZNx0H8Gf4/7iz9SImOh7A5BAQr+yNv5cBBPieSgEYkPEsZ8TYJeRFSxVphQ7Rs
	fj4UCBhEOVNEJiHO/ejU4n8NA8N7VrLngPNFBpEryYIyUfLWhxsXS7BbPx818YajS6Y+BFZ1Eo/
	r6r1h/SnHa3Obs9AU2sLhiBxI9LfD6glBYQbXfm6Zw/S07y0Tzc7pO3RNqQwR1u6CZIOKyQgJF0
	YXjvXIkSC/Vv7+HksjmTNlQNrlGj3GIWwWSMIjk6YDC75JPv78AIHZ0G
X-Google-Smtp-Source: AGHT+IGo7HacaL/bCpYlsLvZ/r0cXH+aP5UU2jDrusuLV2kneGlhMHN7AVzvwnv/xHVzRUqpukB9ig==
X-Received: by 2002:a05:6a00:801:b0:736:a82a:58ad with SMTP id d2e1a72fcca58-73bbefa623bmr4027239b3a.15.1744308210343;
        Thu, 10 Apr 2025 11:03:30 -0700 (PDT)
Received: from localhost.localdomain ([2601:646:8f03:9fee:5e33:e006:dcd5:852d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bb1d2b940sm3609697b3a.8.2025.04.10.11.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 11:03:29 -0700 (PDT)
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
	Fan Ni <fan.ni@samsung.com>
Subject: [PATCH] mm: Introduce free_folio_and_swap_cache() to replace free_page_and_swap_cache()
Date: Thu, 10 Apr 2025 11:00:31 -0700
Message-ID: <20250410180254.164118-1-nifan.cxl@gmail.com>
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
---
 arch/s390/include/asm/tlb.h |  4 ++--
 include/linux/swap.h        | 10 +++++++---
 mm/huge_memory.c            |  2 +-
 mm/khugepaged.c             |  2 +-
 mm/swap_state.c             |  8 +++-----
 5 files changed, 14 insertions(+), 12 deletions(-)

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
index db46b25a65ae..9fc8856eeed9 100644
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
@@ -522,8 +522,12 @@ static inline void put_swap_device(struct swap_info_struct *si)
 	do { (val)->freeswap = (val)->totalswap = 0; } while (0)
 /* only sparc can not include linux/pagemap.h in this file
  * so leave put_page and release_pages undeclared... */
-#define free_page_and_swap_cache(page) \
-	put_page(page)
+#define free_folio_and_swap_cache(folio)	\
+	do {					\
+		if (!folio_test_slab(folio))	\
+			folio_put(folio);	\
+	} while (0)
+
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

