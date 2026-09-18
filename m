Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B0949B460;
	Fri, 18 Sep 2026 07:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789715656; cv=none; b=s8tawFrI++Lj8Vr0HfwjHFqkUTJTNSOkVJUNTvtBYE+vwwcdRZiP0PTLQT+/tb2N+7XCLqA/9POMK0wIiFS9BJeLyVpyX75gTaSbu9PHfzdfh9hBdN5hJKoS/FUFLyEbpFYJ6U6mamU5WcBwB/37jsG3bL/QjBpSyyli3dzmf70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789715656; c=relaxed/simple;
	bh=JKzm/+/moTGkRwZZ555XaG2rt7I4Sk2JiqKSwNii+dg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jXe/EFVSwE/juJoEByfc17OqgIF7UyyktBCLW3vWxtNfcXtNrG4G5PVWpi0iNmzx7RX4Mwxg1rEYEfb/6zfzNRprtnqsrv+B7pbIan7W2UrvMEW31RzSjymx3Ay52PDnjGfol97sSYPS3cpGRvkf0xyY+Q/DM/IjN+4vhhVwyLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ko5U5Hyd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ko5U5Hyd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D737D1F000FF;
	Fri, 18 Sep 2026 07:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789715652;
	bh=JSN/3RICUGwBIu5VwI98GdvFqpcrp4blbXSy58qpsRU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Ko5U5HydpSiCUC607T3WB/2e0AHn/OAQOLnxt0skGjaJ6dlvhiveUPAe5HA2uE/PT
	 /hc+DeZpWm/sd4F8F5oAdb0eLJNrmiRC+bntUlPg4EDlGiIcfENFfIbBGiIxZDGJK+
	 wUq6IdZ/oaxCSHRvKEaIWY6++Qi6+D40+DXu4AW9PP3xG3yH/xeFAfC9eAUQ8BglQC
	 k3mFx4QcVIodeIsTG2wP5wzvEjPZ+f94XFWjmYH+IIE1de1/4uniXYM9JgPIaPqejU
	 MOnV3VtS8mgbZEoQ/cKvMnpocjve8EM2tRtFBwQoUzlU/nCjp62BkJGkb9lbetw+5s
	 qREbZFA6/p+FA==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
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
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v4 3/5] dma: swiotlb: Centralize memory-encryption pool
 sizing
In-Reply-To: <aqwPKO80ZEn0cqa7@arm.com>
References: <20260914070135.313337-1-aneesh.kumar@kernel.org>
 <20260914070135.313337-4-aneesh.kumar@kernel.org>
 <aqwPKO80ZEn0cqa7@arm.com>
Date: Fri, 18 Sep 2026 12:43:59 +0530
Message-ID: <yq5a1par116w.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Catalin Marinas <catalin.marinas@arm.com> writes:

> On Mon, Sep 14, 2026 at 12:31:32PM +0530, Aneesh Kumar K.V (Arm) wrote:
>> +/**
>> + * swiotlb_adjusted_size() - get the prospective adjusted SWIOTLB size
>> + *
>> + * Return the size that confidential-computing guest sizing would select for
>> + * the default pool, without changing the configured SWIOTLB size. An
>> + * explicit swiotlb= size is always preserved. An explicit area count is
>> + * included in the size calculation. Automatic area sizing is initialized
>> + * later from the running kernel's possible CPU map and any resulting size
>> + * adjustment is therefore not reflected in the returned size.
>> + */
>> +unsigned long __init swiotlb_adjusted_size(void)
>> +{
>> +	unsigned long nslabs, size = swiotlb_size_or_default();
>> +
>> +	if (swiotlb_default_size_changed() ||
>> +	    !cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
>> +		return size;
>> +	/*
>> +	 * For SEV and TDX and CCA, all DMA has to occur via
>> +	 * shared/unencrypted pages. Kernel uses SWIOTLB to make this
>> +	 * happen without changing device drivers. However, depending on
>> +	 * the workload being run, the default 64MB of SWIOTLB may not be
>> +	 * enough and SWIOTLB may run out of buffers for DMA, resulting in
>> +	 * I/O errors and/or performance degradation especially with high
>> +	 * I/O workloads.
>> +	 *
>> +	 * Adjust the default size of SWIOTLB using a percentage of guest
>> +	 * memory for SWIOTLB buffers. Also, as the SWIOTLB bounce buffer
>> +	 * memory is allocated from low memory, ensure that the adjusted
>> +	 * size is within the limits of low available memory.
>
> Nit: if SWIOTLB_ANY is passed, do we still allocate only from low
> memory? I think this comment made sense on x86 but it's not valid for
> s390, pseries with the changes so far.
>

I'll remove that part of the comment, as the code does not check the
adjusted size against the low-memory limit.

>
> Otherwise:
>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

-aneesh
