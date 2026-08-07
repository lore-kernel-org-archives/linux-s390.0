Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115B3476068
	for <linux-s390@vger.kernel.org>; Fri,  7 Aug 2026 15:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786116900; cv=none; b=BgJ1rD5TKRBGeJaXmMw28M/ZFNhlIfHLkVMh8OL9zZrn1jHnGryTA59iIqLO4q3QQFg1F+kUx6Yttz7w1sVy0IR3K/sspvf7VKojMc11f11QD86B5zkUj3klyFvH4K1C9xGxz6Ap4rkDMB4BF4wOELgcggGybHM49WVEMVbl8qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786116900; c=relaxed/simple;
	bh=7a7AysVuynNFe1lOeN952FQuu+x6NVHG3FmBrbLqGgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFa4ySmSQnBK94xvmsaoD+rshfZ4sdqiegujqKZI93xM3rs3TXRlD3ZTcD/kpdHJQvgIufVN38B++yeZcIkrPLqYg2OxyzYDX0lNN5HoNV+pTwuXt9u1xUUWROmNsx+9VUWrqm7JvX8l5f/2D5Hm77vQKf7KgOUenlqH0zTtxhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CO+3mFLz; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CO+3mFLz"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-69fec8b4638so13967a12.0
        for <linux-s390@vger.kernel.org>; Fri, 07 Aug 2026 08:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786116897; x=1786721697; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Az5wp+kAsSbtOjG5rv8pQmucG2yE4e6DGCCgwM57rEM=;
        b=CO+3mFLz+OnsuSbka+OZwIUiYQ6ZIdTII924AdUdsNDVEHfbCyZgORYb1GLjx1Cmxr
         LfTHeFk8hjRmB6GtjJVz0uIFrhTviZsJsveFzdtkvebPmw4Ykqflkuc3b5p5XG9UA1jh
         AJ6b23Itqui55e3w9vJ7CiWR2aBVjxccUYHA/J9NqXZb4FmSjwJMGw7R7lXDrCImG4uJ
         wFJ/IOMJpJgGZKCPbs4ctguZspPnZX5yzMKXUd0hKFmrL8CiB0/Fyg+8mofC7mVEvCzA
         KXsl4agTfDeV8xscICo9F/aGDOr/cbOXw7xLJ6hcdPOcrfeWVkbo1LHBbm9tPOkPVg3u
         /RRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786116897; x=1786721697;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Az5wp+kAsSbtOjG5rv8pQmucG2yE4e6DGCCgwM57rEM=;
        b=gZgxoy4/mvz+df4Ed8PxuuL5daDZTfNLYEUWLQte/ieCfQarQPl356gzGNQzuvNND6
         mhy+HDudLWbukle1i/hF1zIL/FaogeysOas5SHwRX3LhU8Rst+dMgNkl4qTgUB9Lxk6f
         4X7QIsdFIxW3nDGEIITYKI7CHGUlA3YpCipxsAwoKjI7BXZp3UoLoBYJzLz92ZTNPIhx
         7qgmwJUfl8rBbh1WlvjDY5luvasbBQqWBoIIMqGbQBfIlree3InuVpoGshsHQyceL++5
         YudGHhHtN5LotOAS+90HWWBKiaklbJWv9dMShlEF7/TcYhIkpilTae4/v09Z2uAGUOWo
         c3qg==
X-Forwarded-Encrypted: i=1; AHgh+RrcX3t8HR8GAW4Hx7Q9EPgTvOHCbYk7BC/4iQZO3UambO2lONrEqpFiFwDB8hTzHto9nFXPPCF8mJ9g@vger.kernel.org
X-Gm-Message-State: AOJu0YzomWGvvohANFHyXaqkbGfsjd7p9yDP2N/21hrYtGJrAPv6O/qb
	j/LPDClsDp6YyXSIex9nhOiuayBt6SAeGLUgRsbrce03sTEeo6fC4CAxXC9ex56QAA==
X-Gm-Gg: AR+sD10tmd+npBhD2/yCd9AXKP1x9vRK41WqG06zI9qvbI2mMF+r+CSi0S/gWsvvB03
	bcNDBTdYxgkRgFANwLi8eUmZpGpEQ/6NHLbhJgepRDkLzSx79CvBFdkdZjKn1VKTCLxShBKoDjL
	yz7vXFacGSsj1oOUfXTMqrHpNkRrOVpB+o7FkmYmGyYCJuEXx8Xi3IQKk7xBOKcTEFogOsq1aAh
	ymoNx0x6DEdd8IbHj/xCNZ6fSda2IHToKaA5UZ4qlG8PyQKWzB+nW6umrWdle95e628HyuC2prv
	Sk5gLEgSr/1FblyL9JBn6y+6WM1ag45KO0w0hS2Wd+c7bPl4PzfBZOxKU2eKnkxVD/SNWDy/hbh
	taE+IISdgW7H5hVVRTHZYA4RpLeTzrw0hIzEZhTb2Hn1opjkYaTZfGH67AkxEb6qmUEOKXtJVF0
	ms/UPu6rcXdqYCHDhhaEHFGQ9eZHDZVjWBZz1px67igqve3MKDFaRUOaUQV6rwRVrpRw8BNVYRK
	PLmKTQJI2mna2eowgroZtwl4TSIHQ==
X-Received: by 2002:a05:6402:65a:b0:6a1:f088:9486 with SMTP id 4fb4d7f45d1cf-6a1f088972amr16113a12.4.1786116896722;
        Fri, 07 Aug 2026 08:34:56 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a1e7d48f8dsm708475a12.17.2026.08.07.08.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 08:34:55 -0700 (PDT)
Date: Fri, 7 Aug 2026 15:34:47 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
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
Message-ID: <anX7F7dnKOtAOIIe@google.com>
References: <20260717180442.110954-18-aneesh.kumar@kernel.org>
 <20260807092612.2202005-1-aneesh.kumar@kernel.org>
 <anXIZSh9lq99VG9X@willie-the-truck>
 <yq5acxvu2ict.fsf@kernel.org>
 <anXbJ2O4DWgPxCeg@willie-the-truck>
 <20260807135810.GA200537@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807135810.GA200537@ziepe.ca>

On Fri, Aug 07, 2026 at 10:58:10AM -0300, Jason Gunthorpe wrote:
> On Fri, Aug 07, 2026 at 02:18:31PM +0100, Will Deacon wrote:
> 
> > > I was under the impression that there is a possibility of using swiotlb
> > > instead of restricted-dma-pool with pKVM.
> > 
> > Yes, that patch enables swiotlb as a possibility for protected guests
> > but with your patch we avoid shrinking the swiotlb buffer even when
> > restricted dma pools are being used and that's a waste of memory.
> 
> I also thought we switched pkvm to use CC-like swiotlb as part of the
> alignment in this rework? Mostafa ?

Yes, now protected VMs can use the SWIOTLB for bouncing. However for
Android (and kvmtool), use restricted DMA. so SWIOTLB is not used.

However, I do not think we should over engineer this in the code,
swiotlb can be set from the cmdline and now through Kconfig also.

Thanks,
Mostafa

> 
> > > If that is not the case, then we could change:
> > > 
> > > !cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
> > > 
> > > to
> > > 
> > > !is_realm_world() &&
> > 
> > Perhaps, or you could just pass the swiotlb= option if the defaults don't
> > work for you. Can you give more details about the slots exhaustion you're
> > seeing under CCA?
> 
> We see badness with swiotlb too, it basically doesn't work out of the
> box if you have to use it 100% for real devices. It easily runs out
> of memory.
> 
> Auto tuning to higher levels makes sense to me, but I'd rather the
> core code handled adjusting its size to the estimated need, not arch
> code.
> 
> Jason
