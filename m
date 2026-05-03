Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853A43D091A
	for <linux-s390@vger.kernel.org>; Sun,  3 May 2026 18:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777832259; cv=none; b=D6wqaUPS5LQh3lTRUrZB3X++D2G/sHaieQz1SNwoLc0pRYzyQUdyGacbUQGqzhsHjTwQMWhi/tRyRND1jxDF186S1NZX6Z8/RfNPTCUVamo+FaFRLJGX0V9R+L64SDdgoORAsrf93iLijle9+TYUXuJth6ETAso4nsT5FGCIIRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777832259; c=relaxed/simple;
	bh=QEiEk4kls8puDhn20pESF7PXeUdaYFVjhBGUlBJcABo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KAI8g06vhz4SxghyA+FBrNpEEgWR8NIp2wcJPUxjImtx+V8wwtzTx5Bbr0SQIfMsEWzp9cFtGtpfIWxcZFK33s/SFo/ymNVVJkGgCDFCZ6yJscVaAqBCEYt7lHDa0mnvz1FPem5R/+P7zAW525O/IIQNB+T5IFf5W5Sj5L6/eqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OoNHn3y4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=q7pHytij; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OoNHn3y4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=q7pHytij; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OoNHn3y4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="q7pHytij";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OoNHn3y4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="q7pHytij"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A9BB95C010;
	Sun,  3 May 2026 18:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777832255; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AsKSGKv1gbQ1kxj3oO+fSJmap4EgBc+0PTi6YnXpoZE=;
	b=OoNHn3y4rN894Hek56TAHXPlCqi/IQ1Uo/ALP1kQg3A/6zShv94jQjNfaUtelYYh+YOGMu
	YeRcyoqLNAZBC2BP6OBIZWp0DepiBiJDwjmpOTSysVRWSzDWf2mNm6RtcDBCZaXZCcT03y
	JNuY4E27lqaHD9OEaIdKjcy6iTWHDa0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777832255;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AsKSGKv1gbQ1kxj3oO+fSJmap4EgBc+0PTi6YnXpoZE=;
	b=q7pHytijoJfoB1JUwtZq+JLzu+1pit499ofgLxkX0CU8I3YxZ3scCg1SxCoipgJc/00K6j
	CBR8iE/NRq1ZfJBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777832255; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AsKSGKv1gbQ1kxj3oO+fSJmap4EgBc+0PTi6YnXpoZE=;
	b=OoNHn3y4rN894Hek56TAHXPlCqi/IQ1Uo/ALP1kQg3A/6zShv94jQjNfaUtelYYh+YOGMu
	YeRcyoqLNAZBC2BP6OBIZWp0DepiBiJDwjmpOTSysVRWSzDWf2mNm6RtcDBCZaXZCcT03y
	JNuY4E27lqaHD9OEaIdKjcy6iTWHDa0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777832255;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AsKSGKv1gbQ1kxj3oO+fSJmap4EgBc+0PTi6YnXpoZE=;
	b=q7pHytijoJfoB1JUwtZq+JLzu+1pit499ofgLxkX0CU8I3YxZ3scCg1SxCoipgJc/00K6j
	CBR8iE/NRq1ZfJBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 93C8F593A8;
	Sun,  3 May 2026 18:17:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id a28LJD+R92kuFQAAD6G6ig
	(envelope-from <jack@suse.cz>); Sun, 03 May 2026 18:17:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2B30FA078B; Sun, 03 May 2026 15:13:04 +0200 (CEST)
Date: Sun, 3 May 2026 15:13:04 +0200
From: Jan Kara <jack@suse.cz>
To: Matthew Wilcox <willy@infradead.org>
Cc: Barry Song <baohua@kernel.org>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, david@kernel.org, ljs@kernel.org, liam@infradead.org, 
	vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com, 
	jack@suse.cz, pfalcato@suse.de, wanglian@kylinos.cn, chentao@kylinos.cn, 
	lianux.mm@gmail.com, kunwu.chan@gmail.com, liyangouwen1@oppo.com, chrisl@kernel.org, 
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com, bhe@redhat.com, 
	youngjun.park@lge.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
Message-ID: <yezmezj26xntushmylductlmytfgvwsnbnzlhffkfwugfxkt6m@gleq22spziyk>
References: <20260430040427.4672-1-baohua@kernel.org>
 <afNM-gIqxpyJ6ro7@casper.infradead.org>
 <CAGsJ_4w0qcYmukHqsyRd0jomoyYkJjOt8b-Cgp53BgP-8QQghw@mail.gmail.com>
 <afS_L-5XeWIldTXA@casper.infradead.org>
 <CAGsJ_4wk=SDtgin+84Ev2TamU-JFfmrg_SUay=-tcYmnFvK6Nw@mail.gmail.com>
 <afTpoL3FklpQZNMM@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afTpoL3FklpQZNMM@casper.infradead.org>
X-Spam-Score: -2.30
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	R_RATELIMIT(0.00)[to_ip_from(RLhrg5631p11qpq785u7koq73u)];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,kvack.org,infradead.org,google.com,suse.com,suse.cz,suse.de,kylinos.cn,gmail.com,oppo.com,tencent.com,huaweicloud.com,redhat.com,lge.com,lists.infradead.org,vger.kernel.org,lists.linux.dev,lists.ozlabs.org];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,infradead.org:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO

On Fri 01-05-26 18:57:52, Matthew Wilcox wrote:
> On Sat, May 02, 2026 at 01:44:34AM +0800, Barry Song wrote:
> > On Fri, May 1, 2026 at 10:57 PM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Fri, May 01, 2026 at 06:49:58AM +0800, Barry Song wrote:
> > > > 1. There is no deterministic latency for I/O completion. It depends on
> > > > both the hardware and the software stack (bio/request queues and the
> > > > block scheduler). Sometimes the latency is short; at other times it can
> > > > be quite long. In such cases, a high-priority thread performing operations
> > > > such as mprotect, unmap, prctl_set_vma, or madvise may be forced to wait
> > > > for an unpredictable amount of time.
> > >
> > > But does that actually happen?  I find it hard to believe that thread A
> > > unmaps a VMA while thread B is in the middle of taking a page fault in
> > > that same VMA.  mprotect() and madvise() are more likely to happen, but
> > > it still seems really unlikely to me.
> > 
> > It doesn’t have to involve unmapping or applying mprotect to
> > the entire VMA—just a portion of it is sufficient.
> 
> Yes, but that still fails to answer "does this actually happen".  How much
> performance is all this complexity in the page fault handler buying us?
> If you don't answer this question, I'm just going to go in and rip it
> all out.

I fully agree with you we should verify whether the retry code still brings
in real-world advantage today with VMA locks. After all the retry logic has
been introduced in 2010. That being said if there are realistic loads where
one thread needs VMA write lock while another thread is faulting the VMA,
then the latencies can be indeed extreme. For example things like cgroup IO
throttling happen on the IO path and thus can throttle IO of a low-priority
thread for a long time.

BTW I'm not sure I quite understand Barry's priority inversion problem
since I'd expect all threads of a task to generally be treated with the
same priority...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
