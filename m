Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7B52BEC34;
	Thu,  8 Oct 2026 05:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791437626; cv=none; b=D+XF+1rDsbDJNGDyCHVQvMhRJmbevT3vjTZ1vVXdoOpyW0OWhpxEQ/OJEm/EI5J9ZvezL1MUvLx9ULCdI8wgbYz8jLPRybooaPz/xGZo50i+OnK4HFTjk+/hhpBQok5Z6pmPG8+OsgziL1lJK8oAaOnBKA8Zf0brazggA7wyLxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791437626; c=relaxed/simple;
	bh=Xr/3FGMXw2SythNdPq6WqsopLIGssI8wJikwFk2nM/U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DgTsaKNzcJzwUvbeuHBGLrl9Cpm9weWBOEf8zcRUe24kZtQnPhBC1AUP6lgApF5FSS2OJt3iDAN9845FhNY1JX1rYV5Qv/6z9aktF2+3NpwUFQu5NcLCusMDaNX5F8KBVLp0Yl0x7MZiOfrwdokt3WGQwhNdn3gsRVeTU05Azqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MlFvX1x1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MlFvX1x1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADBD61F000FF;
	Thu,  8 Oct 2026 05:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791437624;
	bh=DiCB3zTU35Q/So7+8YpTI1O1VNazQCwPsoCqXsbVCxA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=MlFvX1x1UhWZRY1blp5vdgZEPOMCBXQinqSZI84kOfHvYoEphDSM4c94C8k0YCneZ
	 +CvWpN13IHO40ySHjg36SGLM6p3x45bPMR627QwPtHEOxGz1S8+sT5TicHHAqfnwbg
	 bqFKdwKME2OoCRwQAo2p4meLpit9e42WrSXDC9nPxddpD1ycCgJPlJjEd5pDoDOqWs
	 ennUOXzrVpLk3Kqhf1z0mNeMc81DduJcnqdwFkPFglVDZ80bS0a6JisTfrcpB+qHEQ
	 B2B7dFO8dNiI2LLj/G2xvndmsNBdA4U85+1Ksxk77R/C0BzNaKttWJhMVtqisJgUfF
	 7H/HlTSl2Xjzw==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Marc Zyngier <maz@kernel.org>,
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
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v6 6/8] dma: swiotlb: Centralize memory-encryption pool
 sizing
In-Reply-To: <yq5awlrt3dwo.fsf@kernel.org>
References: <20260924060756.1325156-1-aneesh.kumar@kernel.org>
 <20260924060756.1325156-7-aneesh.kumar@kernel.org>
 <asVs3doaJ4WrT3M2@willie-the-truck> <asYZFXGyafRjjBS0@arm.com>
 <asYiOgskwi8JYLe_@willie-the-truck> <yq5awlrt3dwo.fsf@kernel.org>
Date: Thu, 08 Oct 2026 11:03:27 +0530
Message-ID: <yq5av77c92oo.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aneesh Kumar K.V <aneesh.kumar@kernel.org> writes:

> Will Deacon <will@kernel.org> writes:
>
>> On Wed, Oct 07, 2026 at 11:04:05AM +0100, Catalin Marinas wrote:
>>> On Tue, Oct 06, 2026 at 10:49:17PM +0100, Will Deacon wrote:
>>> > On Thu, Sep 24, 2026 at 11:37:54AM +0530, Aneesh Kumar K.V (Arm) wrote:
>>> > > @@ -496,7 +516,8 @@ swiotlb_select_pool_policy(unsigned int flags)
>>> > >  	if (swiotlb_force_disable)
>>> > >  		return SWIOTLB_POOL_NONE;
>>> > >  
>>> > > -	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
>>> > > +	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
>>> > > +	    !restricted_dma_pool_present)
>>> > >  		return SWIOTLB_POOL_CC_GUEST;
>>> > 
>>> > I think this check on the restricted DMA pool is too general -- the pool
>>> > could be tied to a specific DMA-capable peripheral and so treating its
>>> > presence as a global property isn't right.
>>> 
>>> I agree it's a hack but that was the simplest way to avoid the pVMs
>>> getting a bounce buffer after this patch. More than happy to leave it
>>> out and reduce the buffer on cmdline or we come up with some better
>>> heuristics.
>>
>> Hrm, that does mean that reverting just this part will regress pVMs
>> because they'll suddenly be allocating a tonne more memory for an
>> entirely unused swiotlb buffer. So I think I'd prefer to drop the entire
>> series until this has been worked out properly.
>>
>>> Another option could be the arch code passing another flag that it
>>> doesn't want an encrypted pool (e.g. when running in a pKVM guest) but I
>>> don't particularly this either. The arch code doesn't know whether
>>> there's an alternative pool.
>>
>> At that point, the default size may as well be driven by the
>> drivers/virt/coco driver.
>>
>>> That said, such heuristics should have been a separate patch to make it
>>> easier to review/drop.
>>
>> I think the only right way to get a semi-accurate heuristic is to take
>> into account the set of dma-capable devices that will use the swiotlb
>> pool, but that's fiddly and should probably be tackled as a separate
>> series. Maybe a simpler hack in that direction would be to take the
>> SWIOTLB_POOL_CC_GUEST if _any_ device is going to use swiotlb? You'll
>> run into the usual problem of not being able to tell if a device is
>> DMA-capable or not, but you could probably look for a global restricted
>> DMA pool and, if that doesn't exist, check for per-device restricted pools
>> on dma-coherent devices (since restricted DMA isn't supported by ACPI) as
>> a reasonable approximation.
>
> So, something like this?
>
> 	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
> 	    swiotlb_cc_guest_needs_default_pool())
> 		return SWIOTLB_POOL_CC_GUEST;
>

Detecting a DMA-capable device is not straightforward, and if we get it
wrong, we will enable SWIOTLB_POOL_CC_GUEST unnecessarily. Would the
code below be a reasonable approximation of what you suggested?

Another option would be to make swiotlb_cc_guest_needs_default_pool() a
weak function that architectures can override. arm64 pKVM could then use
a different scheme (for this patch series default to false). Would that
be preferable?

#ifdef CONFIG_DMA_RESTRICTED_POOL
static bool __init swiotlb_of_dma_candidate(struct device_node *np)
{
	struct device_node *node __free(device_node) = of_node_get(np);

	/*
	 * Ignore nodes that don't have compatible and reg property
	 * So we don't wrongly consider a node as device node.
	 */
	if (!of_property_present(np, "compatible") ||
	    !of_property_present(np, "reg"))
		return false;

	while (node) {
		if (!of_device_is_available(node))
			return false;
		/*
		 * Ignore reserved-memory nodes because that have compatible
		 * and reg property
		 */
		if (node->parent == of_root &&
		    of_node_name_eq(node, "reserved-memory"))
			return false;
		node = of_get_next_parent(node);
	}
	return of_dma_is_coherent(np);
}

static bool __init swiotlb_of_dma_needs_default_pool(struct device_node *np)
{
	if (!of_dma_get_restricted_pool(np))
		return true;

	return false;
}
#endif

static bool __init swiotlb_cc_guest_needs_default_pool(void)
{
#ifdef CONFIG_DMA_RESTRICTED_POOL
	struct device_node *np;
	bool found = false;

	if (!of_root)
		return true;
	/*
	 * DMA capability is not explicitly described for every DT device.
	 * Use coherent, addressed device nodes as an approximation, and keep
	 * guest sizing unless every candidate has an initialized restricted
	 * pool.
	 */
	for_each_of_allnodes(np) {
		if (!swiotlb_of_dma_candidate(np))
			continue;
		found = true;
		if (swiotlb_of_dma_needs_default_pool(np))
			return true;
	}

	return !found;
#else
	return true;
#endif
}
