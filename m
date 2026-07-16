Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0525305692
	for <linux-s390@vger.kernel.org>; Thu, 16 Jul 2026 14:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784213575; cv=none; b=BCJsXM0zYkKWRkEllB2qB6apSi3OctDaX5gFxni/xo8spAzFAUADD48SJ1T8bvEK+kChjPi2d3rr9FX3WRqwVpdxlLwuTVCKh18mAZhcAAzh8fQcSvWk+rJbW4s5HtaZEWKtjbaZhnzLGLAZQNM5kpCw+stcO2WCARi9y27OK8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784213575; c=relaxed/simple;
	bh=Kt8BJTiDI+f7OuSjZH0CFB0i0A4B8tJakd1pImozOd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVuUA87Zfu2jFI82lZnLmnEAA2oH9k2Fpw/yEestg6MrNzMVA3MM5b9trR1HKGFrgD/6yvh9RDUs8b2ETmHBoHS76Wa57A0W2ckvswwMPFOiYr2eaVZ8OAi0qcLjezjcEm7Jt/mkhiaHKr9UA8NN5CSIdGMUowt20TO9hpV5jgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=W73PkPBe; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="W73PkPBe"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51c1805b8a7so69016681cf.3
        for <linux-s390@vger.kernel.org>; Thu, 16 Jul 2026 07:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1784213573; x=1784818373; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M86Ir7wes1y7r8ERYu4z2fhecNCYpHaDZuovfA+lIDI=;
        b=W73PkPBeN88Wo2jq6qTZiy0ieVNB+jgqQ+yeTqNGoYy4NjVkdE3YSnhZSUyczYnxAO
         uhZyzB4PKT067fEEerfWaTtPcAcJODka1DuN9vRZasTWYZBV6XssYoIptVrHmZOyuRt/
         PGJva0VwWKbEwJ1B16I+HccIvSNAmNwJuxRad5vVW4nqWS0mxJ5cruvKmI0IowixdUJZ
         pszZe+1lvcHkcoeCrzpFPKafsu9tQ/34scryRNsE2P0ZJ+6Y3qS+yrzBjUBaEAIc8ust
         K8DIXyuPjatecx0KGd+q18YnNXub9fXsCSiLWlk1wXLb5n6TSNE0SRpMCxsLtLucb010
         +oAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784213573; x=1784818373;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M86Ir7wes1y7r8ERYu4z2fhecNCYpHaDZuovfA+lIDI=;
        b=aADszDMY0p2AeVtCgUrgJh15IT7oiNJHsQ7Eocsb4gWXCcG8iCmyIYn5i+pDZ9+WKo
         K3CeTvWd2NY1EUWCmdaEq+Hf9a4JyjAl6qrm2vYg2FRd/UK2JoIkP5dgXiONo0su3p3A
         AIsylOgPfTtrfwtbY+XXX9KaqYg2mSxQ6rvoLM/3JOYc1xD1GK1bYkC6Xe3Hrgr+vjQe
         vF4wUylHD8NiGwYS8KY14eElOW/Q+eCvEvuCXd9wR7aayvZydFisIG8iJ6dvDaaWiMMe
         /EucEaiWirAeudTOsJXznocwm/dZ5EmkI4ZHIzyrJG3FCC/jVuTCgVarwUomJe3LSgox
         UW7w==
X-Forwarded-Encrypted: i=1; AHgh+RpwkZ8/D0Kkae+2rZNrykQd50+60c2+4uF5xlS78IgfhnsIOgqwVUQcQgRPpb9tS6jw8Es7zH6sKAJV@vger.kernel.org
X-Gm-Message-State: AOJu0YwdrLhha7yoeRbzLjkkqTGVjX/XI8b2jZQiMcXPpwalMlDcP8/P
	vYJxqzHeoLh9cLznRmwN/Q+ChK0DWNt9kKTMjgy/f1Ti9x3zK78gZoHbx2/nvzzFk4U=
X-Gm-Gg: AfdE7cn4RidBcvaT4vynVdH7Qw1mLKveI2XpFQh4/CWn7jWNpGjV0R+iPWXCrDGOkO1
	k9k/b0I4pZRwJnX0F7nYxY4h4ne+JAB4LuQqTiFOb2MlhMXweT+idNgUfZDfCtos17vp9dFRUQw
	2gAbL36S4iUINOm9sbPyvAmSMbC97YkMriskgv1aMM4LXTd37pInZjmSD+f2JLjCC7ScotLdDAT
	tOByJJMS/awRBCXbVB+AOaMUpZ5BDo9M65vnG2Mr1i4fWaaWItYjbggRbifcCgidCEaY8VdttMu
	nbXt2a60VxhA7f4g/sU4YfY4HUkfqv7V2hMm1Jjof+XmFHlcwD137A5S+3NUtQSWDfL0soRr1gj
	teKthpyiq+y7r4q43fpKHqz/d3U+hhsy0FOcR/5lAESaE23Dfsw==
X-Received: by 2002:a05:622a:1b88:b0:51c:1811:6eae with SMTP id d75a77b69052e-51e4f0a757dmr78823321cf.47.1784213572745;
        Thu, 16 Jul 2026 07:52:52 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51ec9fef211sm28849141cf.0.2026.07.16.07.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 07:52:51 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wkNSF-00000002ZDm-0DPq;
	Thu, 16 Jul 2026 11:52:51 -0300
Date: Thu, 16 Jul 2026 11:52:51 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
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
	Jiri Pirko <jiri@nvidia.com>, Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v7 16/22] dma-direct: make dma_direct_map_phys() honor
 DMA_ATTR_CC_SHARED
Message-ID: <20260716145251.GE210048@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-17-aneesh.kumar@kernel.org>
 <ak42F240d-53QeFN@arm.com>
 <yq5apl0xgy89.fsf@kernel.org>
 <9d83ec13-3b1e-4c1b-8bab-16ea057cfba0@amd.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d83ec13-3b1e-4c1b-8bab-16ea057cfba0@amd.com>

On Thu, Jul 16, 2026 at 11:55:20AM +1000, Alexey Kardashevskiy wrote:
> > > For AMD/SME, on host with memory encryption we now end up setting the C
> > > bit for DMA_ATTR_MMIO. This is fine for RAM but not sure whether
> > > some other MMIO bus understands this attribute. Maybe we should stick to
> > > something like __phys_to_dma() for the !CC_SHARED && MMIO path. Or,
> > > since this is not universally defined, just use the old dma_addr = phys
> > > if MMIO and ignore any unlikely DMA offsets.
> > > 
> > 
> > Considering for AMD/SME system an unencrypted dma addr is one without C
> > bit, will this be good?
> 
> Normally both encrypted and unencrypted DMA addresses do not have
> Cbit, with the only exception of "iommu=pt" (which is not the
> default afaik). And in this case, having Cbit in DMA handles only
> makes sense if p2p trafic goes via the root port (== IOMMU in
> passthrough mode, and I am not sure even about if the root port will
> convert this Cbit to T=1 MMIO in this mode) but if it goes via some
> PCI bridge - then Cbit won't mean encryption for sure. But I do not
> know much about p2p (never touched). But in any case
> force_dma_unencrypted() seems to make no sense here.

True p2p through a switch does not call the DMA API at all, it
directly stuffs the physical MMIO BAR address of the target into the
dma_addr_t - which won't have a C bit.

The DMA API is only involved if the p2p will transit through the root
port, so adding the C bit is correct.

AFAICT it is iommu=!pt that doesn't work at all since the AMD IOMMU
driver always does __sme_set() even for MMIO when forming the IOPTE,
which I guess is wrong for MMIO.

Jason
