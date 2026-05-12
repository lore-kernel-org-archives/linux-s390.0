Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C7D48BD4C
	for <linux-s390@vger.kernel.org>; Tue, 12 May 2026 08:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778575000; cv=none; b=pLrdiWqeSKtkDSn2EtXdFEovEiZF/pmE+y8DqTUXVM60KObUV+NNjf6eVXPC2xSzlSjkcX0stGJa0+gzbck9fXT6utH9d/KjZBlTiUVnDUBqKQ9TpTMrxyiJASPQPflDnCBh58qpoi9xdqlQjWerKsqfrxZlvEwkPNksgYuXEZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778575000; c=relaxed/simple;
	bh=MqZN/73LIN/2DL0Y6KXMIFZwKYNcaTLVzgmc7Efik2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DUd+iY6Hzd37TgMF82kIV6g6ait2HR7p8orkKjbJqEuujrMiY7GqKTdXaMa+SkiGv42EvFxMcFvnrPCh/HgbBjgSJkq+eJn+l50/iOpZN1riE0ieQwh+M+iZ+NC++g2ov5IjG7tLRDuSCmOGZtwwclAJy8aL8+wlNsbHUcreSdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OxABjhln; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=L7RAFmAT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DfeZqqoI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RPxKI++w; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OxABjhln";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="L7RAFmAT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DfeZqqoI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RPxKI++w"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6A4EA759BF;
	Tue, 12 May 2026 08:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778574997; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qeFPBZ4MeGkkPKzW14cEWiFa5q6IagaEwfD13UPfREs=;
	b=OxABjhlnjKoPqma/DwnCh9ytg1ymqNAtN/sQ9nMfbNfSVVpO1pG0mn4USLcQjgr7xWMLG5
	Ty0gqf/eauSaqpxetjhSr93gpbJ6JoFGw/oPkqrbLXvnRauqb6yT/sovIsNiX4Eijxb8L6
	RWGveaKnKqRXk6euaWwZp8DaWlifR9w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778574997;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qeFPBZ4MeGkkPKzW14cEWiFa5q6IagaEwfD13UPfREs=;
	b=L7RAFmATKRu5J9cmTOV37Ybl7z/LrRpErCEHSPmy0c6dVYtgZaBPVe5X5XWAf6wbSYGAqU
	020Pexc8OaYtLcCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778574996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qeFPBZ4MeGkkPKzW14cEWiFa5q6IagaEwfD13UPfREs=;
	b=DfeZqqoIT4ioiv6VHsaqCJQ4w2wWbcF+goDiMNScbajtWamahUFsQ4SLfSfRL9CKUtBvcT
	O5x17wC9q+mHZWkVkUVwWf1B5Z4G/yx6+cIMDNk9PjAy6GV/Pn7EU01aEEpC7ONl8MlaBU
	P3dMQd3mxA9QfMgOZEdbUZlA+NLdcHs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778574996;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qeFPBZ4MeGkkPKzW14cEWiFa5q6IagaEwfD13UPfREs=;
	b=RPxKI++wuNeC0Ia2Hjv4TcWo1i+E7zCF1qOWkpMPqs3WUzf64ogYfQrRoR7xY0z14vKqI5
	UxMNPadIOZomMPBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6E7FE593A9;
	Tue, 12 May 2026 08:36:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id P8jkGJPmAmrTAwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 12 May 2026 08:36:35 +0000
Date: Tue, 12 May 2026 10:36:29 +0200
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
Subject: Re: [PATCH 5/8] mm/bootmem_info: stop marking the pgdat as NODE_INFO
Message-ID: <agLmjW41Sn254z_G@localhost.localdomain>
References: <20260511-bootmem_info_prep-v1-0-3fb0be6fc688@kernel.org>
 <20260511-bootmem_info_prep-v1-5-3fb0be6fc688@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511-bootmem_info_prep-v1-5-3fb0be6fc688@kernel.org>
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,gaisler.com,kernel.org,linux-foundation.org,linux.ibm.com,ellerman.id.au,gmail.com,infradead.org,google.com,suse.com,vger.kernel.org,kvack.org,lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,localhost.localdomain:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

On Mon, May 11, 2026 at 04:05:33PM +0200, David Hildenbrand (Arm) wrote:
> We removed the last user of NODE_INFO in commit 119c31caa59e ("mm/sparse:
> remove !CONFIG_SPARSEMEM_VMEMMAP leftovers for CONFIG_MEMORY_HOTPLUG").
> 
> But it really was never used it besides for safety-checks ever since it was
> introduced in commit 04753278769f ("memory hotplug: register section/node
> id to free"), where we had the comment:
> 
> 	5) The node information like pgdat has similar issues. But, this
> 	   will be able to be solved too by this.
> 	   (Not implemented yet, but, remembering node id in the pages.)
> 
> Of course, that never happened, and we are not planning on freeing the
> node data (pgdat/pglist_data), during memory hotunplug.
> 
> So let's just stop marking the pgdat as NODE_INFO.
> 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Oscar Salvador <osalvador@suse.de>

 

-- 
Oscar Salvador
SUSE Labs
