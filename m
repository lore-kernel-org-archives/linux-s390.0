Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A45737BE99
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 12:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781871714; cv=none; b=pgE1/gmyPSTz+E0Mb95ERoF6aCttQq8QC/XWBLkch06UQhtkTOoT03wWfzDeoDfuo0Tbd+YUsf55H8W14wvUzRPXkjdYGoktqN+/wefAxHz9XLBNegu5bP+XnlBHXmOAR8p4g2XKS6IGS8hrnIAgdni55ryI19oa5Xep1/VRmok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781871714; c=relaxed/simple;
	bh=bExiT/WO2dhEcZ1qca0P3/dM95QJoJRN/ZwhIblcPaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dq57jkaTC93u4QsqjueEHAvfYUbIiVBvx+EkO9UGV42LVTc8jDG4LJs1LxZ4ERllld6kGEVxQEXKvZHCvGluBRD8ct9upYcZ6WfZFrKbgrCd9/qq3JQ6RFvG0LfthxkvDDqS19FWWjUR2TYCPXYjfeQBHPzp3x//Wo2s4gYLNXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=CEGQdskj; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CEGQdskj"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-9157ec935c5so298710585a.2
        for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 05:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781871710; x=1782476510; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c9LPBfHeyyLdgfb3oWsJJs9sVnnCU9Plv3UTJaVJh/Q=;
        b=CEGQdskjw6tUBEj0VUuzJUf1cqTRwHzSpiIEsMMSQ+A0dnX8DWNoXumPX6teKddEpx
         0588xH+81jtOhmC+v+1LKLKyQZfx7W3C6+YkLR7a6tzF1CFDofOTEt/bOl50nlHw+3MA
         tejY/stezvyWcHZyIQtxJwMcsvBqZ5gthNpsO60FqZy9ylH7jtAWkKImxtXJqy3xYvKV
         j5ACUqvghZIZZR9pCfRln00UeeMafN1XYoabgCzKHYVIlh7dyGM1WSzy4rtlzXpiyG3M
         iorfbRAY158nJC+zbaCznFNeVOsVX+wsQlpNeQ0qZ1fpyaOiixghU7q09SNXrRN+ozjm
         4+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781871710; x=1782476510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c9LPBfHeyyLdgfb3oWsJJs9sVnnCU9Plv3UTJaVJh/Q=;
        b=mawFZ1htQLmakANOjxvh/VAw7jt2PEJR6BpPvlCL9GkizcsyJsGUcAbux7WPUyML2y
         LN/Kqigl9cYxMhwmglqD5OXsRdoTkkSA07TX0XGxz2FSYRV0jrZGMTBul3JLa9aTMq+Y
         du1sgvbcdZNs+MZur7YqAUBf6YsI4cJ51uaD+Q4zJLxFgrqDi4cMQdj0ilDDKUo2enJ5
         HJvlEFuuHJxZQWC9Hse9qZlDcfzpISxIo5Ki42YoJftBaMI/pts1LmHFda9QNRyAjBjJ
         Giz8mzIpr+pU+8uQY5Unl8dRvHMeE0KFUkbR9KANBLxm7LTU/lozl9uBniJbruyG3R6v
         9ovQ==
X-Forwarded-Encrypted: i=1; AFNElJ/WpqqROvRKHuRTrubzMwFQ7ny8+2jxEO4/SUFkO6swfoW/G3M6vtZOBPS99IzaUtpnM2HXEm+6R4a1@vger.kernel.org
X-Gm-Message-State: AOJu0YxMSc0qAXC0p241JE6BqOzJrmzWZE2zdKijKCok1B4yFX7zZ5uX
	4rEi2AqZGMcC3NaLAND0YqoXaT3cDnSAvcwrC6M5ROcCkJRqD/wQWaTSZUQCldBPnc8=
X-Gm-Gg: AfdE7ckbzUQtCDzJw2V0Y/roaA9f0lkPpt6YQ5MUI43g7EVMtm15yabcYWBxT8PQmJO
	/sc/14hL2cN5RA60C8BhfeGgzF8pb+WV+uS9VshTcB41PTyu/4OqyN0T3wG2D76bMHyKQ+Mnkqq
	eA5DW0R8ITgXBAietUKrY1qymVQGGou6wjunyY5zrczV8ur65R0JC6Hc0VbtdXdgAyseds8kbA/
	n3vztT2xShDN0SXf+OhML2HDJohL6cvouJwAmJ32miMnwIrE3/hrQH2yrPCab/ti+wJt3LoEAGN
	NgDUgE9frxVydM4NV5W1CrdvGj7+MT8WpV+76aMsmYaAjPmkua+xJGHrE7KwrBj6mLHOZnQ6ene
	1rs2aZZdjWY22KsU+5QrihCpZoL0gUCyqo+R7AHSrnhAagwjwLrwmHntkIpT9QnOJJj9fOHONR0
	OMTAs2Caj+MXJ6CFvMcTKS/KL1NoqNO7UJmz3njL/plnPz+qIKd6NhFmqCZLXF4GHKgo2jSgZcL
	ZcTow==
X-Received: by 2002:a05:620a:4413:b0:915:1359:fc5f with SMTP id af79cd13be357-9208f835f14mr474588385a.14.1781871709844;
        Fri, 19 Jun 2026 05:21:49 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-920a4966577sm218949585a.34.2026.06.19.05.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 05:21:49 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1waYEG-00000004U03-2Vgj;
	Fri, 19 Jun 2026 09:21:48 -0300
Date: Fri, 19 Jun 2026 09:21:48 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>,
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
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v6 00/20] dma-mapping: Use DMA_ATTR_CC_SHARED through
 direct, pool and swiotlb paths
Message-ID: <20260619122148.GL231643@ziepe.ca>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <aigYbK12D8uKQvJF@arm.com>
 <20260609144746.GL2764304@ziepe.ca>
 <2ecfa1a8-6202-4319-9692-a6ffeb5a3dbf@amd.com>
 <yq5aqzm4dz25.fsf@kernel.org>
 <20260618153705.GH231643@ziepe.ca>
 <yq5ao6h6enhm.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5ao6h6enhm.fsf@kernel.org>

On Fri, Jun 19, 2026 at 01:14:13PM +0100, Aneesh Kumar K.V wrote:
> > And this is more insane logic. The right fix is to allocate the
> > swiotlb bounce from the *encrypted* pools when running on the
> > hypervisor which requires undoing this abuse of force_dma_decrypted().
> >
> 
> Agreed. If the device can do encrypted DMA and requires bouncing, it
> should bounce through encrypted pools. We don't support encrypted pools
> now and that means, we mark the option ("mem_encrypt=on iommu=pt
> swiotlb=force") not supported for now? 

?? if you don't have a CC system then the swiotlb is "encrypted"
meaning ordinary struct page system memory.

The hypervisor should not be triggering any CC special stuff here, it
is not a CC guest.

Agree we don't need to worry about swiotlb=force with a trusted device
in the GUEST for now, but it should be something to fix eventually.

Jason
