Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793898058;
	b=uxigh/2tViQa7WHhpAp4Pag068pWtUWxMGDdcFqBFxcylaa7WGJZEoAPo4rNMiqCGlZ4
	 hAcTytoC0z8z10rJVbnsCi9Ne5hWyIX7RNfTfXAN8GdlZ5x+J4VSGcn+LdqGQQjXngfwB
	 Hz2D+eo0OCKyqg0NTrKltYq0xI+X1t46JqbJkJ7Lhk7y5c5wg4j48oAk82kEMBn4ui5ch
	 kigpHK9KP/7rEw43sQqnusaLI85LQHic64n1q9+a00BWtZiXG5qyOK1cPzodIqXUWe8K5
	 BcT1hD/v/kzD2A+1/u5RdWUjO1EzEABm0S2NHF2U+0czHk1+fA+Puq96H4K/N2ZtSWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793898058;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Spamd-Result:X-Rspamd-Server:
	 X-Rspamd-Action:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Rspamd-Queue-Id;
	bh=ZNgGJWG7rTKkwW3ylpil8PEuUBqj8yefdS7O9KEe1jw=;
	b=I7M2rxCciKfYu58QVA6Fl1c8dXlnHUdNV919ryx26ohvoGSY5w9q1o9HWeInV+1R16RG
	 DEgt7NP+vjjQBtBFgjJOucW+91IwM1jLOwksvUPtTcXyRhf/3sEo5ewIRa1M899Sh1xBc
	 kHWiROBjqGgW5oo8lbw9IVRgWOzZZjGUNSrBhflE2bB0PbC5M+4AipvRu/eIixWY0fycn
	 +oh2TfDglgRwPMNC/+gwydUHQCIaRJiJwtnY7G6ML7PQhKkrjhjFeBXEjE5bhkXv/gKAq
	 EDbGgdZTmOKw0jI53b5/PiSo4LyQQHCifnVTLIPuwXoX8K0txRZ4YntzxL87Nasmwww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=bHtRIRuo;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=MnULQVB2;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=bHtRIRuo;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=MnULQVB2;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B03606D805;
	Thu,  5 Nov 2026 17:00:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2B03606D805
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=bHtRIRuo;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=MnULQVB2;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=bHtRIRuo;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=MnULQVB2
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2F1461FE10;
	Thu,  5 Nov 2026 17:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793898056; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZNgGJWG7rTKkwW3ylpil8PEuUBqj8yefdS7O9KEe1jw=;
	b=bHtRIRuonQJOyPSuvBrRcvmluyZbQFXKnkednZ74NurqqE7mD0rORk4DdY37kO9ARtje2H
	Tfb9aw/KT25PXgNShyd0rTI+HsIdalnYzh8Y/ji+5cnsma12HMP+8MbamiIX+zd6qZM6vV
	kk7tYABFjLG5ohPPbtspouCeIZP/sa0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793898056;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZNgGJWG7rTKkwW3ylpil8PEuUBqj8yefdS7O9KEe1jw=;
	b=MnULQVB2MyVRCdT8JcNvwCGhlbVrVTp9YHB8rfRO5thDdE4wCUgLw0RCFoFw+vV3I8Hzux
	IFSTFPsVg63BKPBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=bHtRIRuo;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=MnULQVB2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793898056; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZNgGJWG7rTKkwW3ylpil8PEuUBqj8yefdS7O9KEe1jw=;
	b=bHtRIRuonQJOyPSuvBrRcvmluyZbQFXKnkednZ74NurqqE7mD0rORk4DdY37kO9ARtje2H
	Tfb9aw/KT25PXgNShyd0rTI+HsIdalnYzh8Y/ji+5cnsma12HMP+8MbamiIX+zd6qZM6vV
	kk7tYABFjLG5ohPPbtspouCeIZP/sa0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793898056;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZNgGJWG7rTKkwW3ylpil8PEuUBqj8yefdS7O9KEe1jw=;
	b=MnULQVB2MyVRCdT8JcNvwCGhlbVrVTp9YHB8rfRO5thDdE4wCUgLw0RCFoFw+vV3I8Hzux
	IFSTFPsVg63BKPBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7EB46133F6;
	Thu,  5 Nov 2026 17:00:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HMEkC0K27GqWRwAAD6G6ig:T4
	(envelope-from <clopez@suse.de>); Thu, 05 Nov 2026 17:00:54 +0000
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
Subject: [PATCH v2 3/9] mm/huge_memory: honor MM_CP_TRY_CHANGE_WRITABLE in change_huge_pud()
Date: Thu,  5 Nov 2026 17:50:00 +0100
Message-ID: <20261105165004.2663799-7-clopez@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261105165004.2663799-4-clopez@suse.de>
References: <20261105165004.2663799-4-clopez@suse.de>
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
X-Spamd-Result: default: False [-12.51 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	ARC_NA(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL3zg8z7sygsujbub1yh4z3pr1)];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -12.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 2F1461FE10

When change_protection() is called on a range whose vma->vm_page_prot
does not contain the write bit (MAP_PRIVATE mappings, which need CoW
handling, or MAP_SHARED mappings that want write tracking), the new
entries are created without the write bit, letting the fault handler
re-introduce it. In such cases, MM_CP_TRY_CHANGE_WRITABLE is set to
eagerly restore the W bit in the page table entries when stripping the
write protection was not needed.

However, change_huge_pud() does not currently respect the flag. The only
user of huge PUDs, device DAX, is never CoW and does not need write
notifications for dirty tracking, but it does get them once soft-dirty
tracking is armed through /proc/pid/clear_refs. vm_page_prot then lacks
the write bit, and a protection change leaves dirty PUDs read-only, so
the next write takes a fault only to set the write bit again.

Align change_huge_pud() with change_pte_range() and change_huge_pmd() by
making it respect MM_CP_TRY_CHANGE_WRITABLE. Besides avoiding those
faults, this keeps huge PUDs consistent with the other levels if PUDs
that need CoW, such as anonymous ones, are ever introduced. They would
otherwise lose the write bit on every protection change, even where the
write fault handler would restore it without further checks.

Do this by introducing can_change_pud_writable(), which mimics
can_change_pmd_writable(). Omit the NUMA and uffd-wp checks, which
change_huge_pud() already rejects.

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
index bd44d58e8684..506e1e61c0fd 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2824,6 +2824,29 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
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
@@ -2831,7 +2854,6 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
  * - 1: if pud can be skipped
  * - HPAGE_PUD_NR: if pud was successfully processed
  */
-#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
 int change_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		    pud_t *pudp, unsigned long addr, pgprot_t newprot,
 		    unsigned long cp_flags)
@@ -2863,6 +2885,10 @@ int change_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
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

