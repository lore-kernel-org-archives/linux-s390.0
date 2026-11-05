Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793898064;
	b=AhHHZBK+j5kq7nHHP3LqoQQNP4SdM0lil2erAcluCAaUd7xX8HJCNIrVbGpbR4qrgkrf
	 0RYhtdWzjU92ut4uiLFjP5tsEEOetS0qoZBT+7wdoxCsAiPL/PPp4jdbym7DhjGO0B8Fs
	 mOsdsgS0Cia9Om78ly5PdYBXwMaw7Vr9OM0xOytOAF0IWwAxqVf0/OE1vBHxurfvraqRI
	 jcINzMwXE1Nh/5hYI19yJtQBAc+R8zh/KoxnLdc7wFn+G5+62f2C3DsLgygCMyZyGBlDW
	 JNKLL/Ya7piAavS3dF07+BAUoJ5dH/QFuWnGVC8vS401h00G35xtl/csbmPE/dIfv9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793898064;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Spam-Flag:X-Spam-Level:X-Spamd-Result:
	 X-Spam-Score;
	bh=xEZ9JJfmqsHwOWZ8ElxjeuHq5z5hpn3BAo1KSIMWKNg=;
	b=okQL48BRYnQKcYhnYDYpzzGckKDg0Ya3TcMGOlGijwUWbVQp/HvK8dK+0nx2t0MDPnGC
	 pFVMypWKO53oZX2qOPYZJk7E9IfPBuboA+Dry80phvTFmpkc8vFF9COuxbOBEwrsaBQhV
	 aWISQ6p7wCNm41vsOMjMOlgFIsRbTSZucRXO36UM2dtSQlilRXSh9zNFhoa2TXS1i/PCn
	 VFtL42phfGEWON+2FOjtPD0em+uP9E58VZoBKFzFnDkGhE3l8CsujiD6dM8zoLGIilW25
	 GGz6JHTgw8LRKAHV7ycCFWqTLdT1LovUrYd3pydx0lAIm/2gXi96874fUYpT9H41PPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=q7V7OJU5;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=HQIptzs2;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=q7V7OJU5;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=HQIptzs2;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F6B606D833;
	Thu,  5 Nov 2026 17:01:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9F6B606D833
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=q7V7OJU5;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=HQIptzs2;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=q7V7OJU5;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=HQIptzs2
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7AE0C1FFF4;
	Thu,  5 Nov 2026 17:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793898062; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xEZ9JJfmqsHwOWZ8ElxjeuHq5z5hpn3BAo1KSIMWKNg=;
	b=q7V7OJU5V3kHEmtMC+LW7OPlBP2+X1BkkbG18zyn3y4BGYvK/fgcCEK1aPjhjRnJP2Bqy8
	J+COa3CANIoqRNfmnlqPmBE19vl4XySEEdxN0tI4dTFBIUJYs11QtrVG8F6Hd9R3zqpGzb
	fvEz/nka4/mM+a5fXaLH9lgK+wVXm3w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793898062;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xEZ9JJfmqsHwOWZ8ElxjeuHq5z5hpn3BAo1KSIMWKNg=;
	b=HQIptzs2YWEwUY035nAUQ/KX3dN/98aVd1ncESN86TGDKhwlZOcEvouUYVi5ZD6VFx4oD6
	ANOmGc1e9j6Kn9DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793898062; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xEZ9JJfmqsHwOWZ8ElxjeuHq5z5hpn3BAo1KSIMWKNg=;
	b=q7V7OJU5V3kHEmtMC+LW7OPlBP2+X1BkkbG18zyn3y4BGYvK/fgcCEK1aPjhjRnJP2Bqy8
	J+COa3CANIoqRNfmnlqPmBE19vl4XySEEdxN0tI4dTFBIUJYs11QtrVG8F6Hd9R3zqpGzb
	fvEz/nka4/mM+a5fXaLH9lgK+wVXm3w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793898062;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xEZ9JJfmqsHwOWZ8ElxjeuHq5z5hpn3BAo1KSIMWKNg=;
	b=HQIptzs2YWEwUY035nAUQ/KX3dN/98aVd1ncESN86TGDKhwlZOcEvouUYVi5ZD6VFx4oD6
	ANOmGc1e9j6Kn9DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 825F2133F6;
	Thu,  5 Nov 2026 17:01:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HMEkC0K27GqWRwAAD6G6ig:T8
	(envelope-from <clopez@suse.de>); Thu, 05 Nov 2026 17:01:01 +0000
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
Subject: [PATCH v2 7/9] KVM: pass the mmu_notifier event and flags to kvm_gfn_range
Date: Thu,  5 Nov 2026 17:50:04 +0100
Message-ID: <20261105165004.2663799-11-clopez@suse.de>
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -12.30

Propagate the event and flags of the mmu_notifier invalidation into
struct kvm_gfn_range, so that architecture handlers can tell what kind
of change they are handling, such as a permission upgrade
(MMU_NOTIFIER_RANGE_PERM_UPGRADE). They are not consumed yet, so no
functional change.

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

