Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667D247F2DD;
	Mon, 14 Sep 2026 14:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789396055; cv=none; b=MTDv3+ASKCy9qp8BCFcuvHgIcMfgAVUSz7yY2OhQuY/r16zK5SpV/qbwzdXfVzeOoizx4FRongjDrzsmpiiZWn9xQLO0nAlLtKpCDgIodP/tDPpmWmfzVQuEVx9pB0EyMEzckEJlaWxtHh6ay3HVcoWGv3Bly3x1dPzU+7cwD1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789396055; c=relaxed/simple;
	bh=swvKZdKeKTW3RjsxpBakFJKw47629EQkRgg+kyo6zE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YIWCM5ruynPQbrTrNAj5ycM1I5a9koJtvVPK9XVDSZiqDNSFqcCaD4kgEPf4qvTtneaXGSXB9hZ1vHxZjFsEfVm+5/9h4EibZim2oWq4/N4OsGO/lf0LpOSVfT1y1lPBz4w0TInqdWDQFSKHgj0jHU8Rs0xTDG1/ZyrAyF++Pkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGxPcdJI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGxPcdJI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7501E1F00893;
	Mon, 14 Sep 2026 14:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789396053;
	bh=eufZ+ASnYJyxNHhoWXf4wfzOU/TuE1+5JzkzXKdwlfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EGxPcdJIgOssQEo0tzrSTwkEyUomMpmdg9u3TDfpxTQ2aaKynjVOPP95OoRNaMjK6
	 oz+iwBn8DWpUXme+Rzn6y/SZqjLgbvwRzsAawM2fznuutVD1x65tgqNcNuAXo2s2fx
	 8BJ2lpHKrwO3E7w9ziopxFfvdD7FTXnaMu/BUluyB/YnMLGpZO++qvx3LMdxlIUCax
	 EsqaVnunCK6ujBp040prnEiNo69vamvyVHWW+UfV/KHsuEySwjSYlXiJRoNSKcY8S9
	 y1KtHQIUY8EkkaJZ+rSW4hD6hDy8hP6GYu9gJPMs6O26VrpW/pwVwXEyAThOsPK5RI
	 NKHcn22skIEUQ==
Date: Mon, 14 Sep 2026 15:27:23 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Mark Rutland <mark.rutland@arm.com>, Nick Piggin <npiggin@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Marc Zyngier <maz@kernel.org>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	"David S. Miller" <davem@davemloft.net>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 27/39] mm: rename is_vm_hugetlb_page() to vma_is_hugetlb()
Message-ID: <aqgDqUuxX-7l8j5e@gremlin>
References: <20260908-b4-mmap-prepare-vma-flag-sanify-v1-0-dacf19cce22b@kernel.org>
 <20260908-b4-mmap-prepare-vma-flag-sanify-v1-27-dacf19cce22b@kernel.org>
 <20260909130141.2c5d250d@p-imbrenda>
 <aqFDKJlj76O1hR2R@gremlin>
 <20260909152055.475f053c@p-imbrenda>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909152055.475f053c@p-imbrenda>

On Wed, Sep 09, 2026 at 03:20:55PM +0200, Claudio Imbrenda wrote:
> On Wed, 9 Sep 2026 12:30:45 +0100
> "Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:
>
> > On Wed, Sep 09, 2026 at 01:22:07PM +0200, Claudio Imbrenda wrote:
> > > On Tue, 08 Sep 2026 21:01:31 +0100
> > > "Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:
> > >
> > > [please note that I had to prune the CC list quite aggressively because
> > > my SMTP server was not happy]
> >
> > Yeah sorry about that, I already pruned the list a LOT from what b4 wanted, and
> > still ended up with a ton of people (I consider maintainers for stuff I touch
> > the minimum cc, but also added mm reviewers).
>
> yeah I did not mean to fault you, I understand why the list was so
> long. mine was just a courtesy warning in case people reply to this
>
> [...]
>
> > > > @@ -247,7 +247,7 @@ static int __gmap_helper_unshare_zeropages(struct mm_struct *mm)
> > > >  		 * proof to catch unexpected zeropages in other mappings and
> > > >  		 * fail.
> > > >  		 */
> > > > -		if ((vma->vm_flags & VM_PFNMAP) || is_vm_hugetlb_page(vma))
> > > > +		if ((vma->vm_flags & VM_PFNMAP) || vma_is_hugetlb(vma))
> > >
> > > Would it be possible to replace this ^ with !vma_can_gup() ?
> > >
> > > (obviously not in this patch, since vma_can_gup() is only introduced at
> > > the end of the series)
> >
> > Sure, I could squash that into the 'use and apply vma_can_gup()' patch. Will do
> > on next respin!
>
> excellent, thanks!

Actually this isn't quite vma_can_gup(), as that will wrongly exclude VMAs with
VMA_IO_BIT set, and I think VMA_IO_BIT mappings can map the shared zeropage.

Maybe one to reassess on follow up?

>
> >
> > >
> > > >  			continue;
> > > >  		addr = vma->vm_start;
> > > >
> > >
> > > [...]
> >
> > --
> > Cheers, Lorenzo
>

--
Cheers, Lorenzo
