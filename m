Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AABC7E10F
	for <linux-s390@vger.kernel.org>; Tue,  5 Mar 2024 07:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709623358; cv=none; b=hbIriPUE6ZQoD1W0c6NcRZedhCNdOZhgcq6MPvORradbo98mZODEm6C8+B/jV4emku1h3k+JROd2necL53v/tblDSvJSNXm1ACiwqsr6OO12Ef7l4UCkPuRi1SmRi5Qh8kt17Ut54snTZxWcOrhFb0Omr/88n2PMDin5/EtWAmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709623358; c=relaxed/simple;
	bh=gSuopT+UB64ZbJzax2PN0GsH0wUwb3D2jXENMYp09LU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sHEAcfFuT1Xl3ZE5JVEUCn1gnolduEg3svY8kSTJ5t3iREk74xqXzbjXZ7k/FHmcwQML2tEKVtRdhFNcbbQAs2YSq7TDlZ5MiDnxJNkM58tV/Y2TvkpzBR5dQKLeT6tsf1/b1dnaQo6MPSmXdpUGYKn+XmXsm2xVCwEFViozz6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Onh6yRcU; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Onh6yRcU"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1dcbf3e4598so2806455ad.1
        for <linux-s390@vger.kernel.org>; Mon, 04 Mar 2024 23:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1709623355; x=1710228155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+H7ANhw43eaevV4VQX7czsRSYarXOXymV+NcuYFHLY=;
        b=Onh6yRcUv6IOazRJvTWwpV4gW0sikRuvL0lJjqRfAm2ZaqnayJoHfHWPBt+BQrR5tL
         XDccCueNCQ3f1+qQNXViGXpdMo/Jd1WbmpjUmKsu4wCfqMPYoUk44SJqUi7bPLuJ+fIu
         Z/TvqZ0LYs+ZP6/xCngDeTGYqjpx6gN0LnV7DuXtUpuuh0UXNxWxZuU8V8GNsf12ZEXh
         1/dRS2j+r/A8iYre9ne6OpgWsHgIJIYo4pfb/9gTC9FyVQ+U8QWQrCyMD77mS5/oc3f0
         y2MFkfPO6oELk92Y0Y0zMkLy+fiiullZgVdR0Wr605qyEsVmSsjl5N/eujBQiu76UmV4
         WLuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709623355; x=1710228155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o+H7ANhw43eaevV4VQX7czsRSYarXOXymV+NcuYFHLY=;
        b=J5sIetYurzgljCTo4T7MTDVn+Qx96h//MKEIVIV+oxBNOnqAg4BhYeZn8vM8RY+tso
         mSrku3lG0SR02zdduphf1KU2OUAU0tWskEFFS/4RidPFVsFqmCrj0bo4qS3Wlz2OOzWB
         eChllJWB3FYYhpj8mOV5RjGsa8Jy5QeNI8i801TatMY/1lc36mlTIIlF2oiDm+ZZZq6j
         LVxBg97sp3uzJQGmllyB19cHSutDCX2rOEQU8i0qA944RLe4izi4JwbSXqcxMgT61G6A
         CCvwFiPP1tei1dvz1NIwg0UPVzMHxY3jJfpCdTnMxZCUEitVc4lvhaD/W1Ihz/21ghQC
         UMlQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4PmCjajtbFD+fCR7tB4ClhdMNhCq91FlGcmHVr6fdUhGQYhANO6elmfIvv8dIanrPzrc/K/V3NOvDlBm9Ndb1sKQ4C0NPaMsfeg==
X-Gm-Message-State: AOJu0Yzil8xhfQKLDLv2Kub+mmXsX/admOSOs9m5VIGuz/LkM8Vwl/dl
	72s2bfgsE5T5uP/+siZBN/MtvWyQVXZgyCFe7PhmpBLgc2GMyXVKgXRlDsJu284=
X-Google-Smtp-Source: AGHT+IFhfT/2Pzoa8WqwNZ6N0I6kfte1nwbY/CAra5+bDDaMFCyRo5L5BBcrLvPLzeLCAHKbSkJItg==
X-Received: by 2002:a17:902:d5cb:b0:1dc:51ac:88ef with SMTP id g11-20020a170902d5cb00b001dc51ac88efmr11752027plh.6.1709623355494;
        Mon, 04 Mar 2024 23:22:35 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.155])
        by smtp.gmail.com with ESMTPSA id i11-20020a170902c94b00b001dcdf24e336sm8994818pla.47.2024.03.04.23.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 23:22:35 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: akpm@linux-foundation.org,
	vishal.moola@gmail.com,
	hughd@google.com,
	david@redhat.com,
	rppt@kernel.org,
	willy@infradead.org,
	muchun.song@linux.dev
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	kvm@vger.kernel.org,
	linux-s390@vger.kernel.org
Subject: [PATCH v2 3/3] s390: supplement for ptdesc conversion
Date: Tue,  5 Mar 2024 15:21:54 +0800
Message-Id: <20240305072154.26168-1-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <04beaf3255056ffe131a5ea595736066c1e84756.1709541697.git.zhengqi.arch@bytedance.com>
References: <04beaf3255056ffe131a5ea595736066c1e84756.1709541697.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After commit 6326c26c1514 ("s390: convert various pgalloc functions to use
ptdescs"), there are still some positions that use page->{lru, index}
instead of ptdesc->{pt_list, pt_index}. In order to make the use of
ptdesc->{pt_list, pt_index} clearer, it would be better to convert them
as well.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org
---
v1 -> v2: fix build failure (cross compilation successful)

 arch/s390/include/asm/pgalloc.h |  4 ++--
 arch/s390/mm/gmap.c             | 38 +++++++++++++++++----------------
 arch/s390/mm/pgalloc.c          |  8 +++----
 3 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/arch/s390/include/asm/pgalloc.h b/arch/s390/include/asm/pgalloc.h
index 502d655fe6ae..7b84ef6dc4b6 100644
--- a/arch/s390/include/asm/pgalloc.h
+++ b/arch/s390/include/asm/pgalloc.h
@@ -23,9 +23,9 @@ unsigned long *crst_table_alloc(struct mm_struct *);
 void crst_table_free(struct mm_struct *, unsigned long *);
 
 unsigned long *page_table_alloc(struct mm_struct *);
-struct page *page_table_alloc_pgste(struct mm_struct *mm);
+struct ptdesc *page_table_alloc_pgste(struct mm_struct *mm);
 void page_table_free(struct mm_struct *, unsigned long *);
-void page_table_free_pgste(struct page *page);
+void page_table_free_pgste(struct ptdesc *ptdesc);
 extern int page_table_allocate_pgste;
 
 static inline void crst_table_init(unsigned long *crst, unsigned long entry)
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 8da39deb56ca..e43a5a3befd4 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -206,9 +206,11 @@ static void gmap_free(struct gmap *gmap)
 
 	/* Free additional data for a shadow gmap */
 	if (gmap_is_shadow(gmap)) {
+		struct ptdesc *ptdesc, *n;
+
 		/* Free all page tables. */
-		list_for_each_entry_safe(page, next, &gmap->pt_list, lru)
-			page_table_free_pgste(page);
+		list_for_each_entry_safe(ptdesc, n, &gmap->pt_list, pt_list)
+			page_table_free_pgste(ptdesc);
 		gmap_rmap_radix_tree_free(&gmap->host_to_rmap);
 		/* Release reference to the parent */
 		gmap_put(gmap->parent);
@@ -1348,7 +1350,7 @@ static void gmap_unshadow_pgt(struct gmap *sg, unsigned long raddr)
 {
 	unsigned long *ste;
 	phys_addr_t sto, pgt;
-	struct page *page;
+	struct ptdesc *ptdesc;
 
 	BUG_ON(!gmap_is_shadow(sg));
 	ste = gmap_table_walk(sg, raddr, 1); /* get segment pointer */
@@ -1361,9 +1363,9 @@ static void gmap_unshadow_pgt(struct gmap *sg, unsigned long raddr)
 	*ste = _SEGMENT_ENTRY_EMPTY;
 	__gmap_unshadow_pgt(sg, raddr, __va(pgt));
 	/* Free page table */
-	page = phys_to_page(pgt);
-	list_del(&page->lru);
-	page_table_free_pgste(page);
+	ptdesc = page_ptdesc(phys_to_page(pgt));
+	list_del(&ptdesc->pt_list);
+	page_table_free_pgste(ptdesc);
 }
 
 /**
@@ -1377,7 +1379,7 @@ static void gmap_unshadow_pgt(struct gmap *sg, unsigned long raddr)
 static void __gmap_unshadow_sgt(struct gmap *sg, unsigned long raddr,
 				unsigned long *sgt)
 {
-	struct page *page;
+	struct ptdesc *ptdesc;
 	phys_addr_t pgt;
 	int i;
 
@@ -1389,9 +1391,9 @@ static void __gmap_unshadow_sgt(struct gmap *sg, unsigned long raddr,
 		sgt[i] = _SEGMENT_ENTRY_EMPTY;
 		__gmap_unshadow_pgt(sg, raddr, __va(pgt));
 		/* Free page table */
-		page = phys_to_page(pgt);
-		list_del(&page->lru);
-		page_table_free_pgste(page);
+		ptdesc = page_ptdesc(phys_to_page(pgt));
+		list_del(&ptdesc->pt_list);
+		page_table_free_pgste(ptdesc);
 	}
 }
 
@@ -2058,19 +2060,19 @@ int gmap_shadow_pgt(struct gmap *sg, unsigned long saddr, unsigned long pgt,
 {
 	unsigned long raddr, origin;
 	unsigned long *table;
-	struct page *page;
+	struct ptdesc *ptdesc;
 	phys_addr_t s_pgt;
 	int rc;
 
 	BUG_ON(!gmap_is_shadow(sg) || (pgt & _SEGMENT_ENTRY_LARGE));
 	/* Allocate a shadow page table */
-	page = page_table_alloc_pgste(sg->mm);
-	if (!page)
+	ptdesc = page_table_alloc_pgste(sg->mm);
+	if (!ptdesc)
 		return -ENOMEM;
-	page->index = pgt & _SEGMENT_ENTRY_ORIGIN;
+	ptdesc->pt_index = pgt & _SEGMENT_ENTRY_ORIGIN;
 	if (fake)
-		page->index |= GMAP_SHADOW_FAKE_TABLE;
-	s_pgt = page_to_phys(page);
+		ptdesc->pt_index |= GMAP_SHADOW_FAKE_TABLE;
+	s_pgt = page_to_phys(ptdesc_page(ptdesc));
 	/* Install shadow page table */
 	spin_lock(&sg->guest_table_lock);
 	table = gmap_table_walk(sg, saddr, 1); /* get segment pointer */
@@ -2088,7 +2090,7 @@ int gmap_shadow_pgt(struct gmap *sg, unsigned long saddr, unsigned long pgt,
 	/* mark as invalid as long as the parent table is not protected */
 	*table = (unsigned long) s_pgt | _SEGMENT_ENTRY |
 		 (pgt & _SEGMENT_ENTRY_PROTECT) | _SEGMENT_ENTRY_INVALID;
-	list_add(&page->lru, &sg->pt_list);
+	list_add(&ptdesc->pt_list, &sg->pt_list);
 	if (fake) {
 		/* nothing to protect for fake tables */
 		*table &= ~_SEGMENT_ENTRY_INVALID;
@@ -2114,7 +2116,7 @@ int gmap_shadow_pgt(struct gmap *sg, unsigned long saddr, unsigned long pgt,
 	return rc;
 out_free:
 	spin_unlock(&sg->guest_table_lock);
-	page_table_free_pgste(page);
+	page_table_free_pgste(ptdesc);
 	return rc;
 
 }
diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index 008e487c94a6..abb629d7e131 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -135,7 +135,7 @@ int crst_table_upgrade(struct mm_struct *mm, unsigned long end)
 
 #ifdef CONFIG_PGSTE
 
-struct page *page_table_alloc_pgste(struct mm_struct *mm)
+struct ptdesc *page_table_alloc_pgste(struct mm_struct *mm)
 {
 	struct ptdesc *ptdesc;
 	u64 *table;
@@ -147,12 +147,12 @@ struct page *page_table_alloc_pgste(struct mm_struct *mm)
 		memset64(table, _PAGE_INVALID, PTRS_PER_PTE);
 		memset64(table + PTRS_PER_PTE, 0, PTRS_PER_PTE);
 	}
-	return ptdesc_page(ptdesc);
+	return ptdesc;
 }
 
-void page_table_free_pgste(struct page *page)
+void page_table_free_pgste(struct ptdesc *ptdesc)
 {
-	pagetable_free(page_ptdesc(page));
+	pagetable_free(ptdesc);
 }
 
 #endif /* CONFIG_PGSTE */
-- 
2.30.2

