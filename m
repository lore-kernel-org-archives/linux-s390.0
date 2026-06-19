Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307BB273D8F
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 14:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781877980; cv=none; b=D0Vpe6QZPtWiE99yHkdNBGytWOnLq3VspBR9oFLeDuGpmrSZxotuV9KWAfn+kV6a/maWL/XtDpsOQd7+Cs0r3lz9LvRAV9wEforsbONQzq/2fLb5oT/Rrsj61YZIuHy+eyC2rTgxKXxmiBqQjDDw3AHldsUXGxaWpi54Py7wcRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781877980; c=relaxed/simple;
	bh=buYF9eHsVHWOFCxWTqm+jvcdCDIuP3TzFXTJBvz1HK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U9yQAU4oIdEhlSaGLhLwxu8qZPTG2Igzhw67wxpkQtlL40eur6HWHTsF/E9dFi9iCqXlhhViB9mo+r2hZeCLTw9BGLnJpDkrSgKQq/Sy3yHX66XJTVqNYwQ0+BYQYp+lZ2r/ABb12xwTBwDeMI0U65u+ebX211N3PEdd+y61C+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NaBl3rpl; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NaBl3rpl"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-91578c374ecso173900785a.3
        for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 07:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781877978; x=1782482778; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rSB/t2vnZpwaKaBmIo7hL1ql2I4ostuStLW/up58Wu8=;
        b=NaBl3rplGYIkhNRDvGFma2JNCDxeiwi+ljWkLo1efCBOg2xvhLG7CH4vWaEBpVzZ70
         pcOk7AuLUBUKAHqQ0SJAPiPVkI0Cz7JMP6VBuswsWlNPh5CqIjzL6As+r0LfdmZkXVPg
         /rDHDT1f9fR1aTE32YiggUE2AC4m9xikHS+p5dfg+jPrP/XKPiNHl+SVHZoQPQPOllgj
         HTEm89m1UDT+k6l/MIwXHGs9CoNUnJNSYE0BQQvd6vvxWVs00R9ctY/xVIY/WFoYpWOP
         1TxzC6TkuVuXjP8nNpSNC1LY6bx2Bxd5HqTsdT7d3a0ojCTrDS8S9LAWq6WomxYf+6I6
         /zzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781877978; x=1782482778;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rSB/t2vnZpwaKaBmIo7hL1ql2I4ostuStLW/up58Wu8=;
        b=FGopHpFO9ATGQdZlyyReDEc4ezC+xBO3sfOmaKm1GhqUsrlD0cNunaeC7BxXr4ZOSj
         4R90YMNLN9aFyJ2/ByRrO0sinNrOXiNgmyKYewMgkjBiSG/ShtMf4CajLhObb2qDGa7v
         boCj0wAUcMdqEWONiAbfeqlPIepLfz38ejLEU9Qmc9guJ0EYoXaDmMS5w9cvszkrV3Wk
         jv8Bde2eAjUpi5rTfszM+1FM4hw14fXN/kqQYPDc4x+f/3w9OQVCwED0WS2xg75JWgv7
         XOpjNG9B93HVt1n1lE3O6gK6djAAGckYHJ33oUAyGuqJBIZnU+Oh6h18AmRBWZ1lu8Ki
         iX+g==
X-Forwarded-Encrypted: i=1; AFNElJ+x/unPAVRgokwDV6IecEb0vW5TM8UoA/IGmJl6ncjeM3XjD123z7SuX1kbn7eQOlfZ6BhUtj/g87Fc@vger.kernel.org
X-Gm-Message-State: AOJu0YxJEyJ9LMVSFIm0pSkLUY9PZZlWr9d2tmDoKu/QqfhhWnU1It9+
	qeM7/g2PL7jaSCuPjUkbQP2iDIy2xhtOljiXelg9vOciuUSbXIfDf/relfpr8rlb0N0=
X-Gm-Gg: AfdE7ckpWTVtnY3kUo3lFPkUJVODR2RlnAgWpIU99drJWOAg0kfDLlbdUTxBLhZVr5m
	ymkdNzJCWWTX4T5GYbT+OYTl6VZIHIkfjOWcmcWHl2YXjiq0e7eWbn1H2zs0pmi4LEIjPjjns/C
	+mJZ2Fy0JVfZDl1M1fiXMdPmvtBszcCAm7lEXR5IS7RBBMc9fedxot68B2LLrM/aYcsNo1uUCTn
	l22OvpoiJMRRuuKLscjz2/dUz8R9cxnE9Y/ObWXYDtpy4GrRdQXund7p7px4JVTlfVvJ0L/5ttq
	xmmX4jFhqjopwrSmzUBpJqSnE1VVbF/4w50bGKUuLQbRjUmduY3VbCgSjIQWswZEZZ1xAHM/6f0
	GdDQ2/PHyFf9XH6mtrzyTQd/a28P8rcOF/EgfgGQY29jLHuo+5robbRV44Vgkx1Qmg6RSulS07Z
	R1Al7vC+rMSvSwm68KyH5pzZejfvfE18gbYMwqmMEuQob2q4cHOTyJTqkN5aNs6qPRXgg=
X-Received: by 2002:a05:620a:6842:b0:914:ac45:a98 with SMTP id af79cd13be357-9208f6479eamr503398085a.17.1781877977966;
        Fri, 19 Jun 2026 07:06:17 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-920a142f50asm250739785a.12.2026.06.19.07.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 07:06:17 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1waZrM-00000004cLp-3AI9;
	Fri, 19 Jun 2026 11:06:16 -0300
Date: Fri, 19 Jun 2026 11:06:16 -0300
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
Message-ID: <20260619140616.GB1068655@ziepe.ca>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <aigYbK12D8uKQvJF@arm.com>
 <20260609144746.GL2764304@ziepe.ca>
 <2ecfa1a8-6202-4319-9692-a6ffeb5a3dbf@amd.com>
 <yq5aqzm4dz25.fsf@kernel.org>
 <20260618153705.GH231643@ziepe.ca>
 <yq5ao6h6enhm.fsf@kernel.org>
 <20260619122148.GL231643@ziepe.ca>
 <yq5aldcaejos.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5aldcaejos.fsf@kernel.org>

On Fri, Jun 19, 2026 at 02:36:19PM +0100, Aneesh Kumar K.V wrote:
> >> Agreed. If the device can do encrypted DMA and requires bouncing, it
> >> should bounce through encrypted pools. We don't support encrypted pools
> >> now and that means, we mark the option ("mem_encrypt=on iommu=pt
> >> swiotlb=force") not supported for now? 
> >
> > ?? if you don't have a CC system then the swiotlb is "encrypted"
> > meaning ordinary struct page system memory.
> >
> > The hypervisor should not be triggering any CC special stuff here, it
> > is not a CC guest.
> >
> > Agree we don't need to worry about swiotlb=force with a trusted device
> > in the GUEST for now, but it should be something to fix eventually.
> >
> 
> If i understand this correctly, the setup Alexey is referring to here is
> bare metal system with memory encryption enabled and dma address doesn't
> need C bit cleared because it is handled in iommu.

This is how I understand it too, if the iommu is turned on then it can
take the high PA with the C bit set and map it to an IOVA that matches
the device's dma limit.

> ( I consider this as memory encryption that is handled
> transparently, device can access any address because that encryption
> details are now managed by iommu).

Compared to the guest side there are some important host side differences:

 - On the host the iommu can fix it because this is only a matter of
   IOVA range not access control. On a guest even a IOMMU cannot
   permit access to private memory
 - On the host the state of the device is driven by the dma limit
   which is not set until after the driver probes. On guest the state is
   set by the tsm and device security level before the driver
   probes
 - Both flows end up using pgprot_decrypted and set_memory_decrypted()
   to create their special pools, but for completely different
   reasons.
 - The memory coming from the special swiotlb pool must NOT be used by
   a trusted device on a CC guest, while there is no problem for any
   device to use it on the host.

> Thinking about this more, I guess we should mark the swiotlb as
> cc_shared only with  CC_ATTR_GUEST_MEM_ENCRYPT instead of
> CC_ATTR_MEM_ENCRYPT as we have below.

The name cc_shared should be used for GUEST scenarios only.

I guess there is some merit in keeping swiotlb using "decrypted" to
mean it usinig pgprot_decrypted and set_memory_decyped() which AMD
gives meaning to on both host and guest.

IDK what AMD should do on the host by default. I guess it should setup
a swiotlb pool of low dma addrs "unencrypted", but not "cc_shared"?

But if we are operating on the host then this pool is not limited to
only T=0 devices, every device can "safely" use it. (ignoring this
destroys the security memory encryption on bare metal was supposed to
provide)

> Now we have the case of host memory encryption where the C-bit needs to
> be cleared in dma_addr_t. That requires special handling in the kernel, and
> I believe we need to mark swiotlb as unencrypted in this configuration.

I think we need to split the two things up, they have different
behaviors and need different flags and labels to make it all work
right.

> I am still not clear whether there is a config option or runtime check
> we can use to identify this case.

The dma api has to detect, after the driver sets the dma limit, that
none of system memory is usable when:
 - The direct path is being used
 - phys to dma for 0 is outside the dma limit

Then it should assume the arch has setup a swiotlb pool for it to use
to fix the high memory problem.

Similar hackery would be needed in the dma alloc path to know that
decrypted can be used to fix the high memory problem like for GUEST.

I guess some 'dev_cannot_reach_memory(dev)' sort of test in a
few key places? Setup with a static branch to be a nop on everything
but AMD, compiled out on every other arch.

Jason
