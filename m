Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9EE175A60;
	Tue,  7 Jul 2026 15:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783438910; cv=none; b=vCck41OAdCI5HpfAxd7y7l0JbhYMKFraUfdbtkAPpDGuLvSY+9wcUvHKyvOzyXmggGm+axGv0NWZYfMlckyOKFsmF81HO4ho7NuQCsUnEnOuJ+fL0DxFvXstlgOfx8Asqg1xdeDWt962VAJIQ9j+FicziD0OMQpebTQLJwmwB2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783438910; c=relaxed/simple;
	bh=xMFTUswuraT98QQrkLx1TpVKtw83hgxNIbc8hHyXcSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ni9ux8JDtWCjs2KwKfj9Z+LRPrLwvJde1pgykHxh6m8g/7xmbpB9AoeIfLUt67qmQtfTBGwqUTZy+5cmFO8geV+K8eafSufag1lRwVXhXjI3LstrYNdoqZURDZKbfFHNtqb6et3Fbvqxx785pt0J8h8xsnhxmENyr5HWm8kNI4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=YcCuSd4U; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="YcCuSd4U"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5EB481AED;
	Tue,  7 Jul 2026 08:41:43 -0700 (PDT)
Received: from [10.57.38.146] (unknown [10.57.38.146])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F0913F905;
	Tue,  7 Jul 2026 08:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783438907; bh=xMFTUswuraT98QQrkLx1TpVKtw83hgxNIbc8hHyXcSM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YcCuSd4USWQ9JvBOwgdQS/XGW7fN5UF5gHXcM0Ogcbv+GMTsGplKLOKCsaQ73/VF8
	 1xuAF2K12iBvJ56gFYBusyY7CPREK4DmWCZ4DbU0txiXaoauL4t7iPzZRJzuP3+6Uq
	 EAUVgOWIKMO2gsIMqcbYolSuec2zbVTSCMm62+CI=
Message-ID: <8d6b24ea-3a63-497e-9ce9-6a8e4d340665@arm.com>
Date: Tue, 7 Jul 2026 16:41:40 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/22] coco: arm64: s390: powerpc: Mark secure guests
 with CC_ATTR_GUEST_MEM_ENCRYPT
Content-Language: en-GB
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev
Cc: Robin Murphy <robin.murphy@arm.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Steven Price <steven.price@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Jiri Pirko <jiri@resnulli.us>,
 Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
 Petr Tesarik <ptesarik@suse.com>, Alexey Kardashevskiy <aik@amd.com>,
 Dan Williams <dan.j.williams@intel.com>, Xu Yilun
 <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-9-aneesh.kumar@kernel.org>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20260701054926.825925-9-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/07/2026 06:49, Aneesh Kumar K.V (Arm) wrote:
> arm64 Realms, powerpc secure guests and s390 protected virtualization
> guests currently report CC_ATTR_MEM_ENCRYPT, but not
> CC_ATTR_GUEST_MEM_ENCRYPT.
> 
> These environments are all secure guest configurations. Their
> force_dma_unencrypted() implementations also treat the same secure guest
> state as requiring unencrypted DMA. Report CC_ATTR_GUEST_MEM_ENCRYPT for
> the same condition so generic confidential-computing code can distinguish
> guest memory encryption from host memory encryption instead of relying only
> on CC_ATTR_MEM_ENCRYPT.
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>


For arm64 bits:



> ---
>   arch/arm64/kernel/rsi.c                      | 1 +
>   arch/powerpc/platforms/pseries/cc_platform.c | 1 +
>   arch/s390/mm/init.c                          | 1 +
>   3 files changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/kernel/rsi.c b/arch/arm64/kernel/rsi.c
> index 92160f2e57ff..207e36db1e7a 100644
> --- a/arch/arm64/kernel/rsi.c
> +++ b/arch/arm64/kernel/rsi.c
> @@ -27,6 +27,7 @@ bool cc_platform_has(enum cc_attr attr)
>   {
>   	switch (attr) {
>   	case CC_ATTR_MEM_ENCRYPT:
> +	case CC_ATTR_GUEST_MEM_ENCRYPT:
>   		return is_realm_world();
>   	default:
>   		return false;

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>


Suzuki
