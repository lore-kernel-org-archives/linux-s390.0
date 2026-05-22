Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5704A42314D;
	Fri, 22 May 2026 15:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779464286; cv=none; b=QN8tYz/gRjjahU9BqRPZyiLX+18NdSYPedLedUFpDrxSu2eVHcjiVBDRR5lxIvvguRtUK6Gx1WwsOlgyVLbq20pD5XX9uNR7HH7v0y7enMGWIb1ZIYVjrqd7/3oJk4n95HzPM7/VOTgnfTnlNv9w6JojSHbpylj7OsLAUdQFXLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779464286; c=relaxed/simple;
	bh=HS5K7Miq/JgsqmZgZr78cHmi4Na5MhUbV3a81rxKXQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/0SUvfGgq+x0hNmFinKDnTNvbmgGWIb3Apl+POdlStFtzcBBba+o9HKMAs2euJDu5ssDyVn/od6obZHwCN+U+wEuG5daiQedjpc5S4iB1lVOkLJ0bYkzR4a8+F4zMM94tAkeo+blPM3bdCt+MdDuTs4S3rlIHtbOjYjEF7XjTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e3S85iit; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e3S85iit"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4206E1F000E9;
	Fri, 22 May 2026 15:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779464283;
	bh=Ue6+BrgA5cCiK29yEQFjVEW/61iWgshQWpISoK0a5mo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=e3S85iit9E//Da14omyK4sSzq5E+5P6CirUlrWrNKkWRCr0gH3q2SRSlfFihqMpFf
	 lNIJ+Ym6rgTd0CfoB7Pca50HGx7yg/Kc5w/2lEe4qOmRDVIKJHaZ2mwp0lyokkwzMM
	 6vLSr5NafsQy9TfFAYNw8jc2lOZNyREETBaXhqe0wsF6vVu5L5ph14ppOzYFh+6m+v
	 gJ/dcbqjjuTKEbZXZCc79Pa0JwpRwFDh/QUW0F5E1DEDjYhtDdgK1JyVd4OtmokLSn
	 On0u89WSmNioM38n363WRHRzMjaBZLPk3SQhu/mA8NqmleLSnwm2/5ltuBOTzidZnQ
	 dj5LZD2lAZZXQ==
Date: Fri, 22 May 2026 16:37:54 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Yang Shi <shy828301@gmail.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Barry Song <baohua@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, mhocko@suse.com, 
	jack@suse.cz, pfalcato@suse.de, wanglian@kylinos.cn, chentao@kylinos.cn, 
	lianux.mm@gmail.com, kunwu.chan@gmail.com, liyangouwen1@oppo.com, chrisl@kernel.org, 
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com, bhe@redhat.com, 
	youngjun.park@lge.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, Nanzhe Zhao <nzzhao@126.com>
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
Message-ID: <ahB3DSwipVXw6tmK@lucifer>
References: <afS_L-5XeWIldTXA@casper.infradead.org>
 <CAGsJ_4wk=SDtgin+84Ev2TamU-JFfmrg_SUay=-tcYmnFvK6Nw@mail.gmail.com>
 <afTpoL3FklpQZNMM@casper.infradead.org>
 <CAGsJ_4ysMcrmDLSOwBkf7qwCQrcDWeEMXkHDajTJFMLKUk0bSQ@mail.gmail.com>
 <agrWuDNGddNmvMFD@lucifer>
 <CAGsJ_4zqLfdWoTH9s7FFaqWWj0mESfikYgr7=GcV64qcuXrPxA@mail.gmail.com>
 <CAJuCfpE0WQrB3zJp9qn3jvn5DthS=ttpX7gJJvyEhA_BJGrp5g@mail.gmail.com>
 <agxbq1TxJdniMQT3@lucifer>
 <e6d1017a-e4c5-493e-bfca-932c6d64eaac@kernel.org>
 <CAHbLzkq3S7NDYe4LXjurKNQU+40-wtqrD_PT18YcyHbAcNxiRQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHbLzkq3S7NDYe4LXjurKNQU+40-wtqrD_PT18YcyHbAcNxiRQ@mail.gmail.com>

On Wed, May 20, 2026 at 02:39:49PM -0700, Yang Shi wrote:
> On Wed, May 20, 2026 at 3:34 AM David Hildenbrand (Arm)
> <david@kernel.org> wrote:
> >
> > On 5/19/26 14:53, Lorenzo Stoakes wrote:
> > > On Mon, May 18, 2026 at 12:56:59PM -0700, Suren Baghdasaryan wrote:
> > >
> > >>>
> > >>> I think we either need to fix `fork()`, or keep the current
> > >>> behavior of dropping the VMA lock before performing I/O.
> > >>
> > >> I see. So, this problem arises from the fact that we are changing the
> > >> pagefaults requiring I/O operation to hold VMA lock...
> > >> And you want to lock VMA on fork only if vma_is_anonymous(vma) ||
> > >> is_cow_mapping(vma->vm_flags). So, we will be blocking page faults for
> > >> anonymous and COW VMAs only while holding mmap_write_lock, preventing
> > >> any VMA modification. On the surface, that looks ok to me but I might
> > >> be missing some corner cases. If nobody sees any obvious issues, I
> > >> think it's worth a try.
> > >
> > > Not sure if you noticed but I did raise concerns ;)
> > >
> > > I wonder if you've confused the fault path and fork here, as I think Barry has
> > > been a little unclear on that.
> > >
> > > What's being suggested in this thread is to fundamentally change fork behaviour
> > > so it's different from the entire history of the kernel (or - presumably - at
> > > least recent history :)
> > I don't want fork() to become different in that regard.
> >
> > There is already a slight difference with vs. without per-VMA locks, because
> > there is a window in-between us taking the write mmap_lock and all the per-VMA
> > locks. I raised that previously [1] and assumed that it is probably fine.
> >
> > I also raised in the past why I think we must not allow concurrent page faults,
> > at least as soon as anonymous memory is involved [2].
>
> Thanks for sharing the context, it is quite helpful to understand the
> race conditions. Because Lorenzo also raised the concern about page
> fault race, I will reply to all the concerns regarding page fault race
> together in this thread.
>
> IIUC, there is already some sort of race with per vma lock. Before per
> vma lock, mmap_lock did lock everything. So page fault happened either
> before fork or after fork. But page fault can happen on other VMAs
> which have not been lock'ed yet during fork with per vma lock. For
> example, we have 3 VMAs, we lock the first VMA, but page fault still
> can happen on the other 2 VMAs during fork if they already have
> anon_vma. This is the status quo now, but it seems not harmful.
>
> The bad race shared by David is caused by racing with copy page. So it
> seems like it will be fine as long as we serialize copy page against
> page fault if I don't miss anything. Since we decide whether to copy
> page or not by checking vma->anon_vma, so it seems fine to not take
> vma lock if vma->anon_vma is NULL. This will not introduce more race
> either because setting up a new  anon_vma in page fault or madvise
> requires taking mmap_lock according to the earlier discussions.

NAK. No.

We're not doing this, we're not changing how fork fundamentally behaves because
of concerns about the fault path.

I've delineated exactly why I think this is a problem and you're pressing ahead
without addressing those concerns.

So at this point I'm going to be a grumpy maintainer and just say no, stop
please :)

Let's fix this in the right place. You don't fix a leak in the roof by repairing
a shelf next door :)

Thanks, Lorenzo


>
> Thanks,
> Yang
>
> >
> > ... and I raised that this is pretty much slower by design right now: "Well, the
> > design decision that CONFIG_PER_VMA_LOCK made for now to make page faults fast
> > and to make blocking any page faults from happening to  be slower ..." [3]
> >
> > [1] https://lore.kernel.org/all/970295ab-e85d-7af3-76e6-df53a5c52f8b@redhat.com/
> > [2] https://lore.kernel.org/all/7e3f35cc-59b9-bf12-b8b1-4ed78223844a@redhat.com/
> > [3] https://lore.kernel.org/all/2efa2c89-3765-721d-2c3c-00590054aa5b@redhat.com/
> >
> > --
> > Cheers,
> >
> > David
> >
