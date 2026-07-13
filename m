Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3926E357D19
	for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2026 19:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783971740; cv=none; b=lk+q+Ox20qLkAZobQRw2c3pXWG7JXFLuo4zZV5+Akotm0MDkaI9uskw48MvGjfdz5Honm86TfXfjoTZXHMxgkKFfWuWvUYdmitzgiKgK5aP/g2eIg3FBr0isTjLs2OMNpZzHqaBkIs8+QXCGiL6vKN69QUDDpvd68K99j2ZhF04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783971740; c=relaxed/simple;
	bh=5d6Bc8gkCbSlPfvzi0E/608dMWlnVz1C1iUyYSF7w/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OVzcQTOqeOSwNsUeN1sU4nQHYEAtAlx4WHFhKmjqqounHrk2tlfUhLjJpvUDSpZ7+87jbTr1g2Ev21BXgB8Myu6mDM2uuccWDfKXjPjYLiGfmiqdJ82YIcxjZQ5m7vocb9JqXPnJktl0Z81LSS43fDCKmSQvlCnIGvB7nqfOH1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=K/qvTTqN; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="K/qvTTqN"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-92e85499ffbso21175685a.0
        for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2026 12:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783971738; x=1784576538; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q5KluJxuBWim2YOI+gCMldEdZU/bLOQ3tr992AX6OwE=;
        b=K/qvTTqNV9qxStEIt2GJD2Wf6/0r0z9sW9cWUCgNW5gGeAQjbbXSrxxu2Bx2DFxfT8
         DGllO8QzGEousqgXPH65cd9le50bm6uPxlOQgnizfBly/QgnH187G5C1rOdBO830NO7o
         kPTactL8NC/UHK8nW0KOwy+LacaUHWUS0kbL21Eg+BJEyUwpn1tMc9Ge1UWxAX4I8ozi
         hDhOei25p6uEqJci904/XXhjkzbdy+WK7mUmW1biWG8gRrnNYrkRL2YuCjt3rG4Ratvx
         oO8pfQ5H+zLvfeMnJKiXToUjB3PBoLjxEcSIOiAMortJfIDYvnOeQ/BGWyXHS4A0lpcE
         3hpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783971738; x=1784576538;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q5KluJxuBWim2YOI+gCMldEdZU/bLOQ3tr992AX6OwE=;
        b=fXApNf+iW9lwoT1rU4h3Ps4xkyMrk8+At/+aBFNwnwPg7ro6aYMn5e08vn1uSEVrZ6
         DcnpLlkeJIMkg/8pipd8EvEODsbSadvjV6fh+N5xYiHRxdn6owdcBcc4rjjNDls+2bx+
         VoOn2FsjOYppI2gwm2gCTGaEXBvKYGH49siKB3Uf5M7T1MvGfYaz4pRCA7i1D82D3RPQ
         /GHWy0qqdBqTn1BLTScvYckxsMIlE1Z1rR7hAcR67qhxSankaCR87nyZd8dGOp4FpZIz
         aLZsWcYXUPV8OzT31NBOTq0uuWx+liN/naJsKk9CS+9hKy41T/Znr3RrnSJGpRJXTWPq
         WtLg==
X-Forwarded-Encrypted: i=1; AHgh+RorF68lTkYLERVema0uHX1Hq1J9pq+1XjiBVBWkbwoU0WsLpBu/QYVcNsebFWuwtOK5n+rV8diLZQcE@vger.kernel.org
X-Gm-Message-State: AOJu0YzwE9uyL6JfXe/0dFgIIAeZZ72cAnR2Lz9EID6nBp4pbKiwyJAL
	VYiGI4owtj5w3ACmW2SMVziTaLmtZL6oeVz0qKEUuG/gJTIsdxoUPk0TY3bQAy741Uk=
X-Gm-Gg: AfdE7clOIC5pLGN1L44IUTajJazRDO148NlIQ2qDjKgRSf0R5EtJHjiFisxa9fdEwRr
	MkNHo5jZ5XgHhFxKP6IS5XzEpZz77NiwEklfmQJbaG5U62MN9v9BHJu1ocATT5++id3BBJBZvtd
	fobCyYAem40tH+609QlRklqE2qSee5iJgVGlHJyc13lL64mhdkLhrxmVrepewAaULyHFcPCaPjw
	51iNHczVshHCUKdVwkdrsheNhkXrMzy30iAQQlcesqGRh+GphEdox1v9YP+cuqJBkfwOUrUHxga
	tbkadnnd/DjefkzIFnguCJzfNq816KSOGdjqtPrjBhFpXb9MGsOjtHS9ayZZenMUm2Pbm+z3XZp
	0W+o4v3tkbtn75aK1WV4PS6tCtOzDY8xLwIL+8nYIbgqdJtyDvu1Lb9/Lk832
X-Received: by 2002:a05:620a:262a:b0:92b:d4e3:1f08 with SMTP id af79cd13be357-92ef2bcc2e9mr1042196885a.55.1783971738155;
        Mon, 13 Jul 2026 12:42:18 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5d37540sm1154048285a.38.2026.07.13.12.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 12:42:17 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjMXh-0000000E6o6-0etu;
	Mon, 13 Jul 2026 16:42:17 -0300
Date: Mon, 13 Jul 2026 16:42:17 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
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
Subject: Re: [PATCH v7 21/22] dma: swiotlb: handle set_memory_decrypted()
 failures
Message-ID: <20260713194217.GA3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-22-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701054926.825925-22-aneesh.kumar@kernel.org>

On Wed, Jul 01, 2026 at 11:19:25AM +0530, Aneesh Kumar K.V (Arm) wrote:
> Check the return value when converting swiotlb pools between encrypted and
> decrypted mappings. If the default pool cannot be decrypted after early
> initialization, mark the pool fully used so it cannot satisfy future bounce
> allocations.
> 
> For late initialization, return the `set_memory_decrypted()` failure. For
> restricted DMA pools, fail device initialization if the reserved pool
> cannot be decrypted.
> 
> This prevents swiotlb from using pools whose encryption attributes do not
> match their metadata, and avoids returning pages with uncertain encryption
> state back to the allocator.
> 
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Mostafa Saleh <smostafa@google.com>
> Reviewed-by: Petr Tesarik <ptesarik@suse.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  kernel/dma/swiotlb.c | 80 +++++++++++++++++++++++++++++++++++---------
>  1 file changed, 65 insertions(+), 15 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
