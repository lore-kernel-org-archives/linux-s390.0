Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794493542;
	b=JtcSswPB0hO4kgte7RfHcrhIqBf3ZDpADRV7am65Cm65bag/9f88P02ZAKC0LWfJd9RY
	 ZQ839c0SUcg/ki30Fvcl9I2Ala0C9iTfHQemmA5R1JCHx/tJcb81ZisXyEcGJtRwZlU7M
	 7m4NovytwbL9kXDJ4BrYMY1H50119odLciQTZ7kGTo0icOjcNI3OkG1OHy7SGLLKWQpt7
	 MpCcgzzhghiIsOLtHTu0WaEoun4vc+rcxM6QOf87CAUkT3rFxe5df2YIuvgFCp/84G027
	 BUtWEnaJasR6nA30xfP4WJVyNIgKQ+sjEZNC6aA0PkWzVI+fk+ycTvVFvqiU2lhAI5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493542;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Spam-Flag:X-Spam-Level:X-Spamd-Result:
	 X-Spam-Score;
	bh=egAgTK39zABd/gJChkYURwZvQvarzAr/B6j4tF3tOn8=;
	b=Jf8tEKTQUv1Gp1OGet1SKjQ+Ldxw6yzVPcCfVna8dbztRSPAUmkJzmZHShJcVETi3ilI
	 4H9KTOsbbS0zjK+YLENcYlKa8Gyd5qGfmzirpDLx9+FXZBNTLUEk9qyJckmFOjq0CHrpL
	 GAPsckffwC6FD5QlkF2U4d8j1PsJKU6YA9H54TX9JhJPnkI+dJ4D5Wfxoc14sh49JXo4+
	 uApBpbZmJZemJsbCKK7FbZ6Y8U+Ex9f+ORAb9AsD2093Bz66hYSa8ULC1DqHDFQEjcTRZ
	 DAQJUQKN2vgkUyuatFTa4YSRT+55HRy1DkAM1xz4sbYu82We/PYVKVD3i8Zz/fXNpsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b="k/xP1Kb4";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="/hUSehq+";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b="k/xP1Kb4";
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="/hUSehq+";
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C0F606B0A1;
	Thu, 12 Nov 2026 14:25:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53C0F606B0A1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=k/xP1Kb4;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=/hUSehq+;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=k/xP1Kb4;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=/hUSehq+
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CB18F1F7A5;
	Thu, 12 Nov 2026 14:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794493540; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=egAgTK39zABd/gJChkYURwZvQvarzAr/B6j4tF3tOn8=;
	b=k/xP1Kb4Y0Ig/EixInInOwWOvMgi0T6ABSaEYlalEBYLYUCF5f8zAbGs/mdAEUZbRmN4PR
	ifNh+GYizIzxkHuN2WWC8ffk5lrSWwQ2YJI/LS1FunKlwt27uDNH0fsezbS/UdKRFgiFNv
	QuoLwnyFNFbS9hRk1P8xFoO4z2HfJys=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794493540;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=egAgTK39zABd/gJChkYURwZvQvarzAr/B6j4tF3tOn8=;
	b=/hUSehq+rUZXwcxCjhPMecIMFavt7F/FpLJSnEGR+nK44h8S9YvRwsG1kO0xIZ9OsEHR+Z
	l1CKWMuJt5U+mECA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794493540; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=egAgTK39zABd/gJChkYURwZvQvarzAr/B6j4tF3tOn8=;
	b=k/xP1Kb4Y0Ig/EixInInOwWOvMgi0T6ABSaEYlalEBYLYUCF5f8zAbGs/mdAEUZbRmN4PR
	ifNh+GYizIzxkHuN2WWC8ffk5lrSWwQ2YJI/LS1FunKlwt27uDNH0fsezbS/UdKRFgiFNv
	QuoLwnyFNFbS9hRk1P8xFoO4z2HfJys=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794493540;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=egAgTK39zABd/gJChkYURwZvQvarzAr/B6j4tF3tOn8=;
	b=/hUSehq+rUZXwcxCjhPMecIMFavt7F/FpLJSnEGR+nK44h8S9YvRwsG1kO0xIZ9OsEHR+Z
	l1CKWMuJt5U+mECA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E0FA113432;
	Thu, 12 Nov 2026 14:25:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id w9GzDFnM9WoAPwAAD6G6ig:T8
	(envelope-from <clopez@suse.de>); Thu, 12 Nov 2026 14:25:39 +0000
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
	=?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>
Subject: [PATCH v3 7/9] KVM: pass the mmu_notifier event and flags to kvm_gfn_range
Date: Thu, 12 Nov 2026 15:20:36 +0100
Message-ID: <20261112142039.907090-9-clopez@suse.de>
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
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-16.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -16.30

Propagate the event and flags of the mmu_notifier invalidation into
struct kvm_gfn_range, so that architecture handlers can detect a
permission upgrade (MMU_NOTIFIER_RANGE_PERM_UPGRADE). No functional
change.

Signed-off-by: Carlos López <clopez@suse.de>
---
 include/linux/kvm_host.h | 3 +++
 virt/kvm/kvm_main.c      | 8 ++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index e7fc94e2910a..1f5ce4410ddb 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -274,6 +274,9 @@ struct kvm_gfn_range {
 	enum kvm_gfn_range_filter attr_filter;
 	bool may_block;
 	bool lockless;
+	/* From the mmu_notifier invalidation, if any. */
+	enum mmu_notifier_event event;
+	unsigned int flags;
 };
 bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range);
 bool kvm_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index cf4cb586f140..c517d1deb488 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -532,6 +532,8 @@ struct kvm_mmu_notifier_range {
 	bool flush_on_ret;
 	bool may_block;
 	bool lockless;
+	enum mmu_notifier_event event;
+	unsigned int flags;
 };
 
 /*
@@ -613,6 +615,8 @@ static __always_inline kvm_mn_ret_t kvm_handle_hva_range(struct kvm *kvm,
 			 */
 			gfn_range.arg = range->arg;
 			gfn_range.may_block = range->may_block;
+			gfn_range.event = range->event;
+			gfn_range.flags = range->flags;
 			/*
 			 * HVA-based notifications aren't relevant to private
 			 * mappings as they don't have a userspace mapping.
@@ -738,6 +742,8 @@ static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
 		.on_lock	= kvm_mmu_invalidate_start,
 		.flush_on_ret	= true,
 		.may_block	= mmu_notifier_range_blockable(range),
+		.event		= range->event,
+		.flags		= range->flags,
 	};
 
 	trace_kvm_unmap_hva_range(range->start, range->end);
@@ -2552,6 +2558,8 @@ static __always_inline void kvm_handle_gfn_range(struct kvm *kvm,
 
 	gfn_range.arg = range->arg;
 	gfn_range.may_block = range->may_block;
+	gfn_range.event = range->event;
+	gfn_range.flags = range->flags;
 
 	/*
 	 * If/when KVM supports more attributes beyond private .vs shared, this
-- 
2.51.0

