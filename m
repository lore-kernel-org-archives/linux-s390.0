Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793898063;
	b=3Zjc+hkCJ+3gzaSG/SIpazLyW7tBjG9cL9c0aNQqb1MpttshDr9AXAybAEHoD8FhKYx9
	 K+V9oTbyO9rTSxFUUIV7Qux66G9/ruBq8Yav632E4VI2jyZH9FLIkbhHNH00Mm44JjNEp
	 /mvtmd+ZhCIAzzmy0Wcqi9ohir8OTej4vkKTFVKJDf40Cgbnx6FI+vukd38fbs4I0R2iJ
	 28SZ9gp9miFDbke4xdwFarRD8h7K+3G5kG5g0ZWwj0Fg33bQJvTiKVKaCxFo36Xu7ycC6
	 Qc3dg0M6iO4WPeDvr3wFeMB4GWwrf/b6Bck+iWrJbPNadLOMIBJx1kACWSVTXXS2sBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793898063;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Spam-Flag:X-Spam-Level:X-Spamd-Result:
	 X-Spam-Score;
	bh=yTLCeN5jovvTBrG00oVZHmkRkUI0TUXDkV2kppClmaI=;
	b=fLeBFr0/RmM17EBVe6ptyvOnA9gj6Cjue1YWRmmeKJrONp4rERMFnhMRQY5Y0ff1Hpjf
	 ZscOCnq+9O/6tEwdcsP9HWj+FIzt4FzmSZoD2YVcb4et+MYswkEHp8q6cqcJOoz4AGAmV
	 KYMOSm6AsLwwzQ5zRhkvUM8HGRG4CWcxl9G42Uy5yDfT3I+SojXAZHD7ljm3Oh/dmhCmW
	 k62UkJZhdiFm5x205KvGUjdKgI8TiYv7X0ykwdwKRFRyUTwTAnPq3jnAnlON/54IjIXbo
	 o1kX9r+E9oMswVY/GidGHRRgc+GnCodBmr3cY0MJLGAl5UHp6/FubBnFk7NSyB3x+wA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=qDQSqMce;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="oc1v99b/";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=qDQSqMce;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="oc1v99b/";
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0426606D81A;
	Thu,  5 Nov 2026 17:01:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0426606D81A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=qDQSqMce;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=oc1v99b/;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=qDQSqMce;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=oc1v99b/
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4C63C202C6;
	Thu,  5 Nov 2026 17:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793898061; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yTLCeN5jovvTBrG00oVZHmkRkUI0TUXDkV2kppClmaI=;
	b=qDQSqMcecgH0WXSk2Y240aQ1q68bCPZg+2Qse3YSTomNRPbmJ43/iO8LLK65XIw2Yuie8a
	aenffLtwlLO7coIupW7h0qzIUhGSlqfr9FXRoLGzyez21rEI7jLGfNEFGZsLegaQSo8jJA
	9VrV5WCcb0LrE1YWl6IUGwMUTZL2Gns=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793898061;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yTLCeN5jovvTBrG00oVZHmkRkUI0TUXDkV2kppClmaI=;
	b=oc1v99b/QcPAkScAs/xHlP0u67nIQGuCXV0P05kIB1+DDvNcWAVKTaS5tSV8uxTcV73Cw+
	KPwlc+NFP/MpB5BQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793898061; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yTLCeN5jovvTBrG00oVZHmkRkUI0TUXDkV2kppClmaI=;
	b=qDQSqMcecgH0WXSk2Y240aQ1q68bCPZg+2Qse3YSTomNRPbmJ43/iO8LLK65XIw2Yuie8a
	aenffLtwlLO7coIupW7h0qzIUhGSlqfr9FXRoLGzyez21rEI7jLGfNEFGZsLegaQSo8jJA
	9VrV5WCcb0LrE1YWl6IUGwMUTZL2Gns=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793898061;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yTLCeN5jovvTBrG00oVZHmkRkUI0TUXDkV2kppClmaI=;
	b=oc1v99b/QcPAkScAs/xHlP0u67nIQGuCXV0P05kIB1+DDvNcWAVKTaS5tSV8uxTcV73Cw+
	KPwlc+NFP/MpB5BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E4417133F6;
	Thu,  5 Nov 2026 17:00:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HMEkC0K27GqWRwAAD6G6ig:T7
	(envelope-from <clopez@suse.de>); Thu, 05 Nov 2026 17:00:59 +0000
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
Subject: [PATCH v2 6/9] mm/mmu_notifier: add MMU_NOTIFIER_RANGE_PERM_UPGRADE
Date: Thu,  5 Nov 2026 17:50:03 +0100
Message-ID: <20261105165004.2663799-10-clopez@suse.de>
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
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-12.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL5uaz9zq77jxr8j8m8i6w3kff)];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -12.30

Add a range flag marking an invalidation that only upgrades permissions,
with no PFN change and no revoked access. change_protection() sets it
for MM_CP_PERM_UPGRADE and for the userfaultfd resolves, which unprotect
a page and thus only restore access.

Now that change_protection() keeps writable entries writable on these
changes, no present entry loses access. Writable migration and
device-private entries are still made read-only, which does not affect
secondary MMUs. Migration entries are only installed after secondary
MMUs are invalidated, and device-private pages are migrated back, with
an invalidation, before the CPU can access them.

hugetlb_change_protection() never sets the flag, as hugetlb does not
restore the write bit and may unshare page tables.

A secondary MMU can use the flag to keep its mappings rather than zap
them. Consumers that ignore it are unaffected.

Signed-off-by: Carlos López <clopez@suse.de>
---
 include/linux/mmu_notifier.h | 5 +++++
 mm/hugetlb.c                 | 4 ++++
 mm/mprotect.c                | 5 +++--
 3 files changed, 12 insertions(+), 2 deletions(-)

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
index da5d04edf7c1..1a69d1da527e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6606,6 +6606,10 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
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
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 16b8aef755ab..fb2023dc6e66 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -601,8 +601,9 @@ static inline long change_pud_range(struct mmu_gather *tlb,
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

