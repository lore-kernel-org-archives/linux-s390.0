Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6DE46AF14
	for <linux-s390@vger.kernel.org>; Thu,  4 Jun 2026 14:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780583405; cv=none; b=KUbgwq/CS5sLD76duc+0lugTWDEYvT8qhQ8QZD0VQVmHuD//TGiSTHo6XqupRFoC9TmzGjO83m1PqJizd5iMflq92l+7OW9G5kAA/tXBSqL7928Ex+Vg/3PVFuOk6Of5D0MFicEnSX1xTJDHAtNYs9cGA4ECZFLDD/EdWIYYOVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780583405; c=relaxed/simple;
	bh=uV78Na/cU+RIve0Q1YJ19wLHf0X6yGP9GKIsahjNfAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pZR7FjAmmcW/auxUJVxApXngK3uuStXkjhynHK3If+oeGdOtGiN2lsJ3oTiBzEm7XxBQPSzXx8FhyuuCvop5vF5qufdeITFCKyo+jSd7FU4Rz3mb9CB3kJW1s7dxvKcxnO/3rZF04k7NoK+vT9hkNxNMoRxflzQYGH7Z9g9Xa84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=WhXP/5Ul; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="WhXP/5Ul"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-9157ec935c5so131585685a.2
        for <linux-s390@vger.kernel.org>; Thu, 04 Jun 2026 07:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780583403; x=1781188203; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=leYnnf5Pg/xQRLvt6GMDQfv6g59yyMdkhV1lUPQrWAM=;
        b=WhXP/5UlNSCaNX9EtYvizOTbjzvTYIDLo51KQuUuzQDYBeTbYHkN0+SeQatPn6TzxE
         fGQXR/IFUji7JWNjULzs1sUihdkgUkdXjHZVhIXgumUxrv04ZI+t1NGLdjv6xIrjYCmD
         piEZkEs7yPXtqyug4x130DU9oaTioZc6pBPjQEIF1WPYu9WB2eImq+ywr5XsyczA9Xf9
         hoOb3PvuQRtkzHPB4qpJp65nxM+60ELBIUv64Gf5ufC9NuC1V54X0AVq7gQPekx64Ra4
         rx5QQ+t6N01GZ7fhHJwPipjw8nQ2cFI6d6fEAdJ41Q9X/Rto7PWvWIN4YRPZzTr++ooz
         /9Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780583403; x=1781188203;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=leYnnf5Pg/xQRLvt6GMDQfv6g59yyMdkhV1lUPQrWAM=;
        b=RxpOVHGQIaCXYazCPRoBdhjtJPdaNegfqyBB15BtLGwv0apZUGqxOQA9sJJtlIOeAA
         6OheIyhbUaQ1qLbV1LRiuZ6tXr6d+Z9QBYbmSSqMOJdyr6ApeEdZnMIfqUKO4CNOhEqq
         ggvK01dEOvTpGJ9NK6ZsrNGMwzaG0QuT+J/b39amxQajluJqq8VFwMAE++veqWSILeLV
         lmggU3roSM9wMdfNZVmXsgD29KdAfkBEksqTgkpYnV8XwgdVkGODpTWZbxnUzXWRBYdf
         qniv79QEw87a+i/rRzJbuzT/j+RG7heMe0NkpLlJHD2I49h0ce2e3KQZ2V6vyrD3rXRH
         zLNg==
X-Forwarded-Encrypted: i=1; AFNElJ/nDu4a6AOAFniwE+538OtUC7olsMuQd1rNieQ4LOluvVbO5HOXh1IExTXWcxXZqZFeGXmi0qiiFOe5@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxvc2jPNcznQBn4SBNW6UNPHP+3ENSwU5traMUnXrnht1hDOjo
	HbapYXdqRCcG8iU1x3Cf3+PN5X35UY8FPRFJSvmCI9uyHAVT69dU+51ZRjmf3JBvusM=
X-Gm-Gg: Acq92OHSKc+wx3tHthg+fN/2i3Rq2/A7A71vL01WHCnDYexs1jqkIj+6hBVHSF5WRsk
	wOei2DNDpPEnrY/lQjWitNExpjxrBo2on86h/9TGoJmvbT8NUgwUTb9bbtHoXpjeLADMMPEitzh
	6nrbAGHkvLdKPvL66HW/IbQex17lCVOmRkCg/giU7d/MbHPAbpESFN1jtEsH0B28Gt2b/WXipRj
	cHlfe46hTA8huk4eRapZBNsv94Q4IaFOypzDDl9aHuIaYiq8psoK+rg7WVvPR5+Mq1NsEtfo+d1
	zmBGezNFy7QJ5+Pp+K68ZEv1mtd07jnBayAs/yNXXGI5QBmYzEIAaUdC/00mQaGn8+iVxeuwEV9
	QngXvOuGKV6qa+ocfovqdQqAFVZRaUBGUFDSC+EAURmj2ApMCWmBnUWSBejYiAQrL80S0lpP2ZY
	uxrF+abUOXfjhtevt15KFg4PO4B06HG1j39tr5AERA3E3athHq4pzKsRuRJPqpr8rbm0dG/8Bun
	mTLYiq7O79LM6Qh
X-Received: by 2002:a05:620a:2544:b0:915:3e46:c44a with SMTP id af79cd13be357-9158a80c3f3mr1387419585a.46.1780583403463;
        Thu, 04 Jun 2026 07:30:03 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a21d2c1sm657350885a.11.2026.06.04.07.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 07:30:02 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wV958-00000008IZw-1Hzl;
	Thu, 04 Jun 2026 11:30:02 -0300
Date: Thu, 4 Jun 2026 11:30:02 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
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
	Xu Yilun <yilun.xu@linux.intel.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"x86@kernel.org" <x86@kernel.org>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH v5 05/20] dma-pool: track decrypted atomic pools and
 select them via attrs
Message-ID: <20260604143002.GA2487554@ziepe.ca>
References: <20260522042815.370873-1-aneesh.kumar@kernel.org>
 <20260522042815.370873-6-aneesh.kumar@kernel.org>
 <SN6PR02MB415754E94A9505C2B9739E4DD4092@SN6PR02MB4157.namprd02.prod.outlook.com>
 <yq5afr35sciu.fsf@kernel.org>
 <SN6PR02MB4157D9955A93244014AB7978D4122@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20260603005454.GM2487554@ziepe.ca>
 <SN6PR02MB4157F94C902B78E55E99372DD4102@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157F94C902B78E55E99372DD4102@SN6PR02MB4157.namprd02.prod.outlook.com>

On Thu, Jun 04, 2026 at 02:05:35PM +0000, Michael Kelley wrote:
> From: Jason Gunthorpe <jgg@ziepe.ca> Sent: Tuesday, June 2, 2026 5:55 PM
> > 
> > On Tue, Jun 02, 2026 at 02:24:40PM +0000, Michael Kelley wrote:
> > 
> > > Except that in a normal VM, the "unencrypted" pool attribute does *not*
> > > describe the state of the memory itself.  In a normal VM, the memory is
> > > unencrypted, but the "unencrypted" pool attribute is false. That
> > > contradiction is the essence of my concern.
> > 
> > I would argue no..
> > 
> > When CC is enabled the default state of memory in a Linux environment
> > is "encrypted". You have to take a special action to "decrypt" it.
> > 
> > Thus the default state of memory in a non-CC environment is also
> > paradoxically "encrypted" too. 
> 
> The need to have such an unnatural premise is usually an indication
> of a conceptual problem with the overall model, or perhaps just a
> terminology problem. 

Oh yes I do think the AMD derived terminogy is aweful :(

> Here's a proposal. The new DMA attribute is DMA_ATTR_CC_SHARED.
> Name the pool attribute "cc_shared" instead of "unencrypted". 

Yeah maybe. I sometimes imagine replacing the encrypted/decrypted
names with cc_shared too just to make it sane.

> "cc_shared" set to false in a normal VM doesn't lead to the non-sensical
> situation of claiming that a normal VM is encrypted.

It seems like a good idea to me

Jason
