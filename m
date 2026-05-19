Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED69B348C6F
	for <linux-s390@vger.kernel.org>; Tue, 19 May 2026 13:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779197957; cv=none; b=S9wipBjPrMXHEO15gURYC3azOkmVZgfg2T8+Em3yVkYP7Se2s6xqDyug/xutjA37Gwcsuh7iW8m2jfSZdO7sk0v3KMxNxM/LiUybxdGtlumOsFPMECS6iHQwyrNmfVlz7Osj7oOWfsI2ZUjp3jGGzCsQny2p8lJPfaT/vUx6Cw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779197957; c=relaxed/simple;
	bh=pRQYtCnb87pUz8VrW1rjYy01bwyg5a1R8WEHmalGJNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qn2Gxl7e0SLLtIkrJnKsZ+h36oWsd3XZWoXmKkWp/PuLf7AaKFWyFQ3hUeCie/jE5Gjw4EW0+UsgQclGIC00+i0M3/MByVtjHSR/9BRHUYPQ1O5IGZvfPuOwT9AHkmYYvFuPCnX9ldCSiuuNjUKpOmF3B267+SrqJ8/1IjZ5ePE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ACayE4r8; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ACayE4r8"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51306c9f2a8so43429811cf.1
        for <linux-s390@vger.kernel.org>; Tue, 19 May 2026 06:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779197955; x=1779802755; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2jBYQyB5cOJsBc04yDDPLVV700aJQU8UB+xEqw7DWQ=;
        b=ACayE4r885XVBMVyYZa0vAYHtQBNpyrylqaQXDTIgPdDQrGmAKcXytME2LgSNtLcwi
         GaZAh9uvnht0EpQHN6dU2fF1vAB59iuxWxO47Gb/xeUWcUm3YXA+09ENJJYcrPGepKDz
         najuJFyuLHmxCq6e4R20Ujr9LDVB8khtp6psjd3D3tmPIjk8PH2xtvIRv6H/iOGB54Y2
         qB9XbW4ToPO0vpkRgle3pu7rl5+ynL5bwyPffVM7FJ1az7aiv418uKofwUPOTZ12oYyW
         I6CbZ3P2ckCSW6v6Fq2RC3biVHL5NoCpWs+jfZiDNI0CC7zs6ZiTY1U4INdJ6fN+Vihq
         d7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779197955; x=1779802755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y2jBYQyB5cOJsBc04yDDPLVV700aJQU8UB+xEqw7DWQ=;
        b=F1nb7JHY2Gp98cF98XIMwFbrAIIkK9b9kbALg23BT1Ybziua/B+alh0DYQQb5RqayH
         KpTa5NZ8xng8LTyULH09+J99uF3Z5BtiI3VBtX10Go8zd+r3bt/vRl0ov3dKZosqKlin
         zUtDLzlj1qaI3SfDKzSBoSO+6dIqDmYAYHXRzU8CJ8+R1oN3aVBkGJUenqVZeAaGc0aE
         fLQeQFTPPqobxrLtzGvwz0pMgbq/wLTHK6HfeZnn+1BLSlCGmTHXJP9ZcuU/djwwYKQ4
         wzNmiS1Oo9dYlMrSWWv4l3EFoAEKQlgGURh+yLZDpHAVdmeu4Q2W1BDganFxx7aa8cag
         9D/Q==
X-Forwarded-Encrypted: i=1; AFNElJ8zVzwfMyXoKDBhA0AOWhZleFgJLe87mLUCJ4TLw452OUMhcIvyi52jFiK58g/5gnf2iEZhYhSX8rqw@vger.kernel.org
X-Gm-Message-State: AOJu0YwITHVNb2SdXl+jNo2eGgXFk/DVaRB6rfeF0MjLl72fLSE+8Clz
	UPmsgBweojVvUbAJX8TTA3kYP22w43JI0NG4ZQeQd2X96A8LA2JGAFZT/T4AQBmPgS4=
X-Gm-Gg: Acq92OHAD53EsfweYQWSycwOKdQoT3/9u0EG5a+ocMzRANXP0SNmQ7HCDewOobQ9aDa
	t/6xuVKeQ+yInrHMY6ybeWhUDfvWIPOKb6azfCTASbz91LG2Kr3UjNXY06Vtp3r+0G/qtahfdef
	KKvR2keP4mGsmvolz2hxtld4t8Tn5QeqYUQfiKFuiCffBlEAsu43EphQNDPA1Naifd9qqQ4xjih
	PQmrJ/GXA495AyYyDMRlUh1nVG2G4vpgI0toMGlHDf3iMa31Njn4OXPi4eO8+wzomA/EYQp0kW6
	OoAgbj/Y6BcxOzIBzkiCHVmttQHmQFGxwn5PyM3OVtGXJfZpEcqXY6Hvx0O+HnXnuxuKOzU5+7v
	yatRbo7e5yeKHOATl4YokusMqkFLoAF/MQG0WfMotO/PiIdMCzbhjaJzKdX5Y2N4RBqdRgC3gJv
	3FXXPu636fpcZ9+HOS65DoL5igC4srE41N40PrzsO6bAC07Bh0mmpKEpvY1qHc3QxIDqCpsjihK
	c0kVw==
X-Received: by 2002:a05:622a:50f:b0:50d:a6e3:ae1 with SMTP id d75a77b69052e-5165a03ee67mr270655651cf.17.1779197954757;
        Tue, 19 May 2026 06:39:14 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516514e0b91sm152289551cf.15.2026.05.19.06.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 06:39:14 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wPKfB-0000000Evg5-382Z;
	Tue, 19 May 2026 10:39:13 -0300
Date: Tue, 19 May 2026 10:39:13 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
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
Message-ID: <20260519133913.GB7702@ziepe.ca>
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
 <20260512090408.794195-5-aneesh.kumar@kernel.org>
 <agSKQrSIhizCXKwx@google.com>
 <20260513172450.GR7702@ziepe.ca>
 <agW2lzJI-20DyJVe@google.com>
 <20260514123529.GZ7702@ziepe.ca>
 <agXfm3mS_M3fvRrN@google.com>
 <20260515225113.GN7702@ziepe.ca>
 <agxETC1rXBUSkWYg@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agxETC1rXBUSkWYg@google.com>

On Tue, May 19, 2026 at 11:06:52AM +0000, Mostafa Saleh wrote:

> > > One other interesting case for device-passthrough is non-coherent
> > > devices which then require private pools for bouncing.
> > 
> > Why does shared/private matter for bouncing? Why do you need to bounce
> > at all? Do cmo's not work in pkvm guests?
> 
> At the moment, in iommu_dma_map_phys(), if a non coherent device
> tries to map an unaligned address or size it will be bounced.

Sure, that's fine.

> In pKVM, dma-iommu is used for assigned devices which operate on
> private memory, so bouncing that through the SWIOTLB would leak
> information from the guest as the SWIOTLB is decrypted.

Yes, a device that can do private access should not be using a shared
SWIOTLB, that should be part of the selection logic inside the SWIOTLB
stuff..

Jason
