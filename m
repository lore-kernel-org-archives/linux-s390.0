Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09ADD31714B;
	Mon, 18 May 2026 09:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779097629; cv=none; b=eGIeJ511aM7lTtj6/iAnrsstmYcCbY4N8MNUpoaOa7hjJcTKiBt+5/6d+WzsirBJBlOyR4mHjoMb487Wj6ER1g90XeJSrmCjknQGOhrJkyurLcCgzTwXpLzjnfFw1imNYXcI5Tr+ANnJ4gm/z7AqSu9hHg0yyaL416k0nzUjBWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779097629; c=relaxed/simple;
	bh=TG4jY49etADdd0W92AOWeHiLbA5nZOb/ARZcjnb31oU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IlhzKMGr0AuZnPueQhd/a9mpfA/+rTTS8WDVGINySazP6bldlvUbyW9oDNgb/3ur5ia9mkwn/qHNtI+yw/EN27JIJDe0CYVHBRJrK/0O1AKi8hnI5UJOCXwEA+HlUPLBRZGhC4KwQ0gcv5I1mreLxH1hPguHB6pU3TbtUDDZlPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vQJ0arCr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQJ0arCr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68AFAC2BCB7;
	Mon, 18 May 2026 09:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779097628;
	bh=TG4jY49etADdd0W92AOWeHiLbA5nZOb/ARZcjnb31oU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vQJ0arCrP/xBPlP5xYCcSSm/fS+QQUbWLyhqiDIrU88DmvTAFFSm30+Xht992Kwkr
	 skPTdxS4IrMJ+p5tztV/luY0iNJBbYXUE/c8+gstKuaH8hi9y+Mgq2xBBpJ3ADVJs7
	 ZCI2TQ1MeRf+U2+0uF/4b9BlIJuAH+0Z2Wi/G40INZkrBzkH/PD0+ypSZP4/Fk+Kxe
	 Xp/7tp+4rG7efDwwY87OsxwuUVOB9eHt9qUSqLvldLdv2/QVprIE0DCJVhFMfpWFP/
	 hXJ3evSbQlYMMWAjGszf1ccS6LkTIDY+CHhyS99vXL1+9ZkBTzfrKsyfLU8JAER3+q
	 xVpAdvt8jECkg==
Date: Mon, 18 May 2026 10:46:59 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Barry Song <baohua@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, surenb@google.com, 
	akpm@linux-foundation.org, linux-mm@kvack.org, david@kernel.org, liam@infradead.org, 
	vbabka@kernel.org, rppt@kernel.org, mhocko@suse.com, jack@suse.cz, pfalcato@suse.de, 
	wanglian@kylinos.cn, chentao@kylinos.cn, lianux.mm@gmail.com, kunwu.chan@gmail.com, 
	liyangouwen1@oppo.com, chrisl@kernel.org, kasong@tencent.com, shikemeng@huaweicloud.com, 
	nphamcs@gmail.com, bhe@redhat.com, youngjun.park@lge.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	Nanzhe Zhao <nzzhao@126.com>
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
Message-ID: <agrWuDNGddNmvMFD@lucifer>
References: <20260430040427.4672-1-baohua@kernel.org>
 <afNM-gIqxpyJ6ro7@casper.infradead.org>
 <CAGsJ_4w0qcYmukHqsyRd0jomoyYkJjOt8b-Cgp53BgP-8QQghw@mail.gmail.com>
 <afS_L-5XeWIldTXA@casper.infradead.org>
 <CAGsJ_4wk=SDtgin+84Ev2TamU-JFfmrg_SUay=-tcYmnFvK6Nw@mail.gmail.com>
 <afTpoL3FklpQZNMM@casper.infradead.org>
 <CAGsJ_4ysMcrmDLSOwBkf7qwCQrcDWeEMXkHDajTJFMLKUk0bSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4ysMcrmDLSOwBkf7qwCQrcDWeEMXkHDajTJFMLKUk0bSQ@mail.gmail.com>

On Sun, May 17, 2026 at 04:45:15PM +0800, Barry Song wrote:
> On Sat, May 2, 2026 at 1:58 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Sat, May 02, 2026 at 01:44:34AM +0800, Barry Song wrote:
> > > On Fri, May 1, 2026 at 10:57 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > >
> > > > On Fri, May 01, 2026 at 06:49:58AM +0800, Barry Song wrote:
> > > > > 1. There is no deterministic latency for I/O completion. It depends on
> > > > > both the hardware and the software stack (bio/request queues and the
> > > > > block scheduler). Sometimes the latency is short; at other times it can
> > > > > be quite long. In such cases, a high-priority thread performing operations
> > > > > such as mprotect, unmap, prctl_set_vma, or madvise may be forced to wait
> > > > > for an unpredictable amount of time.
> > > >
> > > > But does that actually happen?  I find it hard to believe that thread A
> > > > unmaps a VMA while thread B is in the middle of taking a page fault in
> > > > that same VMA.  mprotect() and madvise() are more likely to happen, but
> > > > it still seems really unlikely to me.
> > >
> > > It doesn’t have to involve unmapping or applying mprotect to
> > > the entire VMA—just a portion of it is sufficient.
> >
> > Yes, but that still fails to answer "does this actually happen".  How much
> > performance is all this complexity in the page fault handler buying us?
> > If you don't answer this question, I'm just going to go in and rip it
> > all out.
> >
>
> Hi Matthew (and Lorenzo, Jan, and anyone else who may be
> waiting for answers),
>
> As promised during LSF/MM/BPF, we conducted thorough
> testing on Android phones to determine whether performing
> I/O in `filemap_fault()` can block `vma_start_write()`.
> I wanted to give a quick update on this question.
>
> Nanzhe at Xiaomi created tracing scripts and ran various
> applications on Android devices with I/O performed under
> the VMA lock in `filemap_fault()`. We found that:
>
> 1. There are very few cases where unmap() is blocked by
>    page faults. I assume this is due to buggy user code
>    or poor synchronization between reads and unmap().
> So I assume it is not a problem.
>
> 2. We observed many cases where `vma_start_write()`
>    is blocked by page-fault I/O in some applications.
>    The blocking occurs in the `dup_mmap()` path during
>    fork().
>
> With Suren's commit fb49c455323ff ("fork: lock VMAs of
> the parent process when forking"), we now always hold
> `vma_write_lock()` for each VMA. Note that the
> `mmap_lock` write lock is also held, which could lead to
> chained waiting if page-fault I/O is performed without
> releasing the VMA lock.

Hm but did you observe this 'chained waiting'? And what were the latencies?

>
> My gut feeling is that Suren's commit may be overshooting,
> so my rough idea is that we might want to do something like
> the following (we haven't tested it yet and it might be
> wrong):

Yeah I'm really not sure about that.

Prior to the VMA locks, the mmap write lock would have guaranteed no concurrent
page faults, which is really what fb49c455323ff is about.

So Suren's patch was essentially restoring the _existing_ forking behaviour, and
now you're saying 'let's change the forking behaviour that's been like that for
forever'.

I think you would _really_ have to be sure that's safe. And forking is a very
dangerous time in terms of complexity and sensitivity and 'weird stuff'
happening so I'd tread _very_ carefully here.

>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 2311ae7c2ff4..5ddaf297f31a 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1762,7 +1762,13 @@ __latent_entropy int dup_mmap(struct mm_struct
> *mm, struct mm_struct *oldmm)
>         for_each_vma(vmi, mpnt) {
>                 struct file *file;
>
> -               retval = vma_start_write_killable(mpnt);
> +               /*
> +                * For anonymous or writable private VMAs, prevent
> +                * concurrent CoW faults.
> +                */

To nit pick I think the comment's confusing but also tells you you don't need to
specific anon check - writable private is sufficient. And it's not really just
CoW that's the issue, it's anon_vma population _at all_ as well as CoW.

> +               if (!mpnt->vm_file || (!(mpnt->vm_flags & VM_SHARED) &&
> +                                       (mpnt->vm_flags & VM_WRITE)))
> +                       retval = vma_start_write_killable(mpnt);

I think this has to be VM_MAYWRITE, because somebody could otherwise mprotect()
it R/W.

I also don't understand why !mpnt->vm_file for a read-only anon mapping (more
likely PROT_NONE) is here, just do the second check?

(Also please use the new interface, so !vma_test(mpnt, VMA_SHARED_BIT) &&
vma_test(mpnt, VMA_MAYWRITE_BIT))

>                 if (retval < 0)
>                         goto loop_out;
>                 if (mpnt->vm_flags & VM_DONTCOPY) {
>
> Based on the above, we may want to re-check whether fork()
> can be blocked by page faults. At the same time, if Suren,
> you, or anyone else has any comments, please feel free to
> share them.
>
> Best Regards
> Barry

Technical commentary above is sort of 'just cos' :) because I really question
doing this honestly.

I'd also like to get Suren's input, however.

Thanks, Lorenzo
