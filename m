Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794493541;
	b=0rmNC8sog6ii/45JmDOjheJnGEIJgOqc8kMKtZnh2AQpzIJ+qqXLlOLpYx5hQGpiGbWJ
	 C+PZfjSqg8yJ6goscwh6lwgdI6izHcnZjzOWeVmBY2UyVuXETztpGj8UhMaTalvfF8dfU
	 hkz+I9r+jh08hWEvElcEqKh1sHL2ypK7kDyWzy5RUyegkkaEore0AGJhLUrvmYFLhZwUt
	 eSIZoAOL67SjEdf/OwCMWHklcVClBN7Ph6DxPKnLwjbofGm7NquvV1A5aJiLKXf3N5ODq
	 Rbh12QWbNDJCYEZS9a/KEJpKPjul5a1ZamJu/0ZxU2gbB7XY7T7E0B7DdWho7TI18Zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493541;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Pre-Result:X-Rspamd-Queue-Id:
	 X-Rspamd-Pre-Result:X-Rspamd-Action:X-Rspamd-Server:X-Spam-Level:
	 X-Spamd-Result:X-Spam-Flag:X-Spam-Score;
	bh=AcG4jQDK10PWiWbm7mNfeb+DWsCeA1RxCscXblM2xnQ=;
	b=KQZ5rHBrthlkkJcnZhBly9zLmX+/nvZA8+51W9XKI5FD1dPt7sjiPeS8In64lu9DpbFv
	 DCoa3s3P2BMM5FVFFC43HJXG6SKNlxf+8fmV0NC1z9rNYFx+Bjrsz75+6zL2mugaR8YEC
	 ElE6dgWB/i7kAABQ6lcWb9iW2zi4zhVNHuym/Mjy6k6oOidTsBxNOyVaUAjjMOZ3E3lch
	 u+Q9zyq7oBzHEQpFkV1+6KoiRwcpnWskqtqxew4ytT0uZSJpiVbB66OaBJneQ8OUNe/WL
	 sEBD9DiyDdmNvWXpu8QCgc4DQwgeczXtHPxnZMoVgdqGOyIjI50xCFZBN472qXrTwGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5E8606B094;
	Thu, 12 Nov 2026 14:25:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D5E8606B094
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B0A701F7A3;
	Thu, 12 Nov 2026 14:25:39 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5BE6013432;
	Thu, 12 Nov 2026 14:25:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id w9GzDFnM9WoAPwAAD6G6ig:T7
	(envelope-from <clopez@suse.de>); Thu, 12 Nov 2026 14:25:38 +0000
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
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>
Subject: [PATCH v3 6/9] mm/mmu_notifier: add MMU_NOTIFIER_RANGE_PERM_UPGRADE
Date: Thu, 12 Nov 2026 15:20:35 +0100
Message-ID: <20261112142039.907090-8-clopez@suse.de>
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
X-Rspamd-Queue-Id: B0A701F7A3
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00

Add a range flag for invalidations that only upgrade permissions, so
that secondary MMUs can keep their mappings rather than zap them.
change_protection() sets it for MM_CP_PERM_UPGRADE and for the
userfaultfd resolves, which only restore access.

Now that change_protection() keeps writable entries writable on these
changes, no present entry loses access. Writable migration and
device-private entries are still made read-only, which does not affect
secondary MMUs. Migration entries are only installed after secondary
MMUs are invalidated, and device-private pages are migrated back, with
an invalidation, before the CPU can access them.

hugetlb_change_protection() never sets the flag, as hugetlb does not
restore the write bit and may unshare page tables.

Signed-off-by: Carlos López <clopez@suse.de>
---
 include/linux/mmu_notifier.h | 5 +++++
 mm/hugetlb.c                 | 4 ++++
 mm/internal.h                | 7 +++++++
 mm/mprotect.c                | 5 +++--
 4 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index 5db78e5761c5..b2f186ebacf9 100644
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
index ce9c8e57b8e5..06fd31b8fbc4 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6632,6 +6632,10 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
 	 * In the case of shared PMDs, the area to flush could be beyond
 	 * start/end.  Set range.start/range.end to cover the maximum possible
 	 * range if PMD sharing is possible.
+	 *
+	 * MMU_NOTIFIER_RANGE_PERM_UPGRADE is never set here. hugetlb does not
+	 * restore the write bit, and huge_pmd_unshare() may drop the mapping,
+	 * so this is not a strict permission upgrade.
 	 */
 	mmu_notifier_range_init(&range, MMU_NOTIFY_PROTECTION_VMA,
 				0, mm, start, end);
diff --git a/mm/internal.h b/mm/internal.h
index e3f92883bf23..b74ea18c6103 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1453,6 +1453,13 @@ static inline bool pte_needs_soft_dirty_wp(struct vm_area_struct *vma, pte_t pte
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
index 8c0fcd10f5a3..b7accf60c3d4 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -608,8 +608,9 @@ static inline long change_pud_range(struct mmu_gather *tlb,
 			continue;
 
 		if (!range.start) {
-			mmu_notifier_range_init(&range,
-						MMU_NOTIFY_PROTECTION_VMA, 0,
+			mmu_notifier_range_init(&range, MMU_NOTIFY_PROTECTION_VMA,
+						mm_cp_is_perm_upgrade(cp_flags) ?
+						MMU_NOTIFIER_RANGE_PERM_UPGRADE : 0,
 						vma->vm_mm, addr, end);
 			mmu_notifier_invalidate_range_start(&range);
 		}
-- 
2.51.0

