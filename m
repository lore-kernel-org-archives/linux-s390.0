Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E984DDB42;
	Thu, 17 Sep 2026 16:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789661335; cv=none; b=asmE5AyyMMjMAgTDD3M5EUA438Zjd8QGzgS46Ik4Z8WCchUwmT83EGs3J3dXDjHPaWufCLVOltwI/5aPgqKA45aDmaV+jp6rRs4ZlpRwcbarKqZyqVEa/EqwZLk81rSJhNlS7SSXLD/Nm/EkDCb9T222nnchuMWYclqxG5JGhZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789661335; c=relaxed/simple;
	bh=LTrp4k+I8MTH1TFb/n0jAUNy6sMkQLKvNVm0Ssk0Ik4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oqFtbGxGDCIfA0DMLWQY55R3rvlV7w+xgmQgHHzWVEmh1cgpLAlu88Ux+lW4MVoXhOCa456svKqFL6+1byyZ6CcJFh/QKIbnhmqPm/z2YlFmEYJJR2LC1w9pdM8G+SwrHi64Qi7q/XFFQ3I+raa3W0T8OB5UuHm0Xg0IuSeErK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fg2BVR2h; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fg2BVR2h"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D71DA1476;
	Thu, 17 Sep 2026 09:08:48 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C2B23F86F;
	Thu, 17 Sep 2026 09:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789661332; bh=LTrp4k+I8MTH1TFb/n0jAUNy6sMkQLKvNVm0Ssk0Ik4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fg2BVR2hsmdfzOw802jgLmkU4C8dYgDiVodN/BCQcJnNlXQvUZTot4764bZzdYHoP
	 KpxaXu68DSJ+nTWkJw0nr52jlY0S/pY38k0WZGKhlRoxtkP4hWgPjgsWanps+qYf6p
	 OWz0B8EVzI71pY/BTigybbpetQ2VZbhxL7LsQAdw=
Date: Thu, 17 Sep 2026 17:08:43 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Russell King <linux@armlinux.org.uk>,
	Huacai Chen <chenhuacai@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v4 5/5] dma: swiotlb: Remove SWIOTLB_ANY
Message-ID: <aqwQi0AGG6NvHKHG@arm.com>
References: <20260914070135.313337-1-aneesh.kumar@kernel.org>
 <20260914070135.313337-6-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914070135.313337-6-aneesh.kumar@kernel.org>

On Mon, Sep 14, 2026 at 12:31:34PM +0530, Aneesh Kumar K.V (Arm) wrote:
> swiotlb pools are currently allocated below the architecture's low
> address limit by default. SWIOTLB_ANY overrides this and permits
> allocation anywhere in directly mapped memory.
> 
> SWIOTLB_INIT_ADDRESSING_LIMIT now explicitly identifies callers which
> need a pool that is reachable by devices with limited DMA addressing.
> Use it as the placement constraint and remove SWIOTLB_ANY.
> 
> This changes the default behavior for callers which do not set either
> flag. Previously, omitting SWIOTLB_ANY placed the default pool below the
> architecture's low address limit and also constrained dynamically
> allocated pools to the same range. After this change, omitting
> SWIOTLB_INIT_ADDRESSING_LIMIT permits both static and dynamic pools to
> use any directly mapped memory.
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
