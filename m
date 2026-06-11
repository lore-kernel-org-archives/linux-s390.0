Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4CA2248A8;
	Thu, 11 Jun 2026 05:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781157190; cv=none; b=KFNRMeo5O6+1uiauDBUxVNPGvB0pYvt6+g8pMffW5rn3LssfC7EiDcaDeOf3oh0Kiw2JVO23SdDoUTk3rTx+xmCloY3+3xf4tam5FOFiKuZLcZb9uIoMeu8DrUz7B3tYbXnIYm+CDCxr3AQ/EH+wONUVJ9Ywar31QhEUudz5ihQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781157190; c=relaxed/simple;
	bh=Rn41MEbkx7igJGkZqb7oOrjDZ/UtxycUEWMqOGee+d0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gJ61wJ3YGXbzxK3TyOxXoGY+bY8B1uuEwMrTHxPdY+sba2DtYE/t4jmjCL+TqL+T0XT5zvYjw1gMN4GDHZskQE+40ciz5PRfk0wDox7nS7NSiSO//I9eO1MV0r5lxkUp9ltOdP1086bwifNfFd8oFKmnP8zrgWCsax7VneRm55s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZ9uqd0d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZ9uqd0d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A26861F00893;
	Thu, 11 Jun 2026 05:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781157189;
	bh=sEJIr+lPP3nXLw5RoJcEfwsXvE/NpV/RD/uYgu3QwbY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=LZ9uqd0d7apZX5IQP570+CH5enEWdE4i/rnlALBpkVng1ymyhtm8Xo+CXf6k/jI/T
	 PzpwXj8C9y8lPg0EqG2BmAmqvWycVYScBZuIOoexVWPDlJk0h1k2YtyuMWTIEir5xp
	 Ac4imUykBKZf2Ir12ie18URAbLEGxAwTs9dH2Dxho0ZHxwerBlBud5rW5fw3RHgiRq
	 i/QEsYYPYoHhorZg7TrBTtbB0mfEqQbWSxRo0bNMNkbnl1n/CpGi3B/5x9taOYPW/9
	 Jlp+saSSz66Cto6HSo5gt0et9Sna0FPZZpDrNpcs8qWkQ2M2f2JHnCKYHvPpdPdNSY
	 WoypcSrVXBZRg==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
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
Subject: Re: [PATCH v6 00/20] dma-mapping: Use DMA_ATTR_CC_SHARED through
 direct, pool and swiotlb paths
In-Reply-To: <aigYbK12D8uKQvJF@arm.com>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <aigYbK12D8uKQvJF@arm.com>
Date: Thu, 11 Jun 2026 11:22:56 +0530
Message-ID: <yq5a7bo5mxmv.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Catalin Marinas <catalin.marinas@arm.com> writes:

> On Thu, Jun 04, 2026 at 02:09:39PM +0530, Aneesh Kumar K.V (Arm) wrote:
>> This series propagates DMA_ATTR_CC_SHARED through the dma-direct,
>> dma-pool, and swiotlb paths so that encrypted and decrypted DMA buffers
>> are handled consistently.
>> 
>> Today, the direct DMA path mostly relies on force_dma_unencrypted() for
>> shared/decrypted buffer handling. This series consolidates the
>> force_dma_unencrypted() checks in the top-level functions and ensures
>> that the remaining DMA interfaces use DMA attributes to make the correct
>> decisions.
>
> Please check Sashiko's reports, it has some good points:
>
> https://sashiko.dev/#/patchset/20260604083959.1265923-1-aneesh.kumar@kernel.org
>
> I think the main one is the swiotlb_tbl_map_single() changes which break
> AMD SME host support. There cc_platform_has(CC_ATTR_MEM_ENCRYPT) is true
> but force_dma_unencrypted() is false. Normally you'd not end up on this
> path but you can have swiotlb=force.
>

I would consider the above similar to a trusted device requiring swiotlb
bouncing. At some point, based on real-world use cases, we may need to
add protected io_tlb_mem pools. We have not done that yet because no
such use case has come so far.

-aneesh
