Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E824031AA94
	for <linux-s390@vger.kernel.org>; Tue, 19 May 2026 14:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779201943; cv=none; b=KHGg9205hva0L5JPvkjusNlFxCO0VvYH/UST+WDy62N3Hh4lWON5L4TelGQJTvWGpZRM4tBjeHVmLbr5RdnSeq7jN3zhWnpPdu5g9Du6NETbxGYeGUgr9m1YtcsfczVojAen4TY/YEp5ViQ1eMqHYIkz+Qzm+OAv/cdh5TmyiuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779201943; c=relaxed/simple;
	bh=cS793SwOviBnkbKXY6VDrZ6GHZeAkO5ji2zHNpUdkV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bpBDiiguPt18K5IEODCsHJhnrYeZMa6kVi7yCEid/MLCTaNrv6u8/S+CcrY01T7jq5M5yuZhuA029yh4GGLKPMjXbNCJsNj98I403LId4i7MKNQVo8szBfAJDR8czUW7/z0wL66ZTUUo+fl/NiEq3SeC1WAfFON525/ma/lw/WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V75pkfVk; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V75pkfVk"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4891ca4ce02so1825e9.1
        for <linux-s390@vger.kernel.org>; Tue, 19 May 2026 07:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779201940; x=1779806740; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h7Nz6XFDKFDcI1TVcowrB8v0PKJyf/qnRnOMl+2I2pU=;
        b=V75pkfVkdFU6VQB6IjQ1raYR6FJEzU8kxZwZTpL/YBmSoHihrEG6/nmZ0goWpyQw6i
         NW3WkWRfWedz6flI8Q+XDaowusOYXQABc+UI0ZrYhfLT/zWMU6Ode0GsOSN5i7C6uJN6
         upQQmCpHH9hm/3iEJJWV1my+JoFJkoImRGYkwXkJhhAtQsOtDd6wccu55ijdLk2yH5VC
         5sl+Ohp5lZn69DWPsWBE1d/g0JvmIXmuUrr7yvX6/6527nWmzFEbI6wzCCs7gDSH+ijf
         cl/aXsKqa1Y+EHsjrGyPmLIurtT9EGbDvl9vFB4jbsW5HeMJxFwVMqXO8yGBEHVWr/W/
         P/4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779201940; x=1779806740;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h7Nz6XFDKFDcI1TVcowrB8v0PKJyf/qnRnOMl+2I2pU=;
        b=FCKrz2Q+7jd9nFTwzm4ibWC2ktW5ym7JVtg8eBcOG/lx5hXBXz8l34h1WLg4AzUnF4
         FiyknUDUnMRpH9AJeqDu5+/a1WWrmCvV3YvimhBQObg1ltWzt4eGEz7l5UW1ICNcLIEG
         oAm9ZxKIO/Qjl24XQPtRzHcmRpja6NCq5uBDbKzhkbquPP51R/zp0XUUibMVUmO6obNm
         mk+lL7KiepVLuGkw6sIY6/2M2zwC/hugqttvYy64lNXL+/HSRJsMwN5C0YBppypAN/+m
         pwtiqk/UwO0lQRV4QLRwh1KZf3i8IeiQD2p+ik8tSpl8K0YMoLmQ8HP6qp+mYvFlaXdr
         /ulw==
X-Forwarded-Encrypted: i=1; AFNElJ9K6+PWAzhE1BSAJJ6jlFRezWlEkFvZ+JKTQYGJRK1tc1zQx39MN0sN0l3ALvkjZVYvfHo+UqUJTwuv@vger.kernel.org
X-Gm-Message-State: AOJu0YxmXVw0WQfGKlUJAaAiojzM0/p8yzvc6VBCVt7woe2CFysR8R8P
	7Fx4tbgIShhuN93NvzoOYWZU8ZkkC74YYWAtEu2O/76KmIVv3UUYfq9XCYrEBNleRg==
X-Gm-Gg: Acq92OH+LRnKzNPz/7NbBEq/GTesXh+EMqyeFxjxPzDbo+kMkvkwBUyLCz5d7oZnhLh
	pO3RdBbbthJEH4fpoPveG9MF3MPD0QzyXkMt9obtAU6SPg66shL5rdQ2az/wfGL0urSzPN17+z+
	+VYndIix83A+6MeXLy5MGxZObpC7lzTpf4rgZ+jkgHK3oopyTF3yjOm5ouVnvZpnCsPyPbOICjN
	qDu90tLTb6xNkNA5oqgVwQ0JL8yX64y7ELyYEyW4CLVCAd4TydhB1tsAgR3L5AM1pDEk1EOBUYJ
	BDV9GOHNAXXbr8EDew5yZiG/sMxUxjOLB6EFIj/TjsVIfcr1NEjb8osDvDsZgwjX5CTmUPC5K4d
	TU5GNqHxK63ph8K7kTUtZ1V6J4uiJMlh5arA940SNMg3QIfnAoDYF6Y2BZDhhYzaFQ2dNi5rkQu
	v53edEa4OZx1deDH6wgc5tf4QiiGHsybj//UUBXXALr7SmmDD6Ro1GQ/uydvgJC7BM0c2sHPQvk
	ls=
X-Received: by 2002:a05:600d:6401:20b0:489:1f6a:4ac0 with SMTP id 5b1f17b1804b1-48ffa0627e7mr3099895e9.0.1779201939945;
        Tue, 19 May 2026 07:45:39 -0700 (PDT)
Received: from google.com (136.41.155.104.bc.googleusercontent.com. [104.155.41.136])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a178adsm48721081f8f.18.2026.05.19.07.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 07:45:39 -0700 (PDT)
Date: Tue, 19 May 2026 14:45:35 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
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
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v4 04/13] dma: swiotlb: track pool encryption state and
 honor DMA_ATTR_CC_SHARED
Message-ID: <agx3j6Oc8QivZ3RG@google.com>
References: <agSKQrSIhizCXKwx@google.com>
 <yq5ah5oaa63h.fsf@kernel.org>
 <agW5rhE9n2gDQ0w5@google.com>
 <yq5apl2y5f96.fsf@kernel.org>
 <agXaby-7L7yS3Vva@google.com>
 <yq5ah5oa59wy.fsf@kernel.org>
 <agxDxdxynp4KEovA@google.com>
 <20260519132911.GA7702@ziepe.ca>
 <agxolksC_1nfO34X@google.com>
 <20260519143529.GD7702@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260519143529.GD7702@ziepe.ca>

On Tue, May 19, 2026 at 11:35:29AM -0300, Jason Gunthorpe wrote:
> On Tue, May 19, 2026 at 01:41:42PM +0000, Mostafa Saleh wrote:
> > On Tue, May 19, 2026 at 10:29:11AM -0300, Jason Gunthorpe wrote:
> > > On Tue, May 19, 2026 at 11:04:37AM +0000, Mostafa Saleh wrote:
> > > > On Thu, May 14, 2026 at 08:13:25PM +0530, Aneesh Kumar K.V wrote:
> > > > > >> 
> > > > > >> What I meant was that we need a generic way to identify a pKVM guest, so
> > > > > >> that we can use it in the conditional above.
> > > > > >
> > > > > > I have this patch, with that I can boot with your series unmodified,
> > > > > > but I will need to do more testing.
> > > > > >
> > > > > 
> > > > > Thanks, I can add this to the series once you complete the required testing.
> > > > > 
> > > > 
> > > > I am still running more tests, but looking more into it. Setting
> > > > force_dma_unencrypted() to true for pKVM guests is wrong, as the
> > > > guest shouldn’t try to decrypt arbitrary memory as it can include
> > > > sensitive information (for example in case of virtio sub-page
> > > > allocation) and should strictly rely on the restricted-dma-pool
> > > > for that.
> > > 
> > > ??
> > > 
> > > Where does force_dma_unencrypted() cause arbitary memory passed into
> > > the DMA API to be decrypted? That should never happen???
> > 
> > Sorry, maybe arbitrary is not the right expression again :)
> > I mean that, with emulated devices that use the DMA-API under pKVM,
> > they will map memory coming from other layers (VFS, net) through
> > vitrio-block, virtio-net... These can be smaller than a page, and
> > using force_dma_unencrypted() will share the whole page.
> 
> force_dma_unencrypted() should only trigger swiotlb and that never
> memcpy's more than necessary?
> 
> Where does it do otherwise? That sounds like a bug?

Agh, I got confused and thought that it can be triggered from dma_map()
too. I need to figure out why that made pKVM guests boot with broken
restricted-dma-pool then.

However, it should not alway use SWIOTLB? It can trigger decryption for
any memory returned from __dma_direct_alloc_pages() which can come
from alloc_pages_node().

Thanks,
Mostafa


> 
> Jason
