Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793285084;
	b=g5ckdz0fucJ3W85pWCd2yTfGL0llJZ53BLz9e9qrRasi+63pEEWx2L0GgxbIg+E8+UIT
	 zYBTAQXiY7gVj+FbU0XnuJXj3xKPSkyvndBP5rkEWMYnyCC5CN4OJuC4a6VDZ8qA8o2Mr
	 2eCacjLSaCJxfhSAiax+23Yd7WhojWkJ2521WwvIyf1Tf2PQwYE/upN1w09+MR+7Jr0KC
	 x5nEWQE9XuM3BJIykW8tvHZnRMM3YCwwwhgTKJGjGXqQJn2QP6r2nfnrKiQvVwfZz1Cuq
	 RB517Tn0jNy1h2zPoJm+SL5f8QsojmbwDFF6TfRknqjaKLr1peiyOoVSFddKBqiuqIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793285084;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Spamd-Result:X-Spam-Score:X-Spam-Level:
	 X-Spam-Flag;
	bh=GzhVoZib0ILEyLkVLyiQGLJMK7BbWA6VG7i+o0PVJto=;
	b=y5vV5khSerIkaVRO3M2r0tv00TIE5RNZEO/qFxWjoF+UhAGvyJcuVuKnbcXyKrVndzzv
	 bPgX4SDPGGZd5j32I757AW1vWS18jj0RNWwCqBVqHHqBx9Ls01HcdE02DMgrVYkUR3wSG
	 b/Kp+/s9us0h1tstADY0lRnTX8dsc2EV7IKKmazO47TsQNLQaULcmPb5FOdfbRUVmFUeU
	 yyKyJHgaCxmL7b9DssAS7PyoIibboi7GXA57Pa4MLfFXaPFJ0xXeD7fL3KcE1l/hglXik
	 UfHJhe03ep50oHij/wPYR/DGdn3/lgaaLVjpRQQTGKhZalFGe0MZm4T4+ee2rfx8WTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=FBQ+msAQ;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=50oxv05B;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=FBQ+msAQ;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=50oxv05B;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3638606A31D;
	Thu, 29 Oct 2026 14:44:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3638606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=FBQ+msAQ;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=50oxv05B;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=FBQ+msAQ;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=50oxv05B
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5F0B31F7BB;
	Thu, 29 Oct 2026 14:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793285082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GzhVoZib0ILEyLkVLyiQGLJMK7BbWA6VG7i+o0PVJto=;
	b=FBQ+msAQwGPWfOlG0Y23qoGPR/RfctRnamOh6HCzvxwFFZb1Glq3JIJwRCbAHG+/X0uk+0
	+VIQMKrj6DSHbPMQoRWEwmA51tp4kVsW9K912w4YRyzc7TfkhQMTI5xXWrFUM5p5U52q5z
	4fzEcMGN/URISqGi3wB/qv5M8/VVuNI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793285082;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GzhVoZib0ILEyLkVLyiQGLJMK7BbWA6VG7i+o0PVJto=;
	b=50oxv05BuMTzzjIcFlmKyLDLyP3l+Q19Uy6YoGw6837vhZ3SjvorOodAG0d0zkgbk9gOxM
	TW1UiXiKnOu4ACAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793285082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GzhVoZib0ILEyLkVLyiQGLJMK7BbWA6VG7i+o0PVJto=;
	b=FBQ+msAQwGPWfOlG0Y23qoGPR/RfctRnamOh6HCzvxwFFZb1Glq3JIJwRCbAHG+/X0uk+0
	+VIQMKrj6DSHbPMQoRWEwmA51tp4kVsW9K912w4YRyzc7TfkhQMTI5xXWrFUM5p5U52q5z
	4fzEcMGN/URISqGi3wB/qv5M8/VVuNI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793285082;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GzhVoZib0ILEyLkVLyiQGLJMK7BbWA6VG7i+o0PVJto=;
	b=50oxv05BuMTzzjIcFlmKyLDLyP3l+Q19Uy6YoGw6837vhZ3SjvorOodAG0d0zkgbk9gOxM
	TW1UiXiKnOu4ACAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3BD531342D;
	Thu, 29 Oct 2026 14:44:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iNqFENhb42qRUwAAD6G6ig:T2
	(envelope-from <clopez@suse.de>); Thu, 29 Oct 2026 14:44:41 +0000
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
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC PATCH 1/4] mm/mprotect: add MM_CP_PERM_UPGRADE
Date: Thu, 29 Oct 2026 15:33:34 +0100
Message-ID: <20261029143336.390231-4-clopez@suse.de>
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
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -16.30
X-Spam-Level: 
X-Spam-Flag: NO

Add a change_protection() flag for changes that only add permissions:
the PFN stays the same and no access is revoked. mprotect() sets it when
the new VMA permissions are a superset of the old, and the protection
key is unchanged.

This will allow MMU notifier users to perform optimizations, as they
can avoid invalidating PTEs whose permissions can be faulted in.

Signed-off-by: Carlos López <clopez@suse.de>
---
 include/linux/mm.h |  2 ++
 mm/mprotect.c      | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 691cef038d1e..f406ce9d1032 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3415,6 +3415,8 @@ int get_cmdline(struct task_struct *task, char *buffer, int buflen);
 #define  MM_CP_UFFD_RWP_RESOLVE            (1UL << 5) /* resolve rwp */
 #define  MM_CP_UFFD_RWP_ALL                (MM_CP_UFFD_RWP | \
 					    MM_CP_UFFD_RWP_RESOLVE)
+/* Whether this change only upgrades/adds permissions */
+#define  MM_CP_PERM_UPGRADE                (1UL << 6)
 
 bool can_change_pte_writable(struct vm_area_struct *vma, unsigned long addr,
 			     pte_t pte);
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 2888ee638d87..e9b636809c42 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -756,6 +756,17 @@ static const struct mm_walk_ops prot_none_walk_ops = {
 	.walk_lock		= PGWALK_WRLOCK,
 };
 
+static bool vma_flags_is_perm_upgrade(vma_flags_t old_vma_flags,
+				       vma_flags_t new_vma_flags)
+{
+	vm_flags_t old = vma_flags_to_legacy(old_vma_flags);
+	vm_flags_t new = vma_flags_to_legacy(new_vma_flags);
+	vm_flags_t rwx = VM_READ | VM_WRITE | VM_EXEC;
+
+	return !(old & rwx & ~new) &&
+	       (old & ARCH_VM_PKEY_FLAGS) == (new & ARCH_VM_PKEY_FLAGS);
+}
+
 int
 mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
 	       struct vm_area_struct *vma, struct vm_area_struct **pprev,
@@ -837,6 +848,8 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
 	vma_flags_reset_once(vma, &new_vma_flags);
 	if (vma_wants_manual_pte_write_upgrade(vma))
 		mm_cp_flags |= MM_CP_TRY_CHANGE_WRITABLE;
+	if (vma_flags_is_perm_upgrade(old_vma_flags, new_vma_flags))
+		mm_cp_flags |= MM_CP_PERM_UPGRADE;
 	vma_set_page_prot(vma);
 
 	change_protection(tlb, vma, start, end, mm_cp_flags);
-- 
2.51.0

