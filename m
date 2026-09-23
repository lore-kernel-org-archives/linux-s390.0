Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A58153161F;
	Wed, 23 Sep 2026 14:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790173738; cv=none; b=E56Q2tivkd8xiJ6cndZWkRtg5EXL3nze3qnWtGFZxLpcRpDRnfXP3jrTZATk72F1H9ydYUlTdxTe1R3PZJeArE08+g3Xg+Ig1ebYIiQY57KecU2f8Gk5npwJs4uUuD6EDyJrzHmYT8BvRYD9sU4BetQN3Bq0zLOgZdJ4cSGjpdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790173738; c=relaxed/simple;
	bh=XV9XtjxIEhtgt8MoCVDRV/j5+YCPAyY1fr4ZCrG1aX0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aPofFd4Xvv6lWbgHLAMGH/cUg0sDo7hnKQJE3iaO05HbygsqMvlqXorYpze2mMilVdNfFm0j85pZu7/FRuMInq+0YyTXCtio2HRCihMsG647hsWcXBvkfE7LcqIn9G2nliS4rAO3SIb3/xlNBIj95Zi4Opo38T/milPz7KOlXY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKi1uvT9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKi1uvT9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 671E01F00893;
	Wed, 23 Sep 2026 14:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790173737;
	bh=KJ+xcGas6Gs0DUbNkFsLqUYTG/kJ0yvHazAmaBZ9DQc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=gKi1uvT9tdO35/ODP00YcZaB1OEqOdJRXC43vCAtVa6/M+rRGUzFwrcEFzwLOcpM8
	 rFd8FKNGTwcNeaPZJWHgle4aXrscaEQgzv4xKlpwSHuHfa8mOnUXOSeK49Z1Cyp2jU
	 UGm/xAuJEzcqCQlbTOQ8w8JSwAyYh5Y3iAm3TlZ8hc3a46rYZqfHKqB/caJeoPyRSS
	 /zj2aVMtbmuIKRqQ0GaxIrliBpBI6zWSJwyasssqkyicL2r7QVdLv9yWU0w6X9G84P
	 DbwpUJekxBnSZqWqQEEPtZQ3gmRz621gb2mQKitAsMTjtTiWuylDjnHn8PUQB8+ZGO
	 YoEgEm2KBqXYg==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
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
Subject: Re: [PATCH v5 4/6] dma: swiotlb: Centralize memory-encryption pool
 sizing
In-Reply-To: <644aa208-55f0-440c-94b9-75e58e588dde@arm.com>
References: <20260921063628.362078-1-aneesh.kumar@kernel.org>
 <20260921063628.362078-5-aneesh.kumar@kernel.org>
 <644aa208-55f0-440c-94b9-75e58e588dde@arm.com>
Date: Wed, 23 Sep 2026 19:58:36 +0530
Message-ID: <yq5awlsc11pn.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Robin Murphy <robin.murphy@arm.com> writes:

> On 21/09/2026 7:36 am, Aneesh Kumar K.V (Arm) wrote:
>> Memory-encrypted guests use shared or unencrypted memory for DMA and may
>> route all DMA through SWIOTLB. The default pool can therefore be too
>> small for I/O-intensive workloads.
>> 

 [ ... 133 lines skipped ... ] 

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
>
> This is yet another misleadingly ambiguous name.
>

Do you have any suggestions for a better approach? This returns the
swiotlb size adjusted according to the existing heuristics.

>> +{
>> +	unsigned long nslabs, size = swiotlb_size_or_default();
>> +
>> +	if (swiotlb_default_size_changed() ||
>> +	    !cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
>> +		return size;
>
> And this makes for another needlessly convoluted calling convention.
>

I have updated this to

+static unsigned long __init swiotlb_adjusted_size(void)
+{
+	unsigned long nslabs;
+	u64 size = swiotlb_default_pool_size();
+
+	if (!swiotlb_cmdline_size_set &&
+	    cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
+		/*
+		 * For SEV and TDX and CCA, all DMA has to occur via
+		 * shared/unencrypted pages. Kernel uses SWIOTLB to make this
+		 * happen without changing device drivers. However, depending on
+		 * the workload being run, the default 64MB of SWIOTLB may not be
+		 * enough and SWIOTLB may run out of buffers for DMA, resulting in
+		 * I/O errors and/or performance degradation especially with high
+		 * I/O workloads.
+		 *
+		 * Adjust the default size of SWIOTLB using a percentage of guest
+		 * memory for SWIOTLB buffers.
+		 *
+		 * The percentage of guest memory used here for SWIOTLB buffers is
+		 * more of an approximation of the static adjustment which 64MB for
+		 * <1G, and ~128M to 256M for 1G-to-4G, i.e., the 6%
+		 */
+		size = div_u64((u64)memblock_phys_mem_size() * 6, 100);
+		size = clamp_val(size, IO_TLB_DEFAULT_SIZE, SZ_1G);
+	}
+
+	nslabs = swiotlb_calc_nslabs(size, default_nareas);
+
+	return nslabs << IO_TLB_SHIFT;
+}
+

But as shown above, we apply the CoCo sizing heuristic only when no
explicit swiotlb= size was specified and guest memory encryption is
enabled.

>
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
>> +	 * memory for SWIOTLB buffers.
>> +	 *
>> +	 * The percentage of guest memory used here for SWIOTLB buffers is
>> +	 * more of an approximation of the static adjustment which 64MB for
>> +	 * <1G, and ~128M to 256M for 1G-to-4G, i.e., the 6%
>> +	 */
>> +	size = memblock_phys_mem_size() * 6 / 100;
>
> But mostly I fail to see how this makes any sense for the x86 
> crash_low_size_default() case anyway. This calculation is based on the 
> *total* system memory, of which 6% is likely comparable to (or perhaps 
> even more than) the *entire* amount of memory reserved for the crash 
> kernel itself. What's more, if the low memory and size restrictions are 
> lifted for regular CoCo SWIOTLB as people want, then it becomes even 
> more utterly nonsensical to tie crashkernel_low to this.
>
> Yes, this happens to be the behaviour that falls out of how two 
> different parts of the existing code interact, but I highly doubt it was 
> ever intentional, so I'm not convinced that complicating SWIOTLB 
> interfaces to blindly preserve it is the right thing to do.
>


I agree with the concern, but what would be the right solution? When the
crash kernel boots, it will try to allocate the SWIOTLB pool according
to this sizing heuristic, and the allocation may fail if insufficient
memory was reserved.

I have split the x86 crash-kernel changes into a separate patch, which
we can drop depending on the conclusion here. I must admit that I do not
understand the crash-kernel memory restrictions and allocation details
well enough to propose a solution.

-aneesh
