Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794493534;
	b=DnZph+9layRfBV3V8sMPwV0xT5qE7lgDvecIJC5RRuG3iED9wpBoYXKS1aMh55r9ffM6
	 GoJZlyU8zte5VHPzJhYFl/EVVz63LZXD+0YOt7Wzcx4su/OKJai+Ohv0pBMnBJFPBgEt3
	 scVEYwswUoalZMcBmemNkNfSCwu3IeL+8xXc5VrIsmjzz005t9EHgr5d+WTBq2ZboSfGs
	 cfnJXUeesOfVzGkeEHIFTIT5DZ/S70cbI5N3J3V7ckAwDy0n1hYxcxsbPco9HbMUQtTJL
	 hy+d0M+kYeN1CSejYoDuGrIeFlKM7nZ4l1EkanVcrusYZWfaKkkRnGMLOXRPIaW2Zbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493534;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Spamd-Result:X-Spam-Score:X-Spam-Level:
	 X-Spam-Flag;
	bh=rarWhYCLUgWlwnaEceP0km2CWzz/RwE1HqqRhAgWRRk=;
	b=aksD4CpvjqQF3KuDhAyhJSHaMspqrcAzskmMNXrv1Aftr7bJczGm1JsQLyaFQAQaJNFN
	 Zzy4pGLXXtTIuy1KvAhpOTnHyiKK63WVjZ4DhyRmyc/+Ma41v66Ok0SXnb6pJqN7cuA1w
	 UcDw+iMRWwgL3VdN3tSvc7n1NksP1aRU5I+11t2XeSy1DmiulJ+BT8otmsIB7pmlZNIg2
	 HWgzueiI+/b0kEam9SNH4k7o20WPnmnQQB8LBo/JM50lKnHk4a4oh2zd1ot81MwjaFm73
	 /oOJCn9pEj6QGBzx6zzbRyrycfTFYEOqfa4MO3Tu8c2V9h1pn2h5O0yfRdiwRXo8Ftw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ASjfoLYK;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=AG6NBTHW;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ASjfoLYK;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=AG6NBTHW;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C626C606A882;
	Thu, 12 Nov 2026 14:25:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C626C606A882
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ASjfoLYK;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=AG6NBTHW;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ASjfoLYK;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=AG6NBTHW
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CE1611F7B9;
	Thu, 12 Nov 2026 14:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794493531; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rarWhYCLUgWlwnaEceP0km2CWzz/RwE1HqqRhAgWRRk=;
	b=ASjfoLYKq8P16CL79W5QgBRozDfCvHzn/EUBfLPNx8F2lufVQ5iB2IBGuN+qYl0e/ALTYZ
	++i8EkuIRmnFo1YSjCzMaT2/UQ2P1nmDuzcP9scj0NkDxymYz5MIt89/Ilm6QhCrABS8/7
	KKyONF65hOwS0bjJ+rN7kS8QSfff9A8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794493531;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rarWhYCLUgWlwnaEceP0km2CWzz/RwE1HqqRhAgWRRk=;
	b=AG6NBTHWRnF6+79ulbExDm0U1UIZBd1in7IoAWxmZUPNiBDjAmbSNt3HovhqSlrQXcHaIe
	fuxhOHi8BiaCzqAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794493531; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rarWhYCLUgWlwnaEceP0km2CWzz/RwE1HqqRhAgWRRk=;
	b=ASjfoLYKq8P16CL79W5QgBRozDfCvHzn/EUBfLPNx8F2lufVQ5iB2IBGuN+qYl0e/ALTYZ
	++i8EkuIRmnFo1YSjCzMaT2/UQ2P1nmDuzcP9scj0NkDxymYz5MIt89/Ilm6QhCrABS8/7
	KKyONF65hOwS0bjJ+rN7kS8QSfff9A8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794493531;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rarWhYCLUgWlwnaEceP0km2CWzz/RwE1HqqRhAgWRRk=;
	b=AG6NBTHWRnF6+79ulbExDm0U1UIZBd1in7IoAWxmZUPNiBDjAmbSNt3HovhqSlrQXcHaIe
	fuxhOHi8BiaCzqAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A294E134F4;
	Thu, 12 Nov 2026 14:25:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id w9GzDFnM9WoAPwAAD6G6ig:T2
	(envelope-from <clopez@suse.de>); Thu, 12 Nov 2026 14:25:30 +0000
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
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Peter Feiner <pfeiner@google.com>
Subject: [PATCH v3 1/9] mm: fix eager write-bit restore for write-notified shared mappings
Date: Thu, 12 Nov 2026 15:20:30 +0100
Message-ID: <20261112142039.907090-3-clopez@suse.de>
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
	RCPT_COUNT_TWELVE(0.00)[20];
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

change_protection() applies vma->vm_page_prot, which lacks the write bit
for CoW and write-notified mappings. Callers set
MM_CP_TRY_CHANGE_WRITABLE when vma_wants_manual_pte_write_upgrade()
returns true, so that entries that can be written without a fault, such
as dirty PTEs in a shared mapping, are made writable right away.

For shared mappings, that function passes vma->vm_page_prot to
vma_wants_writenotify(). Once writenotify is enabled, this protection
lacks the write bit, while the vma_pgprot_modify() result it is compared
against adds it back. The two never match, so vma_wants_writenotify()
returns false before checking for soft-dirty, uffd-wp and writeback.

As a result, write-notified shmem mappings never get
MM_CP_TRY_CHANGE_WRITABLE. For example, commit 931298e103c2
("mm/userfaultfd: rely on vma->vm_page_prot in uffd_wp_range()") made
uffd-wp unprotect set the flag so that dirty shmem PTEs become writable
again, but this never takes effect. Unprotecting N dirty shmem pages
still leads to N faults that only set the write bit.

This dates back to the commit in the Fixes tag, which moved the
equivalent check in mprotect_fixup() before vma_set_page_prot().

Fix this by passing the protection recomputed from the VMA flags, as
vma_set_page_prot() does.

Note: this only affects performance, as the next write fault restores
the write bit anyway.

Fixes: 64e455079e1b ("mm: softdirty: enable write notifications on VMAs after VM_SOFTDIRTY cleared")
Signed-off-by: Carlos López <clopez@suse.de>
---
 mm/vma.h | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/mm/vma.h b/mm/vma.h
index 3fc3b47a954b..e83700e248e4 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -589,6 +589,14 @@ int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	      unsigned long addr, int new_below);
 #endif
 
+#ifdef CONFIG_MMU
+static inline pgprot_t vma_pgprot_modify(pgprot_t oldprot, vma_flags_t vma_flags)
+{
+	const pgprot_t prot = vma_flags_to_page_prot(vma_flags);
+
+	return pgprot_modify(oldprot, prot);
+}
+
 static inline bool vma_wants_manual_pte_write_upgrade(struct vm_area_struct *vma)
 {
 	/*
@@ -596,19 +604,16 @@ static inline bool vma_wants_manual_pte_write_upgrade(struct vm_area_struct *vma
 	 * if we can't do that automatically for all PTEs in a mapping. For
 	 * private mappings, that's always the case when we have write
 	 * permissions as we properly have to handle COW.
+	 *
+	 * vma->vm_page_prot lacks the write bit if writenotify is already
+	 * enabled, so pass it with the bits restored, as vma_set_page_prot()
+	 * does.
 	 */
 	if (vma->vm_flags & VM_SHARED)
-		return vma_wants_writenotify(vma, vma->vm_page_prot);
+		return vma_wants_writenotify(vma,
+		       vma_pgprot_modify(vma->vm_page_prot, vma->flags));
 	return !!(vma->vm_flags & VM_WRITE);
 }
-
-#ifdef CONFIG_MMU
-static inline pgprot_t vma_pgprot_modify(pgprot_t oldprot, vma_flags_t vma_flags)
-{
-	const pgprot_t prot = vma_flags_to_page_prot(vma_flags);
-
-	return pgprot_modify(oldprot, prot);
-}
 #endif
 
 static inline struct vm_area_struct *vma_prev_limit(struct vma_iterator *vmi,
-- 
2.51.0

