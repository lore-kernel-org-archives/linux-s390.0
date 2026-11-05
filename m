Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793898055;
	b=w7+FpIwFBy+QnjpfB/Mlgo13lIrFWtPNJC+o5JhWx5oOkITKcQtwtTLkyF4Qt2X3l1wY
	 Djvz9H2jtrClK68zFb/xQeLkOoxlTyYCR2uDPgryk9ubeZGPhvYqxxHo6n4lTR9q3jAs8
	 Plm5yrcrnJ5VqG4qm6ZKT7Z0KRQ1a7GXCQVSHtm1if+RUZpFFtE2bMNQti9lfrMPP1fWH
	 aCjYZIeML7I7cMepMTuPOqHEUcGrgQxjoYjvyXebYuMCNQ3V7Vrp8h4yswxmAgYnaLDK9
	 knzNS16oBtn6a+7Cr04dVMh6wO/hTSf/6qNMnaI/OGHniWlYLw87xNjmAPJnbtVEceg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793898055;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Spamd-Result:X-Rspamd-Server:
	 X-Rspamd-Action:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Rspamd-Queue-Id;
	bh=wLnVsJjCToHG/C28VTmqNBcIFpk1g6vauHuX2+bvyeo=;
	b=FeOqzX1mC11Turd3irXuv1J2cyK0KNHRetp5TQP4efE+KP/d5saYOYpHquJSRirLa3V9
	 UUGW89ydGPH1xlK+kIgoyXHqiBXS/QO8/Q5eSvso+OwHNhZJ0KyX89T6QzQX8NNMRZTFg
	 6QGOhKKjJsCYVB41HaINYo7NeuK8cFackf8Ve9I7uZnQNtChChUME7ebkzWKysGVjgObM
	 ZYupzVNmPn3BehqnoE7ZED4dUpuUmDE/yublB8SR/Y35KYRFGYxF16yCy6gnD1eM8KNMY
	 49qWSAxmkUOi7193L/lN0CPI4hK6sqRPIilHWcAxP0bov9z+UopKPFdFqYEW/sK0fNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b="AtWih/Q5";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="/1ksPkT9";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b="AtWih/Q5";
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="/1ksPkT9";
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E290B606A31B;
	Thu,  5 Nov 2026 17:00:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E290B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=AtWih/Q5;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=/1ksPkT9;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=AtWih/Q5;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=/1ksPkT9
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 32F211FB3F;
	Thu,  5 Nov 2026 17:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793898053; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wLnVsJjCToHG/C28VTmqNBcIFpk1g6vauHuX2+bvyeo=;
	b=AtWih/Q5UNeIcyR295m20gTBxLNQQlEW/6jV44r/WyqnpGBlFrxfzrmeI4eK5R/FG9mP8B
	5UwO65a5cCQ1VzYek0nbWAcmTzFXkXz50rqaQTjIh5y0Ds3XEVC9sq3K8x0IZsLdslgQ+1
	YvtRNvhR6Xxc9QjvOip6VNdLyvZvEFg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793898053;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wLnVsJjCToHG/C28VTmqNBcIFpk1g6vauHuX2+bvyeo=;
	b=/1ksPkT9jyto6rEIVfPDgN8Dim3k3Ljbfr+TqqyZUZIMXx716QVdLySR0RyEa8lGTYD3/4
	QsAvYC5IPlJGx8Aw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="AtWih/Q5";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/1ksPkT9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793898053; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wLnVsJjCToHG/C28VTmqNBcIFpk1g6vauHuX2+bvyeo=;
	b=AtWih/Q5UNeIcyR295m20gTBxLNQQlEW/6jV44r/WyqnpGBlFrxfzrmeI4eK5R/FG9mP8B
	5UwO65a5cCQ1VzYek0nbWAcmTzFXkXz50rqaQTjIh5y0Ds3XEVC9sq3K8x0IZsLdslgQ+1
	YvtRNvhR6Xxc9QjvOip6VNdLyvZvEFg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793898053;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wLnVsJjCToHG/C28VTmqNBcIFpk1g6vauHuX2+bvyeo=;
	b=/1ksPkT9jyto6rEIVfPDgN8Dim3k3Ljbfr+TqqyZUZIMXx716QVdLySR0RyEa8lGTYD3/4
	QsAvYC5IPlJGx8Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C24CE134F6;
	Thu,  5 Nov 2026 17:00:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HMEkC0K27GqWRwAAD6G6ig:T2
	(envelope-from <clopez@suse.de>); Thu, 05 Nov 2026 17:00:51 +0000
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
Subject: [PATCH v2 1/9] mm: fix eager write-bit restore for write-notified shared mappings
Date: Thu,  5 Nov 2026 17:49:58 +0100
Message-ID: <20261105165004.2663799-5-clopez@suse.de>
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -12.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 32F211FB3F

change_protection() applies vma->vm_page_prot, which lacks
the write bit for CoW and write-notified mappings. To avoid
needless write faults, callers set MM_CP_TRY_CHANGE_WRITABLE when
vma_wants_manual_pte_write_upgrade() returns true, so that entries that
can be written without a fault, such as dirty PTEs in a shared mapping,
are made writable right away.

For shared mappings, that function passes vma->vm_page_prot to
vma_wants_writenotify(). Once writenotify is enabled, this protection
lacks the write bit, while the vma_pgprot_modify() result it is compared
against adds it back. The two never match, so vma_wants_writenotify()
returns false before checking for soft-dirty, uffd-wp and writeback.

As a result, write-notified shmem mappings never get
MM_CP_TRY_CHANGE_WRITABLE, and their dirty PTEs stay read-only after a
protection change. For example, commit 931298e103c2 ("mm/userfaultfd:
rely on vma->vm_page_prot in uffd_wp_range()") made uffd-wp unprotect
set MM_CP_TRY_CHANGE_WRITABLE so that dirty shmem PTEs become writable
again, but this never takes effect. Unprotecting N dirty shmem pages
still leads to N faults that only set the write bit.

This dates back to the commit in the Fixes tag, which moved the
equivalent check in mprotect_fixup() before vma_set_page_prot().

Fix this by passing the protection recomputed from the VMA flags, as
vma_set_page_prot() does. Note that this is a performance-only fix, as
the write bit is restored on the next page fault anyway.

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

