Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F56613AA2D;
	Thu,  1 Aug 2024 01:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722475467; cv=none; b=FfxZGOYU5XiWZn0GvJKDCCvppu2SUZu9eG+Eu4AwEOJzaIaXCo7QJ98qJlOt8HeSpcK6o6B4o6d0PHX/C1/Tduj134Hkx7kQcnzxwyLL7pupUFI2NTRuRJpBijr6B4ztngbvPxIkX3az5xvVEGbmqiqT8ycpG/4687f2+Nwp6Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722475467; c=relaxed/simple;
	bh=Pgpqo4RtxVJ1ue8DwjL2l0l2UL9ejI31ZTKHWsBrk4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dq2OwA7S1jIfir6der6dsrP8L1KAJlTfq6QP4CQ/ucCAkIGdyNRjQFrdDL11ze8csPvFx8GhHGKRDRIwHr0RnNlbohryOEbwvvmLrvEwZbdDB+sICMRjrReigMyUDo7cIfG08PjtbB5JcRzBl9SiDs3cuJE3DuVZ8qjNYtSVJO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XVZIR7ZC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVZIR7ZC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FD22C116B1;
	Thu,  1 Aug 2024 01:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722475467;
	bh=Pgpqo4RtxVJ1ue8DwjL2l0l2UL9ejI31ZTKHWsBrk4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XVZIR7ZCGTG0w41hQSmLUNL6cZMuc0xp588STEletZW6rGg2Zw5ATIgyJNDcnVReb
	 B3EfWzjWskItTFqdGEFqKaNkyGttT9TLBlQWyu/w8Tuxs0k3bHkwZd0cu+hd+HJiBM
	 TLWeLNnPzjvU1idP/yzgeefl8ZzJqv2fdNIoFW2QL9yRXpPiUWdGcYIxH9/tq99yFQ
	 xlNDkZrz9RPWiLvSDiSFXG1SG7k6RBe2KkK8hixvDn+6BA8ozx+ajPaXfsgWLA8nel
	 7BEThuYora+MdjBceQZNxXOF5muIGxkG3oYUZNn0HCWNcoz+pncWSlk+9RsOGJ4U29
	 oEus3plyggpmg==
Date: Wed, 31 Jul 2024 18:24:24 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: kernel test robot <lkp@intel.com>, Baruch Siach <baruch@tkos.co.il>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, linux-s390@vger.kernel.org,
	Ramon Fried <ramon@neureality.ai>,
	Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>,
	Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, Elad Nachman <enachman@marvell.com>,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/3] dma-mapping: replace zone_dma_bits by
 zone_dma_limit
Message-ID: <20240801012424.GA1640480@thelio-3990X>
References: <053fa4806a2c63efcde80caca473a8b670a2701c.1722249878.git.baruch@tkos.co.il>
 <202407300338.oaUo6jtB-lkp@intel.com>
 <20240730021208.GA8272@thelio-3990X>
 <20240730153450.GA30021@lst.de>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730153450.GA30021@lst.de>

On Tue, Jul 30, 2024 at 05:34:50PM +0200, Christoph Hellwig wrote:
> On Mon, Jul 29, 2024 at 07:12:08PM -0700, Nathan Chancellor wrote:
> > >          |             ~~~~~~~~~~~~~~                   ^~~~~~~~~~~~~~~~
> > >    include/linux/dma-mapping.h:77:40: note: expanded from macro 'DMA_BIT_MASK'
> > >       77 | #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
> > >          |                                        ^~~~~
> > >    2 warnings generated.
> > 
> > FWIW, this is likely a false positive due to an issue in Clang with the
> > control flow graph for global variables:
> > 
> > https://github.com/ClangBuiltLinux/linux/issues/92
> > 
> > DMA_BIT_MASK() has been the biggest offender :/ If there is any way to
> > refactor this code to avoid this, that would be great (as that has been
> > one of our longest outstanding issues and getting it fixed in the
> > compiler does not seem super easy at this point).
> 
> I have no idea what you'd want changed here, but I'll happily take
> patches.

Unfortunately, I am not sure either... I do not see anything obviously,
so perhaps it could just be avoided with the __diag() infrastructure?

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 3dbc0b89d6fb..b58e7eb9c8f1 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -20,7 +20,12 @@
  * it for entirely different regions. In that case the arch code needs to
  * override the variable below for dma-direct to work properly.
  */
+__diag_push();
+__diag_ignore(clang, 13, "-Wconstant-conversion",
+	      "Clang incorrectly thinks the n == 64 case in DMA_BIT_MASK() can happen here,"
+	      "which would truncate with a 32-bit phys_addr_t");
 phys_addr_t zone_dma_limit __ro_after_init = DMA_BIT_MASK(24);
+__diag_pop();
 
 static inline dma_addr_t phys_to_dma_direct(struct device *dev,
 		phys_addr_t phys)
