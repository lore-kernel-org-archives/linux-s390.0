Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D57A34AAF1
	for <linux-s390@vger.kernel.org>; Mon,  1 Sep 2025 12:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729858; cv=none; b=A8L3HcuuiSkXlk6esqhjv/rNOoPM+0qlr1RcmN5BvGJMZbGR1s4I7/Wv7o4HsYdd7CDHmYNM8xvgN78T67/Na6RYcnC87k6yurZfqq+TML9K6lYXvjzb284pXNZL1NS2otvh2GwSAWNafkXzHlq43ppwnI0QPNOsWitLyJ0gfqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729858; c=relaxed/simple;
	bh=31+JNbBxEbgRy394xiEY0SqE+foE7WaLBkkkvVJFhXI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g4Kt8+XYXWzmt9OH4GftJcu1uhnFiu7RVMeuJ36utyzN7NFZdIszWNcFALdI7JgszAxEHmVDYm5gLnBj9boyeYlcyoTkbKM/LNfkwWQDHhU5ktos9IvPX0c9XXGeWP+knU8qvw3cNzjdxv+W9j4ctkGWutACqBfUIeW/sjMymjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=HTecopPj; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="HTecopPj"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6188b6f501cso4788273a12.2
        for <linux-s390@vger.kernel.org>; Mon, 01 Sep 2025 05:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756729854; x=1757334654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=719Ia0lSRQecbD5eusFA1tVcXf6dgvDvzBCqCYcJwqw=;
        b=HTecopPjrD6O6KseQfBkDG2HF0HXMdtaPLkAcOX6N17X/H8SSj08ozVOo6VICD8tJT
         SM3yElEPB5BaDOZKwCX+jKOCy5TdVAHnMj3KUcHdGTo2ZNvhB9ATKfj8aDhR0EzZ99mP
         5mlPHdWYRm1qYMG7YJPxZbx9X1yrA+bX1C0QRpjpLmdxCVJreADV3BbviOU6BP+lXjMQ
         XxLV91GA7QwoNavmE6sCiGEtJk0l4X37hGtM0r5nfrphswI/4j2uii4DukJuc/jziMui
         xnwwbEtMXMTpDxQrKTKJSEpdNL8k32HKyDF1iSJNzuS9QvwU9pKVe14g1ANmpEgQsjC1
         5ICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756729854; x=1757334654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=719Ia0lSRQecbD5eusFA1tVcXf6dgvDvzBCqCYcJwqw=;
        b=g+gbQqqqsxgX2VyGVgNcyR4hrlAL6bY8r3F5xMmZ+qDQjd0xMB8hzhpnUgK2pEOgkD
         YSgfk6vyPzigfSAXFLksE/x3U4XtYw1bLXb3VAQRDeMmaiQBjddEt4DrBaH0LkWZidlc
         9HUn1+UwwQZjThcprEt22Ladg5Yoxj63sO5TLNdFQ+GmmjNs74+RiYhumbKvcPcpgip5
         WERiGTQ3IsB/8MUE8aP5JKpJkPCW3RALN9vu/+lkLjV5goMsllY2CKs5JLDhWMlTMit4
         1RkPqM/uXcmCihoYw272tZ3mAbJD2Ywy2nHKmfXGZbMJN+ZDhasCPzWFi1BwxY59tcFn
         ajtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoJo2M+NzTwJKOTviFkDO4dC5lgOPea05WZW77x3Qv99RZ4xF8HnFT5/Bnp7/PtCixSXkCaaQclmck@vger.kernel.org
X-Gm-Message-State: AOJu0YxQqQn07at/kTOL9OZguGcnA6T3OsvCyqIXGSzF0pD3uC7NDAx6
	c+sk9A1HEIwAWzuK4t7kA2GmC+z4TioOigwk9CyOIk4l/80Z5JixcXTrCslNx/EKlGQ=
X-Gm-Gg: ASbGnctMKTqCH67fwUgxKudcsqxP1dcD+f6WlCgv1oFGZZVRkGmDWeJfefllOqVncxj
	4MENLe6d2yaGcoD4GKXD/WdIZYR0yFy51H4/g8A3tAmFG5da/h7Tx9h2ph9vFvLOJHi1P1rowgB
	W94rUrArQlg47yi9dGXZaau1XhUapB7g4NnezkvR5fdnGARXSMLbzGRQFdcjC/z9B9tB0CgNG7W
	CaOam0uDYPafxkCS7W+uKeMnIQgg8pSWJzDFNX5CJuYpD/V35Srnj5ZdScUhpIXTGUSMniBDRCR
	2Q5TBPLBx+TptTDiN/YRXl7x8YvQxFKmJdcU+1Co0686ifZKHH9OcPipadNKjntEWX/M+t1z4qh
	hcReDWUeDXg+xOcvWJ3soVHmYZFmUxq0pQaQYxw4rrbX5UiDCD2AlVUeUhaC3gL93tokYaMbb4C
	F18TTu2g9T47u0sLKr2uMnb042QfPKvPMec6AcdrMQZ+s=
X-Google-Smtp-Source: AGHT+IFXpOqRLV7jtUuVW63S0urvzzT2Ybqzsy1IuQBF5NxQ7SlgahydrdjD1p/lIEKi/iaMHlbMCA==
X-Received: by 2002:a05:6402:3510:b0:61c:5cac:2961 with SMTP id 4fb4d7f45d1cf-61d2699455emr6335145a12.14.1756729854314;
        Mon, 01 Sep 2025 05:30:54 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61eaf5883b6sm255566a12.20.2025.09.01.05.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 05:30:54 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	willy@infradead.org,
	hughd@google.com,
	mhocko@suse.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	vishal.moola@gmail.com,
	linux@armlinux.org.uk,
	James.Bottomley@HansenPartnership.com,
	deller@gmx.de,
	agordeev@linux.ibm.com,
	gerald.schaefer@linux.ibm.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	davem@davemloft.net,
	andreas@gaisler.com,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	x86@kernel.org,
	hpa@zytor.com,
	chris@zankel.net,
	jcmvbkbc@gmail.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	weixugc@google.com,
	baolin.wang@linux.alibaba.com,
	rientjes@google.com,
	shakeel.butt@linux.dev,
	max.kellermann@ionos.com,
	thuth@redhat.com,
	broonie@kernel.org,
	osalvador@suse.de,
	jfalempe@redhat.com,
	mpe@ellerman.id.au,
	nysal@linux.ibm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-parisc@vger.kernel.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v5 10/12] mm: constify various inline test functions for improved const-correctness
Date: Mon,  1 Sep 2025 14:30:26 +0200
Message-ID: <20250901123028.3383461-11-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250901123028.3383461-1-max.kellermann@ionos.com>
References: <20250901123028.3383461-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We select certain test functions from mm_inline.h which either invoke
each other, functions that are already const-ified, or no further
functions.

It is therefore relatively trivial to const-ify them, which
provides a basis for further const-ification further up the call
stack.

One exception is the function folio_migrate_refs() which does write to
the "new" folio pointer; there, only the "old" folio pointer is being
constified; only its "flags" field is read, but nothing written.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/mm_inline.h | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 150302b4a905..8c4f6f95ba9f 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -25,7 +25,7 @@
  * 0 if @folio is a normal anonymous folio, a tmpfs folio or otherwise
  * ram or swap backed folio.
  */
-static inline int folio_is_file_lru(struct folio *folio)
+static inline int folio_is_file_lru(const struct folio *const folio)
 {
 	return !folio_test_swapbacked(folio);
 }
@@ -84,7 +84,7 @@ static __always_inline void __folio_clear_lru_flags(struct folio *folio)
  * Return: The LRU list a folio should be on, as an index
  * into the array of LRU lists.
  */
-static __always_inline enum lru_list folio_lru_list(struct folio *folio)
+static __always_inline enum lru_list folio_lru_list(const struct folio *const folio)
 {
 	enum lru_list lru;
 
@@ -141,7 +141,7 @@ static inline int lru_tier_from_refs(int refs, bool workingset)
 	return workingset ? MAX_NR_TIERS - 1 : order_base_2(refs);
 }
 
-static inline int folio_lru_refs(struct folio *folio)
+static inline int folio_lru_refs(const struct folio *const folio)
 {
 	unsigned long flags = READ_ONCE(folio->flags.f);
 
@@ -154,14 +154,14 @@ static inline int folio_lru_refs(struct folio *folio)
 	return ((flags & LRU_REFS_MASK) >> LRU_REFS_PGOFF) + 1;
 }
 
-static inline int folio_lru_gen(struct folio *folio)
+static inline int folio_lru_gen(const struct folio *folio)
 {
 	unsigned long flags = READ_ONCE(folio->flags.f);
 
 	return ((flags & LRU_GEN_MASK) >> LRU_GEN_PGOFF) - 1;
 }
 
-static inline bool lru_gen_is_active(struct lruvec *lruvec, int gen)
+static inline bool lru_gen_is_active(const struct lruvec *const lruvec, const int gen)
 {
 	unsigned long max_seq = lruvec->lrugen.max_seq;
 
@@ -217,12 +217,13 @@ static inline void lru_gen_update_size(struct lruvec *lruvec, struct folio *foli
 	VM_WARN_ON_ONCE(lru_gen_is_active(lruvec, old_gen) && !lru_gen_is_active(lruvec, new_gen));
 }
 
-static inline unsigned long lru_gen_folio_seq(struct lruvec *lruvec, struct folio *folio,
+static inline unsigned long lru_gen_folio_seq(const struct lruvec *const lruvec,
+					      const struct folio *const folio,
 					      bool reclaiming)
 {
 	int gen;
 	int type = folio_is_file_lru(folio);
-	struct lru_gen_folio *lrugen = &lruvec->lrugen;
+	const struct lru_gen_folio *lrugen = &lruvec->lrugen;
 
 	/*
 	 * +-----------------------------------+-----------------------------------+
@@ -302,7 +303,8 @@ static inline bool lru_gen_del_folio(struct lruvec *lruvec, struct folio *folio,
 	return true;
 }
 
-static inline void folio_migrate_refs(struct folio *new, struct folio *old)
+static inline void folio_migrate_refs(struct folio *const new,
+				      const struct folio *const old)
 {
 	unsigned long refs = READ_ONCE(old->flags.f) & LRU_REFS_MASK;
 
@@ -330,7 +332,7 @@ static inline bool lru_gen_del_folio(struct lruvec *lruvec, struct folio *folio,
 	return false;
 }
 
-static inline void folio_migrate_refs(struct folio *new, struct folio *old)
+static inline void folio_migrate_refs(struct folio *new, const struct folio *old)
 {
 
 }
@@ -508,7 +510,7 @@ static inline void dec_tlb_flush_pending(struct mm_struct *mm)
 	atomic_dec(&mm->tlb_flush_pending);
 }
 
-static inline bool mm_tlb_flush_pending(struct mm_struct *mm)
+static inline bool mm_tlb_flush_pending(const struct mm_struct *const mm)
 {
 	/*
 	 * Must be called after having acquired the PTL; orders against that
@@ -521,7 +523,7 @@ static inline bool mm_tlb_flush_pending(struct mm_struct *mm)
 	return atomic_read(&mm->tlb_flush_pending);
 }
 
-static inline bool mm_tlb_flush_nested(struct mm_struct *mm)
+static inline bool mm_tlb_flush_nested(const struct mm_struct *const mm)
 {
 	/*
 	 * Similar to mm_tlb_flush_pending(), we must have acquired the PTL
@@ -605,7 +607,7 @@ pte_install_uffd_wp_if_needed(struct vm_area_struct *vma, unsigned long addr,
 	return false;
 }
 
-static inline bool vma_has_recency(struct vm_area_struct *vma)
+static inline bool vma_has_recency(const struct vm_area_struct *const vma)
 {
 	if (vma->vm_flags & (VM_SEQ_READ | VM_RAND_READ))
 		return false;
-- 
2.47.2

