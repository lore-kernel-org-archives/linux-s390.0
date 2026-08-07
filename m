Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FE137BE7F
	for <linux-s390@vger.kernel.org>; Fri,  7 Aug 2026 16:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786121258; cv=none; b=AYjhjAF8PCCqMO296n3suyNhCvoEdaHsd3ayTAhaayXSVlURTXwmxJrH7WDLyqZFCnA9feS+EYEhg4VqJuYgISLX4N/LUYe16NExNT9Z0ONuoroturusSUjKJBHyTdx3U8et/wT380HMMJBWjW6qgKKQUEMRsKpwTSz6dgL4/VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786121258; c=relaxed/simple;
	bh=7bs5G7VXSiFLS7sfQ/bpcg7JaFFI7guoI5oTlg+tHew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BBky4JiKTteR4yAc31271iZm1V+1BsY+NpeplskapeNutfSlupEPo3RFthgMi6hyIJ3pp2DpBlObxxuRJdGLXppJ2gBveuY6R9F6weg5dbMc556OyKN0AGx4kN1z7cZzeAiKg+uTL/TisKodP0YAsBl/d4ORSMesMLp1XpIvrYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=DFI8JbOR; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="DFI8JbOR"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8eeadbc5e21so24109756d6.3
        for <linux-s390@vger.kernel.org>; Fri, 07 Aug 2026 09:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786121256; x=1786726056; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+gWaXZ9+2O+1F3TFyj+8MDOiIFSD+n/ei0pL8L1uFmE=;
        b=DFI8JbORhspWXRivTxh4KgURgbQAlSfXqwfwkqBL+KfaUOsoik34bi7XTMCILqTCYq
         7FEBn0/j4OWvaKia9hZ1XUFr7BrVOsyoVB15Yowtb3OTJj4Mt7E9+kBv90XmIXYulThp
         g2sC1PEcKqojdIvNXUx2Gk6C9kl1csph2AMHj0rT8NHFEefqhTX+GI6S6hXVvycErETt
         oYegv/UE+lJz60MtS9NFAiaKotZxI3og1sleNdpyGK00dNLVCSfl/WJemyG/ov9B4m9G
         p4r4iEHSSYspWC1hCqDXP4Vh+n/NNB0GJK+pcPhLHIZY4DW+i7bJZ1C7EHoNTOSvmNu+
         FWng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786121256; x=1786726056;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+gWaXZ9+2O+1F3TFyj+8MDOiIFSD+n/ei0pL8L1uFmE=;
        b=OzPPPe2oRKxFsx1Nm9+HfTrhL0LGag6/kJo6mWhppktr9xFXQ3er+e//kJuidjwucS
         By4mkHd9GNEM4BgBJU6ai+yEGiiiN6LfMWyboMgXCRsZUmQqZlbbaX7bBljSzHElcPXD
         rc4ujikepXgzh7+sThVUmN7eqKx+iBBaEBt+wtwovXcPJPr22L3AkNgKNLEaVbPGyrPs
         kAgwb60EGQctYqxaztZmdjs4cu9yr/GSBNGDv3UUlR+TToK6+3sFUbVAZF/WMXNYurl1
         1JOrmxAWUoF7qgUQ46d0BwPR4cR3NmGS/H5VXLx9LhEo5tLNzm17/ItaCy85+ysYxoVe
         oShQ==
X-Forwarded-Encrypted: i=1; AHgh+Rov2ONk7KG25KwGT0pGMQFRA8CV7i6/lMlq3UMf6Aha0tDk0CZ9hJXsAe7PTfd62W2gpCIn6n7vZCyU@vger.kernel.org
X-Gm-Message-State: AOJu0YxvoksksLN0hrlAb+6QU+WWLRC1P7NBqGMMuf9HoAdKQyMZEHiu
	4sqSHcEEr+ukKWtAf/nxK1ZT5FWIXgbdB3QqZHyTrtR6+VEl2WRysEU7dDPOBSLtdCM=
X-Gm-Gg: AR+sD13XlXJP69fFJzvcZK66jBngkVk/INq5bcS057y/PndPz/UfVtBcwSORuRpuzqM
	LgOk1zvSK4GxYYdgCeSwuCWz8a5YI2hxBNmIAr88JQO+hELl2/ElJ3WhWaWotO6qb0NsiIvqX22
	GrzaS42P8SSGsK8KDXrJ+p50qrqJcBr78Y8Srnx8/V7w2Ruk9xY8JKGBq2ynGbgskK/fXW0PfNp
	PSMZdV4oCJ4CmdHQU+gTnaFl4p3zFa291DLj81vawB2s7E+3bXVTPmFSTt/9f4DznWKROsj/Mp0
	GF1AifzWM4GSt9imQDy+YgT3xC6MIShdbCQm0gFlRCW8js9PGU7eHn25m6ogv0Dw3Qs+GUI3mp5
	i/BmeXqMI0ugST6OVN37t0GjgbO6Lgq8fB84kaBEsUmdmcZ/uJ9y2pZurpKGenzHhwv9jhIJNZ8
	djrALNknWGIoT7JcpdOHQnTCGsnm51sfE52f1kq/PXWju/DkQp
X-Received: by 2002:a05:620a:2849:b0:930:f2c8:d9ea with SMTP id af79cd13be357-93671f33f9fmr432093385a.41.1786121255653;
        Fri, 07 Aug 2026 09:47:35 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9366e03ed23sm187954085a.7.2026.08.07.09.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 09:47:35 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wsNjK-000000014w0-1mQB;
	Fri, 07 Aug 2026 13:47:34 -0300
Date: Fri, 7 Aug 2026 13:47:34 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Marc Zyngier <maz@kernel.org>, Steven Price <steven.price@arm.com>,
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
Message-ID: <20260807164734.GE200537@ziepe.ca>
References: <20260717180442.110954-18-aneesh.kumar@kernel.org>
 <20260807092612.2202005-1-aneesh.kumar@kernel.org>
 <anXIZSh9lq99VG9X@willie-the-truck>
 <yq5acxvu2ict.fsf@kernel.org>
 <anXbJ2O4DWgPxCeg@willie-the-truck>
 <20260807135810.GA200537@ziepe.ca>
 <anX7F7dnKOtAOIIe@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anX7F7dnKOtAOIIe@google.com>

On Fri, Aug 07, 2026 at 03:34:47PM +0000, Mostafa Saleh wrote:
> On Fri, Aug 07, 2026 at 10:58:10AM -0300, Jason Gunthorpe wrote:
> > On Fri, Aug 07, 2026 at 02:18:31PM +0100, Will Deacon wrote:
> > 
> > > > I was under the impression that there is a possibility of using swiotlb
> > > > instead of restricted-dma-pool with pKVM.
> > > 
> > > Yes, that patch enables swiotlb as a possibility for protected guests
> > > but with your patch we avoid shrinking the swiotlb buffer even when
> > > restricted dma pools are being used and that's a waste of memory.
> > 
> > I also thought we switched pkvm to use CC-like swiotlb as part of the
> > alignment in this rework? Mostafa ?
> 
> Yes, now protected VMs can use the SWIOTLB for bouncing. However for
> Android (and kvmtool), use restricted DMA. so SWIOTLB is not used.

Oh? Why?

> However, I do not think we should over engineer this in the code,
> swiotlb can be set from the cmdline and now through Kconfig also.

That's fine for android, but real users buying a cloud VM and sticking
a distro on it shouldn't be expected to have to mess with cmdline just
go get a halfway working system

Jason
