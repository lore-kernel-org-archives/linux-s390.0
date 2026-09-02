Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB76149F10B;
	Wed,  2 Sep 2026 13:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788355033; cv=none; b=AqMLYZ5Mpclb01sHsogRsHpkt+1AQ6vEiNVkHOB9vUhqDcT2JPYUB7ZgT7yiaNudLDx+Q/BqkE5TYbtiBiQzl3nFHws248Q+FXnEOfeLE58HXbJhgidvX6k3dsEUB1gsZuRWsvGOp3tnH+Cn9shuCSFmyR4T8Ti1CkD4x097LOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788355033; c=relaxed/simple;
	bh=kXh6rWORmdnjlnIdwcKwUW2cG0cItVUQLZSC2ADV19E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LehTYefz3g+Mu4PEeROz0Dvd7lU3+jjtzaQK6ZWvxulzMHTtzdtK+Ib7QVyf9L5xnMbP86umsycEVW/mFJ5Fx6M+RChz/qQa4k4aCmzTfKWlztu7sEtkr4ek/WOeiOZun015aP7O0P4HIgUooOG4XYyoWH1rd+h7melkvMbj+ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCmlo0IB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCmlo0IB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2FFE1F00A3F;
	Wed,  2 Sep 2026 13:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788355031;
	bh=bXBMYuHpZzsw8EGad/hvSHpqzpcAdq2l3BIwxOjmYnc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CCmlo0IBLlh99KpsraxIshQySbpVOt7wo3AbgXvMMm64IlRuM8+U/mJU0jkD3S2vd
	 X7qJ+g/Is1lBaZqPXMtdfb5t8p5ByfyeWPOOPbvCcxq7LFOn6muJpVGJ/EwRyCrFf1
	 uCUF95sa3LdhmEc9e/R0lELT8YFOBwtWPXhOPIhdXTZImP2XedR6LTaSOfDo5gpq0l
	 gaRQgBFj2G/6mJ8fIdlUnMJS0f8+O0wLVB7Cy0+eD7lyvftqdBBUUslyiFcOvdeNTA
	 9Nbp/in1vcFKDSfw3Sd/6+cncOjVKHVHet75vXYoVVLC/vHHmtoCY5WEIq49+tJdy0
	 R8L/bjySoAZQg==
Date: Wed, 2 Sep 2026 16:17:03 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	David Hildenbrand <david@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH 0/4] KVM: s390: replace page allocator calls with
 kzalloc()
Message-ID: <apghz4XAgv0ro15t@kernel.org>
References: <20260902-s390-kvm-v1-0-3bc0986550b1@kernel.org>
 <20260902130612.41500808@p-imbrenda>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902130612.41500808@p-imbrenda>

On Wed, Sep 02, 2026 at 01:06:12PM +0200, Claudio Imbrenda wrote:
> On Wed, 02 Sep 2026 09:15:12 +0300
> "Mike Rapoport (Microsoft)" <rppt@kernel.org> wrote:
> 
> > This is a (small) part of larger work of replacing page allocator calls
> > with kmalloc.
> > 
> > My initial intention a few month ago was to remove ugly casts [1], but then
> > willy pointed out that Linus objected to something like this [2] and it
> > looks like more than a decade old technical debt.
> > 
> > Largely, anything that doesn't need struct page (or a memdesc in the
> > future) should just use kmalloc() or kvmalloc() to allocate memory.
> > kmalloc() guarantees alignment, physical contiguity and working
> > virt_to_phys() and beside nicer API that returns void * on alloc and
> > doesn't require to know the allocation size on free, kmalloc() provides
> > better debugging capabilities than page allocator.
> > 
> > Another thing is that touching these allocation sites gives the reviewers
> > opportunity to see if a PAGE_SIZE buffer is actually needed or maybe
> > another size is appropriate.
> > 
> > For larger allocations that don't need physically contiguous memory
> > kvmalloc() can be a better option that __get_free_pages() because under
> > memory pressure it's is easier to allocate several order-0 pages than a
> > physically contiguous chunk with the same number of pages.
> > 
> > And last, but not least, removing needless calls to page allocator should
> > help with memdesc (aka project folio) conversion. There will be way less
> > places to audit to see if the user was actually using struct page.
> 
> I have some objections to this series, but not because of what you are
> trying to do (which is actually nice).
> 
> I understand that you probably wanted to touch as little code as
> possible,

Yep :)

> but now since you're rewriting the allocations to use
> kmalloc.... I'd like them to be converted to use the __free(kvmalloc)

You mean __free(kfree)? Sure, I can look into it.

> system. It will make the code smaller, easier to read and understand,
> less prone to future errors, etc.
> 
> In some places the whole code flow can be simplified a lot.

-- 
Sincerely yours,
Mike.
