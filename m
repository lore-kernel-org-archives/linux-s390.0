Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793285086;
	b=wS8C9yfIfJOPREqAgtjgj3kLUPhU63WZKV9HjyScQ4Q1rIKbXDRKxxMDtnlnNIBx48Lp
	 T8UZFt8lbT9B4nz2RJNzY9xKR4eHfzXtyj99KAgdd8jmHlhwYpP7zBEAwqmj8/gwvGMDl
	 BD7b47p/lgKPYVPIWSk9bAlrR6ygOMPVud9puBCM/taAEoua4+XM/NOz4i8M1kkfaSweB
	 I/ZarcxyoCKhUtjjZmgozja2G7E1iCb9B9wKh64onypZv4PIue/QhEPynYTAwjChp83u6
	 SxP1AbwwgaQ2mOSiHxZULozwdeJ2huWNgXGyyKVaM2IHep2ZIo8HbPhn1HQhROk4GdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793285086;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Spamd-Result:X-Spam-Score:X-Spam-Level:
	 X-Spam-Flag;
	bh=1a8/3J5EcLl5tWmgNvnCtDWgSoQs/LFJclaf6H2KQps=;
	b=slkO2gCogeSq5QNr7UoWxIrakBhnXoExhkq/8Vvv/lkh31YydA2Tivk6qCfVTib4xvbL
	 iY/w+krg3REmozkMceX0IPWaoSzb9tEeD27+MDom0NfDT2s4SNdsFj7KwcuKk9LkEy6oK
	 +4QuKz9WjykG4ghIoiM1JggDwgwFaot9RBIQzkoZpZuS4zPvRKsZSDQaCh4ac+7OKzfKd
	 EQkHT2gwmhjA5q4w+pshPbIRR7GvGbO9KbJu+erKGvaFBOCNstV/v3UapBJ5lu560LzwT
	 NlijI1pZDXf5JMDlc+ArkkGJ59RfpXDmC1vNfhTGxujRQsUsIelZEXGXW3ZGFxwb3oA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=sVPlBFkX;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Fr8gr2lE;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=sVPlBFkX;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Fr8gr2lE;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664B9606A32C;
	Thu, 29 Oct 2026 14:44:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 664B9606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=sVPlBFkX;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Fr8gr2lE;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=sVPlBFkX;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Fr8gr2lE
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DBE4C22101;
	Thu, 29 Oct 2026 14:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793285083; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1a8/3J5EcLl5tWmgNvnCtDWgSoQs/LFJclaf6H2KQps=;
	b=sVPlBFkXmfRtWTOIWulqhqFMBNfA74K7dPLUsieXrjh5gE1OK37eFJrkehhyUerVIB7DSX
	jbD4nUkR1J3bEFlh0TObLESH5SVno9SGZglr6mp7yJTJO//ZrTVuuc/eV1m4ZBDFOHgr4a
	Hjev4aXqBOJVwxyN6pSg/kXhUjh5olQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793285083;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1a8/3J5EcLl5tWmgNvnCtDWgSoQs/LFJclaf6H2KQps=;
	b=Fr8gr2lEW0N8NZ/ST2LUCem+tNGQbJAxCttJl2zYboPp9Oy6bN0PvuTpS2V0VAYScHRRvV
	+iXRI3Bpfiz9NkCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793285083; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1a8/3J5EcLl5tWmgNvnCtDWgSoQs/LFJclaf6H2KQps=;
	b=sVPlBFkXmfRtWTOIWulqhqFMBNfA74K7dPLUsieXrjh5gE1OK37eFJrkehhyUerVIB7DSX
	jbD4nUkR1J3bEFlh0TObLESH5SVno9SGZglr6mp7yJTJO//ZrTVuuc/eV1m4ZBDFOHgr4a
	Hjev4aXqBOJVwxyN6pSg/kXhUjh5olQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793285083;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1a8/3J5EcLl5tWmgNvnCtDWgSoQs/LFJclaf6H2KQps=;
	b=Fr8gr2lEW0N8NZ/ST2LUCem+tNGQbJAxCttJl2zYboPp9Oy6bN0PvuTpS2V0VAYScHRRvV
	+iXRI3Bpfiz9NkCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A23E11339F;
	Thu, 29 Oct 2026 14:44:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iNqFENhb42qRUwAAD6G6ig:T3
	(envelope-from <clopez@suse.de>); Thu, 29 Oct 2026 14:44:42 +0000
From: =?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>
To: kvm@vger.kernel.org,
	linux-mm@kvack.org,
	seanjc@google.com,
	pbonzini@redhat.com
Cc: linux-s390@vger.kernel.org,
	imbrenda@linux.ibm.com,
	=?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC PATCH 2/4] mm/mmu_notifier: add MMU_NOTIFIER_RANGE_PERM_UPGRADE
Date: Thu, 29 Oct 2026 15:33:35 +0100
Message-ID: <20261029143336.390231-5-clopez@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261029143336.390231-3-clopez@suse.de>
References: <20261029143336.390231-3-clopez@suse.de>
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
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL5uaz9zq77jxr8j8m8i6w3kff)];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -16.30
X-Spam-Level: 
X-Spam-Flag: NO

Add a range flag marking an invalidation that only upgrades permissions
(that is, no PFN change and no revoked access). change_protection() sets
it for MM_CP_PERM_UPGRADE and for the userfaultfd permission resolves,
which unprotect a page and thus only restore access.

A secondary MMU can use the flag to keep its mappings rather than zap
them. Consumers that ignore it are unaffected.

Signed-off-by: Carlos López <clopez@suse.de>
---
 include/linux/mm.h           | 6 ++++++
 include/linux/mmu_notifier.h | 5 +++++
 mm/hugetlb.c                 | 6 +++++-
 mm/mprotect.c                | 7 ++++++-
 4 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index f406ce9d1032..c4fc3876a4b7 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3418,6 +3418,12 @@ int get_cmdline(struct task_struct *task, char *buffer, int buflen);
 /* Whether this change only upgrades/adds permissions */
 #define  MM_CP_PERM_UPGRADE                (1UL << 6)
 
+static inline bool mm_cp_is_perm_upgrade(unsigned long cp_flags)
+{
+	return cp_flags & (MM_CP_PERM_UPGRADE | MM_CP_UFFD_WP_RESOLVE |
+			   MM_CP_UFFD_RWP_RESOLVE);
+}
+
 bool can_change_pte_writable(struct vm_area_struct *vma, unsigned long addr,
 			     pte_t pte);
 extern long change_protection(struct mmu_gather *tlb,
diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index a11a44eef521..112be28cdf6b 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -60,6 +60,11 @@ enum mmu_notifier_event {
 };
 
 #define MMU_NOTIFIER_RANGE_BLOCKABLE (1 << 0)
+/*
+ * Set on an invalidation that only expands permissions without
+ * revoking any existing access, nor freeing/moving the underlying page.
+ */
+#define MMU_NOTIFIER_RANGE_PERM_UPGRADE (1 << 1)
 
 struct mmu_notifier_ops {
 	/*
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index b017ae1dfd6f..68d44044fdd2 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6548,19 +6548,23 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
 	long pages = 0, psize = huge_page_size(h);
 	struct mmu_notifier_range range;
 	unsigned long last_addr_mask;
+	unsigned int mn_flags = 0;
 	bool uffd_wp = cp_flags & MM_CP_UFFD_WP;
 	bool uffd_wp_resolve = cp_flags & MM_CP_UFFD_WP_RESOLVE;
 	bool uffd_rwp = cp_flags & MM_CP_UFFD_RWP;
 	bool uffd_rwp_resolve = cp_flags & MM_CP_UFFD_RWP_RESOLVE;
 	struct mmu_gather tlb;
 
+	if (mm_cp_is_perm_upgrade(cp_flags))
+		mn_flags |= MMU_NOTIFIER_RANGE_PERM_UPGRADE;
+
 	/*
 	 * In the case of shared PMDs, the area to flush could be beyond
 	 * start/end.  Set range.start/range.end to cover the maximum possible
 	 * range if PMD sharing is possible.
 	 */
 	mmu_notifier_range_init(&range, MMU_NOTIFY_PROTECTION_VMA,
-				0, mm, start, end);
+				mn_flags, mm, start, end);
 	adjust_range_if_pmd_sharing_possible(vma, &range.start, &range.end);
 
 	BUG_ON(address >= end);
diff --git a/mm/mprotect.c b/mm/mprotect.c
index e9b636809c42..b48d2fd3b7b5 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -597,8 +597,13 @@ static inline long change_pud_range(struct mmu_gather *tlb,
 			continue;
 
 		if (!range.start) {
+			unsigned int mn_flags = 0;
+
+			if (mm_cp_is_perm_upgrade(cp_flags))
+				mn_flags |= MMU_NOTIFIER_RANGE_PERM_UPGRADE;
+
 			mmu_notifier_range_init(&range,
-						MMU_NOTIFY_PROTECTION_VMA, 0,
+						MMU_NOTIFY_PROTECTION_VMA, mn_flags,
 						vma->vm_mm, addr, end);
 			mmu_notifier_invalidate_range_start(&range);
 		}
-- 
2.51.0

