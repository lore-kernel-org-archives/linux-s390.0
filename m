Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A8934040B;
	Tue, 19 May 2026 13:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779197988; cv=none; b=P6zgOHQwoDkNESqwOPxxg1ZmTCm95SMNQ7SNuXDnUw0cxBWAPalsxYPREFUoqp2L8DNQyez65BCQjuoB+HH7DUsFLWgP28sCWKCBitj4LxH+WPhtg4OKkfxBJgEgrF/QiJkiS8GVytXrVedXXy/C0drz/E8EZcg37H8XKjKBHMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779197988; c=relaxed/simple;
	bh=D+t330bY9theuHhQ7vQ9fk2hC/8pGFvUL2f87DQe0QQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aOH4RkprtJBlFlocEpeH3CI33bzUqbo5dKQhJk7JWmalLEGcqQMN4dtE7tISGyVqDelWKTiuCOwfyYBqFLHnZiS3srhWw0VPYwH9EtGNgpAuq6eWexJt9ZM901TrgiDplA63dYJmPDHOrLExE8It8J4ZUigMysJ1ZIfgH5FTrdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZePrlUUj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZePrlUUj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70FE8C2BCB3;
	Tue, 19 May 2026 13:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779197988;
	bh=D+t330bY9theuHhQ7vQ9fk2hC/8pGFvUL2f87DQe0QQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZePrlUUjoJ6SRML9KTxFEObiSG/GUCVskJopia2OR/NHWF6W+fo2AUoXx/To3zWWb
	 VdFfdF5cL7Dr7E5H6/FcZR0Mk/DI7CxgdxvQLx0rIlIz9/yGZtLcI+6fw3Px7X5xRS
	 /+pxvp2iSCV6J2igJobyEQO5YqAqmSCe5Fdrd4BbRBbRPRUfOZzFXyT8bjqBKlkoGV
	 FFVFOTFSR+yl/lIgyRxF273rU0nwoh/xIf98oDAucm/68fnhiB5diwWjSDoZ0rVmam
	 MgNbD3EuMgIzR9wpMwcKmyM2IpEgfnF1Pv+9MLoF6/BTWGGcSu0LjK+iIfhejRQJxJ
	 nEGvcqVGx0kUA==
Date: Tue, 19 May 2026 14:39:38 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Yang Shi <shy828301@gmail.com>
Cc: Barry Song <baohua@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	surenb@google.com, akpm@linux-foundation.org, linux-mm@kvack.org, david@kernel.org, 
	liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, mhocko@suse.com, 
	jack@suse.cz, pfalcato@suse.de, wanglian@kylinos.cn, chentao@kylinos.cn, 
	lianux.mm@gmail.com, kunwu.chan@gmail.com, liyangouwen1@oppo.com, chrisl@kernel.org, 
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com, bhe@redhat.com, 
	youngjun.park@lge.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, Nanzhe Zhao <nzzhao@126.com>
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
Message-ID: <agxnJ8R-G3CRjeTR@lucifer>
References: <20260430040427.4672-1-baohua@kernel.org>
 <afNM-gIqxpyJ6ro7@casper.infradead.org>
 <CAGsJ_4w0qcYmukHqsyRd0jomoyYkJjOt8b-Cgp53BgP-8QQghw@mail.gmail.com>
 <afS_L-5XeWIldTXA@casper.infradead.org>
 <CAGsJ_4wk=SDtgin+84Ev2TamU-JFfmrg_SUay=-tcYmnFvK6Nw@mail.gmail.com>
 <afTpoL3FklpQZNMM@casper.infradead.org>
 <CAGsJ_4ysMcrmDLSOwBkf7qwCQrcDWeEMXkHDajTJFMLKUk0bSQ@mail.gmail.com>
 <CAHbLzkrOSoh-jmR=uaNvx73n_wn+vExoKY0UzH5zGcfdAiDbNg@mail.gmail.com>
 <agxfLNuLCAT3F4cW@lucifer>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agxfLNuLCAT3F4cW@lucifer>

On Tue, May 19, 2026 at 02:12:10PM +0100, Lorenzo Stoakes wrote:
> On Mon, May 18, 2026 at 02:21:14PM -0700, Yang Shi wrote:
> > Maybe a little bit off topic. This is an interesting idea. It seems
> > possible we don't have to take vma write lock unconditionally. IIUC
> > the write lock is mainly used to serialize against page fault and
> > madvise, right? I got a crazy idea off the top of my head. We may be
>
> Err no, it serialises against literally any modification or read of any
> characteristic of VMAs.
>
> > able to just take vma write lock iff vma->anon_vma is not NULL.
>
> Except if we don't take it and vma->anon_vma is NULL, then somebody can
> anon_vma_prepare() and change vma->anon_vma midway through a fork and completely
> screw up the anon_vma fork hierarchy.

correction: this won't happen as per Barry (see - I managed to confuse myself
here :), since for vma->anon_vma install we take the mmap read lock.

BUT we also have to consider other cases.

>
> So no.
>
> >
> > First of all, write mmap_lock is held, so the vma can't go or be
> > changed under us.
>
> vma->anon_vma can be changed.

Correction: no it can't :)

>
> >
> > Secondly, if vma->anon_vma is NULL, it basically means either no page
> > fault happened or no cow happened, so there is no page table to copy,
> > this is also what copy_page_range() does currently. So we can shrink
> > the critical section to:
>
> Firstly, with no VMA write lock, !vma->anon_vma means a fault can race and
> secondly copy_page_range() checks vma_needs_copy(), there are other cases - PFN
> maps, mixed maps, UFFD W/P (ugh), guard regions.
>
> So yeah this isn't sufficient.

However this is true...

>
> >
> > if (vma->anon_vma) {
> >     vma_start_write_killable(src_vma);
> >     anon_vma_fork(dst_vma, src_vma);
> >     copy_page_range(dst_vma, src_vma);
> > }
>
> Yeah that's totally broken fo reasons above as I said :)
>
> >
> > But page fault can happen before write mmap_lock is taken, when we
> > check vma->anon_vma, it is possible it has not been set up yet. But it
> > seems to be equivalent to page fault after fork and won't break the
> > semantic.
>
> It will totally break how the anon_vma hierarchy works :) See the links at the
> top of https://ljs.io/talks for a link to various slides on anon_vma behaviour
> (it's really a pain to think about because it's a super broken abstraction).
>
> You could end up with a CoW mapping that's unreachable from rmap and you could
> get some nasty issues with page table entries pointing at freed folios :)

Correction: actually we should be safe given mmap read lock on anon_vma install.

>
> >
> > Anyway, just a crazy idea, I may miss some corner cases.
>
> Yeah sorry to push back here but this is just not a viable approach.
>
> And this is forgetting that we have relied on page faults being blocked by fork
> _forever_, who knows what else has baked in assumptions about that
> serialisation.
>
> Forking is one of the nastiest parts of mm and has had multiple, subtle, corner
> case breakages that have been a nightmare to deal with.
>
> So I'm very much against changing this behaviour to try to fix something in the
> fault path.
>
> We should address the fault path issues in the fault path :)

Above still all true though.

>
> >
> > Thanks,
> > Yang
> >
> > }
> >
> > >
> > > Based on the above, we may want to re-check whether fork()
> > > can be blocked by page faults. At the same time, if Suren,
> > > you, or anyone else has any comments, please feel free to
> > > share them.
> > >
> > > Best Regards
> > > Barry
> > >
>
> Cheers, Lorenzo

So still a nope :)

Cheers, Lorenzo
