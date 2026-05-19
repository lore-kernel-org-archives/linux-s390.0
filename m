Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3BA3BCD31
	for <linux-s390@vger.kernel.org>; Tue, 19 May 2026 14:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779201471; cv=none; b=DNhhHggp1MF4znU/3+s+ARCG0ZZEYJM+RRXxOHBua6u+D0gKANZDAK/fymhbFZnlDCT6J3EdHbh1k2Enx3jP/AcUQWlceDvI2CIB3X3npy+J+CTzTkSC+cHr7vUlAleK/UTlCDwvz/7zdhJp6qbbkuXomzHO6GPLksVqus+NJlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779201471; c=relaxed/simple;
	bh=xoUre0ZHh111UbHEIDXHq8nedRN8EZ+gBdSl0fms4oE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CTUWlF4bOhm8Ra9pP91hZQZAUNrR3s+vKRvkO3jU/QWpoeSSx7Hq1Fl4Rkfp9pzRJuNcpPDElNQ06MzpUx6kC4ADUsyG1eB/iBZIvZXIfvJrDvhYbY3BRI/3ff262o956i+TSsRNJ8/gm8HX+ZTVQS43iCK2eYtlWxWvZDo83/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ND8bcBEF; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ND8bcBEF"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-50d75bfb259so22994101cf.1
        for <linux-s390@vger.kernel.org>; Tue, 19 May 2026 07:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779201469; x=1779806269; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xoUre0ZHh111UbHEIDXHq8nedRN8EZ+gBdSl0fms4oE=;
        b=ND8bcBEFQcbC38uXfsGfsR5V3eoc2nZAwWOBVfkqhEi4BANwiunAEYhAzOpeGVrpPn
         6jWoXH/hDyiWilNr6Cn10fs+FGonrGvYF/Ezi9skTw3IDMAShMsWjPA4En++VBzq5xD9
         nLv/4wZNFtcurXPtgr+mh9aAok3R75juqhq3AHpDGrY5k8KPfEFr52GR/+1mOlj3ax1D
         3CDPPVazCWO+2R+/CM+By2xLdg+9lkkJblqDMMN7ZMVWRXRgcpeEBZ4CMv4Ynfcof0Cp
         Z+K6YOMsHgEbDFrzvP//OTuwfiUePtArXucTEvRhrWhgzHIL7ygZ1gswQhcBW61NoV7M
         diBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779201469; x=1779806269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xoUre0ZHh111UbHEIDXHq8nedRN8EZ+gBdSl0fms4oE=;
        b=SETS/XyPGZy4NMoEbHISnrx6EeNeYyeAm+jrASeVIB4Zb0Kvr+HiZPWbN5gSOrjcoN
         wQNyC+6AxXWgndoDK2kH3rE094yj8I1iQWaLn15dpDRgi6wVK57EvbUBSFMehlGgsGFv
         BajkF4AfKS/5ZsjsRU0M6AMmSIs3u/hc/wFYW5KgblF+o1+Hpri+w062X76XY6CLGeDG
         /Oea0RfAYeu/8MDWQNK9IMUJrW0X5uKaKqwIWIUC5eQu+3rQ+tGa9N1wKCmk5xcb8IpP
         WH4QDMHXNt/AakY75jBEZCYzwWCKumrCy5k8RzXoynLdIi1PPhkm2LA2H+N7KpffXVXJ
         ebXQ==
X-Forwarded-Encrypted: i=1; AFNElJ+tHqA7emFFjzMUCukagNu1OpmXrHvHTbbzeFsqSHWJFyvRja/kwh6VLiNdBEDwgDoHKqjDuBqm1dc1@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy/h29ShuijzRYvAzQ6A5kNs4JKpJiwvXvrDLuSND62RVEgo3r
	kx/MslYZ/ze7meNyilL7QwUF0mtEHfiSTSjtHVTtL81UiAsumGcokA4iRhX4zyRofcc=
X-Gm-Gg: Acq92OFnWlYIfZp9ljEIaejIny2AwtWDx5ZYpn8VAVuVYU/IuDmugi92aA5KfWDGhhY
	FpqfUwIOQhiQagW+3OLXrlkicR8JvtWyWwHOg9vMQ/jyLOsKdU4yIUd+w4aXMvj3dvB/AtZf0sp
	udEgNShj3Kz4t7X3g9BodK4qFy5ptFnptWymJCeLHCKp2hz+GAK+dkc/LocxS33hpKzlbegCP/u
	W4i/AR8oOrVoUBGILpYr7wtPm71zSIlamqd7N4wy+DNF9S/dYECzN8wuJH1m7ysDLR02lARbHNZ
	Mrghfth0bTDtynD5vMDYiHdm1Em6C83ibKI5y9UbI4Y5R0gTDPULQ63Ztilymp3UgsGgnAkpnYH
	6Oaas/5Hn7Gi+rbGyRgI0iggh8sbZ7pbrR0az8vmt5CYTJ15EjLQvgbFYR/MqGCney3pj0IwYpR
	WAsuyudhsqPxm7mxz985y00v4+UdTbE2vVfbgeptjx26yo4RtvIGDZBuyY5u6/7Iur7h34Bq7er
	eVsRoj21AeU4Onk
X-Received: by 2002:ac8:584d:0:b0:50f:c26d:f31f with SMTP id d75a77b69052e-5165a046334mr283700431cf.19.1779201468969;
        Tue, 19 May 2026 07:37:48 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516456b6856sm165713481cf.7.2026.05.19.07.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 07:37:48 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wPLZr-0000000F80e-38LO;
	Tue, 19 May 2026 11:37:47 -0300
Date: Tue, 19 May 2026 11:37:47 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
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
Message-ID: <20260519143747.GE7702@ziepe.ca>
References: <yq5apl2y5f96.fsf@kernel.org>
 <agXaby-7L7yS3Vva@google.com>
 <yq5ah5oa59wy.fsf@kernel.org>
 <agxDxdxynp4KEovA@google.com>
 <20260519132911.GA7702@ziepe.ca>
 <agxolksC_1nfO34X@google.com>
 <yq5ah5o3sdn3.fsf@kernel.org>
 <agxt7SFGT7OLMIah@google.com>
 <yq5aecj7sctv.fsf@kernel.org>
 <agxzanDBmIP54hUz@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agxzanDBmIP54hUz@google.com>

On Tue, May 19, 2026 at 02:27:54PM +0000, Mostafa Saleh wrote:
> However, as I mentioned to Jason, I think with some tweaks to
> force_dma_unencrypted() we can make it work under pKVM for aligned
> memory which eliminates some of the bouncing.
> I am currently investigating that.

force_dma_unencrypted() literally means that memory passed into the
DMA API *without* DMA_ATTR_CC_SHARED cannot be DMA'd from.

It should not mean anything else. The DMA API should never decrypt
passed in memory. You always have to bounce.

Jason
