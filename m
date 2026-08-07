Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4872D377AAC
	for <linux-s390@vger.kernel.org>; Fri,  7 Aug 2026 18:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786126441; cv=none; b=nwvAq45dzhQBvqvnpw4pTqAlL3MiRgpdOQV1dQYz8K+T7UVWM6Aw1qTWSdnoX9VnYr3yaZzYE7MYz0vSCOsSsC416SGDRCIDi6QVF6Fyg+c08x1hqKhljC2Gs6p8ArFLlWWXYjGa06KIUHdZoFvgfOj2oLbj6E20PCBaJpfZP+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786126441; c=relaxed/simple;
	bh=E7Ex4RBUa7IG4kdLmTYk7y3iUle3Rq8qAnZNO/0MU2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ayk2/+rHNRDxWxQ6K60rrBawdFzxF3dvsk1x9iIrfKvIFUdvAD9DQU/1FE/tdPenrOC/+tRAIRMAYskkX8YzOGq/wgByKrrghWqjTh69CfVnma8rTDHUQmg3fhej3fb2405WcSKGUpRH0t75+eG6XIuZB+N5LvNUk5FnHr35ulc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nyxUypfJ; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nyxUypfJ"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6a177b2dc8dso1035a12.0
        for <linux-s390@vger.kernel.org>; Fri, 07 Aug 2026 11:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786126438; x=1786731238; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NlmgqKiyqc7mU7pAn/JSXJE8TLhKwTlI/zLMMe65kC4=;
        b=nyxUypfJk9ldvGOs0r00RtaAwiR+rMq5xQ6XKKT7lVl10OAXCHv6k57CTXOcgg9vIS
         4KtV7QHh9CsJ8E20MJlv/VnFTSK5Svnr2oKQfJEJBmELLzvE6fk0h3ZIoHb87C/FnuS3
         TLNZV6n2ivazyk3aC2CzkClR7sf9XogrSDKqpDmenXhPcRsf0ViDoo8P1aDyH9kfcPeK
         QfXz7RFzk7YLqUSwCWXXIdP1KDsC8SAgQYA+hODQOZzHn68HCCP9vaJneVMYRDfJmgYP
         Rf/eH4mMdW9leqSTH/3jR9UGhaEw7vx6Gz5+ct1yjXNE/Bubsn52AzY12lT3Z/vdySdG
         fifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786126438; x=1786731238;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NlmgqKiyqc7mU7pAn/JSXJE8TLhKwTlI/zLMMe65kC4=;
        b=dGCzsssI08x0SE9fRaQyI3qHwyW3mTz0n/8VbZtJV5MSeYrXTf48J+Chv5W93Qb3mX
         nLrRB/wGmdM3t3gsPb/fDYsY0AmT62R20d3B0CG0pSvLNYYRBSkzrHk4YGrcDuKmvlp9
         ZrA6soA3T1iX+iLwwjEhnwkuZLorX6LLdzgtC63zcZ7yWo5Uq0W2qdF4xArQp8S+Ee3E
         /rbruGxDY8ssAv6G2XELcAblpk/V0nm8878JqyNO+hY5YotjPQg9gqn/dZ+7TpJWfS54
         yLLDqLJGzh3W2waftvTRAPdYykr3gItauWXavWCT0fpjMVGl56lYeS69b0bc5xbSiDtG
         b12w==
X-Forwarded-Encrypted: i=1; AHgh+RpTFznixMcZMbNGUS4mpUX60I1zI5pPCBJU7NS6PS28YVRqSen+e4maIdLcLW8VbfzjuZyMK7kQjwFc@vger.kernel.org
X-Gm-Message-State: AOJu0YwiuEg48nAOn1RgA1Y4RexSA6Er/9DXsWGjOxNG3i18QlyjHFhD
	PYt04C88NudRSguAEAHHDClCm9QmZo+SVdbmh9HIAUM89cK6gktx2JxU+ggsx6f+dQ==
X-Gm-Gg: AR+sD10YrIoEfFYjbRLVP7w+HnmbwUaRZuRvRQ9TN3VpWQOhI+HviB81GgLz5Vkxwip
	Vk0LjoecxLHjQBaQ2/UC5MOMFr7Bel6/ec4bqCHLgJ4qxP633oSYczsuv0/vVeU8C3VQghKn2ud
	7z0ujOqlNT+7RNfty4GOofjOKhapTxpcLxXmgXollYctu6TQH732J+wQ5NlF8at5ouJJJVOOifI
	BsPhAp2Va3HwqCIqosL//Ym22QXSRezx9JotEEgJF9l0itML6kOeU7gaoZacn6RFdcnFXawz0bV
	IxxKyj49IQthL7vjdtKg1hmcGAxWl1EVgNrqUQ+VwC+xs4ZliIYvAIfV4oLInEi4HdUnBU0M+ax
	XxqKEYA9toVEQcrIArbpcCf/mdamPWK0tmSk77lgVmkOKKmSqkb/GSyAz/H0j5VWMW4qQeUgwSC
	XHouPCp869c/sjY2jHezwj1ahIjdY9+da7skdqOi/ck4sC1yvOyLQcLpUy9E2FC/1WroryHg5vO
	oosGD6xHSXE57JcL6ALF3zUmqvkdQ==
X-Received: by 2002:aa7:ce06:0:b0:6a1:f26c:ae2d with SMTP id 4fb4d7f45d1cf-6a1f4f438f9mr5439a12.6.1786126433777;
        Fri, 07 Aug 2026 11:13:53 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2080ab446bsm79186966b.27.2026.08.07.11.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 11:13:52 -0700 (PDT)
Date: Fri, 7 Aug 2026 18:13:49 +0000
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
Message-ID: <anYgXSR4VAi3TpOj@google.com>
References: <20260717180442.110954-18-aneesh.kumar@kernel.org>
 <20260807092612.2202005-1-aneesh.kumar@kernel.org>
 <anXIZSh9lq99VG9X@willie-the-truck>
 <yq5acxvu2ict.fsf@kernel.org>
 <anXbJ2O4DWgPxCeg@willie-the-truck>
 <20260807135810.GA200537@ziepe.ca>
 <anX7F7dnKOtAOIIe@google.com>
 <20260807164734.GE200537@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807164734.GE200537@ziepe.ca>

On Fri, Aug 07, 2026 at 01:47:34PM -0300, Jason Gunthorpe wrote:
> On Fri, Aug 07, 2026 at 03:34:47PM +0000, Mostafa Saleh wrote:
> > On Fri, Aug 07, 2026 at 10:58:10AM -0300, Jason Gunthorpe wrote:
> > > On Fri, Aug 07, 2026 at 02:18:31PM +0100, Will Deacon wrote:
> > > 
> > > > > I was under the impression that there is a possibility of using swiotlb
> > > > > instead of restricted-dma-pool with pKVM.
> > > > 
> > > > Yes, that patch enables swiotlb as a possibility for protected guests
> > > > but with your patch we avoid shrinking the swiotlb buffer even when
> > > > restricted dma pools are being used and that's a waste of memory.
> > > 
> > > I also thought we switched pkvm to use CC-like swiotlb as part of the
> > > alignment in this rework? Mostafa ?
> > 
> > Yes, now protected VMs can use the SWIOTLB for bouncing. However for
> > Android (and kvmtool), use restricted DMA. so SWIOTLB is not used.
> 
> Oh? Why?
> 

The patches are not in Linux yet, when it eventually lands in Android
it should be possible, I did some initial assessment and did not
see any regressions.

> > However, I do not think we should over engineer this in the code,
> > swiotlb can be set from the cmdline and now through Kconfig also.
> 
> That's fine for android, but real users buying a cloud VM and sticking
> a distro on it shouldn't be expected to have to mess with cmdline just
> go get a halfway working system

But the whole thing is best effort anyway, the kernel picks
IO_TLB_DEFAULT_SIZE which does not depend on the system topology or
how many devices or how much DMA they do.
SWIOTLB memory is wasted if unused so we should be careful around
that as it would be the other way around and users would have to
decrease it manually.

Thanks,
Mostafa

> 
> Jason
