Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE76438FF5;
	Tue, 19 May 2026 12:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779194643; cv=none; b=JXtFZ9eENkYxcuc0EW1Btg4bDQmu2ZstqAobGaZM3xgUvWH0erC0xXEc2+/xm0EPsKjS7hW90/XK4AwzVHLq1zYs5+++5CBBuWpl9wMBQyLQ7GvYzFYaDyTsOYT39EPfhQ/jL3Fg5j3GjI71d+j71xCCUb626uI+A/GBlmV9nnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779194643; c=relaxed/simple;
	bh=kMUFbNwBqvJpO+Bjd3l9GBxXRf0w6ZacFORzSNgGrqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MlquNxUDO+J6B0Bvyp9AXEW3PazcENLI1DTV5caJsTcJwQs8IzDuTUcWDCwTegMdpSKTUCxmP7YPehWGUNpQRf1GuX4RiVvWh9/87RhinB39RyUN9VGn0g+V73jROF6ASGn518Px/mz0MU79imTMlsdulZefg05ij4dMR5ksXyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bfo4BDRf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bfo4BDRf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23CD8C2BCC6;
	Tue, 19 May 2026 12:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779194642;
	bh=kMUFbNwBqvJpO+Bjd3l9GBxXRf0w6ZacFORzSNgGrqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bfo4BDRfvA9myn7305sBhrTH2J0JJJLZN41DyiCsBL5RaW4yJzwWoRjqEv4bw7XRu
	 3sS6wrONgvzJAEmXQdyWNoxP7IRgXT+BwOJdEatfiHb5tGo3e7Wv57MRVS0Mfl/KwF
	 x37oBTK95eNvN0DhfsqWoIm8NOxS3mlo/N7lra4/86d92nRL8dOyMRTzXe4aNafoSP
	 zmYFhFt5OepkId8YyQ/JRMelvQ33s7dDez4kr7Q7tGi40FybpnQQzZ966Ac5xeTssH
	 5GqAFt9tX2CAZo6ci+b6JD7q1AC8DXMlEmsrGOnNr7zIOL1N/xCP/W2AdAHZDtwZKR
	 +0JGj8KZOVUKg==
Date: Tue, 19 May 2026 13:43:52 +0100
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
Message-ID: <agxXPfG--tkoPynl@lucifer>
References: <20260430040427.4672-1-baohua@kernel.org>
 <afNM-gIqxpyJ6ro7@casper.infradead.org>
 <CAGsJ_4w0qcYmukHqsyRd0jomoyYkJjOt8b-Cgp53BgP-8QQghw@mail.gmail.com>
 <afS_L-5XeWIldTXA@casper.infradead.org>
 <CAGsJ_4wk=SDtgin+84Ev2TamU-JFfmrg_SUay=-tcYmnFvK6Nw@mail.gmail.com>
 <afTpoL3FklpQZNMM@casper.infradead.org>
 <CAGsJ_4ysMcrmDLSOwBkf7qwCQrcDWeEMXkHDajTJFMLKUk0bSQ@mail.gmail.com>
 <agrWuDNGddNmvMFD@lucifer>
 <CAGsJ_4zqLfdWoTH9s7FFaqWWj0mESfikYgr7=GcV64qcuXrPxA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4zqLfdWoTH9s7FFaqWWj0mESfikYgr7=GcV64qcuXrPxA@mail.gmail.com>

On Mon, May 18, 2026 at 07:25:54PM +0800, Barry Song wrote:
> On Mon, May 18, 2026 at 5:47 PM Lorenzo Stoakes <ljs@kernel.org> wrote:
> >
> > On Sun, May 17, 2026 at 04:45:15PM +0800, Barry Song wrote:
> > > On Sat, May 2, 2026 at 1:58 AM Matthew Wilcox <willy@infradead.org> wrote:
> > > >
> > > > On Sat, May 02, 2026 at 01:44:34AM +0800, Barry Song wrote:
> > > > > On Fri, May 1, 2026 at 10:57 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > > > >
> > > > > > On Fri, May 01, 2026 at 06:49:58AM +0800, Barry Song wrote:
> > > > > > > 1. There is no deterministic latency for I/O completion. It depends on
> > > > > > > both the hardware and the software stack (bio/request queues and the
> > > > > > > block scheduler). Sometimes the latency is short; at other times it can
> > > > > > > be quite long. In such cases, a high-priority thread performing operations
> > > > > > > such as mprotect, unmap, prctl_set_vma, or madvise may be forced to wait
> > > > > > > for an unpredictable amount of time.
> > > > > >
> > > > > > But does that actually happen?  I find it hard to believe that thread A
> > > > > > unmaps a VMA while thread B is in the middle of taking a page fault in
> > > > > > that same VMA.  mprotect() and madvise() are more likely to happen, but
> > > > > > it still seems really unlikely to me.
> > > > >
> > > > > It doesn’t have to involve unmapping or applying mprotect to
> > > > > the entire VMA—just a portion of it is sufficient.
> > > >
> > > > Yes, but that still fails to answer "does this actually happen".  How much
> > > > performance is all this complexity in the page fault handler buying us?
> > > > If you don't answer this question, I'm just going to go in and rip it
> > > > all out.
> > > >
> > >
> > > Hi Matthew (and Lorenzo, Jan, and anyone else who may be
> > > waiting for answers),
> > >
> > > As promised during LSF/MM/BPF, we conducted thorough
> > > testing on Android phones to determine whether performing
> > > I/O in `filemap_fault()` can block `vma_start_write()`.
> > > I wanted to give a quick update on this question.
> > >
> > > Nanzhe at Xiaomi created tracing scripts and ran various
> > > applications on Android devices with I/O performed under
> > > the VMA lock in `filemap_fault()`. We found that:
> > >
> > > 1. There are very few cases where unmap() is blocked by
> > >    page faults. I assume this is due to buggy user code
> > >    or poor synchronization between reads and unmap().
> > > So I assume it is not a problem.
> > >
> > > 2. We observed many cases where `vma_start_write()`
> > >    is blocked by page-fault I/O in some applications.
> > >    The blocking occurs in the `dup_mmap()` path during
> > >    fork().
> > >
> > > With Suren's commit fb49c455323ff ("fork: lock VMAs of
> > > the parent process when forking"), we now always hold
> > > `vma_write_lock()` for each VMA. Note that the
> > > `mmap_lock` write lock is also held, which could lead to
> > > chained waiting if page-fault I/O is performed without
> > > releasing the VMA lock.
> >
> > Hm but did you observe this 'chained waiting'? And what were the latencies?
>
> We have clearly observed that the `fork()` operations of many
> popular Android apps, such as iQiyi, Baidu Tieba, and 10086,
> end up waiting on page-fault (PF) I/O when the VMA lock is
> held during I/O operations. This has already become a
> practical issue. I also believe this can lead to chained
> waiting, since the global `mmap_lock` blocks all threads that
> need to acquire it.

I asked about the chained waiting :) I'm aware you've observed contention on
write lock, you said so in your LSF talk.

So have you observed that or is this a theory?

>
>
> >
> > >
> > > My gut feeling is that Suren's commit may be overshooting,
> > > so my rough idea is that we might want to do something like
> > > the following (we haven't tested it yet and it might be
> > > wrong):
> >
> > Yeah I'm really not sure about that.
> >
> > Prior to the VMA locks, the mmap write lock would have guaranteed no concurrent
> > page faults, which is really what Fb49c455323ff is about.
> >
> > So Suren's patch was essentially restoring the _existing_ forking behaviour, and
> > now you're saying 'let's change the forking behaviour that's been like that for
> > forever'.
>
>
> I am afraid not. Before we introduced the per-VMA lock, we
> were not performing I/O while holding `mmap_lock`. A page fault
> that needed I/O would drop the `mmap_lock` read lock and allow
> `fork()` to proceed.

Err I'm talking about fork? The patch you reference is a change to fork?

So you're saying that Fb49c455323ff which explicitly takes the VMA write lock on
fork, was somehow an addendum after fork didnt take the mmap write lock?

I must be imagining
https://elixir.bootlin.com/linux/v6.0/source/kernel/fork.c#L590 then in v6.0
pre-vma locks :)

I suspect that's _not_ what you're saying, so now what you're suggesting as I
stated above, is to fundamentally change fork behaviour to account for the
existing per-VMA lock behaviour on the fault path?

Again I state - are you really sure you want to fundamentally change fork
behaviour for this?

I am extremely concerned about doing that.

>
> Now, you are suggesting performing I/O while holding the VMA
> lock, which changes the requirements and introduces this
> problem.
>
> >
> > I think you would _really_ have to be sure that's safe. And forking is a very
> > dangerous time in terms of complexity and sensitivity and 'weird stuff'
> > happening so I'd tread _very_ carefully here.
>
> Yep. I think my original proposal did not require any changes
> to `fork()`, since it simply preserved the current behavior of
> dropping the VMA lock before performing I/O. In that model,
> `fork()` would not end up waiting on I/O at all.
>
> What you are suggesting now appears to be performing I/O while
> holding the VMA lock, which in turn introduces the need to
> change `fork()`.

Again, you're saying we should fundamentally change the way fork has worked
forever to work around something else.

At LSF I raised the fact that Josef himself suggested we simply drop this I/O
waiting behaviour for file-backed mapppings. Isn't there a way forward that way
rather than 'hey let's drop locks and hope for the best!'

I am really reticent about this because we've seen HORRIBLE bugs come from fork
behaviour, especially edge cases, and mm testing isn't great so I am basically
opposed to this, and you're not really convincing me here.

>
> >
> > >
> > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > index 2311ae7c2ff4..5ddaf297f31a 100644
> > > --- a/mm/mmap.c
> > > +++ b/mm/mmap.c
> > > @@ -1762,7 +1762,13 @@ __latent_entropy int dup_mmap(struct mm_struct
> > > *mm, struct mm_struct *oldmm)
> > >         for_each_vma(vmi, mpnt) {
> > >                 struct file *file;
> > >
> > > -               retval = vma_start_write_killable(mpnt);
> > > +               /*
> > > +                * For anonymous or writable private VMAs, prevent
> > > +                * concurrent CoW faults.
> > > +                */
> >
> > To nit pick I think the comment's confusing but also tells you you don't need to
> > specific anon check - writable private is sufficient. And it's not really just
> > CoW that's the issue, it's anon_vma population _at all_ as well as CoW.
> >
> > > +               if (!mpnt->vm_file || (!(mpnt->vm_flags & VM_SHARED) &&
> > > +                                       (mpnt->vm_flags & VM_WRITE)))
> > > +                       retval = vma_start_write_killable(mpnt);
> >
> > I think this has to be VM_MAYWRITE, because somebody could otherwise mprotect()
> > it R/W.
> >
> > I also don't understand why !mpnt->vm_file for a read-only anon mapping (more
> > likely PROT_NONE) is here, just do the second check?
> >
> > (Also please use the new interface, so !vma_test(mpnt, VMA_SHARED_BIT) &&
> > vma_test(mpnt, VMA_MAYWRITE_BIT))
>
> Yep, I can definitely refine the check further. But before
> doing that, I'd first like to confirm that we are aligned on
> the direction.
>
> If you still intend to hold the VMA lock while performing I/O,
> then I think we should fix `fork()` to avoid taking
> `vma_start_write()`.

Yeah or we could do something different, it isn't a case of you get to do one of
two options you propose - the maintainers decide which way is appropriate.

Of the two options dropping the lock on the fault path rather than this fork
insanity is my preference but I wonder if we can't find another way.

Let me read through the series and give more thoughts I guess.

>
> >
> > >                 if (retval < 0)
> > >                         goto loop_out;
> > >                 if (mpnt->vm_flags & VM_DONTCOPY) {
> > >
> > > Based on the above, we may want to re-check whether fork()
> > > can be blocked by page faults. At the same time, if Suren,
> > > you, or anyone else has any comments, please feel free to
> > > share them.
> > >
> > > Best Regards
> > > Barry
> >
> > Technical commentary above is sort of 'just cos' :) because I really question
> > doing this honestly.
>
> I think we either need to fix `fork()`, or keep the current
> behavior of dropping the VMA lock before performing I/O.

Yup you said :)

>
> >
> > I'd also like to get Suren's input, however.
>
> Yes. of course.
>
> >
> > Thanks, Lorenzo
>
> Best Regards
> Barry

Thanks, Lorenzo
