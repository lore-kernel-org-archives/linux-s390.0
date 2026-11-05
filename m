Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793898059;
	b=DiPsjfmC6nIFReOazdINl9K3eUtqOKgfaFzCT7Pb86uWK201vTa1+5L4uxThUukBVUzX
	 eRrUlpXHUVcHv3qkDdJ9pR3FPdXvE2gI2KgOPSh9eqS9HFWdZnuyMSV18tet5EGURzkeH
	 aljFbCOAgxGOKvl9ZuBi9uTY6xDCJDBQVE0Pe7LEr7BcK6Kva0+AFr0P8QXBDmDqkQDyO
	 vruk9FsjESwR+IbBRAkxg3WCzKpKsI2ibfMKKRi4kAzXojcXKpdXqb+pD66dkrK3jzycT
	 Hzvy/b+QVqe9wPkBOsMeMEY206HL8dc7PDvZIlcMUErPh6xQd3mnp1SAmywDVe0oU9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793898059;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Spamd-Result:X-Spam-Score:X-Spam-Level:
	 X-Spam-Flag;
	bh=JKTmXrXjtWa/G4eyzga8yYon7SkQ1CbbiYS7NLaZQSE=;
	b=2nTO7Xd+jDJOVm+lGIz48T75WY+KSMGaNkGWTYV0/8kJB1T9/WgH/KEWnfvdCJ0e526W
	 nDnRjd56TmZSYOWo/tS2oAHXG/HNahlgIz4zsjr+C5h5KTcgryWQ1SuuD3QAdndPfltsM
	 VMWUdbsmU7UFXMfD/zfVvMXkOj8tE9dmcRRhdZ/uWG5d4Fcf1aXde4Fe5YAhsZrb/LGwk
	 YRgSaBig3e6YYo2FamumGz1UkU+CQ3REDPzd1mi86exDXcSRJl6nW7n67zvpJLWP7La38
	 QH1eTLbRV7oD08Acr5nilX954zBg4rFmOWGwsM0Pwp3+jM4QTFDqGdFF+B0Ho+nF4yA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=FyiaQi6Y;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=P556lgPy;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=FyiaQi6Y;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=P556lgPy;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F677606A328;
	Thu,  5 Nov 2026 17:00:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F677606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=FyiaQi6Y;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=P556lgPy;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=FyiaQi6Y;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=P556lgPy
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A1D701FE8F;
	Thu,  5 Nov 2026 17:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793898057; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JKTmXrXjtWa/G4eyzga8yYon7SkQ1CbbiYS7NLaZQSE=;
	b=FyiaQi6Y22rH29a1RDsHKP1SPcP1S1oFAeAS3xeGQfgeA9N//7ADuXokQdk4OFMCztHkgr
	ODWk2HqyRQocNMJK2K29NCzbfvzJH+R4brhwlcgKg2GP7+R0dcOWewn/PWpaDL3l95hIFQ
	iIB3sgwsZluA/aODCeXlO3pk8d3z+8g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793898057;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JKTmXrXjtWa/G4eyzga8yYon7SkQ1CbbiYS7NLaZQSE=;
	b=P556lgPyQn3q30w9Fgf4cK2jzW9bYpuofte4VAKU44wYJhKO96WGioywB7j7jlZ23FQG8X
	hiQJvKfqZkM6zBBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793898057; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JKTmXrXjtWa/G4eyzga8yYon7SkQ1CbbiYS7NLaZQSE=;
	b=FyiaQi6Y22rH29a1RDsHKP1SPcP1S1oFAeAS3xeGQfgeA9N//7ADuXokQdk4OFMCztHkgr
	ODWk2HqyRQocNMJK2K29NCzbfvzJH+R4brhwlcgKg2GP7+R0dcOWewn/PWpaDL3l95hIFQ
	iIB3sgwsZluA/aODCeXlO3pk8d3z+8g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793898057;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JKTmXrXjtWa/G4eyzga8yYon7SkQ1CbbiYS7NLaZQSE=;
	b=P556lgPyQn3q30w9Fgf4cK2jzW9bYpuofte4VAKU44wYJhKO96WGioywB7j7jlZ23FQG8X
	hiQJvKfqZkM6zBBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A681133F6;
	Thu,  5 Nov 2026 17:00:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HMEkC0K27GqWRwAAD6G6ig:T5
	(envelope-from <clopez@suse.de>); Thu, 05 Nov 2026 17:00:56 +0000
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
Subject: [PATCH v2 4/9] mm/mprotect: add MM_CP_PERM_UPGRADE
Date: Thu,  5 Nov 2026 17:50:01 +0100
Message-ID: <20261105165004.2663799-8-clopez@suse.de>
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
X-Spamd-Result: default: False [-12.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -12.30
X-Spam-Level: 
X-Spam-Flag: NO

Add a change_protection() flag for changes that only add permissions,
keeping the PFN and revoking no access. mprotect() sets it when the new
VMA flags only add read, write or execute permissions. VM_ACCOUNT may be
added as well, as it does not affect the page tables. Any other change,
such as a different protection key, is not considered an upgrade.

This will allow MMU notifier users to perform optimizations, as they
can avoid invalidating PTEs whose permissions can be faulted in.

Signed-off-by: Carlos López <clopez@suse.de>
---
 include/linux/mm.h |  2 ++
 mm/mprotect.c      | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9f167950926a..dddbd76a2760 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3581,6 +3581,8 @@ int get_cmdline(struct task_struct *task, char *buffer, int buflen);
 #define  MM_CP_UFFD_RWP_RESOLVE            (1UL << 5) /* resolve rwp */
 #define  MM_CP_UFFD_RWP_ALL                (MM_CP_UFFD_RWP | \
 					    MM_CP_UFFD_RWP_RESOLVE)
+/* Whether this change only upgrades/adds permissions */
+#define  MM_CP_PERM_UPGRADE                (1UL << 6)
 
 bool can_change_pte_writable(struct vm_area_struct *vma, unsigned long addr,
 			     pte_t pte);
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 754333698c1e..683131c9c4a0 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -756,6 +756,17 @@ static const struct mm_walk_ops prot_none_walk_ops = {
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
@@ -836,6 +847,8 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
 	vma_flags_reset_once(vma, &new_vma_flags);
 	if (vma_wants_manual_pte_write_upgrade(vma))
 		mm_cp_flags |= MM_CP_TRY_CHANGE_WRITABLE;
+	if (vma_flags_is_perm_upgrade(old_vma_flags, new_vma_flags))
+		mm_cp_flags |= MM_CP_PERM_UPGRADE;
 	vma_set_page_prot(vma);
 
 	change_protection(tlb, vma, start, end, mm_cp_flags);
-- 
2.51.0

