Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794493538;
	b=n3tK2iJcKX832gzvLIDCgpy8OMYYMrJUz0X8AIG8aboz0iykUnAaz3ge6ODUTaoCDjtq
	 57gF2egqpa6bZpX3pPdT98JYW4byoAWjrrWo0JEnX5YtSJuw1NBRtDE2fMEWo+eY7T57o
	 bB7PKbpo8b0sx0Mls4ZobCX1Ah6nUks3nSj3+Uzj8Yn72oDwe/TwiIoBJXMHCQOX83tPK
	 dCbtKdDDIh96ysUukjBO41bq06MUyA9K5dPFql7lfWtyXJjc5BdmdWmaTaR8rKhctqlNY
	 eBprQpOXqWi/lrt/ezTwDBtTF9AkZIK7UUTl6ykadrFE6SlDg4mPuZ2QCrYe3nuUTCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493538;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Pre-Result:X-Rspamd-Server:
	 X-Spamd-Result:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Rspamd-Queue-Id:X-Rspamd-Pre-Result:X-Rspamd-Action;
	bh=nqY3plPqqqJzQl36ZGXhU10pdEsrz5YDLPHyxcjMpKg=;
	b=vsMMwkK8jmaDKJlM1qx6fPKHgj8ecfw1TASbvtBmZXDx6NVMVPXATfd+GyJL04zNmNRF
	 AYa4ta2BLWzqIrqQLtYNBvjEKMUABNb1uYyMzHsFXS9znPBziLDq8fWyZoB8fYMVcLC3u
	 R6S0oamyN1efFMIVbuAuxft0aX6b/kjxNLrZYMMQidqYS715GHVBK71Of2Dy6f9QgWg8N
	 bjKcO9eSVgWLPUQh3y73XzLJf0FFfB3OyL6TSNZeEgqekL2Noa1YL8zjVDVsMWPt1mHya
	 ryk9jGiHP/a1YkqwMjjzqX/MHClotsRG25JUpSTm0ocoK7s9Lj7kVVVdqzxF6qkPUDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D1A60A2633;
	Thu, 12 Nov 2026 14:25:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42D1A60A2633
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9A05621E41;
	Thu, 12 Nov 2026 14:25:36 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1BC3113432;
	Thu, 12 Nov 2026 14:25:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id w9GzDFnM9WoAPwAAD6G6ig:T5
	(envelope-from <clopez@suse.de>); Thu, 12 Nov 2026 14:25:35 +0000
From: =?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>
To: kvm@vger.kernel.org,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	seanjc@google.com,
	pbonzini@redhat.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	peterx@redhat.com,
	ljs@kernel.org,
	imbrenda@linux.ibm.com,
	borntraeger@linux.ibm.com,
	frankja@linux.ibm.com,
	=?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Usama Arif <usama.arif@linux.dev>,
	Kiryl Shutsemau <kas@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>
Subject: [PATCH v3 4/9] mm: keep writable entries writable on protection changes
Date: Thu, 12 Nov 2026 15:20:33 +0100
Message-ID: <20261112142039.907090-6-clopez@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261112142039.907090-2-clopez@suse.de>
References: <20261112142039.907090-2-clopez@suse.de>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Queue-Id: 9A05621E41
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action

change_protection() applies vma->vm_page_prot, which lacks the write bit
for CoW and write-notified mappings. MM_CP_TRY_CHANGE_WRITABLE makes
entries writable again if a write fault would only set the write bit.
In shared mappings, it relies on the dirty bit for this, as a clean
entry might still need a write fault to notify the FS.

However, this misses clean entries that were already writable. For
example, a uffd-wp unprotect makes shmem PTEs read-only if they were
mapped by a read fault before uffd-wp was registered, so the next write
to each of them faults.

Entries that were writable before the change can stay writable, as
anything that relies on write faults write-protects the entry first, and
MM_CP_TRY_CHANGE_WRITABLE is only set if the VMA stays writable. So
check the old entry before the shared and private rules.

Note: writable anonymous entries are always exclusive and thus already
kept writable, so in private mappings this only affects PFNs that
drivers map writable into them.

Signed-off-by: Carlos López <clopez@suse.de>
---
 mm/huge_memory.c | 22 ++++++++++++++++------
 mm/mprotect.c    | 11 +++++++++++
 2 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 080b718eb7de..69f4485c277e 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2269,7 +2269,8 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
 }
 
 static inline bool can_change_pmd_writable(struct vm_area_struct *vma,
-					   unsigned long addr, pmd_t pmd)
+					   unsigned long addr, pmd_t oldpmd,
+					   pmd_t pmd)
 {
 	struct page *page;
 
@@ -2288,6 +2289,10 @@ static inline bool can_change_pmd_writable(struct vm_area_struct *vma,
 	if (userfaultfd_huge_pmd_wp(vma, pmd))
 		return false;
 
+	/* Writes did not need a fault before the change either. */
+	if (pmd_write(oldpmd))
+		return true;
+
 	if (!(vma->vm_flags & VM_SHARED)) {
 		/* See can_change_pte_writable(). */
 		page = vm_normal_page_pmd(vma, addr, pmd);
@@ -2317,7 +2322,7 @@ vm_fault_t do_huge_pmd_uffd_rwp(struct vm_fault *vmf)
 	pmd = pmd_mkyoung(pmd);
 	if (!pmd_write(pmd) &&
 	    vma_wants_manual_pte_write_upgrade(vma) &&
-	    can_change_pmd_writable(vma, vmf->address, pmd))
+	    can_change_pmd_writable(vma, vmf->address, vmf->orig_pmd, pmd))
 		pmd = pmd_mkwrite(pmd, vma);
 	set_pmd_at(vma->vm_mm, vmf->address & HPAGE_PMD_MASK,
 		   vmf->pmd, pmd);
@@ -2354,7 +2359,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 	 */
 	writable = pmd_write(pmd);
 	if (!writable && vma_wants_manual_pte_write_upgrade(vma) &&
-	    can_change_pmd_writable(vma, vmf->address, pmd))
+	    can_change_pmd_writable(vma, vmf->address, old_pmd, pmd))
 		writable = true;
 
 	folio = vm_normal_folio_pmd(vma, haddr, pmd);
@@ -2820,7 +2825,7 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 
 	/* See change_pte_range(). */
 	if ((cp_flags & MM_CP_TRY_CHANGE_WRITABLE) && !pmd_write(entry) &&
-	    can_change_pmd_writable(vma, addr, entry))
+	    can_change_pmd_writable(vma, addr, oldpmd, entry))
 		entry = pmd_mkwrite(entry, vma);
 
 	ret = HPAGE_PMD_NR;
@@ -2835,7 +2840,8 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
 static inline bool can_change_pud_writable(struct vm_area_struct *vma,
-					   unsigned long addr, pud_t pud)
+					   unsigned long addr, pud_t oldpud,
+					   pud_t pud)
 {
 	struct page *page;
 
@@ -2846,6 +2852,10 @@ static inline bool can_change_pud_writable(struct vm_area_struct *vma,
 	if (vma_soft_dirty_enabled(vma) && !pud_soft_dirty(pud))
 		return false;
 
+	/* Writes did not need a fault before the change either. */
+	if (pud_write(oldpud))
+		return true;
+
 	if (!(vma->vm_flags & VM_SHARED)) {
 		/* See can_change_pte_writable(). */
 		page = vm_normal_page_pud(vma, addr, pud);
@@ -2896,7 +2906,7 @@ int change_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	entry = pud_modify(oldpud, newprot);
 	/* See change_pte_range(). */
 	if ((cp_flags & MM_CP_TRY_CHANGE_WRITABLE) && !pud_write(entry) &&
-	    can_change_pud_writable(vma, addr, entry))
+	    can_change_pud_writable(vma, addr, oldpud, entry))
 		entry = pud_mkwrite(entry);
 	set_pud_at(mm, addr, pudp, entry);
 	tlb_flush_pud_range(tlb, addr, HPAGE_PUD_SIZE);
diff --git a/mm/mprotect.c b/mm/mprotect.c
index e18d4e12fc34..84bcfe0281d3 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -194,6 +194,17 @@ static __always_inline void set_write_prot_commit_flush_ptes(struct vm_area_stru
 {
 	bool set_write;
 
+	/*
+	 * Writes did not need a fault before the change either. All PTEs in
+	 * the batch share the write bit.
+	 */
+	if (pte_write(oldpte)) {
+		set_write = maybe_change_pte_writable(vma, ptent);
+		prot_commit_flush_ptes(vma, addr, ptep, oldpte, ptent, nr_ptes,
+				       /* idx = */ 0, set_write, tlb);
+		return;
+	}
+
 	if (vma_test(vma, VMA_SHARED_BIT)) {
 		set_write = can_change_shared_pte_writable(vma, ptent);
 		prot_commit_flush_ptes(vma, addr, ptep, oldpte, ptent, nr_ptes,
-- 
2.51.0

