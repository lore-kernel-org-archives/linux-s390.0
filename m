Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80D6492181
	for <linux-s390@vger.kernel.org>; Tue, 12 May 2026 08:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778575143; cv=none; b=S5vYAJ+GU+SIrDZI0Kx1QVZNHBJZGv4K/qrjK3UMhzkgSWY3OLJhn/C9Mpz9u1G8nO5MHnBPjMhMm+FSAKgs+zIcp6Pr1AaM2QgKresoyfoHJVaO/F5CLtPl2SoEK8VnYVX57mFH2pQW4tI/kdehue323fezGbKIophtf7Dy28I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778575143; c=relaxed/simple;
	bh=PvSguwhqC3pPaNbt2AclEaZ3/FN1nKCLR2BONxjiSnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZvYenPjJ8FgY9zt9c3MoHAR91TePqgUwVdbuwQyu5jYaVyTGZf5NZctnSfuM0ReZN/mD0J9/3ntenQobOPVz8q3R/U+anDr5qE4hck9eVydL+SPsengDKCoT2DOfpXgehDmZ8CY8rFpldxqC92wTX11B0prP18G6I2O9mjf2gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=B24BTupO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XZLe/pWb; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=z4qmOL+i; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nkIJGcsG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="B24BTupO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XZLe/pWb";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="z4qmOL+i";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nkIJGcsG"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D14CD6BF73;
	Tue, 12 May 2026 08:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778575140; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cRmCTdeVkPT2NuaQu5a1eLxhY8w1hkEcHcyxJVJjlzY=;
	b=B24BTupO5JD9b26rwUH+K9d1/Vcxshhn52OYk9URYHhW436cIHAcJ5Vn9NDb3R/VmHnt+A
	cYBPHakUFtxh7DWa7mBoUfuFlt/MQIhnuYJnoVtjcHTkPpy7Dd+E30iqB7kbl02XE0cBDM
	7YCh3HdiM45BD/uV2O0o/nSt4iYbtUM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778575140;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cRmCTdeVkPT2NuaQu5a1eLxhY8w1hkEcHcyxJVJjlzY=;
	b=XZLe/pWbKYtYi19GVwMZY/8qyCkUAAmKF9/VmTP6qz18Z/+WD8g/3EBKvKtPmU1lJ3juOd
	hDzcDCS2jGG7GHBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=z4qmOL+i;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=nkIJGcsG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778575138; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cRmCTdeVkPT2NuaQu5a1eLxhY8w1hkEcHcyxJVJjlzY=;
	b=z4qmOL+ipch1HGEOuXBJglkJcbrzuLP0/yWV+sZjFrdb8mn2mm/2d67A3ITeIcejAQGxR/
	RdFe8Skzfs1Q2ocyTDFeb7DByE/k3whOFxeLqYBe7XWtPbR7TIm+Nw09k14Vr/EhxhyVGP
	TRRlokoiixe8q5/sUxRjtZkAzEWJ01Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778575138;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cRmCTdeVkPT2NuaQu5a1eLxhY8w1hkEcHcyxJVJjlzY=;
	b=nkIJGcsGKfpKdIByts87clqd4f1+DPMfWm7jsnBwweokDo5anFQqhbyqLq5lx7kwRFlN5L
	NTStTSZDy+fb8QBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A89CD593A9;
	Tue, 12 May 2026 08:38:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mOqnJiHnAmpiBgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 12 May 2026 08:38:57 +0000
Date: Tue, 12 May 2026 10:38:52 +0200
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
Subject: Re: [PATCH 7/8] s390/mm: use free_reserved_page() in
 vmem_free_pages()
Message-ID: <agLnHDFulmuyhxGi@localhost.localdomain>
References: <20260511-bootmem_info_prep-v1-0-3fb0be6fc688@kernel.org>
 <20260511-bootmem_info_prep-v1-7-3fb0be6fc688@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511-bootmem_info_prep-v1-7-3fb0be6fc688@kernel.org>
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,localhost.localdomain:mid,suse.de:dkim,suse.de:email];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: D14CD6BF73
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.51

On Mon, May 11, 2026 at 04:05:35PM +0200, David Hildenbrand (Arm) wrote:
> We never select CONFIG_HAVE_BOOTMEM_INFO_NODE on s390. Therefore,
> free_bootmem_page() nowadays always translates to free_reserved_page().
> 
> Let's use free_reserved_page() to replace the free_bootmem_page() loop.
> We can stop including bootmem_info.h.
> 
> Likely, vmemmap freeing code could be factored out into the core in the
> future.
> 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

 

-- 
Oscar Salvador
SUSE Labs
