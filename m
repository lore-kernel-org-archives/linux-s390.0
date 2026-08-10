Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CAA366052;
	Mon, 10 Aug 2026 16:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786378918; cv=none; b=eVwmYFfJiaWm0pIu9SuOJp3VPj4cyAhGSaSj0GDS0Dw3IRkI/+guDxEXdQUR+63H8Ccw9NnAwyHqsqG71FsdPmQ9vwSH11izjiJjh1AzFQf8C4yLttxeVRCy9oat+1hzVJPGqS+luz1lYHq5gBrJaihY8AWS1i9GJO4ApnldYf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786378918; c=relaxed/simple;
	bh=u7lDQ5r1fWCV8TfA8aUHo69CydShqVMlVgOaxbleVmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwOI3wjBN6TvMID+aDwG4Ng+bqzrRyyVnOE7Wj3XQPKWJz/hSZT/vgas1h0NDsCcRKqXRwSJuTghtNxWtFJKvbakSFk8Xp+TeWgLab5bSY/853r78lq0mEA2HvqqWRqgaJuzl4ouXgOIV1JdhR6EldKs/qMLymkUkA987F+L+lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=bqTh46Qe; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="bqTh46Qe"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3CF9E14BF;
	Mon, 10 Aug 2026 09:21:52 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 940CD3F86F;
	Mon, 10 Aug 2026 09:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786378916; bh=u7lDQ5r1fWCV8TfA8aUHo69CydShqVMlVgOaxbleVmA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bqTh46QerWY1zlFZ0mKKu44uNBAwm5uhv2fyJoPgLQHiR9ozkJg7mTYyHUIwznQ7F
	 guNDtKeUBBY1lv05yMvTR0qMAGhhi60tk7oyfdh9cQQs1v5iFNNQQzXGwC7mzs7w/6
	 vQud/ujNVA4Bg+M33xIYsyHn0bSt/j1WqkiFrAH8=
Date: Mon, 10 Aug 2026 17:21:50 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Marc Zyngier <maz@kernel.org>, Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
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
Message-ID: <ann6noRzoPLL9kDY@arm.com>
References: <20260807182017.GH200537@ziepe.ca>
 <7d22482f-d5fd-4cf4-9d32-6a54e02f2fbb@samsung.com>
 <yq5av79iiard.fsf@kernel.org>
 <anml6lLRERm1Iv-_@willie-the-truck>
 <28442500-1d53-4776-bae5-459c3ffc1cc6@samsung.com>
 <anm6K2umtx4iKnyZ@willie-the-truck>
 <20260810130818.GN200537@ziepe.ca>
 <annc1ynWUsWQc4JM@willie-the-truck>
 <annx8-HDjTq933vp@arm.com>
 <ann1MnO8bADV9EGe@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ann1MnO8bADV9EGe@willie-the-truck>

On Mon, Aug 10, 2026 at 04:58:42PM +0100, Will Deacon wrote:
> On Mon, Aug 10, 2026 at 04:44:51PM +0100, Catalin Marinas wrote:
> > I can see x86 in mem_encrypt_setup_arch() adjusting the bounce buffer to
> > 6% of the guest memory. We could make up similar logic for arm64 or we
> > could just rely on CONFIG_SWIOTLB_DYNAMIC (default off currently for
> > arm64 I think).
> 
> As Jason said, this should be done outside the arch code.

I agree, better in the core code. I'd prefer to go for some dynamic
resizing than random percentage of guest memory like x86 (but, in the
absence of dynamic swiotlb, we could pick some default).

I noticed we still have a small change in behaviour regarding dynamic
swiotlb. The increment for new allocations is based on default_nslabs
which is reduced with the new patches. It gets even weirder if one sets
the same IO_TLB_DEFAULT_SIZE on the kernel command line, it will be
overridden by swiotlb_adjust_size() anyway.

I think this core code needs a bit more tidying up.

-- 
Catalin
