Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD7129D27D;
	Mon, 22 Jun 2026 14:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782139824; cv=none; b=YCd828ArFFg9DuSTT40X31NmCxHoenVSNmdF9f91hOfgnsTFwJeNkGL8Akx58Q3WrgSrJoXps8ajXOJwmfQFRYH8jS1G/4BIBGfu+uX2QdMw2ECgnWFEYX8B4XS930NheDcpxKnx1RdpRbesidDvIvS+BWgWl6CLcJUNRtF7Yvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782139824; c=relaxed/simple;
	bh=/SrCoAsoB14wPKY7tOCIz77shFno0oDfEISaZZ78C5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fbBnKAhJCpmVhOarVto6UvnevReV1UYejzpcy/wvXXYUhrMvOkklC3p2ElXi/7Hix8oFHULXJ0SLMcO+T6egZkCDI+aJEFM4v2SL2LeBU1hCFvjVD3FReuZJyN6MbdcSlWfERRtvwJi7aE53fidRBq+gBd07TEpYkHaR0u0zPUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JK+kFtzl; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JK+kFtzl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=5FxiXI2Cp5YdtBkdSD+qNScBXccHcZeYoAW8t2qi+Yc=; b=JK+kFtzlUAONUzDRoTzYX+brhD
	GKFH0RfbSzUM95BSOrozCSCjOw8vzTHXTIm39G4MXXyBXkGQxtrTmVgQzvzmmmeBEBPZ5Y830BVuk
	fl7AcG6/bn+wbK2Lu1KCjHNA0aPKVEZY6qTmdbEyqF8o+9MMHqTDUmuXwOB5rkZLoDq8h5WSGs3eG
	EZGd4nIcvKQn1H7UodiJAGUOAIvYYdKLQi5gwAqTUvXspEktsI80PoQ3S8uztj6P35PIEY+OtzAci
	pFgaZPJGW47T+bbX3mwQZ0H9RhR2jZxYGZuhZyHbY8K0S/+O2urv10M2x7CACas7uQMjPhjDb5t0L
	Sbnx7uoA==;
Received: from [38.23.173.23] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbfyR-00000005693-3OS3;
	Mon, 22 Jun 2026 14:50:07 +0000
Date: Mon, 22 Jun 2026 10:50:02 -0400
From: "Liam R. Howlett" <liam@infradead.org>
To: Barry Song <baohua@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, 
	Suren Baghdasaryan <surenb@google.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, akpm@linux-foundation.org, linux-mm@kvack.org, vbabka@kernel.org, 
	rppt@kernel.org, mhocko@suse.com, jack@suse.cz, pfalcato@suse.de, 
	wanglian@kylinos.cn, chentao@kylinos.cn, lianux.mm@gmail.com, kunwu.chan@gmail.com, 
	liyangouwen1@oppo.com, chrisl@kernel.org, kasong@tencent.com, shikemeng@huaweicloud.com, 
	nphamcs@gmail.com, bhe@redhat.com, youngjun.park@lge.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	Nanzhe Zhao <nzzhao@126.com>
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
Message-ID: <c5soxcu245cerfljr2ddto4h7xqksfxzxti47mq6sqn6pnmnxh@th5kxapvnaj3>
References: <ag4h87CBd-gph9zX@casper.infradead.org>
 <CAGsJ_4zA8afu0xXy0WS+tMe-eesDX1W6UBmfAsuouUpcAgK8JQ@mail.gmail.com>
 <ag4kj84EcKqamdB-@casper.infradead.org>
 <3be9475b-0e8a-4df8-a130-4262f993973d@kernel.org>
 <CAGsJ_4xC5LdhuoWV1=tK-RZ5rkjc8aOKOkmb1L_8BG_3gtJhDg@mail.gmail.com>
 <ahB6QyHgYq8ksj65@lucifer>
 <CAGsJ_4zxLvZ01i19vdo0xA47T1hxa1VRYvxLmiDhy5q1GDKPRg@mail.gmail.com>
 <CAJuCfpHTxaU4KdNmefU7C7cWZSLCFDLPdUrnqV6yzxzN+8RQ0Q@mail.gmail.com>
 <ajhOUdbWsswgQyl2@casper.infradead.org>
 <CAGsJ_4ybg5LGYopTUJTh5R2rN6X3uR9xoJSL+RdTYVtm1-xqLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4ybg5LGYopTUJTh5R2rN6X3uR9xoJSL+RdTYVtm1-xqLg@mail.gmail.com>

On 26/06/22 08:15AM, Barry Song wrote:
> On Mon, Jun 22, 2026 at 4:49 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Sat, Jun 20, 2026 at 04:48:57PM -0700, Suren Baghdasaryan wrote:
> > > Just checking in on the followup plans. IIUC the RFC mentioned will
> > > try to implement the solution we discussed at LSFMM: splitting
> > > VM_FAULT_RETRY into two flags - one for retrying under per-VMA locks
> > > and another one to fallback to mmap_lock.
> >
> > I continue to hate this idea.  I don't believe that those who were
> > pushing for it have ever tried to understand the whole fault path.
> > It's utterly byzantine.
> >
> > I defy anyone to make sense of this:
> >
> >         /*
> >          * NOTE! This will make us return with VM_FAULT_RETRY, but with
> >          * the fault lock still held. That's how FAULT_FLAG_RETRY_NOWAIT
> >          * is supposed to work. We have way too many special cases..
> >          */
> >         if (vmf->flags & FAULT_FLAG_RETRY_NOWAIT)
> >                 return 0;
> >
> >         *fpin = maybe_unlock_mmap_for_io(vmf, *fpin);
> >         if (vmf->flags & FAULT_FLAG_KILLABLE) {
> >                 if (__folio_lock_killable(folio)) {
> >                         /*
> >                          * We didn't have the right flags to drop the
> >                          * fault lock, but all fault_handlers only check
> >                          * for fatal signals if we return VM_FAULT_RETRY,
> >                          * so we need to drop the fault lock here and
> >                          * return 0 if we don't have a fpin.
> >                          */
> >                         if (*fpin == NULL)
> >                                 release_fault_lock(vmf);
> >                         return 0;
> >                 }
> >
> > Wed need to simplify the fault path, not add additional complexity.
> > Josef has said he wouldn't've done the lock dropping had we had per-VMA
> > locks.  We should rip it out.
> 
> I think you have agreed that, at least for anon vma, we can
> keep the current policy, since anon vma is much more volatile
> than file vma.

I don't think any of the above has to do with anon vmas.  Does any anon
vma handling have anything to do with your problem?

This would be needed if anon vmas were being faulted while being
unmapped or merged?  Do we really need a fast path for that?  Note that
anon vmas cannot be merged if the vma chain... you know what, I wonder
how many people know what I'm talking about here... Let's just say that
they can't be merged if they were around for a fork.

So, then, we're looking at anon vmas taking the mmap lock on:
1. single task anon vmas being expanded and faulted at the same time
2. single task anon vmas being unmapped and faulted at the same time

I think that's it?

But maybe I missed something critical about your use case here?

I don't understand why you are involving anon vmas in this discussion,
so I must have missed something with your IO completion issue.  Is there
an anon vma causing your priority inversion?

> Concurrent page faults and VMA modifications can happen more
> often than with file VMAs.

But it's only a problem for anon vmas with per-vma locking if it's the
same vma (or the vma lock sequence counter overflows, but let's say
that's a statistically insignificant non-zero value).

> 
> For file vmas, how much code can we actually remove, given that
> the first page fault might already be holding mmap_lock?

How much complexity can we remove and maintain the performance, might be
a better question.

> It could be the case that lock_vma_under_rcu() fails, and then
> on the first page fault we end up holding mmap_lock before
> retrying. So are we also going to rip out the lock release,
> even if it risks holding mmap_lock for a long time?
> 
>         vma = lock_vma_under_rcu(mm, addr);
>         if (!vma)
>                 goto lock_mmap;
>        ...
> lock_mmap:
> 
>         vma = lock_mm_and_find_vma(mm, addr, regs);
>         if (unlikely(!vma)) {
>                 fault = 0;
>                 si_code = SEGV_MAPERR;
>                 goto bad_area;
>         }
> 
> If we still need to keep the page fault retry code there, it
> doesn't seem like "ripping out" really reduces complexity in
> the page fault code?

This seems unrelated to be above complexity that might be the target of
removal?

Thanks,
Liam

