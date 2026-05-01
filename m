Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1687C9463;
	Fri,  1 May 2026 17:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777658298; cv=none; b=sX6p1cxQCCMaOZRQQ9PmMHck4CUxLq9OQZaMdwVcyLtR2BflnDJaZjkhobwWwjRMGslMKpocjVg+Uw2FvlzofPgHaSB/9UPvp8nwUsPU0LvcnPiLQPsvdp1dY3IqiWCc8W6L/uuRjjdBFP+bgQdz7s+Cq86vHdLa1UE8RGAKyPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777658298; c=relaxed/simple;
	bh=L2Ai0rss00lHVHyU9nqIjQFpeDBC5UekkeW9+Y/JMgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WEkCCfO6b+eXe39sZlmN0bTTMffhNvMs8LF/uasXzzSYNdhfWVl7Fw6RDwphpis6aSkb5HqFW6XaacE/ydjMIQvqOgUT+SsDuwn9gAfldrr3Bi7InLdhvITkH09OXHniD/DjDu5GvDkLBhpvtjnptn1B1xgW2mVmE2pOon3nglA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cS0FYwD2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cS0FYwD2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=u/+O11I2l5uEWQtHiF9iLIDtrtif7F+7W2x9HgtS2Zk=; b=cS0FYwD2XOEYVbuKnpFKh9ZiSM
	0EwDyUhzf4L/Z7u5RfwH9F/lLM1NhuqZPIwTkUmNl1PS4VMevXWN1PepuvnRy9E8BXEEBe1NqpbST
	JCuDyJciLjPMlOgK/msGkQ/Etm/ww5vna/xrv//xWjQSuG3YKtTWGFNZVR8+M3tsp34wr0aQKFWkJ
	uFsTeHHXdKUGothOh1mQqNx0qA+TQ+SY8myKKpSqt0cEDRnA3Sr7IVPyxsjySvvgY2FjAsXzlkA0p
	PsB/KjAACHCD+NoUMzQlqunyAml2flv3i9OPzaSZZMasw49lDXCUAuGtnBBvR4d+htLsXvVM7+CgM
	/hohbFOw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIs7c-000000098SG-2Rmh;
	Fri, 01 May 2026 17:57:52 +0000
Date: Fri, 1 May 2026 18:57:52 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Barry Song <baohua@kernel.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, david@kernel.org,
	ljs@kernel.org, liam@infradead.org, vbabka@kernel.org,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, jack@suse.cz,
	pfalcato@suse.de, wanglian@kylinos.cn, chentao@kylinos.cn,
	lianux.mm@gmail.com, kunwu.chan@gmail.com, liyangouwen1@oppo.com,
	chrisl@kernel.org, kasong@tencent.com, shikemeng@huaweicloud.com,
	nphamcs@gmail.com, bhe@redhat.com, youngjun.park@lge.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
Message-ID: <afTpoL3FklpQZNMM@casper.infradead.org>
References: <20260430040427.4672-1-baohua@kernel.org>
 <afNM-gIqxpyJ6ro7@casper.infradead.org>
 <CAGsJ_4w0qcYmukHqsyRd0jomoyYkJjOt8b-Cgp53BgP-8QQghw@mail.gmail.com>
 <afS_L-5XeWIldTXA@casper.infradead.org>
 <CAGsJ_4wk=SDtgin+84Ev2TamU-JFfmrg_SUay=-tcYmnFvK6Nw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4wk=SDtgin+84Ev2TamU-JFfmrg_SUay=-tcYmnFvK6Nw@mail.gmail.com>

On Sat, May 02, 2026 at 01:44:34AM +0800, Barry Song wrote:
> On Fri, May 1, 2026 at 10:57 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Fri, May 01, 2026 at 06:49:58AM +0800, Barry Song wrote:
> > > 1. There is no deterministic latency for I/O completion. It depends on
> > > both the hardware and the software stack (bio/request queues and the
> > > block scheduler). Sometimes the latency is short; at other times it can
> > > be quite long. In such cases, a high-priority thread performing operations
> > > such as mprotect, unmap, prctl_set_vma, or madvise may be forced to wait
> > > for an unpredictable amount of time.
> >
> > But does that actually happen?  I find it hard to believe that thread A
> > unmaps a VMA while thread B is in the middle of taking a page fault in
> > that same VMA.  mprotect() and madvise() are more likely to happen, but
> > it still seems really unlikely to me.
> 
> It doesn’t have to involve unmapping or applying mprotect to
> the entire VMA—just a portion of it is sufficient.

Yes, but that still fails to answer "does this actually happen".  How much
performance is all this complexity in the page fault handler buying us?
If you don't answer this question, I'm just going to go in and rip it
all out.

> BTW, the chain can propagate: a page fault occurs, B wants to write this
> VMA, and C (a higher-priority task) wants to write another VMA. D may need
> to iterate VMAs under mmap_lock, so B can end up blocking both C and D.

I know.
