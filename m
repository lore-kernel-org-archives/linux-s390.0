Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B59B54277
	for <linux-s390@vger.kernel.org>; Wed, 17 Jul 2024 22:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721253756; cv=none; b=llzbpDJv8MsupF2xcoJCiNli3oHKF7N5y8/Fqjejtjxg49OdB8ciPYkcrs4DhgD9SlhPn+3CAn1LpI6Z6BF6Hh8+CqS1hzV5Zt1MtqOhikDoNXHpReNIQp0PDJu6+vOrdHxcFYWRZB3j8Bu+CS3bYSEojuu4YHpcv2Bdv0xsCUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721253756; c=relaxed/simple;
	bh=yifXmTzgE0c9+yXX+xoaKz3QzUaCFTIgmBPINt1EPi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mLodx3uzIM+aAhw0ba8b7kbfUIl6pZbuab5GY1fNzJ8LbShrrNHRSf3pduDeLL1nUSSmDD+rxwc2v4QulY6vwCvh3d51+g0oTHB2+aKiDnvDeW9NvTzxvXwICwGVictMgciKYa6nNmSHPr6XqfQxOVf4ztUSMEUxC2VhD70jMkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jPY8VyJ2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jPY8VyJ2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721253753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zJ8eA1hPxoK8G44ES49PoyN6H9fuen7ZiOJ63tJzju0=;
	b=jPY8VyJ2aQZPBsIO94+LAsaFTYs/HltBug+XLn2Pa4jQZceScmUO80IPwmcjihRh67whrR
	5ZTO3clc7hU6Tud2y4aRcojEdU17qeSUaqu3QjAmfs1R9xYyO4H3fMZNn5mykDNMkLEcZZ
	yHsKNVJSWVc21mVxyURdEgfNkHnz0fY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211--9BMHpLdMxyC6Z4MzPvKwg-1; Wed, 17 Jul 2024 18:02:31 -0400
X-MC-Unique: -9BMHpLdMxyC6Z4MzPvKwg-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6b798c6b850so594976d6.0
        for <linux-s390@vger.kernel.org>; Wed, 17 Jul 2024 15:02:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721253751; x=1721858551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zJ8eA1hPxoK8G44ES49PoyN6H9fuen7ZiOJ63tJzju0=;
        b=eCuAQeEpsU4sCAdAvLlBQi9ekbUi6YXVGZUc3+KgZ+/dO3zsZi1ipu+d8u02+eqH1o
         +ksJYGHS9mp66ctfwq6tKSMu5YwUprKjeKvlj8bRgeCIddTpaOfcYls4AsuUwfK/3eMt
         LDznq3jiH25JOud/pTrihz5J3AYnNEVeTsirZPfCR5aswgWCaASlRJ/UzeHuLMEAwXwb
         KiOSns9OOxI1pkq+qXI/izEwoYTgBdemhMv1cnHILsp2e0x0sm1tx3iFsKoWtpTjhnCY
         RNuB8K/g7TALZ+tp/44dU0L+FD/0EuxrOaoWe4mAtb7p2UAdJESbROrvBB5AAirUEfGm
         JkkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZIddExeXWpqjw9e/8vWjMjIx6Jn/slhy2uwXvZeUO0EXCs1LZooA151oGaCPImWig6ThYwdTHTd5inv8ygIkZotM9T1xxdx5Zdw==
X-Gm-Message-State: AOJu0YxmXGiHJlDoW900J4Zb/KbrmXRtDEmVSBJZHLTFHc29SxvUK+o0
	rC5Q/O/inW7HB5p7EJt1gmzkAsJefCSVh6YJtw9JzK3hqhqHtGLVvmubdCFQljl2uckRDSdKCJX
	yWisQFrGhDlvmyNqeBMpq1GFoDD9EuYuz9QufoAYDX5STaLVlEjhnKE7aCxs=
X-Received: by 2002:a05:622a:164b:b0:44e:cff7:3743 with SMTP id d75a77b69052e-44f86e7339emr21651771cf.9.1721253750854;
        Wed, 17 Jul 2024 15:02:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgaCdw1UOkSL+KIFT2eMjRU01W5DATHpkzikOyR2irQlfZJvXc4O4/CXTqU/rdsuwB1sVYnA==
X-Received: by 2002:a05:622a:164b:b0:44e:cff7:3743 with SMTP id d75a77b69052e-44f86e7339emr21651491cf.9.1721253750364;
        Wed, 17 Jul 2024 15:02:30 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f5b83f632sm53071651cf.85.2024.07.17.15.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 15:02:29 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Vlastimil Babka <vbabka@suse.cz>,
	peterx@redhat.com,
	David Hildenbrand <david@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	linux-s390@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Michal Hocko <mhocko@kernel.org>,
	linux-riscv@lists.infradead.org,
	sparclinux@vger.kernel.org,
	Alex Williamson <alex.williamson@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	x86@kernel.org,
	Alistair Popple <apopple@nvidia.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	Ryan Roberts <ryan.roberts@arm.com>,
	Hugh Dickins <hughd@google.com>,
	Axel Rasmussen <axelrasmussen@google.com>
Subject: [PATCH RFC 4/6] mm: Move huge mapping declarations from internal.h to huge_mm.h
Date: Wed, 17 Jul 2024 18:02:17 -0400
Message-ID: <20240717220219.3743374-5-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240717220219.3743374-1-peterx@redhat.com>
References: <20240717220219.3743374-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most of the huge mapping relevant helpers are declared in huge_mm.h, not
internal.h.  Move the only few from internal.h into huge_mm.h.

Here to move pmd_needs_soft_dirty_wp() over, we'll also need to move
vma_soft_dirty_enabled() into mm.h as it'll be needed in two headers
later (internal.h, huge_mm.h).

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/huge_mm.h | 10 ++++++++++
 include/linux/mm.h      | 18 ++++++++++++++++++
 mm/internal.h           | 33 ---------------------------------
 3 files changed, 28 insertions(+), 33 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 37482c8445d1..d8b642ad512d 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -8,6 +8,11 @@
 #include <linux/fs.h> /* only for vma_is_dax() */
 #include <linux/kobject.h>
 
+void touch_pud(struct vm_area_struct *vma, unsigned long addr,
+	       pud_t *pud, bool write);
+void touch_pmd(struct vm_area_struct *vma, unsigned long addr,
+	       pmd_t *pmd, bool write);
+pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma);
 vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf);
 int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		  pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long addr,
@@ -629,4 +634,9 @@ static inline int split_folio_to_order(struct folio *folio, int new_order)
 #define split_folio_to_list(f, l) split_folio_to_list_to_order(f, l, 0)
 #define split_folio(f) split_folio_to_order(f, 0)
 
+static inline bool pmd_needs_soft_dirty_wp(struct vm_area_struct *vma, pmd_t pmd)
+{
+	return vma_soft_dirty_enabled(vma) && !pmd_soft_dirty(pmd);
+}
+
 #endif /* _LINUX_HUGE_MM_H */
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5f1075d19600..fa10802d8faa 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1117,6 +1117,24 @@ static inline unsigned int folio_order(struct folio *folio)
 	return folio->_flags_1 & 0xff;
 }
 
+static inline bool vma_soft_dirty_enabled(struct vm_area_struct *vma)
+{
+	/*
+	 * NOTE: we must check this before VM_SOFTDIRTY on soft-dirty
+	 * enablements, because when without soft-dirty being compiled in,
+	 * VM_SOFTDIRTY is defined as 0x0, then !(vm_flags & VM_SOFTDIRTY)
+	 * will be constantly true.
+	 */
+	if (!IS_ENABLED(CONFIG_MEM_SOFT_DIRTY))
+		return false;
+
+	/*
+	 * Soft-dirty is kind of special: its tracking is enabled when the
+	 * vma flags not set.
+	 */
+	return !(vma->vm_flags & VM_SOFTDIRTY);
+}
+
 #include <linux/huge_mm.h>
 
 /*
diff --git a/mm/internal.h b/mm/internal.h
index b4d86436565b..e49941747749 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -917,8 +917,6 @@ bool need_mlock_drain(int cpu);
 void mlock_drain_local(void);
 void mlock_drain_remote(int cpu);
 
-extern pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma);
-
 /**
  * vma_address - Find the virtual address a page range is mapped at
  * @vma: The vma which maps this object.
@@ -1229,14 +1227,6 @@ int migrate_device_coherent_page(struct page *page);
 int __must_check try_grab_folio(struct folio *folio, int refs,
 				unsigned int flags);
 
-/*
- * mm/huge_memory.c
- */
-void touch_pud(struct vm_area_struct *vma, unsigned long addr,
-	       pud_t *pud, bool write);
-void touch_pmd(struct vm_area_struct *vma, unsigned long addr,
-	       pmd_t *pmd, bool write);
-
 /*
  * mm/mmap.c
  */
@@ -1342,29 +1332,6 @@ static __always_inline void vma_set_range(struct vm_area_struct *vma,
 	vma->vm_pgoff = pgoff;
 }
 
-static inline bool vma_soft_dirty_enabled(struct vm_area_struct *vma)
-{
-	/*
-	 * NOTE: we must check this before VM_SOFTDIRTY on soft-dirty
-	 * enablements, because when without soft-dirty being compiled in,
-	 * VM_SOFTDIRTY is defined as 0x0, then !(vm_flags & VM_SOFTDIRTY)
-	 * will be constantly true.
-	 */
-	if (!IS_ENABLED(CONFIG_MEM_SOFT_DIRTY))
-		return false;
-
-	/*
-	 * Soft-dirty is kind of special: its tracking is enabled when the
-	 * vma flags not set.
-	 */
-	return !(vma->vm_flags & VM_SOFTDIRTY);
-}
-
-static inline bool pmd_needs_soft_dirty_wp(struct vm_area_struct *vma, pmd_t pmd)
-{
-	return vma_soft_dirty_enabled(vma) && !pmd_soft_dirty(pmd);
-}
-
 static inline bool pte_needs_soft_dirty_wp(struct vm_area_struct *vma, pte_t pte)
 {
 	return vma_soft_dirty_enabled(vma) && !pte_soft_dirty(pte);
-- 
2.45.0

