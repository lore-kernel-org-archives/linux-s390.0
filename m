Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5B14A33E6
	for <linux-s390@vger.kernel.org>; Tue, 12 May 2026 08:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778575521; cv=none; b=YhXziy/8/B9Smh2PZ+7fmaydx/pRJAp9KxCuIAAMZcE99rIXII0nI8NGLS4v21/18Rx7LMMvn7pfRTSlEwPe9450jkAzwGmrQyAMITcT4ajsFryVsQz8KOi3nM6fYnw+7zHkyQPMhK/LNV+8s8gu7jQfe8OEBJXZtIRABNjdkXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778575521; c=relaxed/simple;
	bh=ZOHdqAnTE7e8dNqPPY4ykaVwJa3M9s3yDSxo0RREBRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B2hWQZlgbHsSARoUewOLttJkmn39EPcQ1cTHuPTUMXUp/yOqVynMxv/fRuAcFlR7uK7/WaDYw/rC3hRCpQzo2ng7pu6K4j4Ggmuj9q1YJb7DM1bWrEuz4mBje/r4sfQ1B1NJOw4bbldEyONtUngaEwmWHuFkA4pCwwNLNLooB2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0DIAw/Lb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wlS+ubs2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0DIAw/Lb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wlS+ubs2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0DIAw/Lb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wlS+ubs2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0DIAw/Lb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wlS+ubs2"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1EADE5D634;
	Tue, 12 May 2026 08:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778575512; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VVhUu+lg1kvYAZheHCbKtRrVHTg43eeZOy4q05OgGw0=;
	b=0DIAw/LbkWRCYPpD3+i1wnlozxRda8gJxf0kVkjNTDXsTbOdeGH/d4BBCo6imoUNbuN6hC
	A+aBChhNKHHqLAz+qr+5HJ/EO0w9hc6E3Euu0JajBE6G32rTNIRLPKJjnBwwRBLnG/raic
	dzzpDPMWy2jOOFSnfNkzfdC4jyKQCdQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778575512;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VVhUu+lg1kvYAZheHCbKtRrVHTg43eeZOy4q05OgGw0=;
	b=wlS+ubs2D6Ep/tmUl0C2jTHAHUUW9og+1my0meSb8uJ28QcnzxeTrdYUZof5QUj/PfTmeB
	6ZtA3N0+klZT+5Cg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778575512; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VVhUu+lg1kvYAZheHCbKtRrVHTg43eeZOy4q05OgGw0=;
	b=0DIAw/LbkWRCYPpD3+i1wnlozxRda8gJxf0kVkjNTDXsTbOdeGH/d4BBCo6imoUNbuN6hC
	A+aBChhNKHHqLAz+qr+5HJ/EO0w9hc6E3Euu0JajBE6G32rTNIRLPKJjnBwwRBLnG/raic
	dzzpDPMWy2jOOFSnfNkzfdC4jyKQCdQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778575512;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VVhUu+lg1kvYAZheHCbKtRrVHTg43eeZOy4q05OgGw0=;
	b=wlS+ubs2D6Ep/tmUl0C2jTHAHUUW9og+1my0meSb8uJ28QcnzxeTrdYUZof5QUj/PfTmeB
	6ZtA3N0+klZT+5Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 23421593A9;
	Tue, 12 May 2026 08:45:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uZmDBpfoAmo7DAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 12 May 2026 08:45:11 +0000
Date: Tue, 12 May 2026 10:45:09 +0200
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
Subject: Re: [PATCH 0/8] mm: remove CONFIG_HAVE_BOOTMEM_INFO_NODE (Part 1)
Message-ID: <agLolRUSzT9gnMZn@localhost.localdomain>
References: <20260511-bootmem_info_prep-v1-0-3fb0be6fc688@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511-bootmem_info_prep-v1-0-3fb0be6fc688@kernel.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,gaisler.com,kernel.org,linux-foundation.org,linux.ibm.com,ellerman.id.au,gmail.com,infradead.org,google.com,suse.com,vger.kernel.org,kvack.org,lists.ozlabs.org];
	RCVD_COUNT_TWO(0.00)[2];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,localhost.localdomain:mid]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On Mon, May 11, 2026 at 04:05:28PM +0200, David Hildenbrand (Arm) wrote:
> We want to remove CONFIG_HAVE_BOOTMEM_INFO_NODE. As a first step,
> let's limit the remaining harm to x86 and core code, removing
> sparc, ppc and s390 leftovers, starting the stepwise removal by removing
> and simplifying some code.
> 
> Once a related x86 vmemmap fix [1] is in, we can merge part 2 that will
> remove CONFIG_HAVE_BOOTMEM_INFO_NODE entirely.
> 
> Tested on x86-64 with hugetlb vmemmap optimization in combination with
> KMEMLEAK, making sure that the problem reported in dd0ff4d12dd2 ("bootmem:
> remove the vmemmap pages from kmemleak in put_page_bootmem") does not
> reappear -- hoping I managed to trigger the original problem.
> 
> Heavily cross-compiled, but let's let build bots run on it for a bit.
> 
> [1] https://lore.kernel.org/r/20260429-vmemmap-v2-1-8dfcacffd877@kernel.org 
> 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Awesome cleanup David, thanks for doing this ;-)

 

-- 
Oscar Salvador
SUSE Labs
