Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7B81474AF;
	Fri,  6 Dec 2024 14:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733496743; cv=none; b=X8a2DByq4Yb/iljMAOv2JrD6EVN0cPdEoOwqJefvc/zTokzd6xmHaqkN42DqcCbsnnt2c73kdOhmKAcAoDJH4MN8ouu5AkoU6PA18f7UtR/3AYJ2s13vf9aLhcVLwDjJhCZbha35LApqeT8YASOfHFDmEpnCuMgGOcjERFGrjzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733496743; c=relaxed/simple;
	bh=c/8ZlkYzbi6DXqIwQK4RCNgWQVop5LJWPwZQmkhzQxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xvdo5pd3r3DRWL5zc7MXxqI2d1wshwJQctJKGyeHZQa71lKQiZ15ZfuaUXCMEfwSuvANzXy6rAq1ByvpQYNrFkgbu7Wg/OzUsmqt75mBzrDL1V+1MnkTVPSGP/MMNNQsGqxe7OGBo92lZ+k0T+s9QalEbDH71mI1Uqo3PBWZEyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=morinfr.org; spf=pass smtp.mailfrom=morinfr.org; dkim=pass (1024-bit key) header.d=morinfr.org header.i=@morinfr.org header.b=PxFerdCI; arc=none smtp.client-ip=212.27.42.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=morinfr.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morinfr.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=morinfr.org header.i=@morinfr.org header.b="PxFerdCI"
Received: from bender.morinfr.org (unknown [82.66.66.112])
	by smtp2-g21.free.fr (Postfix) with ESMTPS id 64F5B2003CA;
	Fri,  6 Dec 2024 15:52:07 +0100 (CET)
Authentication-Results: smtp2-g21.free.fr;
	dkim=pass (1024-bit key; unprotected) header.d=morinfr.org header.i=@morinfr.org header.a=rsa-sha256 header.s=20170427 header.b=PxFerdCI;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=morinfr.org
	; s=20170427; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Z0V41C+el6ZxU+5bWs0t+oix5z85dABjQe8DaTTtBhM=; b=PxFerdCIiCaY8kBwiLnLtlVvpK
	hUKVkQWTVJ8G8cruN1Y9qYkReotnK48NHn0Kyfrr2LSNaq4Bca4cMHMSOb5PcwP5Yew5H+1+HbOwa
	OWVcvvwSaM6fKsny5CFzJojc9T0RiEW5aTHr2mo8uflPzIpQVESFbFqv1Q1XB7wLZHKY=;
Received: from guillaum by bender.morinfr.org with local (Exim 4.96)
	(envelope-from <guillaume@morinfr.org>)
	id 1tJZgc-002J1j-1t;
	Fri, 06 Dec 2024 15:52:06 +0100
Date: Fri, 6 Dec 2024 15:52:06 +0100
From: Guillaume Morin <guillaume@morinfr.org>
To: David Hildenbrand <david@redhat.com>
Cc: Heiko Carstens <hca@linux.ibm.com>,
	Guillaume Morin <guillaume@morinfr.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Xu <peterx@redhat.com>,
	Eric Hagberg <ehagberg@janestreet.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v3] mm/hugetlb: support FOLL_FORCE|FOLL_WRITE
Message-ID: <Z1MPlgsli-eA4o7z@bender.morinfr.org>
References: <Z1EJssqd93w2erMZ@bender.morinfr.org>
 <20241206045019.GA2215843@thelio-3990X>
 <Z1KLLXpzrDac-oqF@bender.morinfr.org>
 <20241206092453.9026-A-hca@linux.ibm.com>
 <c43a3149-c84b-448b-be80-1e026740911c@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c43a3149-c84b-448b-be80-1e026740911c@redhat.com>

On 06 Dec 10:29, David Hildenbrand wrote:
>
> On 06.12.24 10:24, Heiko Carstens wrote:
> > On Fri, Dec 06, 2024 at 06:27:09AM +0100, Guillaume Morin wrote:
> > > On 05 Dec 21:50, Nathan Chancellor wrote:
> > > > This looks to be one of the first uses of pud_soft_dirty() in a generic
> > > > part of the tree from what I can tell, which shows that s390 is lacking
> > > > it despite setting CONFIG_HAVE_ARCH_SOFT_DIRTY:
> > > > 
> > > >    $ make -skj"$(nproc)" ARCH=s390 CROSS_COMPILE=s390-linux- mrproper defconfig mm/gup.o
> > > >    mm/gup.c: In function 'can_follow_write_pud':
> > > >    mm/gup.c:665:48: error: implicit declaration of function 'pud_soft_dirty'; did you mean 'pmd_soft_dirty'? [-Wimplicit-function-declaration]
> > > >      665 |         return !vma_soft_dirty_enabled(vma) || pud_soft_dirty(pud);
> > > >          |                                                ^~~~~~~~~~~~~~
> > > >          |                                                pmd_soft_dirty
> > > > 
> > > > Is this expected?
> > > 
> > > Yikes! It does look like an oversight in the s390 code since as you said
> > > it has CONFIG_HAVE_ARCH_SOFT_DIRTY and pud_mkdirty seems to be setting
> > > _REGION3_ENTRY_SOFT_DIRTY. But I'll let the s390 folks opine.
> > > 
> > > I don't mind dropping the pud part of the change (even if that's a bit
> > > of a shame) if it's causing too many issues.
> > 
> > It would be quite easy to add pud_soft_dirty() etc. helper functions
> > for s390, but I think that would be the wrong answer to this problem.
> > 
> > s390 implements pud_mkdirty(), but it is only used in the context of
> > HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD, which s390 doesn't support. So
> > this function should probably be removed from s390's pgtable.h.
> > 
> > Similar the pud_soft_dirty() and friends helper functions should only
> > be implemented if common code support for soft dirty would exist,
> > which is currently not the case. Otherwise similar fallbacks like for
> > pmd_soft_dirty() (-> include/linux/pgtable.h) would also need to be
> > implemented.
> > 
> > So IMHO the right fix (at this time) seems to be to remove the above
> > pud part of your patch, and in addition we should probably also drop
> > the partially implemented pud level soft dirty bits in s390 code,
> > since that is dead code and might cause even more confusion in future.
> > 
> > Does that make sense?
> 
> As hugetlb does not support softdirty, and PUDs are currently only possible
> (weird DAX thing put aside) with hugetlb, it makes sense to drop the pud
> softdirty thingy.

Thanks all. I dropped the check and the dummy definition I had to add
for i386 in v4 [1]

[1] https://lore.kernel.org/linux-mm/Z1MO5slZh8uWl8LH@bender.morinfr.org/T/#u

-- 
Guillaume Morin <guillaume@morinfr.org>
