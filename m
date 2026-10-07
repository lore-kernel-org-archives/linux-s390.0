Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15C046D085;
	Wed,  7 Oct 2026 10:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791369828; cv=none; b=VJyyKi8Odf7eWtiedj8FQ3pDb4G7GAS2r3V+enZ/N18Vj9xk4L28/YV3SJlN9xyDhaL2RBPApbr8OykGuRUey71iiasvJ/2EF5dhFmuK8hSOkhRE7TWcYSDYRSnCGhpska3t4eVhLDUQzuShnwHQS3uKCTIId/AF1DK+Q1E3+ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791369828; c=relaxed/simple;
	bh=4no4EBIa5yNr+kE5WtdIiQ6V9l3YNICeBciitWaIClg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KD6CAAvXXoZjH1Qie4c/fB+nZJmKhMyb6sHhizwnpF1IYks5zBomc0I7EEEG0WVGLlM+jYw1isnPaen8aQvjBnwb5Xl2mSuZv5oXkFXLvJam+jQkAdvfaaXnm359wqNXAR0w0CAC0yW0LqMddZkiHO0FUhPEJSWqz9XtAWRbYIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KN8YV3SX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KN8YV3SX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C1281F0089B;
	Wed,  7 Oct 2026 10:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791369800;
	bh=dSfm8zGQjJ78+rtH0xMcl1bNgx4bDu9UJfcECSmeR6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KN8YV3SX/+vPIl1z/SoJzky7kO3iOdA4eCZLo1Isxg0ipYiQYxsj//oMDVe5DeCgb
	 +ZX1vOXpBD7AdvgI5nw4WLDz5dbF29s7hgAge6B7PwmKa1GBPPoltb+giqqMWm+qNw
	 o+yKY8qUAvodMMP8XJR0xLtMKU4jBz+wTqpOD1RizC4SBgc30I38SANe3eP4rmIG+p
	 RNzAxxe1agTFDTGezv+Jpsq1Fz5G4JWaspFxdRJqlOaPn73xQTvQ/uKIL3Sul9Dr3Z
	 HkoDk1IjsaFDQ018+5v7dbi7LnM2VTHd/NtIVcLgo74xY8frMJePFisRyln/P2PrJB
	 nWzH8B97sx6dQ==
Date: Wed, 7 Oct 2026 11:43:06 +0100
From: Will Deacon <will@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
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
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v6 6/8] dma: swiotlb: Centralize memory-encryption pool
 sizing
Message-ID: <asYiOgskwi8JYLe_@willie-the-truck>
References: <20260924060756.1325156-1-aneesh.kumar@kernel.org>
 <20260924060756.1325156-7-aneesh.kumar@kernel.org>
 <asVs3doaJ4WrT3M2@willie-the-truck>
 <asYZFXGyafRjjBS0@arm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asYZFXGyafRjjBS0@arm.com>

On Wed, Oct 07, 2026 at 11:04:05AM +0100, Catalin Marinas wrote:
> On Tue, Oct 06, 2026 at 10:49:17PM +0100, Will Deacon wrote:
> > On Thu, Sep 24, 2026 at 11:37:54AM +0530, Aneesh Kumar K.V (Arm) wrote:
> > > @@ -496,7 +516,8 @@ swiotlb_select_pool_policy(unsigned int flags)
> > >  	if (swiotlb_force_disable)
> > >  		return SWIOTLB_POOL_NONE;
> > >  
> > > -	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
> > > +	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
> > > +	    !restricted_dma_pool_present)
> > >  		return SWIOTLB_POOL_CC_GUEST;
> > 
> > I think this check on the restricted DMA pool is too general -- the pool
> > could be tied to a specific DMA-capable peripheral and so treating its
> > presence as a global property isn't right.
> 
> I agree it's a hack but that was the simplest way to avoid the pVMs
> getting a bounce buffer after this patch. More than happy to leave it
> out and reduce the buffer on cmdline or we come up with some better
> heuristics.

Hrm, that does mean that reverting just this part will regress pVMs
because they'll suddenly be allocating a tonne more memory for an
entirely unused swiotlb buffer. So I think I'd prefer to drop the entire
series until this has been worked out properly.

> Another option could be the arch code passing another flag that it
> doesn't want an encrypted pool (e.g. when running in a pKVM guest) but I
> don't particularly this either. The arch code doesn't know whether
> there's an alternative pool.

At that point, the default size may as well be driven by the
drivers/virt/coco driver.

> That said, such heuristics should have been a separate patch to make it
> easier to review/drop.

I think the only right way to get a semi-accurate heuristic is to take
into account the set of dma-capable devices that will use the swiotlb
pool, but that's fiddly and should probably be tackled as a separate
series. Maybe a simpler hack in that direction would be to take the
SWIOTLB_POOL_CC_GUEST if _any_ device is going to use swiotlb? You'll
run into the usual problem of not being able to tell if a device is
DMA-capable or not, but you could probably look for a global restricted
DMA pool and, if that doesn't exist, check for per-device restricted pools
on dma-coherent devices (since restricted DMA isn't supported by ACPI) as
a reasonable approximation.

Will
