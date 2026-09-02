Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442563E5A0E;
	Wed,  2 Sep 2026 07:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788335729; cv=none; b=fftvx1A4fL4bXGqR0L7Wu92fxsn/45ViKff24awpMPxww24KLvSDVHn3l6A8BLJMjGbh0BVPS98S+c4RyKcLh0Ezb8TQ4MHZKOpmQ9869eyBqvUgp67v5Ml8MAsoN9W+i7O5VUndikp5mcVnYSvCyLWpuA3jp+bbiHVyuB8bL24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788335729; c=relaxed/simple;
	bh=RnPVzCJQ/nbWwecHQ83NNjW9MlvS7zzyy1ZLmL9pUmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oXAHzdadND52xyRhikLAQstV4sJO58N6C/xbOlCDJ6b50ixExRblsjUcOhIKc+hYRtd4CBkObwG6Utxok3Ae6TYE5NXGrxfzE3THa7MRTsOYaEaHfJXzc4ATnhQtJlEGFabHEmF+qq4qFjNrkBQhlWw/bygNCe/3awC/oyTYdf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NirAID+U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NirAID+U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 577E51F000E9;
	Wed,  2 Sep 2026 07:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788335727;
	bh=iE2Y6ChXMI62Dd2a61tZtGbr0CVk+MR40gr5QEek2mQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NirAID+U7QL7Lqf6oXvUtdwmkh1WpHQdwDZL/TyFCyp3ynziQsKG621DwmZhdKsIO
	 TcKZqi66jJBrgvES4EG1CRQKPb3heVvV6zQ7wHkJZriUsGudTb3C0DNvySx7O5sHoW
	 vlx1/wQ4z0giGu2gHVk+ppBrseYEc9nPAojMFYKb2FMMYaVxU0IcjlETcVJJ7d+zx1
	 M6FJifbZmCvASMj+RaRfxchBk4iJaeLTK4aCyfC7IzAbFpOqE+2xF0eydXc7m1HbeB
	 dRLZAvTMW+mwbnMcqyFEozBmVVqhAlJhIWqglbMf2egWadMdCTE0VgFb2XOQqFRSpU
	 lk1XwMrX6u7Sw==
Date: Wed, 2 Sep 2026 10:55:21 +0300
From: Mike Rapoport <rppt@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Heiko Carstens <hca@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	kvm@vger.kernel.org
Subject: Re: [PATCH 2/4] KVM: s390: Replace get_zeroed_page() with kzalloc()
 for the STSI buffer
Message-ID: <apfWaanSoZQOwEw_@kernel.org>
References: <20260902-s390-kvm-v1-0-3bc0986550b1@kernel.org>
 <20260902-s390-kvm-v1-2-3bc0986550b1@kernel.org>
 <20260902062223.5295D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902062223.5295D1F000E9@smtp.kernel.org>

On Wed, Sep 02, 2026 at 06:22:22AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Critical] Replacing get_zeroed_page() with kzalloc() breaks the hardware 4K alignment requirement for the STSI buffer, creating a Guest-to-Host Denial of Service (DoS) vulnerability.
> --
> 
> commit bcd4e89cdbdb3a1d43d3845b698f4de5d334121d
> Author: Mike Rapoport (Microsoft) <rppt@kernel.org>
> 
> KVM: s390: Replace get_zeroed_page() with kzalloc() for the STSI buffer
> 
> This commit replaces get_zeroed_page() with kzalloc() for allocating
> the STSI response block buffer in the s390 KVM subsystem.
> 
> Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
> 
> > diff --git a/arch/s390/kvm/s390/priv.c b/arch/s390/kvm/s390/priv.c
> > index b3cb2c2c3aa71..856939acf012f 100644
> > --- a/arch/s390/kvm/s390/priv.c
> > +++ b/arch/s390/kvm/s390/priv.c
> [ ... ]
> > @@ -911,19 +912,19 @@ static int handle_stsi(struct kvm_vcpu *vcpu)
> >  	switch (fc) {
> >  	case 1: /* same handling for 1 and 2 */
> >  	case 2:
> > -		mem = get_zeroed_page(GFP_KERNEL_ACCOUNT);
> > +		mem = kzalloc(PAGE_SIZE, GFP_KERNEL_ACCOUNT);
> >  		if (!mem)
> >  			goto out_no_data;
> > -		if (stsi((void *) mem, fc, sel1, sel2))
> > +		if (stsi(mem, fc, sel1, sel2))
> 
> [Severity: Critical]
> Does this allocation guarantee the 4K alignment required by the STSI hardware
> instruction?
> 
> While kzalloc() for PAGE_SIZE might often return page-aligned memory, it is
> not strictly guaranteed, especially if slab debugging (CONFIG_SLUB_DEBUG)
> with redzoning or CONFIG_KASAN is enabled.

It's strictly guaranteed, see commit 59bb47985c1db ("mm, sl[aou]b:
guarantee natural alignment for kmalloc(power-of-two)")
 
-- 
Sincerely yours,
Mike.
