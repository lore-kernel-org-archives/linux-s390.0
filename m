Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF307357D0A
	for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2026 19:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783971753; cv=none; b=EFRQ4hFA2vEgCFShxtk9ghnlTP2IvSaQgaDEzP6gBbajuzWvcE/3yQbj7R+LbsYM0zW+PDVSQGydwtIFJJ+GbDQ4w/15UdAYzHMo2fBb/ps4AmgbehIIUJUHUbHQ5JCdkm83hkaoHfK+T440GCueeSc3tm0lXXNKUMjfB5jpiFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783971753; c=relaxed/simple;
	bh=LrC9TUnnqFTfebiht7I286OGjyOyXGf0/ejqHXWR6G8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qSeEszY0cwaCLPVccED0+uAtNlp0yAavhoJnmToBtBl8HYWiWc+7ruTnoL4YmKHOFw3/c8k6V2gehnCMk3lRRaLLl6/ZIEUAhIITAq4JaVXAmKcjlFVtlWR5akhvvtqtcBg0lNzrewqR9TFONId/wBY0QnEYnqpongRIDF4NMmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=E4aPWAt5; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="E4aPWAt5"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51c0ecfaee7so26362091cf.0
        for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2026 12:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783971751; x=1784576551; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1BBsjNZJ46p61GVJyRNvRKNhKTJyhEwUbX6XNXZgDe0=;
        b=E4aPWAt5iG/uGrQDOCeF0ieeKbFA01FIAdeM5OVxSjTJ6HHssRUJjm+a+azdXHcv0y
         Cx6EAetrWfReMqUTGZHjxUNrhVhLB3xlATt5xiJ4KrKTQErL+heKSrI4fSDs2aKgUhoo
         ZdRZ3G+2kLlD+rA+wqZ+NKSq3ycAZPiIXHBFDyf63UFsHpnjKFziRu3GgJPCndiVfnia
         vL7+5UbaL2mVEN2iOSlePFuNmPtGeeWRSp2qasmT9zPgoJnbvqMsrtpqNB6z9e2swQ0a
         1PcK/5K/VR/L/ygtP3v2kttKBuUMF7AaTV506oVLUbA3xNIVwOPgeg2nHsac/Y+n3gHk
         zzRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783971751; x=1784576551;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1BBsjNZJ46p61GVJyRNvRKNhKTJyhEwUbX6XNXZgDe0=;
        b=WNLe/sQ8oSLm5/1xMnWYRRO4Og3xlmhEXX/wLBhyGZUT7QWBNBvQ4sbMVKYNfDrRL8
         KirjeOrPBiLvPmLjfr75NCekar8C+U18pDGCa40mfI9ous7nPi+lxEGEjywUU1bC0zRa
         A6RIreytUPk1pnScm5fBuo/bZeY7vI/ZQ0CAbFmsAGQGQMRRc5QNggWDyuqJkhYw6VKe
         i1LHQG/v+8tjEeion6VhT1IjMRlslI7fTFAFTN/L06HY9U3xU8L4p9G/pufJbycw3oOc
         YFKAmFJDa+W6PA/dRMoYzsq22e4rkj3xA0QfTGhS1gO007yQCbAspVnvR8LoDgz7XZdd
         ZSYA==
X-Forwarded-Encrypted: i=1; AHgh+RouyKOz+ANVLKdB7+4EDcs7mvrmeyiSlBUJxPxW+PYI5bVhonPs7rrKFYnwauvj/GVEbvb3o5SuDnkx@vger.kernel.org
X-Gm-Message-State: AOJu0YyRpP/H1TrH4Ps9OTRokmA7wzJ6GOrAzNRenQQso4MDXJzZkgY4
	w+4fQQbU+xW0lW7QvAHFvVMshP+pvm0fnZ6golS8vdejPoBo8aPGDDMfPGC/jltWBAc=
X-Gm-Gg: AfdE7clc+XjIyoPcx7Ij8emypb0v80IGiI4yz18fHQbTMiNU0sSU5INQH2Z/X1t8dsw
	dEwFXy9deGXfFvpIYcszoLDd+XXJk1BVv+zFcjg8VhTIQKEH5PZaQsWOxgdocBLAkLPCo/b6hZI
	LCm0cYOCKySE8whqDhO4KJEt6OBfxw7GuIV8ryi2C7MIbOf4T4jYVqj7psz2m7ieEVX8gCCBU0Z
	lq0vBx+/ATVn0wOPrWCfgg8pNqUoEKgXvjVfe5wEv31tQbO61Dp+Vi0OAYAiJTh8xxeU6GasKHE
	f6TZ6d8xc7x1LARkHiKJylqSgx+zyvBTajE0FyM9M6SZtkw6OFsb8oOCh06kMPnUcIJ3gN+rw7I
	Z/lJrgTG6Em1q0ihHiHQG7pjej6qCJ8RBghm9+NwNRVyn1YSr/+xBruWBMSUy
X-Received: by 2002:ac8:7d53:0:b0:517:6550:2a0 with SMTP id d75a77b69052e-51cbf0b836emr108931441cf.19.1783971750625;
        Mon, 13 Jul 2026 12:42:30 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd5bbac2asm138277776d6.21.2026.07.13.12.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 12:42:30 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjMXt-0000000E6oU-2oJ5;
	Mon, 13 Jul 2026 16:42:29 -0300
Date: Mon, 13 Jul 2026 16:42:29 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v7 22/22] swiotlb: remove unused SWIOTLB_FORCE flag
Message-ID: <20260713194229.GB3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-23-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701054926.825925-23-aneesh.kumar@kernel.org>

On Wed, Jul 01, 2026 at 11:19:26AM +0530, Aneesh Kumar K.V (Arm) wrote:
> SWIOTLB_FORCE has no remaining in-tree users. Forced bouncing is now
> controlled through the swiotlb=force command line option via
> swiotlb_force_bounce.
> 
> Remove the unused flag and simplify the force_bounce initialization.
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  include/linux/swiotlb.h | 3 +--
>  kernel/dma/swiotlb.c    | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
