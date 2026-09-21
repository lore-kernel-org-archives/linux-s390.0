Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8497D4BEE48;
	Mon, 21 Sep 2026 15:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790005559; cv=none; b=s2qMaGuEuIYR6ouhO4sqoeNdXgq39J+DD8D9k70GZ4em9x/l/C+n4XNNuLHZduhlFeJbVrpb84+pKoW+OKXxqFFuY9kCLRLl9y9urT0NquFK9dvWoOhik9YP/psdk7XIJKCmRg0dwfqHUZYaBv1XAbOxx24zPqTnDFK4cp6YbqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790005559; c=relaxed/simple;
	bh=cIKZrmFNDgxQa0qqmau+ZqQxkkl6FQkDRcq1dC9miXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l8T8Fz/gX5fRJOcJcBpwG3seaLwx5JDzjF/nJJbMaR+fHyl6ADt1R9mRXCQX7GRGayguZP+t20M35MHzQw5L7VWoHVZfjoERAr/uk6a9KJCLlTh8b7POIqzJaAoss2rDrqV9j67MP6SeT9HBA4gfzGLx2nZyH1aL1vX5+FVyGVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=EoC0cuIQ; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="EoC0cuIQ"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2CE1C176C;
	Mon, 21 Sep 2026 08:45:52 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B5CD83F632;
	Mon, 21 Sep 2026 08:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790005555; bh=cIKZrmFNDgxQa0qqmau+ZqQxkkl6FQkDRcq1dC9miXU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EoC0cuIQz6hLQwqx0QF1eocGbFHcONiXNcdsw4wKNlOhOiOhVhiSZSeViIz1bFPb7
	 muOHOKkL6n9D40Sc0M8nsRMGJOPM/9pqWCmEHDGay46C0wCozVnJkI6euIIJu4A7eT
	 wCKvl5TAYjrxpCiY2Dw1a5LcGTlG38H10QNCNR8Y=
Message-ID: <94630348-d295-4424-9f6c-0dc3b8704077@arm.com>
Date: Mon, 21 Sep 2026 16:45:36 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/6] dma: swiotlb: Track whether the pool size was
 explicitly set
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Will Deacon
 <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Steven Price <steven.price@arm.com>,
 Suzuki K Poulose <Suzuki.Poulose@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Jiri Pirko <jiri@resnulli.us>,
 Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
 Petr Tesarik <ptesarik@suse.com>, Alexey Kardashevskiy <aik@amd.com>,
 Dan Williams <dan.j.williams@intel.com>, Xu Yilun
 <yilun.xu@linux.intel.com>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Russell King <linux@armlinux.org.uk>,
 Huacai Chen <chenhuacai@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, x86@kernel.org
References: <20260921063628.362078-1-aneesh.kumar@kernel.org>
 <20260921063628.362078-3-aneesh.kumar@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260921063628.362078-3-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/09/2026 7:36 am, Aneesh Kumar K.V (Arm) wrote:
> swiotlb_adjust_size() must not override a pool size supplied through the
> swiotlb= command-line parameter.
> 
> Currently, it determines whether a size was supplied by comparing
> default_nslabs with IO_TLB_DEFAULT_SIZE. This fails when the user
> explicitly requests the compiled-in default size, allowing the request
> to be overwritten by automatic pool sizing.
> 
> Record whether swiotlb= supplied a numeric size and add
> swiotlb_default_size_changed() to query that state.
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>   kernel/dma/swiotlb.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index aa19e81ae544..8f86deb25be2 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -107,6 +107,7 @@ static struct io_tlb_mem io_tlb_default_mem;
>   
>   static unsigned long default_nslabs = IO_TLB_DEFAULT_SIZE >> IO_TLB_SHIFT;
>   static unsigned long default_nareas;
> +static bool swiotlb_size_set __initdata;

Nit: there are various ways and reasons that the size is set in general; 
could this please be named something clearer, e.g. 
"swiotlb_cmdline_size_set"?

>   /**
>    * struct io_tlb_area - IO TLB memory area descriptor
> @@ -269,6 +270,7 @@ setup_io_tlb_npages(char *str)
>   		/* avoid tail segment of size < IO_TLB_SEGSIZE */
>   		default_nslabs =
>   			ALIGN(simple_strtoul(str, &str, 0), IO_TLB_SEGSIZE);
> +		swiotlb_size_set = true;
>   	}
>   	if (*str == ',')
>   		++str;
> @@ -304,6 +306,11 @@ unsigned long swiotlb_size_or_default(void)
>   	return default_nslabs << IO_TLB_SHIFT;
>   }
>   
> +static bool __init swiotlb_default_size_changed(void)

...and then do we really need a trivial wrapper function with the exact 
same scope as the variable itself? (Plus the name is similarly confusing 
as the places this is used are themselves potentially changing the 
default size, if you consider "default" to mean "not explicitly 
specified"...)

With the naming improved,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> +{
> +	return swiotlb_size_set;
> +}
> +
>   void __init swiotlb_adjust_size(unsigned long size)
>   {
>   	/*
> @@ -311,7 +318,7 @@ void __init swiotlb_adjust_size(unsigned long size)
>   	 * architectures such as those supporting memory encryption to
>   	 * adjust/expand SWIOTLB size for their use.
>   	 */
> -	if (default_nslabs != IO_TLB_DEFAULT_SIZE >> IO_TLB_SHIFT)
> +	if (swiotlb_default_size_changed())
>   		return;
>   
>   	default_nslabs = swiotlb_aligned_nslabs(size);

