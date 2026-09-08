Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFADC563FAB;
	Tue,  8 Sep 2026 14:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788876397; cv=none; b=iLSQpzCq5+z8CAcuJlg9T7+cnST9Ic/GJN2/dkg9lXVjpKe9VdTOAE7ctolxWeSY2KlYP01XWLmklbKCs/j3Pg5oajJJkUaR82Hk2VWMzDUVnw9Q2hHJV6l4tOg42UUtdTCHLvs2hbFqxK6I9zc3SIhihVQooG9g2PeKgsWU7uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788876397; c=relaxed/simple;
	bh=lKE8pTQb3SU3IlL3dMd1xcdSlzS75G2aqEM8bP8RQjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJBrrGef/tr7U9tDFBJivB5XS6oWB+DwU9DwdZti8oUsP1Rs2dsnYlkx0FBaAqHFfsNUfEqP6KO+FeZ0UtyTT9df29Vlub6wuqdhO59vC7ZJ9gmnpTZWk33JHZOGolDPQ/SEmpq2b++OH6RKBDxEhzz0dqHAvMPbF+DbmndHDCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B66881F00A3A;
	Tue,  8 Sep 2026 14:06:08 +0000 (UTC)
Date: Tue, 8 Sep 2026 17:05:44 +0300
From: Mike Rapoport <rppt@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Adrian =?utf-8?Q?Barna=C5=9B?= <abarnas@google.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Alexandre Ghiti <alex@ghiti.fr>, Andy Lutomirski <luto@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
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
Subject: Re: [PATCH v3 4/6] mm/vmalloc: make set_area_direct_map HUGE_VMAP
 friendly
Message-ID: <aqAWOKZDiHE9ksrM@kernel.org>
References: <20260903-execmem-set-vm-perms-v0-2-v3-0-949b64a9f755@kernel.org>
 <20260903-execmem-set-vm-perms-v0-2-v3-4-949b64a9f755@kernel.org>
 <2b0f5877-e71a-4824-adeb-5af2dd8b0269@kernel.org>
 <ap_tjOTR48tja_8e@kernel.org>
 <d379aae2-4249-4c6a-a748-5419d4f74f34@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d379aae2-4249-4c6a-a748-5419d4f74f34@kernel.org>

On Tue, Sep 08, 2026 at 01:48:36PM +0200, David Hildenbrand (Arm) wrote:
> On 9/8/26 13:12, Mike Rapoport wrote:
> > On Tue, Sep 08, 2026 at 12:41:48PM +0200, David Hildenbrand (Arm) wrote:
> >> On 9/3/26 11:28, Mike Rapoport (Microsoft) wrote:
> >>> set_area_direct_map() always updates direct map alias permissions in
> >>> single page increments.
> >>>
> >>> For HUGE_VMAP areas it's suboptimal. Not only the loop in
> >>> set_area_direct_map() needlessly has more iterations (e.g times 512 on
> >>> x86), but it also causes fragmentation of the direct map that could be
> >>> avoided for the HUGE_VMAP areas populated with large pages.
> >>>
> >>> All pages in an area are always of the same order: either same-order
> >>> large pages when VM_ALLOW_HUGE_VMAP is set and all huge pages were
> >>> successfully allocated, or order-0 page when VM_ALLOW_HUGE_VMAP is
> >>> cleared or when huge pages allocation fails and fallback path is taken.
> >>>
> >>> Instead of updating the direct map permissions for every order-0 page in
> >>> an area, use the area's page_order as the loop increment and update the
> >>> large pages in one call to set_direct_map_{invalid,default}_noflush().
> >>>
> >>> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> >>> ---
> >>>  mm/vmalloc.c | 13 ++++++++-----
> >>>  1 file changed, 8 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> >>> index 5506b180f5c27..6ed6c160abed7 100644
> >>> --- a/mm/vmalloc.c
> >>> +++ b/mm/vmalloc.c
> >>> @@ -3367,12 +3367,15 @@ static inline void set_area_direct_map(const struct vm_struct *area,
> >>>  				       int (*set_direct_map)(struct page *page,
> >>>  							     unsigned int nr))
> >>>  {
> >>> -	unsigned long i;
> >>> +	unsigned int nr = (1U << vm_area_page_order(area));
> >>> +
> >>> +	for (unsigned long i = 0; i < area->nr_pages; i += nr) {
> >>> +		if (page_address(area->pages[i])) {
> >>> +			int err = set_direct_map(area->pages[i], nr);
> >>
> >> Do we really expect some pages to have a directmap and others not?
> > 
> > Every page in the area can be allocated separately and
> > __vmalloc_area_node() has
> > 
> > 	if (!(gfp_mask & (GFP_DMA | GFP_DMA32)))
> > 		gfp_mask |= __GFP_HIGHMEM;
> > 
> > so generally speaking yes :)
> 
> Ah, I was thinking in terms of HUGE_VMAP, because there we sure would expect
> all-or-nothing, right?

Even with VM_ALLOW_HUGE_VMAP an area may be backed by highmem pages. When
huge allocations are disabled either because an architecture does not
support them or nohugevmalloc=no, vmalloc(VM_ALLOW_HUGE_VMAP) silently
falls back to order-0 allocations.
 
> -- 
> Cheers,
> 
> David

-- 
Sincerely yours,
Mike.
