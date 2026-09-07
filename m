Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4499146AF10;
	Mon,  7 Sep 2026 10:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788778789; cv=none; b=Nv2cierpT8XNY2t4QVlHkfchHLrvajltxfOMEz0oCbIdCgu0yTs/Uahwn1jDyZM3qnO+MoNjcPr/JGkk2DTpfHvKc/IXQF8+CvOOOMv/HENUNu6FV9FY2IYlgn4YtYPdLBzTRyxCsRdsqUwHunXHH5GoaAzCSTODe7/N+d1rxj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788778789; c=relaxed/simple;
	bh=BL0AoMpVklCIRt59TB9o8/bj+tQ2HL6ifIgvPUbeaQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=inXoibrFhvuKx4aruOQUuF4RRiiGI3A2wbnPXZHFJpL8RpTlPlHfvWgZzY8jUWohj1JM35UWJeGnYJdQjB/E72/hurap2NxwKl1lZj6J7OW7hZCPNtWzznbNhzLaiVn2KF9PbkdTwSKKVWdCvnXgTE4h3OG7nSrsMYJEC77YZxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQLPF7Ac; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQLPF7Ac"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D121A1F00A3A;
	Mon,  7 Sep 2026 10:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788778787;
	bh=q+doeYPqSHwTV6GWhVKw0/CQpUhwLuuwacGXzuEjLCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bQLPF7AcDemfWBqPoPCRAE99PgrjkUWkwXaNvg/04tZqnwjKw5f3Wm+GA8boCFWjE
	 uttV8eDDpZpALucM8dnWE9vk7T75QMe9+TPjYqoAfa5GLoX7Cn2UCe2QveWxn0D8X4
	 vUcGqG0ORG3tAtphU7U7j7gN8daGb9PnqYUUETeXZMw9eOkcW20j+avg5iBW6y9XV2
	 2G9G4Y6G1FDWzjYgcM4TdeeexmUL/xaN9gC9Kh6sD0bBqZjAi5MCxImE/phTWSV7ds
	 NPydyjaIifX6Q+z7vyX0X5FzKnV/SIceSw99im+sdZvja5aKB4TXpEpuKF7PL0Pi+e
	 kQd7w/haK/FTg==
Date: Mon, 7 Sep 2026 13:59:42 +0300
From: Mike Rapoport <rppt@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH 06/13] s390/cmf: Use kmalloc() for the CMB area
Message-ID: <ap6ZHlAPE_txA0ou@kernel.org>
References: <20260907-s390-cio-ready-v1-0-ca7f39806234@kernel.org>
 <20260907-s390-cio-ready-v1-6-ca7f39806234@kernel.org>
 <20260907103540.250761F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907103540.250761F00A3A@smtp.kernel.org>

On Mon, Sep 07, 2026 at 10:35:39AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Critical] Integer overflow to zero-size allocation causing lowcore memory corruption.
> --
> 
> commit 2913241109f97628467377f13982dfc657e8d846
> Author: Mike Rapoport (Microsoft) <rppt@kernel.org>
> 
> s390/cmf: Use kmalloc() for the CMB area
> 
> This commit replaces __get_free_pages() with kmalloc() for allocating
> the channel measurement block area, and updates the free path to use
> kfree().
> 
> Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
> 
> > diff --git a/drivers/s390/cio/cmf.c b/drivers/s390/cio/cmf.c
> > index 92ab3d546fe47..6c46b0d0b3da4 100644
> > --- a/drivers/s390/cio/cmf.c
> > +++ b/drivers/s390/cio/cmf.c
> > @@ -501,12 +501,12 @@ static int alloc_cmb(struct ccw_device *cdev)
> >  		WARN_ON(!list_empty(&cmb_area.list));
> >  
> >  		spin_unlock(&cmb_area.lock);
> > -		mem = (void *)__get_free_pages(GFP_KERNEL, get_order(size));
> > +		mem = kmalloc(PAGE_SIZE << get_order(size), GFP_KERNEL);
> 
> [Severity: Critical]
> If size evaluates to 0 (for example, if the maxchannels module parameter
> is configured to 0 by the user), get_order(0) underflows and returns 52 on
> 64-bit s390x.

I missed that one while reviewing automated conversion. It should be

	mem = kmalloc(PAGE_ALIGN(size), GFP_KERNEL);
 
> The allocation size expression PAGE_SIZE << 52 evaluates to
> (1UL << 12) << 52, which wraps around modulo 64 and evaluates to exactly 0.

-- 
Sincerely yours,
Mike.
