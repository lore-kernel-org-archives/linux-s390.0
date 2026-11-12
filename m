Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794493537;
	b=OIR9QgZEyA7HOuvSAGARly/97ubz9GMf6jw3qEpr8qw9NTvM397wcxt1FwnIRhKdudJL
	 GlOljIV/1GdKOzTjRUdob8ekYaa64KDXDwvP/Ca5i1d3kvRme90ZukvwSq75g9Y51Z6EZ
	 cYaUO6gLlj7RP0TD/HWGrYdDGl6xG1ZNDg913+fHvVCCJ0qJ2MgnRUmJBni1XmcNk75A7
	 YWcL1So601351hmhbIX/FU1BGz3FGTFg2eZv5KdYNxo3RReJwWoQVGk7mdbXoFrQyneA6
	 DeV11IIYZlp/jeThN6YvhsMcOeVm5JDog31uCv6jeSpNBv4i5vylGc7Eo6/PloBVQjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493537;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Spamd-Result:X-Spam-Score:X-Spam-Level:
	 X-Spam-Flag;
	bh=6YWUCSXWqyL1xWG0ifotpOzssQneDskvG8p1+21PIR4=;
	b=uFkT8Af8XWaMqlA8NOoEdYBfe9ZknvecW1yRtZkvXMcZO5SQKMJNRp+qdBV1OFDzRj2q
	 pV949l4GSwtFStaiGmHs0RTEpSHOPlyw8IDtQ4HdbKuDOaRygi96B9i7uPyM3+DovzoIo
	 MC3unaXSTF3CPDZu98jgDpOdCaRaeXxiGDwWfKNUwIUWnDlL5mNF7rROfjqPmOGJTkQhi
	 YnrLYOekYjyt/2FZ96B7kd6M2y0qEgeIVSqlSMCaTnq8d9u+2ghdloixyjSgPkls29TyV
	 Q11DU588mY1WYuk+cM/vYyjPqlb5UEeazwJpDBJfb57m7b+7cRdHa0Vkg0HY36YgYRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=RadUXxFz;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=IZqtonmx;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=RadUXxFz;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=IZqtonmx;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F57960A2619;
	Thu, 12 Nov 2026 14:25:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F57960A2619
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=RadUXxFz;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=IZqtonmx;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=RadUXxFz;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=IZqtonmx
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DE15D21DEF;
	Thu, 12 Nov 2026 14:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794493534; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6YWUCSXWqyL1xWG0ifotpOzssQneDskvG8p1+21PIR4=;
	b=RadUXxFzw0HyqoD8lqQh5wbYPJz0ASHGDzXSkyZjXl/V+5m7xPx/svoXkDxCJvmpgcwy6R
	gI+U7ML0T4axp66JIE6EPZvAsEW4OzonyXlgJn1F1X0YiVzkUBo84xFjNM/d7Kjwzt6Xwz
	WX2ZFxX5ly2jUooq9uoQ8aPZVPyk32g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794493534;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6YWUCSXWqyL1xWG0ifotpOzssQneDskvG8p1+21PIR4=;
	b=IZqtonmxFwZVkMHUyVhmFt3xNKcjxQ46cGK7RNQYrb12IKUPSvBmH5ZgzZzE9SJQtdvKLL
	+FjBiBzVnR3Sc4AA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794493534; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6YWUCSXWqyL1xWG0ifotpOzssQneDskvG8p1+21PIR4=;
	b=RadUXxFzw0HyqoD8lqQh5wbYPJz0ASHGDzXSkyZjXl/V+5m7xPx/svoXkDxCJvmpgcwy6R
	gI+U7ML0T4axp66JIE6EPZvAsEW4OzonyXlgJn1F1X0YiVzkUBo84xFjNM/d7Kjwzt6Xwz
	WX2ZFxX5ly2jUooq9uoQ8aPZVPyk32g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794493534;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6YWUCSXWqyL1xWG0ifotpOzssQneDskvG8p1+21PIR4=;
	b=IZqtonmxFwZVkMHUyVhmFt3xNKcjxQ46cGK7RNQYrb12IKUPSvBmH5ZgzZzE9SJQtdvKLL
	+FjBiBzVnR3Sc4AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D6DA13432;
	Thu, 12 Nov 2026 14:25:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id w9GzDFnM9WoAPwAAD6G6ig:T4
	(envelope-from <clopez@suse.de>); Thu, 12 Nov 2026 14:25:33 +0000
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
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Usama Arif <usama.arif@linux.dev>,
	Kiryl Shutsemau <kas@kernel.org>
Subject: [PATCH v3 3/9] mm/huge_memory: honor MM_CP_TRY_CHANGE_WRITABLE in change_huge_pud()
Date: Thu, 12 Nov 2026 15:20:32 +0100
Message-ID: <20261112142039.907090-5-clopez@suse.de>
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
X-Spamd-Result: default: False [-16.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL8fugicft4tip39ru97wanzoz)];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -16.30
X-Spam-Level: 
X-Spam-Flag: NO

change_protection() applies vma->vm_page_prot, which lacks the write bit
for CoW and write-notified mappings. MM_CP_TRY_CHANGE_WRITABLE makes
entries writable again if a write fault would only set the write bit.

However, change_huge_pud() ignores the flag. For example, device DAX
mappings are write-notified once soft-dirty tracking is armed through
/proc/pid/clear_refs, and a protection change then leaves dirty PUDs
read-only, so the next write to each of them faults.

Fix this by adding can_change_pud_writable(), based on
can_change_pmd_writable(). It omits the NUMA and uffd-wp checks, as
change_huge_pud() bails out on those changes.

Signed-off-by: Carlos López <clopez@suse.de>
---
 include/linux/pgtable.h |  5 +++++
 mm/huge_memory.c        | 28 +++++++++++++++++++++++++++-
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 780fe849ff8b..943d7e95f426 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1866,6 +1866,11 @@ static inline int pmd_soft_dirty(pmd_t pmd)
 	return 0;
 }
 
+static inline int pud_soft_dirty(pud_t pud)
+{
+	return 0;
+}
+
 static inline pte_t pte_mksoft_dirty(pte_t pte)
 {
 	return pte;
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index eb913acb03b7..080b718eb7de 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2833,6 +2833,29 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	return ret;
 }
 
+#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
+static inline bool can_change_pud_writable(struct vm_area_struct *vma,
+					   unsigned long addr, pud_t pud)
+{
+	struct page *page;
+
+	if (WARN_ON_ONCE(!(vma->vm_flags & VM_WRITE)))
+		return false;
+
+	/* Do we need write faults for softdirty tracking? */
+	if (vma_soft_dirty_enabled(vma) && !pud_soft_dirty(pud))
+		return false;
+
+	if (!(vma->vm_flags & VM_SHARED)) {
+		/* See can_change_pte_writable(). */
+		page = vm_normal_page_pud(vma, addr, pud);
+		return page && PageAnon(page) && PageAnonExclusive(page);
+	}
+
+	/* See can_change_pte_writable(). */
+	return pud_dirty(pud);
+}
+
 /*
  * Returns:
  *
@@ -2840,7 +2863,6 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
  * - 1: if pud can be skipped
  * - HPAGE_PUD_NR: if pud was successfully processed
  */
-#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
 int change_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		    pud_t *pudp, unsigned long addr, pgprot_t newprot,
 		    unsigned long cp_flags)
@@ -2872,6 +2894,10 @@ int change_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	 */
 	oldpud = pudp_invalidate(vma, addr, pudp);
 	entry = pud_modify(oldpud, newprot);
+	/* See change_pte_range(). */
+	if ((cp_flags & MM_CP_TRY_CHANGE_WRITABLE) && !pud_write(entry) &&
+	    can_change_pud_writable(vma, addr, entry))
+		entry = pud_mkwrite(entry);
 	set_pud_at(mm, addr, pudp, entry);
 	tlb_flush_pud_range(tlb, addr, HPAGE_PUD_SIZE);
 
-- 
2.51.0

