Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FE53A784E;
	Tue,  8 Sep 2026 07:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788854145; cv=none; b=fY/KxEgadpe8nL8jqvRJxYQ7iWH58JlRjPx1mlP7cJvVP73JpuqqeGgJGYNs52XSeo8gmRYnlSZ6EzRgmsHnq8/M/COOQS1EoGYejH74j8P8/ld5bcJ7pMBOSg/knujaPeAOdxOHBXyVBZnR/WrFdF1dRNdHfYkjxqO7ayPgRdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788854145; c=relaxed/simple;
	bh=MSPURKxSHbdvBRQY9rT7DI+SwAuPBuipMVVDS70t2Xc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zn7hltuBDFBx3bUc3nXC9ri3Qkkw0lLd0loiRQ2SSyfVX/4nl4KvAt0qs+z+KIXsUIbvHVs0B/ncrYf/Irujg1lb9MG0NlbFdpj1tGslVsiM0UZ1TNcUIR6+yf1hBIRKJozOOkWzN/7fOqfKmEpYBBXfBwJrridJZklaVHsqdMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aibw55aV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aibw55aV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F3C1F00A3A;
	Tue,  8 Sep 2026 07:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788854143;
	bh=+z/W0SyogxAbXELZ8t1ZssTfimRFsPFk5JDyvb71aNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Aibw55aVzuncFoqY/O0hYQQB0/O43/vaI9PhWMKkcNFwVlbWbhT6CGhChSUX7M9+N
	 dpiaYMM1PpymYnfVaGijOm/xiD4Ab7ceySQHOJCbWM7mfEXrr8GgYgxgGEiSLcvfpe
	 o7rkqmRz/aOWv6WO8J83j1YL3nGsFtQApzatCAk1iYSCUyg/Nr7zH7zYYUNLWyNbL0
	 xSAeu+j1qWcgsrT0R3bze1sfwMWvj+VqbwFLKY64oOhZP2eyap/4GAkrrsxswA0eC2
	 meloyVlB+pXTSVTv3BP4DvmEA82i2lAXaxabPLGB83Tm8g4C2Em6npv2XvPfpkBmVE
	 ZWnKnp+JxdEWg==
Date: Tue, 8 Sep 2026 10:55:36 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	David Hildenbrand <david@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 1/4] KVM: s390: Replace get_zeroed_page() with
 kzalloc() for the STHYI buffer
Message-ID: <ap-_eN-RcdeNg6SW@kernel.org>
References: <20260906-s390-kvm-v2-0-2cf6434e6646@kernel.org>
 <20260906-s390-kvm-v2-1-2cf6434e6646@kernel.org>
 <dcb5547b-a04b-4991-a581-e3784ccfe303@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcb5547b-a04b-4991-a581-e3784ccfe303@linux.ibm.com>

On Mon, Sep 07, 2026 at 02:23:02PM +0200, Janosch Frank wrote:
> On 9/6/26 10:27 AM, Mike Rapoport (Microsoft) wrote:
> > handle_sthyi() allocates the buffer that receives the STHYI response
> > block before it is copied to the guest.
> > 
> > This buffer can be allocated with kmalloc() as there's nothing special
> > about it to go directly to the page allocator.
> > 
> > kmalloc() provides a better API that does not require ugly casts and
> > kfree() does not need to know the size of the freed object.
> > 
> > Performance difference between kmalloc() and __get_free_pages() is not
> > measurable as both allocators take an object/page from a per-CPU list for
> > fast path allocations.
> > 
> > For the slow path the performance is anyway determined by the amount of
> > reclaim involved rather than by what allocator is used.
> > 
> > The only goto in that function does not unwind anything, it merely skips
> > to the exit when the function code is invalid. Turn it into an early
> > return so that the buffer can be freed with __free(kfree).
> > 
> > Replace use of get_zeroed_page() with kzalloc() and free_page() with
> > kfree().
> > 
> > Assisted-by: copilot:claude-opus
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Yup, there's no alignment requirement anyway.
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
> 
> 
> 
> Looking at the kernel's sthyi.c there are a couple more locations we could
> change:
> 
> I don't see a need for the syscall to allocate a page and the cache doesn't
> need page allocation either. We should even be able to have them byte

That's planned :)
I'm splitting this project into small chunks to ease both my review of what
LLM did and to avoid patch bombs that are hard to review for everyone.

> aligned since they are never the destination for one of the diagnose
> instructions, a kvzalloc should be fine if I didn't miss something...

For PAGE_SIZE allocations kvzalloc() will kzalloc() anyway, so I'd rather
use the latter explicitly. 
 
> Diag224 needs a 4k aligned 31-bit physical address for some reason so that
> needs GFP_DMA. diag204 is vmallocing anyway since subcode 7 uses logical
> addresses.

Actually __vmalloc_node() seems a bit odd there :)
Plain vmalloc() would do the same.

-- 
Sincerely yours,
Mike.
