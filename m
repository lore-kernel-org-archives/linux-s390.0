Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D1D274FD3
	for <linux-s390@vger.kernel.org>; Fri, 12 Dec 2025 15:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765554411; cv=none; b=eiooUU+jj4xvlQXSf8YPQyAm2SU7wyxoNBYrPWmh8f0rcL3Gkg3qd6S4EELvErxkUPMlrdc9rkK2dU76+H8pz30m8VsPzGiAK9KlALQvAI2QAQeR9EOmeq7GP73cCYO9lB0V/YnaMEeKhtdj3o5c1XexUJmZJ28onlHm3GMXn0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765554411; c=relaxed/simple;
	bh=5RIR3QivN08NI6X+Qqpt8w1nWCDDw5mAKulgQOD6E2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QFmx9STbNCQ8BfrqcAZPKXvJ88XQQJLVYBHR2SSoQv77ZSQGY7TTcbO2XaPxBn5mqyjRgbzvZxyRQ61hgUf+eCovoBhq70lSQjK5yi1J5d68QpdPQn9YMrSHVd8AjuE89wycHcUndUSvnTeekN2txLBfw8Z3FCv2PCn2aANNq3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aW8wXZW+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LCkYq5pi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=voMEt+w+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WPV/oajO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aW8wXZW+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LCkYq5pi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="voMEt+w+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WPV/oajO"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E7FD833868;
	Fri, 12 Dec 2025 15:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765554407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yppV3tB5dvhlg5DZnbzRlXY7U/eYJxZV50SOFiaVbpo=;
	b=aW8wXZW+j/QQ4PZR0U0UNiRhkWmAtSyBaiPLlBpignWG1VSGbR0ikJuI+mNIVKR0CM3uWa
	HteRgj9XTVdF4G6rqC4UIqkLzvk4sn79EKwsGQ1cJTVHixu4a7qIIFnDcpe79bv0Fyj7EA
	o8Mk6P1R4qa8K8rvhvKHOBNqJbV1Gzc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765554407;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yppV3tB5dvhlg5DZnbzRlXY7U/eYJxZV50SOFiaVbpo=;
	b=LCkYq5piMPBYHWICB3jHNWcz33cljiCIkblZI2TiWBJIS/ETloj9ja+RP9C+1KURvmebTx
	Y+aK5dN9t7DGvNCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765554406; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yppV3tB5dvhlg5DZnbzRlXY7U/eYJxZV50SOFiaVbpo=;
	b=voMEt+w+mipvLD+d8ektO/f0JWcIxtJF1IOLWACI5bPy7Qd4sqXYZX8yaU8niHDWHo0PEM
	eR7zu1s7dIyKtUTR2rza69RNGUOtW3KA8RSODI4wxEDS3v27tSD2enuOyW+PWyeGaw11J6
	jD+f8myFM+T54rUDSg/1zmKvA8IOMTw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765554406;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yppV3tB5dvhlg5DZnbzRlXY7U/eYJxZV50SOFiaVbpo=;
	b=WPV/oajOPweYsvGu6vcLsiMpAkd3L+gfJ2P01JvC1mYJFX2x62ajJNJ/y/3iAl0sRBbrcH
	eAmkOxhMpSCOQ3Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D3DA13EA63;
	Fri, 12 Dec 2025 15:46:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aPVMM+Y4PGnXCwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 12 Dec 2025 15:46:46 +0000
Message-ID: <5e79bed1-598d-4e34-8f1e-87b6dba52bf8@suse.cz>
Date: Fri, 12 Dec 2025 16:46:46 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/page_alloc: change all pageblocks migrate type on
 coalescing
To: Alexander Gordeev <agordeev@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>
Cc: Marc Hartmayer <mhartmay@linux.ibm.com>, linux-mm@kvack.org,
 linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251212151457.3898073Add-agordeev@linux.ibm.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <20251212151457.3898073Add-agordeev@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.19)[-0.938];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.29

On 12/12/25 16:14, Alexander Gordeev wrote:
> When a page is freed it coalesces with a buddy into a higher
> order page while possible. When the buddy page migrate type
> differs, it is expected to be updated to match the one of the
> page being freed.
> 
> However, only the first pageblock of the buddy page is updated,
> while the rest of the pageblocks are left unchanged.
> 
> That causes warnings in later expand() and other code paths
> (like below), since an inconsistency between migration type
> of the list containing the page and the page-owned pageblocks
> migration types is introduced.
> 
> The issue is first exposed with commit e0932b6c1f94 ("mm:
> page_alloc: consolidate free page accounting"), where the
> warnings were introduced, but it is observed in earlier
> versions if similar warnings are added.
> 
> [  308.986589] ------------[ cut here ]------------
> [  308.987227] page type is 0, passed migratetype is 1 (nr=256)
> [  308.987275] WARNING: CPU: 1 PID: 5224 at mm/page_alloc.c:812 expand+0x23c/0x270
> [  308.987293] Modules linked in: algif_hash(E) af_alg(E) nft_fib_inet(E) nft_fib_ipv4(E) nft_fib_ipv6(E) nft_fib(E) nft_reject_inet(E) nf_reject_ipv4(E) nf_reject_ipv6(E) nft_reject(E) nft_ct(E) nft_chain_nat(E) nf_nat(E) nf_conntrack(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) nf_tables(E) s390_trng(E) vfio_ccw(E) mdev(E) vfio_iommu_type1(E) vfio(E) sch_fq_codel(E) drm(E) i2c_core(E) drm_panel_orientation_quirks(E) loop(E) nfnetlink(E) vsock_loopback(E) vmw_vsock_virtio_transport_common(E) vsock(E) ctcm(E) fsm(E) diag288_wdt(E) watchdog(E) zfcp(E) scsi_transport_fc(E) ghash_s390(E) prng(E) aes_s390(E) des_generic(E) des_s390(E) libdes(E) sha3_512_s390(E) sha3_256_s390(E) sha_common(E) paes_s390(E) crypto_engine(E) pkey_cca(E) pkey_ep11(E) zcrypt(E) rng_core(E) pkey_pckmo(E) pkey(E) autofs4(E)
> [  308.987439] Unloaded tainted modules: hmac_s390(E):2
> [  308.987650] CPU: 1 UID: 0 PID: 5224 Comm: mempig_verify Kdump: loaded Tainted: G            E       6.18.0-gcc-bpf-debug #431 PREEMPT
> [  308.987657] Tainted: [E]=UNSIGNED_MODULE
> [  308.987661] Hardware name: IBM 3906 M04 704 (z/VM 7.3.0)
> [  308.987666] Krnl PSW : 0404f00180000000 00000349976fa600 (expand+0x240/0x270)
> [  308.987676]            R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:3 PM:0 RI:0 EA:3
> [  308.987682] Krnl GPRS: 0000034980000004 0000000000000005 0000000000000030 000003499a0e6d88
> [  308.987688]            0000000000000005 0000034980000005 000002be803ac000 0000023efe6c8300
> [  308.987692]            0000000000000008 0000034998d57290 000002be00000100 0000023e00000008
> [  308.987696]            0000000000000000 0000000000000000 00000349976fa5fc 000002c99b1eb6f0
> [  308.987708] Krnl Code: 00000349976fa5f0: c020008a02f2	larl	%r2,000003499883abd4
>                           00000349976fa5f6: c0e5ffe3f4b5	brasl	%r14,0000034997378f60
>                          #00000349976fa5fc: af000000		mc	0,0
>                          >00000349976fa600: a7f4ff4c		brc	15,00000349976fa498
>                           00000349976fa604: b9040026		lgr	%r2,%r6
>                           00000349976fa608: c0300088317f	larl	%r3,0000034998800906
>                           00000349976fa60e: c0e5fffdb6e1	brasl	%r14,00000349976b13d0
>                           00000349976fa614: af000000		mc	0,0
> [  308.987734] Call Trace:
> [  308.987738]  [<00000349976fa600>] expand+0x240/0x270
> [  308.987744] ([<00000349976fa5fc>] expand+0x23c/0x270)
> [  308.987749]  [<00000349976ff95e>] rmqueue_bulk+0x71e/0x940
> [  308.987754]  [<00000349976ffd7e>] __rmqueue_pcplist+0x1fe/0x2a0
> [  308.987759]  [<0000034997700966>] rmqueue.isra.0+0xb46/0xf40
> [  308.987763]  [<0000034997703ec8>] get_page_from_freelist+0x198/0x8d0
> [  308.987768]  [<0000034997706fa8>] __alloc_frozen_pages_noprof+0x198/0x400
> [  308.987774]  [<00000349977536f8>] alloc_pages_mpol+0xb8/0x220
> [  308.987781]  [<0000034997753bf6>] folio_alloc_mpol_noprof+0x26/0xc0
> [  308.987786]  [<0000034997753e4c>] vma_alloc_folio_noprof+0x6c/0xa0
> [  308.987791]  [<0000034997775b22>] vma_alloc_anon_folio_pmd+0x42/0x240
> [  308.987799]  [<000003499777bfea>] __do_huge_pmd_anonymous_page+0x3a/0x210
> [  308.987804]  [<00000349976cb08e>] __handle_mm_fault+0x4de/0x500
> [  308.987809]  [<00000349976cb14c>] handle_mm_fault+0x9c/0x3a0
> [  308.987813]  [<000003499734d70e>] do_exception+0x1de/0x540
> [  308.987822]  [<0000034998387390>] __do_pgm_check+0x130/0x220
> [  308.987830]  [<000003499839a934>] pgm_check_handler+0x114/0x160
> [  308.987838] 3 locks held by mempig_verify/5224:
> [  308.987842]  #0: 0000023ea44c1e08 (vm_lock){++++}-{0:0}, at: lock_vma_under_rcu+0xb2/0x2a0
> [  308.987859]  #1: 0000023ee4d41b18 (&pcp->lock){+.+.}-{2:2}, at: rmqueue.isra.0+0xad6/0xf40
> [  308.987871]  #2: 0000023efe6c8998 (&zone->lock){..-.}-{2:2}, at: rmqueue_bulk+0x5a/0x940
> [  308.987886] Last Breaking-Event-Address:
> [  308.987890]  [<0000034997379096>] __warn_printk+0x136/0x140
> [  308.987897] irq event stamp: 52330356
> [  308.987901] hardirqs last  enabled at (52330355): [<000003499838742e>] __do_pgm_check+0x1ce/0x220
> [  308.987907] hardirqs last disabled at (52330356): [<000003499839932e>] _raw_spin_lock_irqsave+0x9e/0xe0
> [  308.987913] softirqs last  enabled at (52329882): [<0000034997383786>] handle_softirqs+0x2c6/0x530
> [  308.987922] softirqs last disabled at (52329859): [<0000034997382f86>] __irq_exit_rcu+0x126/0x140
> [  308.987929] ---[ end trace 0000000000000000 ]---
> [  308.987936] ------------[ cut here ]------------
> [  308.987940] page type is 0, passed migratetype is 1 (nr=256)
> [  308.987951] WARNING: CPU: 1 PID: 5224 at mm/page_alloc.c:860 __del_page_from_free_list+0x1be/0x1e0
> [  308.987960] Modules linked in: algif_hash(E) af_alg(E) nft_fib_inet(E) nft_fib_ipv4(E) nft_fib_ipv6(E) nft_fib(E) nft_reject_inet(E) nf_reject_ipv4(E) nf_reject_ipv6(E) nft_reject(E) nft_ct(E) nft_chain_nat(E) nf_nat(E) nf_conntrack(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) nf_tables(E) s390_trng(E) vfio_ccw(E) mdev(E) vfio_iommu_type1(E) vfio(E) sch_fq_codel(E) drm(E) i2c_core(E) drm_panel_orientation_quirks(E) loop(E) nfnetlink(E) vsock_loopback(E) vmw_vsock_virtio_transport_common(E) vsock(E) ctcm(E) fsm(E) diag288_wdt(E) watchdog(E) zfcp(E) scsi_transport_fc(E) ghash_s390(E) prng(E) aes_s390(E) des_generic(E) des_s390(E) libdes(E) sha3_512_s390(E) sha3_256_s390(E) sha_common(E) paes_s390(E) crypto_engine(E) pkey_cca(E) pkey_ep11(E) zcrypt(E) rng_core(E) pkey_pckmo(E) pkey(E) autofs4(E)
> [  308.988070] Unloaded tainted modules: hmac_s390(E):2
> [  308.988087] CPU: 1 UID: 0 PID: 5224 Comm: mempig_verify Kdump: loaded Tainted: G        W   E       6.18.0-gcc-bpf-debug #431 PREEMPT
> [  308.988095] Tainted: [W]=WARN, [E]=UNSIGNED_MODULE
> [  308.988100] Hardware name: IBM 3906 M04 704 (z/VM 7.3.0)
> [  308.988105] Krnl PSW : 0404f00180000000 00000349976f9e32 (__del_page_from_free_list+0x1c2/0x1e0)
> [  308.988118]            R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:3 PM:0 RI:0 EA:3
> [  308.988127] Krnl GPRS: 0000034980000004 0000000000000005 0000000000000030 000003499a0e6d88
> [  308.988133]            0000000000000005 0000034980000005 0000034998d57290 0000023efe6c8300
> [  308.988139]            0000000000000001 0000000000000008 000002be00000100 000002be803ac000
> [  308.988144]            0000000000000000 0000000000000001 00000349976f9e2e 000002c99b1eb728
> [  308.988153] Krnl Code: 00000349976f9e22: c020008a06d9	larl	%r2,000003499883abd4
>                           00000349976f9e28: c0e5ffe3f89c	brasl	%r14,0000034997378f60
>                          #00000349976f9e2e: af000000		mc	0,0
>                          >00000349976f9e32: a7f4ff4e		brc	15,00000349976f9cce
>                           00000349976f9e36: b904002b		lgr	%r2,%r11
>                           00000349976f9e3a: c030008a06e7	larl	%r3,000003499883ac08
>                           00000349976f9e40: c0e5fffdbac8	brasl	%r14,00000349976b13d0
>                           00000349976f9e46: af000000		mc	0,0
> [  308.988184] Call Trace:
> [  308.988188]  [<00000349976f9e32>] __del_page_from_free_list+0x1c2/0x1e0
> [  308.988195] ([<00000349976f9e2e>] __del_page_from_free_list+0x1be/0x1e0)
> [  308.988202]  [<00000349976ff946>] rmqueue_bulk+0x706/0x940
> [  308.988208]  [<00000349976ffd7e>] __rmqueue_pcplist+0x1fe/0x2a0
> [  308.988214]  [<0000034997700966>] rmqueue.isra.0+0xb46/0xf40
> [  308.988221]  [<0000034997703ec8>] get_page_from_freelist+0x198/0x8d0
> [  308.988227]  [<0000034997706fa8>] __alloc_frozen_pages_noprof+0x198/0x400
> [  308.988233]  [<00000349977536f8>] alloc_pages_mpol+0xb8/0x220
> [  308.988240]  [<0000034997753bf6>] folio_alloc_mpol_noprof+0x26/0xc0
> [  308.988247]  [<0000034997753e4c>] vma_alloc_folio_noprof+0x6c/0xa0
> [  308.988253]  [<0000034997775b22>] vma_alloc_anon_folio_pmd+0x42/0x240
> [  308.988260]  [<000003499777bfea>] __do_huge_pmd_anonymous_page+0x3a/0x210
> [  308.988267]  [<00000349976cb08e>] __handle_mm_fault+0x4de/0x500
> [  308.988273]  [<00000349976cb14c>] handle_mm_fault+0x9c/0x3a0
> [  308.988279]  [<000003499734d70e>] do_exception+0x1de/0x540
> [  308.988286]  [<0000034998387390>] __do_pgm_check+0x130/0x220
> [  308.988293]  [<000003499839a934>] pgm_check_handler+0x114/0x160
> [  308.988300] 3 locks held by mempig_verify/5224:
> [  308.988305]  #0: 0000023ea44c1e08 (vm_lock){++++}-{0:0}, at: lock_vma_under_rcu+0xb2/0x2a0
> [  308.988322]  #1: 0000023ee4d41b18 (&pcp->lock){+.+.}-{2:2}, at: rmqueue.isra.0+0xad6/0xf40
> [  308.988334]  #2: 0000023efe6c8998 (&zone->lock){..-.}-{2:2}, at: rmqueue_bulk+0x5a/0x940
> [  308.988346] Last Breaking-Event-Address:
> [  308.988350]  [<0000034997379096>] __warn_printk+0x136/0x140
> [  308.988356] irq event stamp: 52330356
> [  308.988360] hardirqs last  enabled at (52330355): [<000003499838742e>] __do_pgm_check+0x1ce/0x220
> [  308.988366] hardirqs last disabled at (52330356): [<000003499839932e>] _raw_spin_lock_irqsave+0x9e/0xe0
> [  308.988373] softirqs last  enabled at (52329882): [<0000034997383786>] handle_softirqs+0x2c6/0x530
> [  308.988380] softirqs last disabled at (52329859): [<0000034997382f86>] __irq_exit_rcu+0x126/0x140
> [  308.988388] ---[ end trace 0000000000000000 ]---
> 
> Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> Closes: https://lore.kernel.org/linux-mm/87wmalyktd.fsf@linux.ibm.com/
> Fixes: e0932b6c1f94 ("mm: page_alloc: consolidate free page accounting")
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>

Hm I guess we haven't seen this before because it's common that
pageblock_order is just one below MAX_ORDER so we're only merging two
pageblocks. But your arch/config must be different to expose it. In any case
LGTM, thanks.

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/page_alloc.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index ed82ee55e66a..6e644f2744c2 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -913,6 +913,17 @@ buddy_merge_likely(unsigned long pfn, unsigned long buddy_pfn,
>  			NULL) != NULL;
>  }
>  
> +static void change_pageblock_range(struct page *pageblock_page,
> +				   int start_order, int migratetype)
> +{
> +	int nr_pageblocks = 1 << (start_order - pageblock_order);
> +
> +	while (nr_pageblocks--) {
> +		set_pageblock_migratetype(pageblock_page, migratetype);
> +		pageblock_page += pageblock_nr_pages;
> +	}
> +}
> +
>  /*
>   * Freeing function for a buddy system allocator.
>   *
> @@ -999,7 +1010,7 @@ static inline void __free_one_page(struct page *page,
>  			 * expand() down the line puts the sub-blocks
>  			 * on the right freelists.
>  			 */
> -			set_pageblock_migratetype(buddy, migratetype);
> +			change_pageblock_range(buddy, order, migratetype);
>  		}
>  
>  		combined_pfn = buddy_pfn & pfn;
> @@ -2146,17 +2157,6 @@ bool pageblock_unisolate_and_move_free_pages(struct zone *zone, struct page *pag
>  
>  #endif /* CONFIG_MEMORY_ISOLATION */
>  
> -static void change_pageblock_range(struct page *pageblock_page,
> -					int start_order, int migratetype)
> -{
> -	int nr_pageblocks = 1 << (start_order - pageblock_order);
> -
> -	while (nr_pageblocks--) {
> -		set_pageblock_migratetype(pageblock_page, migratetype);
> -		pageblock_page += pageblock_nr_pages;
> -	}
> -}
> -
>  static inline bool boost_watermark(struct zone *zone)
>  {
>  	unsigned long max_boost;

