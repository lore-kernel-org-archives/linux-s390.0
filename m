Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DAD399004
	for <linux-s390@vger.kernel.org>; Mon, 27 Apr 2026 08:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777279216; cv=none; b=is7bynVKuIBQkqEZ3Egm1p11dB+629suECHk2LqyHPu7MQuOhFcQDAvYSu0KzMx4TWGyHDWI5qasi3ei4bL+Mq/I6ol3MZuoEL7z6k/c+KW7zECX9wQ17UQ2nKiDNBodgPguFXNPd/w3hFzfF6mt8IVob8YvUm/5JysLv2007/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777279216; c=relaxed/simple;
	bh=J4K4WRMeIupX4g2+9UUJs4Q75/PNoTkQ942MQBipmNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cwNNExYXkgMUESd4IxLvBF6lOcv8k/FpvK8ctjr62Ok0kSnRV7x+gxx0d5r/cJcFOHZYNm1Krv0DdYM7wWOy53po82I9nMfuUDYkOOd0oUxal6Pa/wOhXZOfHQeLzrtz9cOB+WlibzucHquU+TdQtMBZIZ69rjlsUIiIs/qomds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nj+KaZoT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dZpnDmyN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qQIp1vvF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MnJWARvn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nj+KaZoT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dZpnDmyN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qQIp1vvF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MnJWARvn"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D7F695BE62;
	Mon, 27 Apr 2026 08:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777279213; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UReiR8tBfbqAEvNOviGNvtVyvBhm/HcNLTCRksGYy3I=;
	b=nj+KaZoTa9/GluQ+DtQMok6+GUWJi1tSIzfND7q2L8gk5IOcF7ADSICLODzq2/HDwKHuR1
	mwc1neZ6DMk57ngllZ7J3GsnGDuJaFGnXJZ0HQFjQArUVjpiAXBGWtiiQJzf0Aprw9pw5N
	2LD+fRuQSktgzxdecdWzeEGxtd9RFV4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777279213;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UReiR8tBfbqAEvNOviGNvtVyvBhm/HcNLTCRksGYy3I=;
	b=dZpnDmyNL8/pfI3pY1ODk1TSRuRBxiFsZiMCHy0UXtV95kCKLZQh6EeZ6uQZBb5ZUpQmYW
	qR31hY14RmsYwTAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777279212; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UReiR8tBfbqAEvNOviGNvtVyvBhm/HcNLTCRksGYy3I=;
	b=qQIp1vvF6IRXxs1zMpZogcXfT47UPQX2tZrk9tFoSjC8cRwLBVKntuH5EvgsK37aSYBEGv
	fFFW0tgJuYgGLmcuiyI9LdRRmpJ1LvQxtG9m0j4Jp0VEOgP4Wok1DScnpFZiS36ADkjn1P
	4ruWkvqy6PhyJcGkIo6TtKDeuL6m21w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777279212;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UReiR8tBfbqAEvNOviGNvtVyvBhm/HcNLTCRksGYy3I=;
	b=MnJWARvn4BQ8RqANKFlWJgXcRF03Fl+yplpj549cRVqodgRw5qXhJQGw5EPljgVL0wb/aR
	BlINi6ltNAnZqMAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6BB04593B0;
	Mon, 27 Apr 2026 08:40:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BQwYGOwg72n7JQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 27 Apr 2026 08:40:12 +0000
Date: Mon, 27 Apr 2026 10:40:02 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_vma_mapped_walk: add missing pgtable entry
 accessors
Message-ID: <ae8g4jipQxQZRe6E@localhost.localdomain>
References: <20260427052000.196402-1-agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427052000.196402-1-agordeev@linux.ibm.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,localhost.localdomain:mid]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On Mon, Apr 27, 2026 at 07:20:00AM +0200, Alexander Gordeev wrote:
> Convert pgtable direct entry dereferences to the corresponding
> pXdp_get() accessors. Use ptep_get_lockless() variant for PTE
> reads when no lock is taken.
> 
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
>  mm/page_vma_mapped.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> index b38a1d00c971..a4520bb10d2a 100644
> --- a/mm/page_vma_mapped.c
> +++ b/mm/page_vma_mapped.c
...
> @@ -317,7 +317,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>  				goto restart;
>  			}
>  			pvmw->pte++;
> -		} while (pte_none(ptep_get(pvmw->pte)));
> +		} while (pte_none(ptep_get_lockless(pvmw->pte)));

map_pte() might take the lock if PVWN_SYNC mode, or am I missing something?

 

-- 
Oscar Salvador
SUSE Labs
