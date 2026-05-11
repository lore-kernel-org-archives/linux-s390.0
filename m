Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCE837B027
	for <linux-s390@vger.kernel.org>; Mon, 11 May 2026 12:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778501681; cv=none; b=BoBVk5pnmMGX/zuDDUdVeQyPefkL7IeAQQeEJ/XVLgYbVWwo2oBVIVIOSuEhToVGMteaBB5bBhaeQf6JrwYv8vsVNo40WySwW81Hv/i9Ybl+QTVsxr7JPQCzvKzUwxS25DQ7xByhnyjAr5vi5fQWYbHiQCO/QL37f00ceznXFjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778501681; c=relaxed/simple;
	bh=zSQRKgY2wFIIME1UtYuy1XW31/VAE3Fm5Mh90yJtF68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uamaqt2eJq5LN1JS6nBeNPYYQrb9fajhD7071SoqNVoSmgvRlJEXbU6KL4Agx5kgBqPapt1ORcA8M93oEN1E6EIny6UVuf6ZjlvFfPLfvwEvoxUAi9tYLz9ImH+B9iU9+1x4UCkFB6VjmTCuoH0tjVVi9sFIUeeNyRb74mY2tx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JK6iUU0q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MMegOG1C; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=S5RbwMsW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pfImO4AD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JK6iUU0q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MMegOG1C";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="S5RbwMsW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pfImO4AD"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CEE4E5CCDF;
	Mon, 11 May 2026 12:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778501678; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x8IczejHyQKAFVK8A9X7vhcds+BgOyppvdPBbfzrGGY=;
	b=JK6iUU0q0sMdEqJt04pZHXwse66yK7PJOPbgUOy8E67voS3luLWD6PrxBG6lnlAm4t+W6g
	UhibCarKVYbRhYtQyJO613JN+fejq3RtoOfroeNrmXN70tJ8j1IzX49EeBwg+Yx2T6Zy4O
	Jf7Khg5BVoLiPolqmSXl2KWKurNngNE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778501678;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x8IczejHyQKAFVK8A9X7vhcds+BgOyppvdPBbfzrGGY=;
	b=MMegOG1CXsA9nfXDrhRmL9bY/Bvl7Tr1axzxeEUuLR8hp9syPkxcTDwrFoBXiVLdGXYBIp
	qzdWQ9lWy8sPhdCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778501674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x8IczejHyQKAFVK8A9X7vhcds+BgOyppvdPBbfzrGGY=;
	b=S5RbwMsWScSOdtxjxNiBO/7HRnqI7O+pX/OEYmZqjNcK8WRxmle7zycXWlSBSh66JvsFj5
	aHm2Jd6pm7lpVz2fSiNxeooEbWaxEbZiT4bCOo59+QU5tkVQLGqKDrubL8qntEKRLwHb+z
	OpdICmm5Gd45lbQUU0SCPt96ZZ4raT0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778501674;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x8IczejHyQKAFVK8A9X7vhcds+BgOyppvdPBbfzrGGY=;
	b=pfImO4ADJMGt0V0+pOCb1eYPBVG7wc3nr5az6clLRhLUsgeGczZC9t48G94gk1yzfVFYv2
	fQz+tXUe7vpzaSDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C0E70593A3;
	Mon, 11 May 2026 12:14:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id j2n4LCnIAWoWWQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 11 May 2026 12:14:33 +0000
Date: Mon, 11 May 2026 14:14:32 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Muchun Song <songmuchun@bytedance.com>
Cc: David Hildenbrand <david@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, linux-mm@kvack.org,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	muchun.song@linux.dev
Subject: Re: [PATCH] drivers/base/memory: make memory block get/put explicit
Message-ID: <agHIKJtoZgKl9k3c@localhost.localdomain>
References: <20260511111800.2181785-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511111800.2181785-1-songmuchun@bytedance.com>
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linuxfoundation.org,linux-foundation.org,infradead.org,google.com,suse.com,linux.ibm.com,ellerman.id.au,gmail.com,kvack.org,lists.linux.dev,vger.kernel.org,lists.ozlabs.org,linux.dev];
	R_RATELIMIT(0.00)[to_ip_from(RLpyoywcuziyeafcj9rrbbd19s)];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,localhost.localdomain:mid,bytedance.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

On Mon, May 11, 2026 at 07:18:00PM +0800, Muchun Song wrote:
> Rename the memory block lookup helper to make the acquired reference
> explicit, add memory_block_put() to wrap put_device(), and collapse the
> redundant section-number wrapper into a single block-id based lookup
> interface.
> 
> This makes it clearer to callers that a successful lookup holds a
> reference that must be dropped, reducing the chance of forgetting the
> matching put and leaking the memory block device reference.
> 
> Link: https://lore.kernel.org/linux-mm/7887915D-E598-42B3-9AFE-BFFBACE8DE2D@linux.dev/#t
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Oscar Salvador <osalvador@suse.de>

Thanks, it looks more solid to me!
 

-- 
Oscar Salvador
SUSE Labs
