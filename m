Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794493544;
	b=lmDaWvzPDLt+hgxAK9hTTKX9xv4DZz1BMlY+4PEjzRiB4apLOPiURzOfmlz8ylG+ElLk
	 006tipSgM9hcowmXEKeiABjYDmffcbP5eG3Thi/adTGFaNQxCwrjlHr5jW/zDO40b50BT
	 QUw+fLAfvrb/1L722ZELp3iPJNnN1re/pcXOAoT311CGig0ybJXHKJzSIEAXCiECiY3Z2
	 iRFKGp2XuGem5D+wL38roxONIZgihRmV1LcFA+lkaZN0/t0ZMwNTbIHL/f4TxyEGsGz/W
	 0StLf7q/X7Kzv7mpshYMY/l3uXtdK/baUG0cusqfoS3Kp8wQ/4qVtPSj3SLBpTKKUvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493544;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Spamd-Result:X-Spam-Score:X-Spam-Level:
	 X-Spam-Flag;
	bh=pds7Uqtuvy1DGjOeeoA+Vkfk5LWosIAipoHj1WXULeE=;
	b=nhMODCH+nbNRGVU2g02TOFteI8h2QJKTlCD0sLoshk5Em2TfgoRc1rsbO2rkAGfE3hAV
	 KAIqwLVEtnLYtz11E1nUxtdpNi2AVJD3geap4pB84Dq8ljuLLxjRKt56u4AVK1taapjQf
	 jdD025t6wL23L0hElzR44H+ABvEIaFgbgUrQVXLDGdptLJfwbIzCBBX9zibFFNYhPUe1Y
	 m73eG7Jx/68zEAoLXlPpkSvE8dq7Jcgo0KQEkMIt1dyJGl2zxkJ06uD9tARmR8V+uy0Ku
	 /WWiGhBmkFnpRN9PaNpZh68EtRo4UGDr6xCRRdl2QsygmAAtjrtAwLiuexWdx9MGO4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=NoYzXDWf;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="27/HHTUY";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=NoYzXDWf;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="27/HHTUY";
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D1260A3822;
	Thu, 12 Nov 2026 14:25:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9D1260A3822
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=NoYzXDWf;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=27/HHTUY;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=NoYzXDWf;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=27/HHTUY
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3588B1F7AB;
	Thu, 12 Nov 2026 14:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794493542; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pds7Uqtuvy1DGjOeeoA+Vkfk5LWosIAipoHj1WXULeE=;
	b=NoYzXDWfAOmI8zdX5+chynT7UmwhBQTnmoRwZoMJ/VGhFM0PKtfGA/JYP/bSAIOADu9kGQ
	9gOBQ7k7ZTXpUlGUFGpEfaj3G9VTwdpmvysWY4H7QdBJ6dxmg4p0Id7AeGXlHPNsGl9x5k
	nn5xl4sAlY5CnQHYIWz4RkNYFCqp2cU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794493542;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pds7Uqtuvy1DGjOeeoA+Vkfk5LWosIAipoHj1WXULeE=;
	b=27/HHTUYBi6MOz2Dw2T7fjj9pDuC9sG1BBJdzOY94YAfUiu/eHvOCNpuZOT9gxMVmfVKLl
	tBbKllXxrTJz+JCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794493542; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pds7Uqtuvy1DGjOeeoA+Vkfk5LWosIAipoHj1WXULeE=;
	b=NoYzXDWfAOmI8zdX5+chynT7UmwhBQTnmoRwZoMJ/VGhFM0PKtfGA/JYP/bSAIOADu9kGQ
	9gOBQ7k7ZTXpUlGUFGpEfaj3G9VTwdpmvysWY4H7QdBJ6dxmg4p0Id7AeGXlHPNsGl9x5k
	nn5xl4sAlY5CnQHYIWz4RkNYFCqp2cU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794493542;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pds7Uqtuvy1DGjOeeoA+Vkfk5LWosIAipoHj1WXULeE=;
	b=27/HHTUYBi6MOz2Dw2T7fjj9pDuC9sG1BBJdzOY94YAfUiu/eHvOCNpuZOT9gxMVmfVKLl
	tBbKllXxrTJz+JCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EF33813432;
	Thu, 12 Nov 2026 14:25:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id w9GzDFnM9WoAPwAAD6G6ig:T9
	(envelope-from <clopez@suse.de>); Thu, 12 Nov 2026 14:25:40 +0000
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
Subject: [PATCH v3 8/9] KVM: x86/mmu: don't zap secondary MMU on permission upgrade
Date: Thu, 12 Nov 2026 15:20:37 +0100
Message-ID: <20261112142039.907090-10-clopez@suse.de>
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
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -16.30
X-Spam-Level: 
X-Spam-Flag: NO

When an mmu_notifier invalidation only upgrades permissions
(MMU_NOTIFIER_RANGE_PERM_UPGRADE), keep the existing SPTEs instead of
zapping them. The PFN is unchanged and no access is revoked, so an
existing SPTE is no more permissive than the new host PTE, and the new
permissions are picked up on the next fault.

The motivating case is a userfaultfd-wp dirty tracker such as QEMU's
background snapshot, which unprotects every guest page as it saves it.
Zapping on each unprotect makes the guest refault its whole working
set. On a 64GB guest under a background snapshot, a read-mostly workload
drops secondary-MMU refaults from ~1M/s to ~2.5K/s and cross-vCPU TLB
shootdowns from ~1400/s to near zero.

Note: this also skips the APIC-access page reload, which is not needed
as the page's PFN is unchanged.

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

