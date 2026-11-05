Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793898067;
	b=MuTP6MP2v5KAkARzaE5SGDJsOQisK5ePIx2CA0gWIZeUAvUmYQVuJz7y/96b0vj7j2vI
	 E5d9PClD/Qcztbd4VM6uaYLN4LHviX/vv3uESgWNRM0LSDVmvQVXmJNPbL1oSvpLVaQmm
	 MZpDqdRCXQVJPINw6OYp9MJjV+zzPhWsMeSqXPZfNEAXneYtOpWmObzQqKggoLX0mBx1e
	 vcki166tUJLD8mKyKjghQWBr4O9mT4ORmPknfIRcueR8laPjPV8mPWc5nrhBLmW3QUBW2
	 K9NyTWtbn8igA89a+WemajI+gr7GK55MeIWKtnzZ9ZYdmnluaji4wcAtolwgJ5SEwNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793898067;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Spamd-Result:X-Rspamd-Server:
	 X-Rspamd-Action:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Rspamd-Queue-Id;
	bh=0sIowcuQ5IyfilZxYg4IseA453ZPtAePPTKkUBTmPjo=;
	b=yBJ/vR188FA9USbZLZ3zQSseQG0IMlTRU0Nuo5dhhNqjtZm92SYYgj1dTczAYUCH24/D
	 zQLXVYo67gIxC2SWWQlGuPqvzXf7+XkZjROv9WhdGLbDwnRw5F6SyCbaO3oTHK5vmVzzb
	 ufqVaLwpnSBaEBr6Hdtkl0v4xBnQT7JWcFK9nkWshBgDDk3EUeFwzsW0KQOzR3FXWL0a2
	 dwu4BUWjbd83KzKWfvnI+K1vMYcaAlsUScb2tXfxtkODtiURbdwwYzya/kI4EFxxVgfG7
	 l/Dyj8yjpiQVkxZa8yhZEEsSxyW9y90AIjFgS5DO2E6DpjpMGcHRgQtEwpBFzguLS4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Pei1+gTR;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=VbIGDJjm;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=eGgBk4uw;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=lv4BOyjX;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806D76082BC2;
	Thu,  5 Nov 2026 17:01:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 806D76082BC2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Pei1+gTR;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=VbIGDJjm;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=eGgBk4uw;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=lv4BOyjX
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E2B3E1FCFB;
	Thu,  5 Nov 2026 17:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793898065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0sIowcuQ5IyfilZxYg4IseA453ZPtAePPTKkUBTmPjo=;
	b=Pei1+gTR/J1zBT1gB2ZeIJQxUCowvgas0b47E0oxSiRyXbqfWcWT9CdLgVofqWdP18Qg1v
	Ma8pSr6pCXEUEOa0V2V7ffs5/4vXBJVhoGTnqrnRVNYJiIbjX4ekZxUb3RcUoicU6NFpCa
	9Dzmz5lgpmD102+OnFKvh/48r+57WtM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793898065;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0sIowcuQ5IyfilZxYg4IseA453ZPtAePPTKkUBTmPjo=;
	b=VbIGDJjmTZVhO0JTDSy7XYPe54eMhLayiPZvsUM2mYuCPJZ4FLgK5H77l+InWBrOhXV5GV
	hIZsQZNN4vhg0qBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=eGgBk4uw;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=lv4BOyjX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793898063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0sIowcuQ5IyfilZxYg4IseA453ZPtAePPTKkUBTmPjo=;
	b=eGgBk4uwtc8odIcPkfJnvOhwvShX1Dzp80/Y9+pOvhwx2yg6xph2VIq2YxIEJqjm3b0zp+
	2ES30McqhT6ATAMyAkgShopGIv8d34lgBrlGUnLFvO0HDMHEpHDwCbbcwu22ILKAE+UIC9
	RBUzcteQ4gT3NeSyIoKLjzjert/tTQU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793898063;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0sIowcuQ5IyfilZxYg4IseA453ZPtAePPTKkUBTmPjo=;
	b=lv4BOyjX8HinF0YoiV2Xm9Cn46XE9J0/uhYRUvlZz2sLnoHhypKXYcPDivccnQoxvlqcHG
	XlE+f2wiywA7r9AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9C9B8133F6;
	Thu,  5 Nov 2026 17:01:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HMEkC0K27GqWRwAAD6G6ig:T9
	(envelope-from <clopez@suse.de>); Thu, 05 Nov 2026 17:01:02 +0000
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
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2 8/9] KVM: x86/mmu: don't zap secondary MMU on permission upgrade
Date: Thu,  5 Nov 2026 17:50:05 +0100
Message-ID: <20261105165004.2663799-12-clopez@suse.de>
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
	RCPT_COUNT_TWELVE(0.00)[19];
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
X-Rspamd-Queue-Id: E2B3E1FCFB

When an mmu_notifier invalidation only upgrades permissions
(MMU_NOTIFIER_RANGE_PERM_UPGRADE), keep the existing SPTEs instead of
zapping them. The PFN is unchanged and no access is revoked, so an
existing SPTE is no more permissive than the new host PTE. Permissions
for the SPTE are updated on the next fault, so dropping them early
gains nothing.

The motivating case is a userfaultfd-wp dirty tracker such as QEMU's
background snapshot, which unprotects every guest page as it saves it.
Zapping on each unprotect makes the guest refault its whole working
set. On a 64GB guest under a background snapshot, a read-mostly workload
drops secondary-MMU refaults from ~1M/s to ~2.5K/s and cross-vCPU TLB
shootdowns from ~1400/s to near zero. Uses of mprotect() that only add
access benefit likewise.

Note that this also skips the APIC-access page reload, which is not
needed as the page's PFN is unchanged. KVM does not retry a failed
reload, but that issue is pre-existing and unrelated to this change.

Signed-off-by: Carlos López <clopez@suse.de>
---
 arch/x86/kvm/mmu/mmu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index f89e9f8a6cc2..3c92379bdbe0 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1719,6 +1719,13 @@ bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
 	lockdep_assert_once(kvm->mmu_invalidate_in_progress ||
 			    lockdep_is_held(&kvm->slots_lock));
 
+	/*
+	 * Do not bother zapping SPTEs if this is only a protection upgrade.
+	 * Permissions will be faulted-in on demand.
+	 */
+	if (range->flags & MMU_NOTIFIER_RANGE_PERM_UPGRADE)
+		return false;
+
 	if (kvm_memslots_have_rmaps(kvm))
 		flush = __kvm_rmap_zap_gfn_range(kvm, range->slot,
 						 range->start, range->end,
-- 
2.51.0

