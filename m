Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793898062;
	b=AbQkYJnPWAQ4i8h4fTaP2m2fUrCBsZKKD8J0HvmHX+YOCdcJ+ONu+N77eiwJTslNi+rY
	 JUqVy+KpZdwQ5bKmDovGsdPn7bDyOvaWWiibKm0XVN14X31/HWbYCEooSm04v9LAuNiXd
	 2x4bWgygzNY6UyTsnYwKvSt9PHMGv9xOa54lftCHd5T1OHjyOsBFcRpL9RsquZZfQwH37
	 bM/WhcPU6UFHIAKHJQxbSpEnIKt/N8xHWqGmnq4OKDsjuimTGOWGjkARyrsrrSmR+itPN
	 LC19SH50MsvILGMf5TQiOH7Fvlrsud5+VoImeNEUHtXvXFk8cfCTufmdbdcTZuby6sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793898062;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id:X-Spam-Level:
	 X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:X-Spamd-Result:
	 X-Spam-Score;
	bh=XrOlVJc59oYib62BfT/3ENAYDoWhZ0QgBTfWP6Dr3iE=;
	b=1RtOGXe0VmqqxxlhpKn5BTLQcrOv5ChSNpCEu09zh1prsboGsdzVZakXAP5wJOEdOOiH
	 gepYYuAitWByNc4HDupd13ooOCNP+WjyshPelz6vGwttmN/4NamDQjZMe3fJLxVLpTehz
	 b5h1euf/6AFwuyamkgdrrTsWnW42DZyYxwiQ1d7CC4fYmNqX46Z1k5+pUI7Tu/loXFFVH
	 ku0YDkiK4J7OiF1GSCfJpg6AbZ01Ekh4pQUzYzz7f5JOFqoDPGq73FQ9r03eVk722LWzb
	 gNamz1lM2KMBWlCrk7kQDklXE+Bir1Qze/TQDOnJvFSBv8stWRFyI7lKke+6tG5ynKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=bwfKcNNH;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=oMZXE9vq;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=bwfKcNNH;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=oMZXE9vq;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559F3606A33F;
	Thu,  5 Nov 2026 17:01:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 559F3606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=bwfKcNNH;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=oMZXE9vq;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=bwfKcNNH;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=oMZXE9vq
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A519322969;
	Thu,  5 Nov 2026 17:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793898059; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XrOlVJc59oYib62BfT/3ENAYDoWhZ0QgBTfWP6Dr3iE=;
	b=bwfKcNNHotvZiPIGKoYNHRVjzFCLekuO/biuK0+R+N+v7R6/3iDScSBzvXibnkScKr7HPW
	p7TKbxrVczEqGFHY7vl7yTBH41pYxALVihvTZ66tK+K52QJRjiPIFLxLuYUVcg+aX9jwdN
	F+59SFQc+NVuOP9tXnEajUkBtdwGsp4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793898059;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XrOlVJc59oYib62BfT/3ENAYDoWhZ0QgBTfWP6Dr3iE=;
	b=oMZXE9vqv/q9klCqGpvzovKwu+02C8g691XsaiMX52BN3O/iSypUm5MDyh5oxy++gkk9Xo
	nB8GkVyOX4c5wmCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=bwfKcNNH;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=oMZXE9vq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793898059; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XrOlVJc59oYib62BfT/3ENAYDoWhZ0QgBTfWP6Dr3iE=;
	b=bwfKcNNHotvZiPIGKoYNHRVjzFCLekuO/biuK0+R+N+v7R6/3iDScSBzvXibnkScKr7HPW
	p7TKbxrVczEqGFHY7vl7yTBH41pYxALVihvTZ66tK+K52QJRjiPIFLxLuYUVcg+aX9jwdN
	F+59SFQc+NVuOP9tXnEajUkBtdwGsp4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793898059;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XrOlVJc59oYib62BfT/3ENAYDoWhZ0QgBTfWP6Dr3iE=;
	b=oMZXE9vqv/q9klCqGpvzovKwu+02C8g691XsaiMX52BN3O/iSypUm5MDyh5oxy++gkk9Xo
	nB8GkVyOX4c5wmCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E1386133F6;
	Thu,  5 Nov 2026 17:00:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HMEkC0K27GqWRwAAD6G6ig:T6
	(envelope-from <clopez@suse.de>); Thu, 05 Nov 2026 17:00:57 +0000
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
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>
Subject: [PATCH v2 5/9] mm/mprotect: keep writable entries writable on permission upgrades
Date: Thu,  5 Nov 2026 17:50:02 +0100
Message-ID: <20261105165004.2663799-9-clopez@suse.de>
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
X-Rspamd-Queue-Id: A519322969
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-12.51 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL3zg8z7sygsujbub1yh4z3pr1)];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -12.51

change_protection() applies vma->vm_page_prot, which lacks the write bit
for CoW and write-notified mappings, so it write-protects every entry
in them. When an entry would simply be made writable on fault without
further checks (e.g. dirty PTEs in shared mappings, exclusive anonymous
pages), MM_CP_TRY_CHANGE_WRITABLE makes the entry writable again to
avoid the future fault.

However, writable entries in shared mappings that are not dirty still
become read-only. For example, a uffd-wp unprotect makes clean shmem
PTEs read-only even if they were never write-protected, e.g. when they
were mapped by a read fault before uffd-wp was registered. The next
write to each of them causes a fault that only restores the write bit.

Now that MM_CP_PERM_UPGRADE indicates whether mprotect() only adds
permissions, change_protection() can tell, together with the
userfaultfd unprotect flags, when a change revokes no access. Keep
writable entries writable in these cases, at the PTE, PMD and PUD
levels. This is consistent with the write fault handler, as an entry
that is already writable needs no write fault.

Signed-off-by: Carlos López <clopez@suse.de>
---
 mm/huge_memory.c | 7 +++++++
 mm/internal.h    | 7 +++++++
 mm/mprotect.c    | 4 ++++
 3 files changed, 18 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 506e1e61c0fd..6e23d0e4ae66 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2809,6 +2809,10 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	if (userfaultfd_rwp(vma) && pmd_uffd(entry))
 		entry = pmd_modify(entry, PAGE_NONE);
 
+	/* See change_present_ptes(). */
+	if (mm_cp_is_perm_upgrade(cp_flags) && pmd_write(oldpmd))
+		entry = pmd_mkwrite(entry, vma);
+
 	/* See change_pte_range(). */
 	if ((cp_flags & MM_CP_TRY_CHANGE_WRITABLE) && !pmd_write(entry) &&
 	    can_change_pmd_writable(vma, addr, entry))
@@ -2885,6 +2889,9 @@ int change_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	 */
 	oldpud = pudp_invalidate(vma, addr, pudp);
 	entry = pud_modify(oldpud, newprot);
+	/* See change_present_ptes(). */
+	if (mm_cp_is_perm_upgrade(cp_flags) && pud_write(oldpud))
+		entry = pud_mkwrite(entry);
 	/* See change_pte_range(). */
 	if ((cp_flags & MM_CP_TRY_CHANGE_WRITABLE) && !pud_write(entry) &&
 	    can_change_pud_writable(vma, addr, entry))
diff --git a/mm/internal.h b/mm/internal.h
index 566cbd2dce48..a1a66f3b4b9c 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1423,6 +1423,13 @@ static inline bool pte_needs_soft_dirty_wp(struct vm_area_struct *vma, pte_t pte
 	return vma_soft_dirty_enabled(vma) && !pte_soft_dirty(pte);
 }
 
+/* Whether a change_protection() only adds permissions. */
+static inline bool mm_cp_is_perm_upgrade(unsigned long cp_flags)
+{
+	return cp_flags & (MM_CP_PERM_UPGRADE | MM_CP_UFFD_WP_RESOLVE |
+			   MM_CP_UFFD_RWP_RESOLVE);
+}
+
 /* shrinker related functions */
 unsigned long shrink_slab(gfp_t gfp_mask, int nid, struct mem_cgroup *memcg,
 			  int priority);
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 683131c9c4a0..16b8aef755ab 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -306,6 +306,10 @@ static __always_inline void change_present_ptes(struct mmu_gather *tlb,
 	if (userfaultfd_rwp(vma) && pte_uffd(ptent))
 		ptent = pte_modify(ptent, PAGE_NONE);
 
+	/* A permission upgrade keeps writable entries writable. */
+	if (mm_cp_is_perm_upgrade(cp_flags) && pte_write(oldpte))
+		ptent = pte_mkwrite(ptent, vma);
+
 	/*
 	 * In some writable, shared mappings, we might want
 	 * to catch actual write access -- see
-- 
2.51.0

