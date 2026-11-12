Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794493539;
	b=3pDUa9kvjttn0li2GN2HyybvRSsLqe11Y50iMruFQsx4H9wPaDglgP7B88PwgV0Fm7hG
	 TET3lDfaAhaMN1EJykvXH/rXrTiAVlH01m9IRJUc5OyQoySn1Y93GMVSP4Tt6u3D6gClt
	 sjwuIF04xFj/bZZZ3TMfeYYSUzclWj18HMEl76RGphXEy10atTU/9VTgBts8l4Iuag+Zv
	 Ie5AM41xsq2EbG7wdIKDJrLP/9tQ1yQHt3+JIfu6+HUx3wAQ21v0Cc3IguZyu38+3l/dq
	 54AHH4HUIKNNFD/hk8KBZ1B7OE9LtcUUsxuDiEhMFUykQ47RiX11AWq4726cLnhYNZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493539;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Pre-Result:X-Rspamd-Server:
	 X-Spamd-Result:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Rspamd-Queue-Id:X-Rspamd-Pre-Result:X-Rspamd-Action;
	bh=Z3xrZBlTc/FTOQz95usYjN2adGsAVepEaeJcyS2OQCY=;
	b=Z8SdpQJKV2MiVavIU9pqHq/vd6p7TblKzhp4jjTd0rHcgGvsh3C5PICeP6xwl7vB0UPy
	 Fy6HJa3sITHYOVwNTc033HgXr73qNhGvLajsvipjACa0aRabj2BF8NYEroq9z94sPadgo
	 lHN8kbJmnm2MEATJk5YESLWzSGpm62ny7r8iwJgPNC+YpX90d2dLsOSkxCpzLb5RgUlOj
	 R3GjwWbali+CfNYpfsYuIpqYQwq2ZA8rtyDKHSqfZL2LosAslT/lE3fY6vRR2bDXnIvM8
	 KFxwHYcbAOljGimhzXOp5CUnjmUNWF61DfxbJgnrSgj2S152COd6FUvtN/dUajx0hlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769DA60A380D;
	Thu, 12 Nov 2026 14:25:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 769DA60A380D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1465B21E0A;
	Thu, 12 Nov 2026 14:25:38 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CB15213432;
	Thu, 12 Nov 2026 14:25:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id w9GzDFnM9WoAPwAAD6G6ig:T6
	(envelope-from <clopez@suse.de>); Thu, 12 Nov 2026 14:25:36 +0000
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
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>
Subject: [PATCH v3 5/9] mm/mprotect: add MM_CP_PERM_UPGRADE
Date: Thu, 12 Nov 2026 15:20:34 +0100
Message-ID: <20261112142039.907090-7-clopez@suse.de>
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
X-Rspamd-Queue-Id: 1465B21E0A
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action

Add a change_protection() flag for changes that only add permissions,
so that MMU notifier users can keep their mappings and fault in the new
permissions later. mprotect() sets it when the new VMA flags only add
read, write or execute permissions, or VM_ACCOUNT, which does not affect
the page tables. Any other change, such as a different protection key,
is not an upgrade.

Signed-off-by: Carlos López <clopez@suse.de>
---
 include/linux/mm.h |  2 ++
 mm/mprotect.c      | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6af3b7008f1a..001829a61405 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3585,6 +3585,8 @@ int get_cmdline(struct task_struct *task, char *buffer, int buflen);
 #define  MM_CP_UFFD_RWP_RESOLVE            (1UL << 5) /* resolve rwp */
 #define  MM_CP_UFFD_RWP_ALL                (MM_CP_UFFD_RWP | \
 					    MM_CP_UFFD_RWP_RESOLVE)
+/* Whether this change only upgrades/adds permissions */
+#define  MM_CP_PERM_UPGRADE                (1UL << 6)
 
 bool can_change_pte_writable(struct vm_area_struct *vma, unsigned long addr,
 			     pte_t pte);
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 84bcfe0281d3..8c0fcd10f5a3 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -767,6 +767,17 @@ static const struct mm_walk_ops prot_none_walk_ops = {
 	.walk_lock		= PGWALK_WRLOCK,
 };
 
+static bool vma_flags_is_perm_upgrade(vma_flags_t old_vma_flags,
+				      vma_flags_t new_vma_flags)
+{
+	vm_flags_t old = vma_flags_to_legacy(old_vma_flags);
+	vm_flags_t new = vma_flags_to_legacy(new_vma_flags);
+	/* VM_ACCOUNT does not affect page tables */
+	vm_flags_t mask = VM_READ | VM_WRITE | VM_EXEC | VM_ACCOUNT;
+
+	return new == (old | (new & mask));
+}
+
 int
 mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
 	       struct vm_area_struct *vma, struct vm_area_struct **pprev,
@@ -847,6 +858,8 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
 	vma_overwrite_flags(vma, new_vma_flags);
 	if (vma_wants_manual_pte_write_upgrade(vma))
 		mm_cp_flags |= MM_CP_TRY_CHANGE_WRITABLE;
+	if (vma_flags_is_perm_upgrade(old_vma_flags, new_vma_flags))
+		mm_cp_flags |= MM_CP_PERM_UPGRADE;
 	vma_set_page_prot(vma);
 
 	change_protection(tlb, vma, start, end, mm_cp_flags);
-- 
2.51.0

