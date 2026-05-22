Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E24256C61;
	Fri, 22 May 2026 15:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779464373; cv=none; b=nGHGMg4NwvFlC3CQquDX+k8RPtsoXMuxgROBnYwf/ZCUPcPGkOCmvc3vOMXYTDLK0MKZ3A8egiJ5MPgi0zwC4X1TjEuPMstPA+m6uq/u0cKwwGmKgjEFdujr0jgct9dbse/sZ8GVYdND3l0Xyx5NtrVJV+TH9dpZu/4lgQQa3Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779464373; c=relaxed/simple;
	bh=PhXZNDewQIU/RtpMf+wfAqV2sivH+vGmM2cktxerE4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k4/EqNfwudZnwB71N5pIsze/WVf+5hmUEW1mmWtFL/VdckMDwzSA0jczBsmGC1ZEMQWMzkkSf12PKi2g+dYG54PhsLWWa3Ij3YqUYiINi8vtg6P0XffNoTmvjhAj6uQNv4zkFZOBoZ058hm1ryI8laPrn4IcFrlh1bcOUPaFZa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i257pqtM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i257pqtM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A38B41F000E9;
	Fri, 22 May 2026 15:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779464370;
	bh=PhXZNDewQIU/RtpMf+wfAqV2sivH+vGmM2cktxerE4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=i257pqtM2kYPACyD1ngfUggI4iSRxqjUdYlFKKxzVufZViVIVT2xBOEl0SpU6DInE
	 ROGVAZb/3/W0IvbwFMxor6HFcVcNrG5Q21A1mRVWwKOQBsih1iPdGeTznGeoJB3DO+
	 Fn3PvCB8+2fNVtuS/MJbVyshSkcM02OLF0I9W6ZI0pMtT9j53IMpWiV0ZX8JC6M9P/
	 FaQjM533MNXthFgpwvWbAxK8bl8eUM9XMOgr6DAoXK73ugQpZzruTM8OshFacd6BC7
	 PNNlBh7PgBgxYyU+EgAcx28busgrsz6DinxYMoEk9F2NneTnICrdURcILPdeHr1TFa
	 GSUpZYp++RtDg==
Date: Fri, 22 May 2026 16:39:20 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Barry Song <baohua@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
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
Message-ID: <ahB4fJkNVH2UIglX@lucifer>
References: <CAGsJ_4w0qcYmukHqsyRd0jomoyYkJjOt8b-Cgp53BgP-8QQghw@mail.gmail.com>
 <afS_L-5XeWIldTXA@casper.infradead.org>
 <CAGsJ_4wk=SDtgin+84Ev2TamU-JFfmrg_SUay=-tcYmnFvK6Nw@mail.gmail.com>
 <afTpoL3FklpQZNMM@casper.infradead.org>
 <CAGsJ_4ysMcrmDLSOwBkf7qwCQrcDWeEMXkHDajTJFMLKUk0bSQ@mail.gmail.com>
 <agrWuDNGddNmvMFD@lucifer>
 <CAGsJ_4zqLfdWoTH9s7FFaqWWj0mESfikYgr7=GcV64qcuXrPxA@mail.gmail.com>
 <CAJuCfpE0WQrB3zJp9qn3jvn5DthS=ttpX7gJJvyEhA_BJGrp5g@mail.gmail.com>
 <agxbq1TxJdniMQT3@lucifer>
 <CAJuCfpG2Zmpf5N_ejB6ZDv8LDjpVtTfA_tYQ6sW+Noc9Y+XhdA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpG2Zmpf5N_ejB6ZDv8LDjpVtTfA_tYQ6sW+Noc9Y+XhdA@mail.gmail.com>

On Wed, May 20, 2026 at 05:51:23AM +0000, Suren Baghdasaryan wrote:
> On Tue, May 19, 2026 at 12:53 PM Lorenzo Stoakes <ljs@kernel.org> wrote:
> >
> > On Mon, May 18, 2026 at 12:56:59PM -0700, Suren Baghdasaryan wrote:
> >
> > > >
> > > > I think we either need to fix `fork()`, or keep the current
> > > > behavior of dropping the VMA lock before performing I/O.
> > >
> > > I see. So, this problem arises from the fact that we are changing the
> > > pagefaults requiring I/O operation to hold VMA lock...
> > > And you want to lock VMA on fork only if vma_is_anonymous(vma) ||
> > > is_cow_mapping(vma->vm_flags). So, we will be blocking page faults for
> > > anonymous and COW VMAs only while holding mmap_write_lock, preventing
> > > any VMA modification. On the surface, that looks ok to me but I might
> > > be missing some corner cases. If nobody sees any obvious issues, I
> > > think it's worth a try.
> >
> > Not sure if you noticed but I did raise concerns ;)
>
> Sorry, I didn't realize your first comment was a conceptual objection
> to this approach of allowing page faults to race with the fork.

Ah yeah it's understandable I think there's been so many threads in this
conversation that it's easy to get lost :)

>
>
> >
> > I wonder if you've confused the fault path and fork here, as I think Barry has
> > been a little unclear on that.
> >
> > What's being suggested in this thread is to fundamentally change fork behaviour
> > so it's different from the entire history of the kernel (or - presumably - at
> > least recent history :) and permit concurrent page faults to occur on a forking
> > process.
> >
> > I absolutely object to this for being pretty crazy. I mean I'm not sure we
> > really want to be simultaneously modifying page tables while invoking
> > copy_page_range()? No?
> >
> > OK you cover anon and MAP_PRIVATE file-backed but hang on there's
> > VM_COPY_ON_FORK too.. so PFN mapped, mixed map and (the accursed) UFFD W/P as
> > well as possibly-guard region containing VMAs now can have page tables raced.
>
> Ugh, yeah, I realize now this is a minefield. Resolving all possible
> races there would not be trivial and might introduce other performance
> issues.

Yeah, it's dangerous waters :)

>
> >
> > That's not to mention anything else that relies on serialisation here (this
> > would be changing how forking has been done in general) that we may or may not
> > know about.
> >
> > The risk level is high, for what amounts to a hack to work around the fault
> > issue.
> >
> > I suggest that if we have a problem with the fault path, let's look at the fault
> > path :)
> >
> > So yeah I'm very opposed to this unless I'm somehow horribly mistaken here or a
> > very convincing argument is made.
>
> So, current approach of dropping locks during I/O sounds like still
> the best solution.

Yeah _of those proposed_ I think importantly. This doesn't mean there aren't
other potential solutions.

Thanks, Lorenzo

>
> >
> >
> > >
> > >
> > >
> > >
> > > >
> > > > >
> > > > > I'd also like to get Suren's input, however.
> > > >
> > > > Yes. of course.
> > > >
> > > > >
> > > > > Thanks, Lorenzo
> > > >
> > > > Best Regards
> > > > Barry
> >
> > Cheers, Lorenzo
