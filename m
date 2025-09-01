Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCAD275106
	for <linux-s390@vger.kernel.org>; Mon,  1 Sep 2025 20:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756759837; cv=none; b=skpb2tJnJX6IXaripyl+yWeHi6aVaqi/mvStzRMhQwBkSyqNKwtxkI7Va+QA4ahlivoVJdyDO7glNSJN6qSZ8vB0r7pEUCH3LDkkonPibMdIY7QeFkM0KIUF2+ojtikjByFn18Q0owiv7PnI84l1548Z8KnY0z5Q+PtoWdNzdNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756759837; c=relaxed/simple;
	bh=TMT49CqstTNtBaTVBDnVTRRV9UZlWdrh748RuoUcnSc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wt6PRX8VDbh4ONTQ7XRptTF4QNtMs0nhwJKeRTyHLJ3szbCz6th/Aq/icOvKaaoVconTTEPXPfhwVXmsAYz4nrVXcqpVvkMKHzHKrGvkFWDQIICY12ggcHP8Bi6fD7W8YrGU73C3kX9l0DHswqfwf/RJo4njkd5xUgsd+gVWqsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=FHQ91QSn; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="FHQ91QSn"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b0418f6fc27so235933366b.3
        for <linux-s390@vger.kernel.org>; Mon, 01 Sep 2025 13:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756759833; x=1757364633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+HuFWfM/wBc81hJ9dDpPKVdEJMtdQ1aHoBTwvYzmlVA=;
        b=FHQ91QSnsRjfVPy0zY1rSfaE13IzuBddN7koWV8FABvl4CnCk1K0RyXVwVx7Aj4Aa5
         OnyKz1581fAFHF4LMEnp//MdHK+M9kSxednjB9fj6Xl6fgGTeB15VKX2ioru/1BBvOi4
         X0M7YrbW3UUo7jKn32autgZTe9pdRuKEdoTSbtZ4uCheXuopYkRvX0qnigHN7ni5xQjd
         zIIiOp7UVOvU/9k89LRoHcVK2OFg9YYU3lzg8etBf3KUIie3IyKTxGG+vGjHVTXR4p+Z
         yMPlZiAullwaGpbq6Oqfs1GsyKJifr1dmQ6kAZxxt6tym9hIjF/esK8ZX4J0cj5TMmAZ
         qBzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756759833; x=1757364633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+HuFWfM/wBc81hJ9dDpPKVdEJMtdQ1aHoBTwvYzmlVA=;
        b=ObDjDngWlt0BNY8nAbDmOi3NkYWKQurmHjdgXEEp/3y0jPsB8kH/XorSc9OOaQpGWr
         YCMylukF5nE9BgWYv/ombosDe4ODfMbBhdQIQG04N3bfGznJeImEc/pwheFpluwOMlbh
         sairjzWAl/VQFyXzo+wZttiQFCaEBc0ltbWa3ZZtu3EUlbnwzjXRBIy6iEbyr3cOasZS
         Y2OfLX1TAbB2cEt0bA1X3rj61tiNN9Fo7mcimb0RvPPeOpS6IVyxwZMJOOJ9BNUGmIN6
         SwFGO3hh5KwAS3aPqWW641ELVUn62VgYTqpGQkZ6GIzOuesKv80wPpQkZNYlA3W2dtq/
         E/lg==
X-Forwarded-Encrypted: i=1; AJvYcCUZ9hUJmF8if2T9LyDGEu3+Lmg9jyt7lHI+P1W+o6ASt6msdu9s4aijgMFJjx5Z9fzgh0dt7cnNLJKu@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp0YnhghXh1+oyWdrXB3gt6B2YlaMUa4Ma7M9dOCGkQtCEogJR
	hcSFIoaN+h5n71zCJB2NIb/i8qMqPVs91wqrVqs2xicvjddHYvvy4qjixyItk2I4cV0=
X-Gm-Gg: ASbGncvKYRReZZ9ok4HfDEf7xF3ROvIldnWItSqWFquoX/jQEZoOLZcOPtDV/q17saz
	SORMTN4j0way7l2LJuU8RJIzoPHcudZmzbYZLhkF6xwjPZAFJXuhB0Fv6j67mLrBYbqNLaUEG9o
	Xx4Ea7/fDW0OmHCFQDZ2bRg9ZIyOLreJCT6IKKK4fbL5HUdEaMVihEXg0+oSayQ3aDJM45/GvNK
	ho0//8dtNhyUU2+sKlr53bMlKFU+lEwPUvhFds+7XnZXdUm9qkmPtFt7yObCFre6w5foTYJ4N7w
	zPyGG0KvMSm6hi3hoAujPNUalQjYw9AvdXD/mCDb2TUs+lpgj2UwyhaF8fA+zIQrnM5oDqsAK0b
	nhEuzsDm8XrN9QXRKyO4PdzDYe1HqUnqYAKyMIHTVFiVbUX/cDsvOt6EDPNp5pof6q5ojWWOWzJ
	okwAMwU5AkJ70pvB1nnYK+nce+CiAlaJsS
X-Google-Smtp-Source: AGHT+IE84zezaOZTWoQkapLH2C1BbO6vX7Y1+6hTyfb4WtgBOH2M2hBOPUkaiYSUFhoR0XJ1xkAFHg==
X-Received: by 2002:a17:906:4794:b0:aff:7429:d40f with SMTP id a640c23a62f3a-b01d8a322b9mr880289766b.4.1756759833266;
        Mon, 01 Sep 2025 13:50:33 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefcbd9090sm937339066b.69.2025.09.01.13.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 13:50:33 -0700 (PDT)
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
Subject: [PATCH v6 03/12] mm: constify zone related test/getter functions
Date: Mon,  1 Sep 2025 22:50:12 +0200
Message-ID: <20250901205021.3573313-4-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250901205021.3573313-1-max.kellermann@ionos.com>
References: <20250901205021.3573313-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For improved const-correctness.

We select certain test functions which either invoke each other,
functions that are already const-ified, or no further functions.

It is therefore relatively trivial to const-ify them, which
provides a basis for further const-ification further up the call
stack.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mmzone.h | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index f3272ef5131b..6c4eae96160d 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1104,7 +1104,7 @@ static inline unsigned long promo_wmark_pages(const struct zone *z)
 	return wmark_pages(z, WMARK_PROMO);
 }
 
-static inline unsigned long zone_managed_pages(struct zone *zone)
+static inline unsigned long zone_managed_pages(const struct zone *zone)
 {
 	return (unsigned long)atomic_long_read(&zone->managed_pages);
 }
@@ -1128,12 +1128,12 @@ static inline bool zone_spans_pfn(const struct zone *zone, unsigned long pfn)
 	return zone->zone_start_pfn <= pfn && pfn < zone_end_pfn(zone);
 }
 
-static inline bool zone_is_initialized(struct zone *zone)
+static inline bool zone_is_initialized(const struct zone *zone)
 {
 	return zone->initialized;
 }
 
-static inline bool zone_is_empty(struct zone *zone)
+static inline bool zone_is_empty(const struct zone *zone)
 {
 	return zone->spanned_pages == 0;
 }
@@ -1273,7 +1273,7 @@ static inline bool folio_is_zone_movable(const struct folio *folio)
  * Return true if [start_pfn, start_pfn + nr_pages) range has a non-empty
  * intersection with the given zone
  */
-static inline bool zone_intersects(struct zone *zone,
+static inline bool zone_intersects(const struct zone *zone,
 		unsigned long start_pfn, unsigned long nr_pages)
 {
 	if (zone_is_empty(zone))
@@ -1581,12 +1581,12 @@ static inline int local_memory_node(int node_id) { return node_id; };
 #define zone_idx(zone)		((zone) - (zone)->zone_pgdat->node_zones)
 
 #ifdef CONFIG_ZONE_DEVICE
-static inline bool zone_is_zone_device(struct zone *zone)
+static inline bool zone_is_zone_device(const struct zone *zone)
 {
 	return zone_idx(zone) == ZONE_DEVICE;
 }
 #else
-static inline bool zone_is_zone_device(struct zone *zone)
+static inline bool zone_is_zone_device(const struct zone *zone)
 {
 	return false;
 }
@@ -1598,19 +1598,19 @@ static inline bool zone_is_zone_device(struct zone *zone)
  * populated_zone(). If the whole zone is reserved then we can easily
  * end up with populated_zone() && !managed_zone().
  */
-static inline bool managed_zone(struct zone *zone)
+static inline bool managed_zone(const struct zone *zone)
 {
 	return zone_managed_pages(zone);
 }
 
 /* Returns true if a zone has memory */
-static inline bool populated_zone(struct zone *zone)
+static inline bool populated_zone(const struct zone *zone)
 {
 	return zone->present_pages;
 }
 
 #ifdef CONFIG_NUMA
-static inline int zone_to_nid(struct zone *zone)
+static inline int zone_to_nid(const struct zone *zone)
 {
 	return zone->node;
 }
@@ -1620,7 +1620,7 @@ static inline void zone_set_nid(struct zone *zone, int nid)
 	zone->node = nid;
 }
 #else
-static inline int zone_to_nid(struct zone *zone)
+static inline int zone_to_nid(const struct zone *zone)
 {
 	return 0;
 }
@@ -1647,7 +1647,7 @@ static inline int is_highmem_idx(enum zone_type idx)
  * @zone: pointer to struct zone variable
  * Return: 1 for a highmem zone, 0 otherwise
  */
-static inline int is_highmem(struct zone *zone)
+static inline int is_highmem(const struct zone *zone)
 {
 	return is_highmem_idx(zone_idx(zone));
 }
@@ -1713,12 +1713,12 @@ static inline struct zone *zonelist_zone(struct zoneref *zoneref)
 	return zoneref->zone;
 }
 
-static inline int zonelist_zone_idx(struct zoneref *zoneref)
+static inline int zonelist_zone_idx(const struct zoneref *zoneref)
 {
 	return zoneref->zone_idx;
 }
 
-static inline int zonelist_node_idx(struct zoneref *zoneref)
+static inline int zonelist_node_idx(const struct zoneref *zoneref)
 {
 	return zone_to_nid(zoneref->zone);
 }
@@ -2021,7 +2021,7 @@ static inline struct page *__section_mem_map_addr(struct mem_section *section)
 	return (struct page *)map;
 }
 
-static inline int present_section(struct mem_section *section)
+static inline int present_section(const struct mem_section *section)
 {
 	return (section && (section->section_mem_map & SECTION_MARKED_PRESENT));
 }
@@ -2031,12 +2031,12 @@ static inline int present_section_nr(unsigned long nr)
 	return present_section(__nr_to_section(nr));
 }
 
-static inline int valid_section(struct mem_section *section)
+static inline int valid_section(const struct mem_section *section)
 {
 	return (section && (section->section_mem_map & SECTION_HAS_MEM_MAP));
 }
 
-static inline int early_section(struct mem_section *section)
+static inline int early_section(const struct mem_section *section)
 {
 	return (section && (section->section_mem_map & SECTION_IS_EARLY));
 }
@@ -2046,27 +2046,27 @@ static inline int valid_section_nr(unsigned long nr)
 	return valid_section(__nr_to_section(nr));
 }
 
-static inline int online_section(struct mem_section *section)
+static inline int online_section(const struct mem_section *section)
 {
 	return (section && (section->section_mem_map & SECTION_IS_ONLINE));
 }
 
 #ifdef CONFIG_ZONE_DEVICE
-static inline int online_device_section(struct mem_section *section)
+static inline int online_device_section(const struct mem_section *section)
 {
 	unsigned long flags = SECTION_IS_ONLINE | SECTION_TAINT_ZONE_DEVICE;
 
 	return section && ((section->section_mem_map & flags) == flags);
 }
 #else
-static inline int online_device_section(struct mem_section *section)
+static inline int online_device_section(const struct mem_section *section)
 {
 	return 0;
 }
 #endif
 
 #ifdef CONFIG_SPARSEMEM_VMEMMAP_PREINIT
-static inline int preinited_vmemmap_section(struct mem_section *section)
+static inline int preinited_vmemmap_section(const struct mem_section *section)
 {
 	return (section &&
 		(section->section_mem_map & SECTION_IS_VMEMMAP_PREINIT));
@@ -2076,7 +2076,7 @@ void sparse_vmemmap_init_nid_early(int nid);
 void sparse_vmemmap_init_nid_late(int nid);
 
 #else
-static inline int preinited_vmemmap_section(struct mem_section *section)
+static inline int preinited_vmemmap_section(const struct mem_section *section)
 {
 	return 0;
 }
-- 
2.47.2

