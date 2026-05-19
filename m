Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2DF3EE1E5;
	Tue, 19 May 2026 12:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779195226; cv=none; b=OgU6aknKTY6sDnFloADf/zaec9n4LjmiJ0E++HzRzBurKJJ0o7U5ldiUws9lLOugjzVnIbi7bXGws+APjy1XugtqvtdSeqvyw3FNYPcnRRaICVq+t0qboAWhOogrCQLF1ofw7vHN/YGXPg3C+Kpo5ccwQe1lQaMoJl8HXdHxyy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779195226; c=relaxed/simple;
	bh=TWIr4MBWXFvB87XL0FdioP0FNTIlJtiR/wiwlQFXNPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ofwZnK3MDS2aCPW3K+uRwKr5jntBVPqY/jtn+wfSOGZ+dtkFml6z9LMo8VPrm/lbrJ1mbs5N7ox05r6Ttl9A3e05DYcog/qXsUjv5rKCJs1u5lMH95sTH0o6kCilgxYjw2rfc498UliQonJvsvwJIUpSsglsUj+TkG8trpiTOLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLI0FZjw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLI0FZjw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72C81C2BCB3;
	Tue, 19 May 2026 12:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779195226;
	bh=TWIr4MBWXFvB87XL0FdioP0FNTIlJtiR/wiwlQFXNPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MLI0FZjwvoL5JToMb00i26zGbDKR5eFTRY9x7LCaeGUN+sYUX8fzz+RnEI5gPwclG
	 94gIHQBg5cOT7eMp2oQzs8eGOxkU1JO1Kcb+sxUNWdlfQYLhFP9l/TwBAiy20kt84O
	 II+rfpB4Co8rMtxuvCVJIOREAlO6IJ8YUAuKE7eYLlErSw63NgBTZSC12q0IgIdIFV
	 yyM5qbUtJcli+VfLGIS8ETLLylKZavBDZX7hHEAiuwPsjuPIavN0UPjxGKNCNPRKJl
	 BlwtrnFUq9/ePp3NnvDShqo/+UYXBFU69SGJ0VF2IQoRPjHMIREZ4zRu4MIgZ6ZSoW
	 N/xrCUg0I4CsA==
Date: Tue, 19 May 2026 13:53:36 +0100
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
Message-ID: <agxbq1TxJdniMQT3@lucifer>
References: <20260430040427.4672-1-baohua@kernel.org>
 <afNM-gIqxpyJ6ro7@casper.infradead.org>
 <CAGsJ_4w0qcYmukHqsyRd0jomoyYkJjOt8b-Cgp53BgP-8QQghw@mail.gmail.com>
 <afS_L-5XeWIldTXA@casper.infradead.org>
 <CAGsJ_4wk=SDtgin+84Ev2TamU-JFfmrg_SUay=-tcYmnFvK6Nw@mail.gmail.com>
 <afTpoL3FklpQZNMM@casper.infradead.org>
 <CAGsJ_4ysMcrmDLSOwBkf7qwCQrcDWeEMXkHDajTJFMLKUk0bSQ@mail.gmail.com>
 <agrWuDNGddNmvMFD@lucifer>
 <CAGsJ_4zqLfdWoTH9s7FFaqWWj0mESfikYgr7=GcV64qcuXrPxA@mail.gmail.com>
 <CAJuCfpE0WQrB3zJp9qn3jvn5DthS=ttpX7gJJvyEhA_BJGrp5g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpE0WQrB3zJp9qn3jvn5DthS=ttpX7gJJvyEhA_BJGrp5g@mail.gmail.com>

On Mon, May 18, 2026 at 12:56:59PM -0700, Suren Baghdasaryan wrote:

> >
> > I think we either need to fix `fork()`, or keep the current
> > behavior of dropping the VMA lock before performing I/O.
>
> I see. So, this problem arises from the fact that we are changing the
> pagefaults requiring I/O operation to hold VMA lock...
> And you want to lock VMA on fork only if vma_is_anonymous(vma) ||
> is_cow_mapping(vma->vm_flags). So, we will be blocking page faults for
> anonymous and COW VMAs only while holding mmap_write_lock, preventing
> any VMA modification. On the surface, that looks ok to me but I might
> be missing some corner cases. If nobody sees any obvious issues, I
> think it's worth a try.

Not sure if you noticed but I did raise concerns ;)

I wonder if you've confused the fault path and fork here, as I think Barry has
been a little unclear on that.

What's being suggested in this thread is to fundamentally change fork behaviour
so it's different from the entire history of the kernel (or - presumably - at
least recent history :) and permit concurrent page faults to occur on a forking
process.

I absolutely object to this for being pretty crazy. I mean I'm not sure we
really want to be simultaneously modifying page tables while invoking
copy_page_range()? No?

OK you cover anon and MAP_PRIVATE file-backed but hang on there's
VM_COPY_ON_FORK too.. so PFN mapped, mixed map and (the accursed) UFFD W/P as
well as possibly-guard region containing VMAs now can have page tables raced.

That's not to mention anything else that relies on serialisation here (this
would be changing how forking has been done in general) that we may or may not
know about.

The risk level is high, for what amounts to a hack to work around the fault
issue.

I suggest that if we have a problem with the fault path, let's look at the fault
path :)

So yeah I'm very opposed to this unless I'm somehow horribly mistaken here or a
very convincing argument is made.


>
>
>
>
> >
> > >
> > > I'd also like to get Suren's input, however.
> >
> > Yes. of course.
> >
> > >
> > > Thanks, Lorenzo
> >
> > Best Regards
> > Barry

Cheers, Lorenzo
