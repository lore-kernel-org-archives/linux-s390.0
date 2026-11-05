Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793898067;
	b=Xj/dGevi52SujcwdI+YKLFakpTAy11Rr4j0QpB0khChbVw1Hi58ZAKUiJj6CE6EXUS/b
	 g0wB2VHZMKJYTGB+geMLEaGfCSmERT2dfuIX3wVHq4fddBpufYP5ZhvzYDA+dYvQiZYY0
	 rbIG5+1RWgOSslIoqfbGA3T6YezHbRMQ729UGJfz2GUoHPlkpaH9x/ev8TOknbmgYo+td
	 OJvl5d9pQ84qx8co2+Fm6QK7RYz8Y26XvzMzwAuJMLW0pxGmdEB1qTKnZzagyGf/gkwKL
	 xl28nWjYRvIQjCD54IrTUm9SilrqGVgx9cEIXX+2ncl3oCuq83SIPWpPCwO6ukG2VkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793898067;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Spam-Flag:X-Spam-Level:X-Spamd-Result:
	 X-Spam-Score;
	bh=zJ4YMgar/+f3xch1CQmR84D/AWFtiNZ8AwAhZEnWX4g=;
	b=iO7B5puWrr5xM85RZ6jFP9gN8lLFQOw9n9Q/z75KsJREAndC6pM71qTTc42tsH3hu9Yf
	 aWxMK+QnQuQTEdBvKRNHE1JZrml4FHrw2TDIH3kSxN9jR/j0uZjhxK15/QUvBT0pirSLx
	 dyki+tUswmO7pxEpNeevLujZXTzb0A5k8JH/lyB7qLYmeg5SewMEAo9wGq30uV0uk4gtu
	 ohjsEVGmgL4xl0vODRD3POU26sxb5U6FuEw5oM4u7lFe8FjHKKlgNyD/Xsaa5pnsfUjDQ
	 L4pASEuvrX9fl0G4SE6IOQaFw8Maqy6vehB/AHa0ebbYB8+GRFE1WXvlhtXTeb22cjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=o2rewCfA;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=gNOFwnmK;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=o2rewCfA;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=gNOFwnmK;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A556082BC7;
	Thu,  5 Nov 2026 17:01:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3A556082BC7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=o2rewCfA;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=gNOFwnmK;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=o2rewCfA;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=gNOFwnmK
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5FE6D22937;
	Thu,  5 Nov 2026 17:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793898065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zJ4YMgar/+f3xch1CQmR84D/AWFtiNZ8AwAhZEnWX4g=;
	b=o2rewCfAnbi1hi0MofFMdb9Ixx8NBxq97b3E5eyBcNFiBDcnEHA/FcNJrljUp4KAPbfEuN
	MO7dqjK5dOd0b+XN3ue2BGEy1uOew2ZFUM7ucie5f0BEUHakLT+5Oxhlpe9roQPHm+E6Nc
	QXqStp0DXuqg2djuEq5GdV7OvbrQtyA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793898065;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zJ4YMgar/+f3xch1CQmR84D/AWFtiNZ8AwAhZEnWX4g=;
	b=gNOFwnmKOfXqFUyiXGIpJJR+IwTNMewBrh/2d7AdIwYvDM6h85yo91Qf+wKyAI2vats1dw
	WdwdsPOSHQyQngBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793898065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zJ4YMgar/+f3xch1CQmR84D/AWFtiNZ8AwAhZEnWX4g=;
	b=o2rewCfAnbi1hi0MofFMdb9Ixx8NBxq97b3E5eyBcNFiBDcnEHA/FcNJrljUp4KAPbfEuN
	MO7dqjK5dOd0b+XN3ue2BGEy1uOew2ZFUM7ucie5f0BEUHakLT+5Oxhlpe9roQPHm+E6Nc
	QXqStp0DXuqg2djuEq5GdV7OvbrQtyA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793898065;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zJ4YMgar/+f3xch1CQmR84D/AWFtiNZ8AwAhZEnWX4g=;
	b=gNOFwnmKOfXqFUyiXGIpJJR+IwTNMewBrh/2d7AdIwYvDM6h85yo91Qf+wKyAI2vats1dw
	WdwdsPOSHQyQngBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 16CD5134F6;
	Thu,  5 Nov 2026 17:01:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HMEkC0K27GqWRwAAD6G6ig:T10
	(envelope-from <clopez@suse.de>); Thu, 05 Nov 2026 17:01:04 +0000
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
	Steffen Eiden <seiden@linux.ibm.com>,
	Andreas Grapentin <gra@linux.ibm.com>,
	Marc Zyngier <maz@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH v2 9/9] KVM: s390: don't unmap the gmap on permission upgrade
Date: Thu,  5 Nov 2026 17:50:06 +0100
Message-ID: <20261105165004.2663799-13-clopez@suse.de>
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
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLmtzipbxtgehzutu1qae44kxg)];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -12.30

When an mmu_notifier invalidation only upgrades permissions
(MMU_NOTIFIER_RANGE_PERM_UPGRADE), keep the existing gmap entries
instead of unmapping them. The PFN is unchanged and no access is
revoked, so an existing entry is no more permissive than the new host
PTE.

A write to an entry that is still read-only causes a protection
exception, which kvm_s390_faultin_gfn() handles as a write fault,
picking up the new permissions. This applies to both s390 and arm64
guests.

Signed-off-by: Carlos López <clopez@suse.de>
---
 arch/s390/kvm/arm64/arm.c | 7 +++++++
 arch/s390/kvm/s390/s390.c | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/s390/kvm/arm64/arm.c b/arch/s390/kvm/arm64/arm.c
index bd9d85235f43..5aee1817aad8 100644
--- a/arch/s390/kvm/arm64/arm.c
+++ b/arch/s390/kvm/arm64/arm.c
@@ -678,6 +678,13 @@ void kvm_arch_commit_memory_region(struct kvm *kvm, struct kvm_memory_slot *old,
 
 bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
 {
+	/*
+	 * Do not bother unmapping if this is only a protection upgrade.
+	 * Permissions will be faulted-in on demand.
+	 */
+	if (range->flags & MMU_NOTIFIER_RANGE_PERM_UPGRADE)
+		return false;
+
 	return gmap_unmap_gfn_range(kvm->arch.gmap, range->slot, range->start, range->end);
 }
 
diff --git a/arch/s390/kvm/s390/s390.c b/arch/s390/kvm/s390/s390.c
index 18fb200f854a..954bf6b64683 100644
--- a/arch/s390/kvm/s390/s390.c
+++ b/arch/s390/kvm/s390/s390.c
@@ -5871,6 +5871,13 @@ bool kvm_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
  */
 bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
 {
+	/*
+	 * Do not bother unmapping if this is only a protection upgrade.
+	 * Permissions will be faulted-in on demand.
+	 */
+	if (range->flags & MMU_NOTIFIER_RANGE_PERM_UPGRADE)
+		return false;
+
 	return gmap_unmap_gfn_range(kvm->arch.gmap, range->slot, range->start, range->end);
 }
 
-- 
2.51.0

