Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921893F661D
	for <linux-s390@vger.kernel.org>; Wed,  5 Aug 2026 09:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785921027; cv=none; b=MyNvgS3Y6el7DeZw7Ga12p8ooFqgvzlvfYGKK0ahTGYDnhTlHR/WLVIA7CMXnBZ3lAc/T2ghGu+BG6rjX0sEkfVBOt5gewzNIq13ud0dUBzneE/e76Rle+zhvKzFZKVOQja5k/aSswIk+ZO/tn8TrtJ+Q7wqoRORAQ/PejjXqos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785921027; c=relaxed/simple;
	bh=gINDk3IoAOl14/uSe78s8gXta9IkyDgK1jiiLUqSSAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ivqhTCchUxcqCvwfmsTykJVPlX5JRkT+ZQXxc5GxdqsVJQyEMwPtMJ99k1AJldH+eprV/KFYUr330xa3U0rNhaVzBHrXuB2FKLHucKjHZ0gPEB3lobBWmNxZsiE/RX4VgH1s7SoiXcMx7YNvUn6FFI6lDC2tsVW3EPH8aLtjP5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MUY4SAt3; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MUY4SAt3"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4954d5d814fso46335e9.0
        for <linux-s390@vger.kernel.org>; Wed, 05 Aug 2026 02:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785921022; x=1786525822; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Gc5m4+tIBvg0egjJhph4T+RN5CfIOJByD9/EsS70PrM=;
        b=MUY4SAt3iWUCThC9My4iK8q25dVRByYTSh8zwS4wvqRV1OTsIMqLh01YruBxXBHP/j
         E+whf8qm3opjNZdJl13Km4D3M7h2VcVrXsk+TvPwiraHMr77hEYWlOx85ow45SOuCbO+
         d8v9XanvJCExvHD7Q1GPwe/o6dGPIcBgFCKzA4OLwu7FcQ9bBK5qH7Yr9/aEwu/t9gRl
         2ijWQfUuNrJ8iHmyftvlcd5N1idOb8WKs7oGY61z53EwBd7V/0VXu5cOrwg6yJOKNMhd
         NOQMXQIgWoI6brBG/DMwFFMmgU0R8ZzHP9l4HFmdVy515LPtfUaR2aIu5lRVtTYtBdA0
         50kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785921022; x=1786525822;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gc5m4+tIBvg0egjJhph4T+RN5CfIOJByD9/EsS70PrM=;
        b=R85rV8T/sRgxs84SeYjsa+xwxyr13JdGBnIS9QxRDjk8TesUKd/FsYySQyMaL+eV1C
         PHB3sJ2fVDWeOoBClzqW+lMxdGshuT8+yvAi12R1Jdz7U9v1BIPHfOWQnogKLEGOqnX5
         SfKStJMBeFz7a39pnH2YQzbhxNw+WRejHAKQrKP6WImQgs7uZr16+okvLy3LwO4+426i
         dag2gC1Qvmh7Y8/a5BP/lwtw2B9LNyB3EVxt6r4M44mtirD7d3N7L/uNKX/l8yY4vT9Q
         3hmdvvcEZ25+UKepjf3aFtTJNxyTlgjcgPGpSZRP4SakT6X4In7ouCxJRZfQZrrFhUQ6
         X27w==
X-Forwarded-Encrypted: i=1; AHgh+RrGb56sTZXaZmloiBuE4eTBLV+3lv0ni/Om3mnViDAPMc8DnHxC+na/bNNHjt8ddyKgDdX9LnpCNBdO@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7cPwd7Gs0A6pvmLJZ9ECFR/cRo6olT0g7YAHhh1gujigIqXSq
	77G6lyyybzI16HAYlX2fq9atNk7Ogi6BGKW4ABSScca4eAnJ824ogC3u51l+ABQfvw==
X-Gm-Gg: AR+sD10PMyzpDW3SjOjyQTHu4wc2IX5rNd7ohrnJqiaSNvpdJ7Fw57Kx2ErnNBZ1Ah5
	4bDhD3SISPr9kN/ghTIIK74Zdq9HtkPvN7tQgmcv/JtjqWg94Z45kHvGvZmif3goRsqViGw7mIx
	YiaTQZmlHmVgD1+fXx3EjyiDLNEgz6qCJCSvL2BIL9pne2uVawU4IqUOkPJ8PEgthvI4upCcMea
	tOgre7syVu/nITbubQTQiaGGAMTkPxBHxYr7AP0rxqKhK77oNAsS8StrqyO8K6rArPUotSPNSvE
	ylqOqAFSmB1a4TErFMKrFNCeeDCmSYFlmMvYMXB0f4rkbCUYAIVMQCBNSf9fxIHLlEHlppU+5+q
	ygbMDulYmmhzjSeTDgcS5rjWIlKItwm+p7uNKR92w21ygIBL1dOU97qIKxcfIDegMSErFcGnsWh
	k4s7GFId2vU2G3BY/vb5hoDUmWE9hFGaMdoM0NpuKabzkenOanu7Q6/PGtf0fJslD5sBwGxkGX3
	vQuYD9i20i6EuIg6QXWuzDImrcQOQ==
X-Received: by 2002:a05:600c:630f:b0:495:4069:b0de with SMTP id 5b1f17b1804b1-4994f123620mr696915e9.9.1785921021836;
        Wed, 05 Aug 2026 02:10:21 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994dfda45asm92632815e9.4.2026.08.05.02.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 02:10:20 -0700 (PDT)
Date: Wed, 5 Aug 2026 09:10:16 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
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
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v8 12/23] dma: swiotlb: pass mapping attributes by
 reference
Message-ID: <anL9-OrDGqYQAWNV@google.com>
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
 <20260717180442.110954-13-aneesh.kumar@kernel.org>
 <ami_mpd_1pF4Tmdu@google.com>
 <yq5a5x1ygo7z.fsf@kernel.org>
 <amnRB98ZZIysHuM3@google.com>
 <yq5acxw6dl1d.fsf@kernel.org>
 <20260804142032.GC27883@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804142032.GC27883@nvidia.com>

On Tue, Aug 04, 2026 at 11:20:32AM -0300, Jason Gunthorpe wrote:
> On Wed, Jul 29, 2026 at 06:12:38PM +0530, Aneesh Kumar K.V wrote:
> > There is a possibility that we may support io_tlb_mem with cc_shared =
> > false in the future. As a result, only swiotlb_map() knows which type of
> > bounce buffer was used, making it the only place where the attributes
> > can be updated correctly.
> 
> Yeah, +1, the attribute should be changed at the same effective place
> the source memory is changed away from what the DMA API user
> provided. Only the thing providing the new memory (eg swiotlb) should
> know its properties.

I will keep the conversation here instead of 2 threads.

That seems like a big leap, I'd be worried about devices that operate
on confidential data that should not be shared/decrypted.

One example for this which exists in pKVM (this part is not
upstream yet) is non coherent devices that require bouncing but they
still want to keep the data private. In that case ideally they get
an encrypted SWIOTLB pool, but it's always better to fail than to use
a decrypted pool behind it's back.

I have not been following the work on T=1/T=0 devices, but IIRC, they
required some complexity to handle their stage-2 as these modes will
be emulated differently (for CCA, RMM vs untrusted host).
I was thinking that it might be easier to represent those to the
guest kernel as 2 separate devices (bounded to different groups...)
where one is trusted and the other is not, and that way the DMA-API
can have strict rules about memory sharing.

Otherwise, SWIOTLB does not seem like the right place to me, as it
does not understand the context the device is operating in, and the
DMA-API should deduce that from the flags passed.

Thanks,
Mostafa

> 
> Jason
