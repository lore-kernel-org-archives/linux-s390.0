Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88056370ACC
	for <linux-s390@vger.kernel.org>; Tue, 14 Jul 2026 12:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784031770; cv=none; b=g27b7FnKE4OTd0X6u49xCrChTyVLWLYrVgxvlH0V/zIdwZIfrRhN4lE/cfQKUcN5Ew7huSqmTJO3JBIEhR8LZ4/p/bZm8S+xRl9tHVLC7hEYNTVFijsckibyN4j/ObRdkRTl2xTP9Q4ZMkDptd1z4d/kuGjNs9KU1dUiyvz3uWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784031770; c=relaxed/simple;
	bh=Gu04W+cCiiM26ZsyHUMdXjMPrm/Duv/aZB+CYp/Nq1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5+PNS/nmgcIHhMW11FlWRkNP6s6ssifOJ1Ua97V+nsfsywYMMKJPl9RUNQTZlEIiArkp+sp0fqH1vIad3ygNbovXK2A1G97HtuaIAZNSjRbI8/zCn8RuJyNMkrB4WRfq1AObzLkdlz9yv89Zly3jUsCkGjZESK17aPlEULtmio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=kXbSuiGs; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kXbSuiGs"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-92ea24a2dbfso317289685a.0
        for <linux-s390@vger.kernel.org>; Tue, 14 Jul 2026 05:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1784031754; x=1784636554; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5CIAv+UZ8t7s5h+WlDS73yJMkdztMQ3zXG2Fxq/to8M=;
        b=kXbSuiGsizaJGXnP5Oe10d3MmN6ZDiAdGtR2MPNJ1vRy5smGbDLppm2hUD/hE4rqd4
         WijR9WOS40i+6nBD4RjrDWNfRrspbtfZqht1Vns+WDsFh4mxdQCT/wIa+4PFhElgQ4on
         jj4YtFlthd4AGtMZarD8Tk7xwGUecfLGEhFYVhLN6vdAjHKMW/PgHrGSchgkVMRTfOme
         VO3Y8nrYrYL2xD14FNxaLerz9QcyrB7VpG/BbRV2iCMcZaFuIGlvA+Quo98Wu9ImqfXg
         rlaNePbbMd2NzvQLK2zQiPZuKJImliERRpHt+Y3bNC8diF6RuUL4S02PN7jDPy0wx8Qm
         K9qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784031754; x=1784636554;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5CIAv+UZ8t7s5h+WlDS73yJMkdztMQ3zXG2Fxq/to8M=;
        b=mErJQezwSIi5bu+gMu0bQ3CT681M1UyT6WRSbLQL0qyCp1EW3AxuWz3A8b9EtW6qzb
         MV0nBNbWFh10ixE7CQ2UpGnFBAJy/NnaoeezsXeelnL3iV5OmOPWYEcygamBLKwpUiPv
         8MCGPEIWIqXooRMzBOHbeiAn+zjGoTo/6PHnNjw9WgwZGZcezJ8v+vxhfynFdZPlXzef
         8pezIYszGiuD20ta/67NEQsmNQ6RqVSLvKES7yu3lmRE400REwF0pKQpCiWBKrVZX9nM
         mhS5/FCofvmlW6ZDrwY605rSGOEDQT4cdv2JUNesoFfXiJhEU/yGll9Hlkj67jpJdiVq
         upKw==
X-Forwarded-Encrypted: i=1; AHgh+Rrt3mf4GoNHaZZgBZ4RwyjPwrRlC1gUXszqUDXPvRqQmt7vZWtGy0jPZoaKrAh5Lh+ASdCIDlAMNWLP@vger.kernel.org
X-Gm-Message-State: AOJu0YxIFjZTQscKmpjlE1+wEpnosiTlZnrXG/vTGPHES4u5eypfMMWN
	04Wke3z3FWtEoP+pRZpbZ8sAr/r+uztQrLVyV17i0RgFe6aRvWK0SXCElyY58ZNeEEQ=
X-Gm-Gg: AfdE7cnnVQyM7uuzNUxl9C/sHWKlQCzHZwkDjiOpMGp6TUmskljGiz+SlBP/YZagANf
	e9h4Ev12GgAU77q0Pago4vrlTNDaqClAiJigH7UgtQngH8bRqJvpIfnVwLLsmN9a6OQOgvOmtUT
	pANiacpLNtNXnOKLkYc/xq46+4Ty8Ry/7d0MjeIjd8h+8xwHi9Za0CGezXiOcjMU/nijoKxVyjs
	7+ATXBL7fzYGIYP79UR6jQOFG5Z86lBKm7lmza+EosK+0K7TL+bNHKUGrBoSr2T8ZlpvzjNUU3T
	OCnnOZBgNhM4Rnv2BuCxGqXuXFaZKEOXNSexIeNL6bAgw88XTUSjARDPpIu+SeIBtHAD72F43Iy
	svGCq93hIzQwATzrcmStSx9ZvYrrpb9Kd0JOSdCQIPbmQsceBMH+iTm1aTHUn
X-Received: by 2002:a05:620a:7085:b0:92e:6bbf:966e with SMTP id af79cd13be357-92ef2cb202cmr1211484585a.45.1784031754284;
        Tue, 14 Jul 2026 05:22:34 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd82ea9casm164927486d6.42.2026.07.14.05.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 05:22:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjc9g-0000000FRaG-0ohM;
	Tue, 14 Jul 2026 09:22:32 -0300
Date: Tue, 14 Jul 2026 09:22:32 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
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
Subject: Re: [PATCH v7 02/22] dma-pool: fix page leak in atomic_pool_expand()
 cleanup
Message-ID: <20260714122232.GE3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-3-aneesh.kumar@kernel.org>
 <20260713175433.GI3133966@ziepe.ca>
 <yq5azezumef6.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5azezumef6.fsf@kernel.org>

On Tue, Jul 14, 2026 at 09:05:25AM +0530, Aneesh Kumar K.V wrote:
> Jason Gunthorpe <jgg@ziepe.ca> writes:
> 
> > On Wed, Jul 01, 2026 at 11:19:06AM +0530, Aneesh Kumar K.V (Arm) wrote:
> >> @@ -115,8 +116,10 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
> >>  	 */
> >>  	ret = set_memory_decrypted((unsigned long)page_to_virt(page),
> >>  				   1 << order);
> >> -	if (ret)
> >> +	if (ret) {
> >> +		leak_pages = true;
> >>  		goto remove_mapping;
> >> +	}
> >
> > Truely these _set_memory_decrypted() things are an insane API. So a if
> > it fails to decrypt it can be in any messy state?
> >
> 
> Yes, we could possibly try to encrypt the page again and, if that
> succeeds, avoid leaking it. We might want to do that tree-wide in a
> separate patch.

IMHO it is a horrid API if failure leaves thing in an indeterminate
state. For something like this I don't see why the arch FW implementation
would be unable to restore things back to as they were on failure.

But whatever, everything about set_memory_xx is really bad it could
use a cleaning

Jason
