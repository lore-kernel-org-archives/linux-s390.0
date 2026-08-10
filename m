Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25DD2D592C;
	Mon, 10 Aug 2026 10:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786357236; cv=none; b=FNs9ahbsJ3PIGVPhfZg7rSOriokMwEuHbasKTQda9g0k+TQhoaXzJG7BOvy5ZDlwH16Zdp/c46C0v/2KCOBi4tHtHQj7V51b3qXt7+61/VPYjzp8QbQYVGWh58QGbn4czLGr1lluj8IlWgjNg+a24MHFpDSL9lPjUL1rdpo6KnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786357236; c=relaxed/simple;
	bh=QDnLd2Qssm4qkXIlUrBXDBoa7JhwdI6IPm/F30rfl4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NLJTg8XYmTAADAzVWAQTNomFGSbkwC0B+WhRWGft2otFKRfoOPRw5IBjG5IVAOfaVThNkpKoKyEebHv3wQ17w+8f3uivr9eUSRYPx32NWfEOzTFm8A454F/3vQLFUhguQeM45RajkdIwXClwogE6wwo2l0lh1TVsj9ZQD0+jkhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOj+T9lc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOj+T9lc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 169771F000E9;
	Mon, 10 Aug 2026 10:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786357235;
	bh=KO6eVlrCoGv7LRa95h7FC3E/wXet0JaIn2ciTJXwruE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SOj+T9lcP3BfqhGI1ByG0Cv3PFMgqUXv8bHIyEGQ0Crx7WPJvpMXrDR6cnXA8haDH
	 cYjQmWETdYROJsgxJuY0xAnMz+qcsum4zhRddj5OuQmXFYimXS65x+nSJ/ri3Pl+I1
	 NNbWKQWfp+9tZN7Pqfs4BBq401HgnEBNwmndyyrcCDyiTbSvJXGLmyQauDbrl/5q/E
	 wSkKYR4xrnk2AmyDzRpVJfB47dSs8n1OBShCZjXa2N+CTMRHmZEtOsPiqUVTW8WnRr
	 dQPmOerSaod1zGxwRrnOVvRSAkC99DwkhJUjDCZDMb4jRWp+BTOJwOS++QcQwsQ0GI
	 RC8+hOhcdNwJA==
Date: Mon, 10 Aug 2026 11:20:26 +0100
From: Will Deacon <will@kernel.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
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
Message-ID: <anml6lLRERm1Iv-_@willie-the-truck>
References: <yq5acxvu2ict.fsf@kernel.org>
 <anXbJ2O4DWgPxCeg@willie-the-truck>
 <20260807135810.GA200537@ziepe.ca>
 <anX7F7dnKOtAOIIe@google.com>
 <20260807164734.GE200537@ziepe.ca>
 <anYgXSR4VAi3TpOj@google.com>
 <CGME20260807182023eucas1p1f653436207b2b00338e99ea1d8f847df@eucas1p1.samsung.com>
 <20260807182017.GH200537@ziepe.ca>
 <7d22482f-d5fd-4cf4-9d32-6a54e02f2fbb@samsung.com>
 <yq5av79iiard.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5av79iiard.fsf@kernel.org>

On Mon, Aug 10, 2026 at 02:59:42PM +0530, Aneesh Kumar K.V wrote:
> Marek Szyprowski <m.szyprowski@samsung.com> writes:
> 
> > On 07.08.2026 20:20, Jason Gunthorpe wrote:
> >> On Fri, Aug 07, 2026 at 06:13:49PM +0000, Mostafa Saleh wrote:
> >>> But the whole thing is best effort anyway, the kernel picks
> >>> IO_TLB_DEFAULT_SIZE which does not depend on the system topology or
> >>> how many devices or how much DMA they do.
> >>> SWIOTLB memory is wasted if unused so we should be careful around
> >>> that as it would be the other way around and users would have to
> >>> decrease it manually.
> >> Yeah, it is why the arch code shouldn't really be sizing it directly,
> >> it should be done in common code and, yes, we are probably going to
> >> have to do something alot smarter to have the common code better
> >> auto-tune this for the CC case..
> >
> > What about the $subject patch? I assume that it is still needed to
> >
> > restore the behavior that was altered by the "[PATCH v8 00/23]
> >
> > dma-mapping: Track shared DMA state through direct, pool and swiotlb
> >
> > paths?" patchset?
> >
> 
> I would request that we pick this patch to fix the regression described
> in https://lore.kernel.org/all/yq5azeyxyfol.fsf@kernel.org/.

I really don't think we need it. CCA hardware isn't exactly widespread
and the KVM host side patches don't appear close to being merged.

We have time to fix this properly, rather than papering over it in the
arch code.

Please consider this a NAK from the arm64 side on this patch.

Will
