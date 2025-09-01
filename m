Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFF93126B7
	for <linux-s390@vger.kernel.org>; Mon,  1 Sep 2025 09:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756718386; cv=none; b=ZI3PLQQDSR0cbCqWRpxwX0SY3+mvq+xGjzITYZJgafW5ZAbtrsfDhwnwEEMhLm+EDO8TUkSJYKUG5qBXMHzO24R9Aae6S3Wzgmffe9NR2LhTlhRboSRdM8CoW3V2HmqOTVFfOwpXg3TjOax/5OIdErGVUuZR7W4ogOd2ATmuFcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756718386; c=relaxed/simple;
	bh=1IUQHBYBdu3W5xrcejp3dDaBM+7cropS3oh55p/sPZg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EMp9sq+TwiHHyfUSPTxVToNmhinokaxvKeD6q4gi+9aegJkZNNIjX3FAtVfXbr8LqWCKbf4O0T/4Bg5S/FbuRDOlPhymDsmo92RwpVor8UNxQRvrjLO+rtfnz71SS20UwM3i4H8aGbeTau5ZRiMRU8vhLskJvaSxgXQpjPSerdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=HNudBCAJ; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="HNudBCAJ"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b042cc39551so101097166b.0
        for <linux-s390@vger.kernel.org>; Mon, 01 Sep 2025 02:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756718382; x=1757323182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g27oviGyH1E7poP48wwMPEGWPzCs6iGckjbF7ofuUGI=;
        b=HNudBCAJi8VhVScveRJ9jemnHmMBGsE3ipZcT6MB4MhTHRsmsvj04kOEeU9H18uOHJ
         FyhrdwyBbiuzPzlx0cefXzqi0fwM3oztC+HpNlbDzwGA6IDQLOJ00gC+ZVa7P/mfyhDH
         HLrZ8KFUYJsVtlMJWYsefj74bynauYzBQaIavOm/HA9GKEwefaWpT8Ej2SA34X7iK8D8
         jVKvgHg94GY8dF+C5xOwmnzyddnHl1+uYRO7nQqsPZ/AZhz6aF95xZukglxs9jh45zXX
         GKuX9fHmijAVciQA8Hkd9xhr1zYU3o0rWngEYRu7lAtu7wWesJKaQo6mn7/LsOaV5KVW
         0zsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756718382; x=1757323182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g27oviGyH1E7poP48wwMPEGWPzCs6iGckjbF7ofuUGI=;
        b=de6p0Jh6gRVZWqmRL0DDOLjKlRDiO8V3ifRcwEEEfc02G8kUf6M+H1OZqX6b95FS84
         5kXxbONouqHgvZD70wLf2eqj8zI0Rqx3fPpw1s2O6FtyAFVCtdnOvj7FHx9sAzY6y15V
         VzZyoobFm0+ycFrghMrHas+gfyrL5EUYd2BgC41CVUlLEX+BpRzUqcZkmXN953hmaZ87
         hv5BWunPkLtoXnHSEeQcSiP16Fqp+bzEN9BY8pN8KuREPPASeuBzuc4Srq/2Iw5pK2sI
         iPmeQmoy5+UX+4zYmGH+sjSNEmXGLIazmvzhz57xtxyPv1TmuGu5lu9MsMQ0bhVTL3ry
         XaoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeeh2YYeV7O2+9V/yilHW/fN2yZcXWAx1LVgrPyYNRuIR2hsNJeTqVVANfAoIP8acNDUQEN+pdi77I@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq46ZWn9bZG/y4TVGDKnhyiv+MgINiRISwLK6OIygQZFro072+
	yQ5XG1h8jj31UUzwsJxZvq5CBsHSv9H8cRJqoHm1dZHSSlm54WK8ItDH6RnAxLjfLgw=
X-Gm-Gg: ASbGnctijFZ49fSTzsr8hA0I5IjmnxCOqyhoU3y6+kIXt1yV8gt7YcqS+QoS/F9VzQ9
	XKMvQLK+4Pya0Mw3ygdbDEzEIS8uTVKTxw64s666XUyIFXfWsAYBaGr02E1e+6xq7vfnIlQEGIH
	eBNjNJZN2BuvcVnqyuZfS97JQ18kx+ItAPI9ChG8XWUchGmq+3GRgJE0y7FAbG6Tek/cuiVUoRo
	ZPeq87IQzhWgU7om/XCEM3oKn1vXI+8kY8341F61ynkWyqrTpdRAh5uxF8FJkCZW1hDTuEYuBTe
	DWDPaiiDwjIH2SholGwb25IHekfKb9OguBXGKr1YhaA4Pq8Bul/Z5jm9B1F3UITz9DHMxOgo3de
	xA83gXeMJF1rd2AEm4b9MOvT0+ApQrUy2UzNGuztUaJcPiA3c1jcdG7BiSYteYQ+an9Jmrroxew
	YYe65rYFL9FrUPwYr8aFtvn0A6XVCJX07/D9A7TAKLtrQ=
X-Google-Smtp-Source: AGHT+IE/NGoKVl7E/tUqxPYYVhGW9MLa5x5g5kYKEMsRq2hhu2ZhegH9KRzjvzCYerPMCTr/toceTQ==
X-Received: by 2002:a17:907:86a4:b0:b04:3888:5a5b with SMTP id a640c23a62f3a-b04388890admr126924566b.42.1756718382390;
        Mon, 01 Sep 2025 02:19:42 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b01902d0e99sm541005766b.12.2025.09.01.02.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 02:19:42 -0700 (PDT)
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
Subject: [PATCH v4 10/12] mm/mm_inline: add const to pointer parameters for improved const-correctness
Date: Mon,  1 Sep 2025 11:19:13 +0200
Message-ID: <20250901091916.3002082-11-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250901091916.3002082-1-max.kellermann@ionos.com>
References: <20250901091916.3002082-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory management (mm) subsystem is a fundamental low-level component
of the Linux kernel. Establishing const-correctness at this foundational
level enables higher-level subsystems, such as filesystems and drivers,
to also adopt const-correctness in their interfaces. This patch lays
the groundwork for broader const-correctness throughout the kernel
by starting with the core mm subsystem.

This patch adds const qualifiers to folio, lruvec, mm_struct, and
vm_area_struct pointer parameters in mm_inline.h functions that do not
modify the referenced memory, improving type safety and enabling compiler
optimizations.

Functions improved:
- folio_is_file_lru()
- folio_lru_list()
- folio_lru_refs()
- folio_lru_gen()
- lru_gen_is_active()
- lru_gen_folio_seq()
- folio_migrate_refs()
- mm_tlb_flush_pending()
- mm_tlb_flush_nested()
- vma_has_recency()

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

