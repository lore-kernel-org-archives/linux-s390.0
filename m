Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1ACB3A7593
	for <linux-s390@vger.kernel.org>; Fri,  7 Aug 2026 13:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786111098; cv=none; b=l6Ynq2P14C6LGYwtz3mnRougClnzvg5IzJ0vW9opLKN3II5Rl/G+MMEwPGN6bi9dGs+k8vvAS+/EsQJnFbC3SqyTo8J34mYWhCQ2Hztwy1M/f1U3OtuEdvf9vvBZ4lVqMUCRAaKi/cfuo+OHNnCo0DlG/4XU/0WtNNHDzgbzK/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786111098; c=relaxed/simple;
	bh=zrBhytxcXDNPG0MMxibBNcHjDvvuQV6t6BI7tYVRQPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hspDoDScLBP6Eql9TzThDpvWL15xTbu/rq7bJSdOO1J21g/Bruo7IFv5hqovIa7femhZHT+MzQuBHx9nvTaAXvUHt3f3cHKMvU54alESPZoooXsFclCEBtH+VOC1fg0CHMWenr52iIOqQkNU9gFkAUmJPLWhZR3QkbLF85SHPDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=f1zwtco0; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="f1zwtco0"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-92e5b048375so171950785a.1
        for <linux-s390@vger.kernel.org>; Fri, 07 Aug 2026 06:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786111092; x=1786715892; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i2ro1loNwbkACqpDIeM0PdgrbNZfsWDTHY6fPjx3IQg=;
        b=f1zwtco0Spb1KGX/d4YUUD5iwf5/K8pVAXM6jJz5a1HYP4Luw2nOuPkxp3l04gz82S
         Zbxh0Rj6HM4C0x7A97PcsOfCklVPCR031BtHPqzaJGgzaj+wDKxRwKvtZ+hJmeRRsiul
         2UetpBw6g+OsFIRz5Q4T824gBbhl4/p7IbGYbaeAx/gt0Q88xdVekkQ81XD+O7mLk0ev
         x1SREJU8+ppxeEC3SmzPYqnV6rM0NUd+kmVaxKjPo+6R2gvXrX5e4aiulV5gFHnXubdy
         r7FVlZ135OO0fQH4HSxDfiuErkDquQIUfCvp91J/LMHnYIdqEGmjx/VpaLKt5H4rCQg+
         Ey6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786111092; x=1786715892;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i2ro1loNwbkACqpDIeM0PdgrbNZfsWDTHY6fPjx3IQg=;
        b=lcEqNi2FhxSVNfjjoWCvyAB2+ggV1fqytrztvcAqJIPhCHj4VPuNQ87wgKYYuPtAnI
         vbL68ojNbVDdMAONf8N4RyNFt1Ie5PwU2Een7DaEFWglyBzVWOKBNTdxk07a4ih8mJK6
         TJ5ursahgYxhMBfQFRIl5E8Xa745WP1YcrSpuxgBwg+3SgjLrVHnhWvUahxWDiitluEu
         K5L0SVMl9l+UUVqAXJKdq0sNGjXSJ9yUtBceCLOIdJple/pZryRQ9wlMBUMXR03iezzX
         g0ETeKdsFoR5ikPLC6+0goI5KXdJ2lt+38KpWPQ4+QWcMIN2ejVvx4hrzbnhRoFOxmuQ
         36LA==
X-Forwarded-Encrypted: i=1; AHgh+RoQQUQOFeqoUy1arbWNOGJGUPtIe4pT/xFigAH/GZaxz/H1vocB/O+97Ewr004ggGqfJJuizRwuvTHM@vger.kernel.org
X-Gm-Message-State: AOJu0Yx62lLTM0bCbd8VkvJgtvTJt7ITO8Yl4M/D76Vn7H00X99S9uoA
	opJfS+yAPu3Yk9UZT9SHkRXdSorNF/MxJRA0JXyhzp3VrUfBcN7JIAriGWzQ0+C26AU=
X-Gm-Gg: AR+sD12L8UjVXpdvA3m9XJPqYWIUIU619T1zqn5d8xwAGyXZRy+ii04SHGKjrcCKggG
	kuNBTvq1ArBJMiHAUMNT9+hnU9RdHu+MIAAM3j3VhKlrcCsGhBJZdxsdip0k5sARSZDdJumRlrE
	purB10PV8E7MiAkrhSOQX6LXu4FGLD1IKetnKcQoQDJEvWKeJ/7gOf4EwTQIqBtnJmWYcxh5rLu
	v9r6oAdvNqLn56G04sU9OWHZqEjr5MlxFYxqsdwDTHBHRCr8UzdV/URZpVQ9kZpe0PBR+bW7pVD
	iC0Xp/9UwWNaG3HcDo4rCY8vBpG3R/AmuqS5NKFG2zLNctg+ceBQodXJ83mO4NJggUbXdTFYGU2
	c+cCzQBE5vY0Xe9Faf43biV17EBKgj/VRgX4XLpiQH0aChxJY2KeKVmi9aysR107IqL7HRx++OY
	6QZBuzz5QSR8JBeSCeuN0c3uLr4JfT0Dq/SHKZOw==
X-Received: by 2002:a05:620a:2725:b0:916:14f5:8866 with SMTP id af79cd13be357-936490191c4mr2577886985a.16.1786111092001;
        Fri, 07 Aug 2026 06:58:12 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9366e2971d0sm152121785a.43.2026.08.07.06.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 06:58:11 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wsL5O-000000012Hc-2aob;
	Fri, 07 Aug 2026 10:58:10 -0300
Date: Fri, 7 Aug 2026 10:58:10 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Will Deacon <will@kernel.org>, Mostafa Saleh <smostafa@google.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Marc Zyngier <maz@kernel.org>, Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH] arm64: swiotlb: Keep the default size for protected
 guests
Message-ID: <20260807135810.GA200537@ziepe.ca>
References: <20260717180442.110954-18-aneesh.kumar@kernel.org>
 <20260807092612.2202005-1-aneesh.kumar@kernel.org>
 <anXIZSh9lq99VG9X@willie-the-truck>
 <yq5acxvu2ict.fsf@kernel.org>
 <anXbJ2O4DWgPxCeg@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anXbJ2O4DWgPxCeg@willie-the-truck>

On Fri, Aug 07, 2026 at 02:18:31PM +0100, Will Deacon wrote:

> > I was under the impression that there is a possibility of using swiotlb
> > instead of restricted-dma-pool with pKVM.
> 
> Yes, that patch enables swiotlb as a possibility for protected guests
> but with your patch we avoid shrinking the swiotlb buffer even when
> restricted dma pools are being used and that's a waste of memory.

I also thought we switched pkvm to use CC-like swiotlb as part of the
alignment in this rework? Mostafa ?

> > If that is not the case, then we could change:
> > 
> > !cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
> > 
> > to
> > 
> > !is_realm_world() &&
> 
> Perhaps, or you could just pass the swiotlb= option if the defaults don't
> work for you. Can you give more details about the slots exhaustion you're
> seeing under CCA?

We see badness with swiotlb too, it basically doesn't work out of the
box if you have to use it 100% for real devices. It easily runs out
of memory.

Auto tuning to higher levels makes sense to me, but I'd rather the
core code handled adjusting its size to the estimated need, not arch
code.

Jason
