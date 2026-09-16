Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53B64BE449;
	Wed, 16 Sep 2026 10:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789554231; cv=none; b=WTxNsFLQfLPySzhOaFyLL1wGbs4v/tcgucz/1Amb1lmX8M953nWkaifQOBz8f8KytMSeCq5C5BxUcfHP6Mor/AL4vfxNMtk8ss+KxEQGIJm518ZSykkC1/HMFcM6yJouuhqH2F5BBZy4EKLLMCrMJZ+QqcPm3qIVxtMzewqHP0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789554231; c=relaxed/simple;
	bh=zSLx5JJzmSNS5vkOxyZiXEJzS2L0xDH/nEnxei+zEEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QxBb/KY0u80J9GK6vP7XzMqgcAaewMT83dfZd6NKqAF+MBHtwDO3jF2l0cRDkWZ13GQzzT/6SAf+i2fJkJzdlSGs3Ykfw+PrfKC61VYY91+/TYLlC73CrWQSAj8zMQdU+NykFIyXRGECNSshhkeb+AxEfls1vEmVmfYS3oRjQno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iu/2+DYz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iu/2+DYz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D43D1F000FF;
	Wed, 16 Sep 2026 10:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789554210;
	bh=xLztN3PKEKqZc0fzcEuGAJpCX3EDSgFfQXKxXcN7Y+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iu/2+DYzeYlpKqLCzxyVavNx1R/QW+QBBQWo8pZzIvyMGgoXK+D7j9MAyKwOUgQty
	 X38d1Bu8FWFUgc8+xQldM5PVAZqazK9tmC6t0v9vhcwCX1VV0xoGlM4Xc3Lm2wnQ99
	 NlbclkJLPajt55PXlAchwdyA/t1lszYRMXJEumBWXbjZfa9Vo51tjeXX8MkE8W3FgZ
	 poWB5he0cPqPHUAwvk4Pcc5TQ+JgroS20H7qDI+eB8O9dOg9GcLFqiUyvxVjSaVlQ4
	 c2BYcI/weoC+otqhw5SuWdDb5qtxxzhLIze1y7lsmHsmfk7tdvdRmEQJNNmiNXhRfu
	 JdquqTt4RyB1A==
Date: Wed, 16 Sep 2026 13:23:23 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vineeth Vijayan <vneethv@linux.ibm.com>,
	Vlastimil Babka <vbabka@kernel.org>, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 11/13] s390/qdio_setup: Use kzalloc() for the storage
 list
Message-ID: <aqpuG_QJdsMj6_so@kernel.org>
References: <20260910-s390-cio-ready-v2-0-e931086fdde1@kernel.org>
 <20260910-s390-cio-ready-v2-11-e931086fdde1@kernel.org>
 <20260916092720.15587B52-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916092720.15587B52-hca@linux.ibm.com>

On Wed, Sep 16, 2026 at 11:27:20AM +0200, Heiko Carstens wrote:
> On Thu, Sep 10, 2026 at 02:00:13PM +0300, Mike Rapoport (Microsoft) wrote:
> > __qdio_allocate_qs() allocates the storage list information block of a
> > queue.
> > 
> > This memory can be allocated with kmalloc() as there's nothing special
> > about it to go directly to the page allocator.
> ...
> > @@ -109,7 +109,7 @@ static int __qdio_allocate_qs(struct qdio_q **irq_ptr_qs, int nr_queues)
> >  			return -ENOMEM;
> >  		}
> >  
> > -		q->sl_page = (void *)__get_free_page(GFP_KERNEL);
> > +		q->sl_page = kzalloc(PAGE_SIZE, GFP_KERNEL);
> >  		if (!q->sl_page) {
> 
> Speaking about unnecessary changes: why is this a conversion to
> kzalloc() instead of kmalloc()?

An LLM went wild and I missed it in my review :)
Same in another patch.

-- 
Sincerely yours,
Mike.
