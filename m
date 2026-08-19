Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C8B2F549F;
	Wed, 19 Aug 2026 07:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787122902; cv=none; b=aMQqvJraTBt46mT0ej0gPC2vpgZBaQodiIg1HG/OJc3YcxpLbatez6ixlGyG/8mJJCCKwnatd5ZIcYFTE6Vb+08OSpIOEOOB41OXXojHDc/rZXmk4W1OTK+yC4u7neBaZ8YoZ14obDY1pIwfOWXdY0UYwkhgqRKrRj2XRWTekQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787122902; c=relaxed/simple;
	bh=Hj4Wel8J4WuqBVGvWrT9ncwHdXK0JXgeZUnIar7dycU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VhdgO3bPA5y5KfLSC4rlHaW/OpqkKvXG8/thj6R1SjqH4lHa7pmhU55saJsuEQV52SDYzeq2u+LQ58z7AJzy4UbkXjxs9EN0OtfGDb6GcEvAcOJq70+oNyXp4gVgqzBAggeWwU8BNTwfXJ8wHBJqxJYvrvkFp3utYRAPvwZDXSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W218OjmE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W218OjmE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0E0F1F000E9;
	Wed, 19 Aug 2026 07:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787122900;
	bh=aMKxJGzD04KmpYdtuo6wR1wjBXa3j2PKTFpPFdjXzYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=W218OjmEyHpxk8/viVdeC99qw0slMQEIeb88kkfoCArZxB5b+ptrrTJCAevq6VxDC
	 vMLWsCTCZofQBaxR8oOPqWS3kHD49USp31sbZl8DRPCFt4KACVCCQrNyM/PgNyaQHR
	 VkV0HOObXqdXGCJvNJhTxaqj9fmO35W5uT1jdRtJNLUOb/HjegZxblTMNGIV/GVRRM
	 flhucOwsPBVMpfnwxRKIG1ToXGaPjBMWqxwbx+olsHHxa7QcV4g0KWxIkN0N9mv8Xz
	 L8AUvX3FOqiw4smqbYXS27a0Eeumx4rnsMmynElmR0J9GQkX0rxY+csbE6hJYTSs4X
	 O/LT5KmkF12xg==
Date: Wed, 19 Aug 2026 10:01:25 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Brendan Jackman <brendan.jackman@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Adrian =?utf-8?Q?Barna=C5=9B?= <abarnas@google.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Alexandre Ghiti <alex@ghiti.fr>, Andy Lutomirski <luto@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@kernel.org>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Len Brown <lenb@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Vasily Gorbik <gor@linux.ibm.com>, WANG Xuerui <kernel@xen0n.name>,
	Will Deacon <will@kernel.org>, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-pm@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	loongarch@lists.linux.dev
Subject: Re: [PATCH 4/6] mm/vmalloc: make set_area_direct_map HUGE_VMAP
 friendly
Message-ID: <aoVUxU8NJuxP21tk@kernel.org>
References: <20260816-execmem-set-vm-perms-v0-2-v1-0-90944a3ad43f@kernel.org>
 <20260816-execmem-set-vm-perms-v0-2-v1-4-90944a3ad43f@kernel.org>
 <DKR7R0BECQXX.2FCNF36EFETS8@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DKR7R0BECQXX.2FCNF36EFETS8@linux.dev>

On Mon, Aug 17, 2026 at 02:21:41PM +0200, Brendan Jackman wrote:
> On Sun Aug 16, 2026 at 12:59 PM CEST, Mike Rapoport (Microsoft) wrote:
> > set_area_direct_map() always updates direct map alias permissions in
> > single page increments.
> >
> > For HUGE_VMAP areas it's suboptimal. Not only the loop in
> > set_area_direct_map() needlessly has more iterations (e.g times 512 on
> > x86), but it also causes fragmentation of the direct map that could be
> > avoided for the HUGE_VMAP areas populated with large pages.
> >
> > All pages in an area are always of the same order: either same-order
> > large pages when VM_ALLOW_HUGE_VMAP is set and all huge pages were
> > successfully allocated, or order-0 page when VM_ALLOW_HUGE_VMAP is
> > cleared or when huge pages allocation fails and fallback path is taken.
> >
> > Instead of updating the direct map permissions for every order-0 page in
> > an area, use the area's page_order as the loop increment and update the
> > large pages in one call to set_direct_map_{invalid,default}_noflush().
> >
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > ---
> >  mm/vmalloc.c | 13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> >
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index fc7993db4152..11170d1ee5be 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -3361,12 +3361,15 @@ static inline void set_area_direct_map(const struct vm_struct *area,
> >  				       int (*set_direct_map)(struct page *page,
> >  							     unsigned int nr))
> >  {
> > -	unsigned long i;
> > +	unsigned int nr = (1U << vm_area_page_order(area));
> > +
> > +	for (unsigned long i = 0; i < area->nr_pages; i += nr) {
> > +		if (page_address(area->pages[i])) {
> > +			int err = set_direct_map(area->pages[i], nr);
> >  
> > -	/* HUGE_VMALLOC passes small pages to set_direct_map */
> > -	for (i = 0; i < area->nr_pages; i++)
> > -		if (page_address(area->pages[i]))
> > -			set_direct_map(area->pages[i], 1);
> > +			WARN_ON_ONCE(err);
> 
> Nit: Maybe worth a comment on why this is expected to always succeed?
> I.e. I think we are assuming the only failure mode is allocation but 
> because we know vm_area_page_order() there shouldn't be any allocation?

The assumption we relying on is more involved, but yeah, I can add a
comment. 

-- 
Sincerely yours,
Mike.
