Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9B647DD7A
	for <linux-s390@vger.kernel.org>; Tue, 12 May 2026 08:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778574901; cv=none; b=BjVhi94B3xi0s/u1nZCtEbaI3UX8qSRWqTiG1y+WF5fsIcPDkki1d7klqqHma4JkmMpNP6+S4Izaaq66jFAbVpd083a+LE2TibjhhLTrziJioRj/BJ9i9/AKxrTep1tlM665lAAITSVz2Zc5ndJGKBukUjdWULA3nlb4RJ38tEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778574901; c=relaxed/simple;
	bh=ZrDK/2PvD6eHkDBO3sLhUlvlUJRIIoVyUwWxBqWB9IQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ChixhGfhcXStAhOeFqKMG9er5tR5C8l/SWEiQa45CRYTFjKDrP6x67491951xJNP9x+GR0k+KSf3PIkJAxOndz0Yix4TnzmnvLVtPaDE/Kghc6a7o1Wa12XoZ4pLGt2f1NLsvKQDp0UwUOXNVLUC7YvVKMVzP/3RU4egqevibhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JgteD5SU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=U7WR/Fgt; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=l1VAvGNu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iMM7usRt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JgteD5SU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="U7WR/Fgt";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="l1VAvGNu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iMM7usRt"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 50C8B6BF48;
	Tue, 12 May 2026 08:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778574898; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3l7Zxuv97fVDs6BKGH50Lkzj1T/33QzsVau3DKkKv4k=;
	b=JgteD5SU241A8M5FOIhoYUFygm7tY40r0GYV4JWMRuwAtYW0c1qAIsNGezNHZdYNF5yjyT
	Lu1M4zbt/RDs4mzLwwD8LQu8hctfWVf9vc6lz3aEMVb++jPPLdxUuvpb3+UjN5PMXHV6Mc
	OqpZwT/bCE8yDoxe4PtETglKGKr0SB4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778574898;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3l7Zxuv97fVDs6BKGH50Lkzj1T/33QzsVau3DKkKv4k=;
	b=U7WR/FgtRcmuAbqVYknYG2VkR8xSf/GkUthKCcFPE3A0vbxUuUXua6QatQSUpftyHk+Op7
	I9pAJHhMMiJsbCDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=l1VAvGNu;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=iMM7usRt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778574897; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3l7Zxuv97fVDs6BKGH50Lkzj1T/33QzsVau3DKkKv4k=;
	b=l1VAvGNuNtx7Z6JKNEXRCRQwI3UFDEmWr6DUFRkbzEyKi3QWEBNbOXqVWeECWrMq2/ilz+
	Niysj9Mevjw9CiZ8rlC+Iymiph3PplZOiQiHtTcJ0qWtBqgf59O09iOJnkRTZyHrpf1M32
	btRgcQqyyNP9MeZONOJdxp6SxQJawRk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778574897;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3l7Zxuv97fVDs6BKGH50Lkzj1T/33QzsVau3DKkKv4k=;
	b=iMM7usRtPxSmum8ruI/H4KeMRzmOSa4w3oEdCFakiGci3f9Oz+tTkYsHkf/zKIpCVetgUp
	6FtS64H0cOFGZFBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4F872593A9;
	Tue, 12 May 2026 08:34:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yepUETDmAmpyAgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 12 May 2026 08:34:56 +0000
Date: Tue, 12 May 2026 10:34:50 +0200
From: Oscar Salvador <osalvador@suse.de>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 4/8] mm/bootmem_info: remove call to
 kmemleak_free_part_phys()
Message-ID: <agLmKu3IpGS3FtmX@localhost.localdomain>
References: <20260511-bootmem_info_prep-v1-0-3fb0be6fc688@kernel.org>
 <20260511-bootmem_info_prep-v1-4-3fb0be6fc688@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511-bootmem_info_prep-v1-4-3fb0be6fc688@kernel.org>
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,gaisler.com,kernel.org,linux-foundation.org,linux.ibm.com,ellerman.id.au,gmail.com,infradead.org,google.com,suse.com,vger.kernel.org,kvack.org,lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,localhost.localdomain:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 50C8B6BF48
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.51

On Mon, May 11, 2026 at 04:05:32PM +0200, David Hildenbrand (Arm) wrote:
> The call to kmemleak_free_part_phys() was added in 2022 in
> commit dd0ff4d12dd2 ("bootmem: remove the vmemmap pages from kmemleak in
> put_page_bootmem").
> 
> In 2025, commit b2aad24b5333 ("mm/memmap: prevent double scanning of memmap
> by kmemleak") started to use MEMBLOCK_ALLOC_NOLEAKTRACE when allocating
> the memmap to skip the kmemleak_alloc_phys() in the buddy.
> 
> So remove the call to kmemleak_free_part_phys(). If this would still
> be required for other purposes, either free_reserved_page() should take
> care of it, or selected users.
> 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  include/linux/bootmem_info.h | 1 -
>  mm/bootmem_info.c            | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/include/linux/bootmem_info.h b/include/linux/bootmem_info.h
> index 492ceeb1cdf8..f724340755e5 100644
> --- a/include/linux/bootmem_info.h
> +++ b/include/linux/bootmem_info.h
> @@ -82,7 +82,6 @@ static inline void get_page_bootmem(unsigned long info, struct page *page,
>  
>  static inline void free_bootmem_page(struct page *page)
>  {
> -	kmemleak_free_part_phys(PFN_PHYS(page_to_pfn(page)), PAGE_SIZE);
>  	free_reserved_page(page);
>  }
>  #endif
> diff --git a/mm/bootmem_info.c b/mm/bootmem_info.c
> index 6e2aaab3dca9..74c1116626c8 100644
> --- a/mm/bootmem_info.c
> +++ b/mm/bootmem_info.c
> @@ -32,7 +32,6 @@ void put_page_bootmem(struct page *page)
>  
>  	if (page_ref_dec_return(page) == 1) {
>  		set_page_private(page, 0);
> -		kmemleak_free_part_phys(PFN_PHYS(page_to_pfn(page)), PAGE_SIZE);

A bit odd that kmemleak_free_part_phys() did not complain if we never
did kmemleak_alloc_phys() for these pages?
 

-- 
Oscar Salvador
SUSE Labs
