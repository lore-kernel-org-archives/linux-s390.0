Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF456450917
	for <linux-s390@vger.kernel.org>; Tue, 14 Jul 2026 12:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784031916; cv=none; b=kaZ+7m2UuPmUhxBgcuwOuJ7TClCyLGjN3gaC4FtHQ9BYR8orwQTereT3VM25FBgJi+nxQnzOyYfj6fP/MUfzQvldp8JPnoWrnL6jskANbsOo/nYXC9rlaNlX2tkESqmJEolvbvDUXxAtdWEtQ90uCXfnYF05t4Jhlhq7FEOV/HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784031916; c=relaxed/simple;
	bh=k2xYiw7NCZIf6MiSTVQXcck+1c/iJ0/CPBcm116ZP7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YWuAvFpb4ePdkyDfjKoRBfeeOjByAPEkQwt/bYleQu+bDYkq/ookuE7wZJet8mGvhVQkMg3q9SIh15jzErsM4Tj2GK71FdaoNul92Qs8K38mx2+wfE699y2dZ5J8yx7czZOycyXOiTQ2qrssJJ40WXqHP8i127bIhbyhdHTV/Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=DI9EwAwH; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="DI9EwAwH"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92e50c5d14cso257071385a.2
        for <linux-s390@vger.kernel.org>; Tue, 14 Jul 2026 05:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1784031906; x=1784636706; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NW2Ta6E1fh/Eyc2M2Ag3HwLKZzUCdETSNuP1MsMtNOc=;
        b=DI9EwAwHh3lRr87UZlEaiH83gC7ckw2uJ7V75DPKEc8ApyrX/Uu6OWpGj1r8pVBh7R
         VGzEn/0f3pCeyBNvWnQBo5lu9NYhvpkzVVqPymypYYKSdWAbN1QEOnVZTN08FLSGio59
         R3P6iIyAZyh8yAqY6QlthrUYaVZvaX18i0Fti1TBNfXyVTizNcv4VvVv2gStqQeu//8K
         WfHEzUaECjnFgqjjLJvGbrtbmWUogNBF8+JCLBtgyykBQ43nBAoGlYdMtonw0uBCwRMb
         zYAAnV+4/+q+qEwHcPW5Mk2+c3IKOPp+nJEMzrQejnVmVsh3vzybCHsFiVFXrhY3uK+V
         jOqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784031906; x=1784636706;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NW2Ta6E1fh/Eyc2M2Ag3HwLKZzUCdETSNuP1MsMtNOc=;
        b=NG7WK+yZ8Zjdq3o3W78W2L/GHq1BfdXO3Jq+sAkIDVac4jYuGHsrTD/U3OxqaWTMpH
         dutmbs6Pxz03blzHEupx5tvVIWsPPnEz38xFpNmRM9hHW+gLbZxIwtb3TMdrZoKFlx7a
         pLRuNptv8bbt7klTD3lm/8QFBSL6fXMTCH12fTqqVeK4mTr8UddwSNbi/ZhZlVGlVXQS
         R0rtPzlQcjHZMxnODiFPMuLU5y3bceRyeFn8cAAkPT4z8Zc7f3sqTW9cFiCxTffS8YGk
         iuhh2FggBwjBJjOdN95hLpLS+YWJtietQBTkp28xf2iFxFwiGjKr6UY4vpnzgyFdbF8s
         GFnQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqzikr7PKsP5L/j2XleOTFWPLj6dES+HqmppEk6p5aT3Fru1EaLi1qOQnEE/6bKSVI2R8qDkNXlxcJC@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0DWiv6ho/j/N+eD2ZCTC9QqvzMCDI43beKwEad0rGxDE4iT7z
	9jMEjmVWVepnBQFlKtQM1FV2eIVKxuiTDP5HZujjwcq5+Dkua523RFg2O/usHN0DjE8=
X-Gm-Gg: AfdE7cnUeh7ZvGYzHCpOOHNMnit7pf5jdc1Ihtk11RTeKougNyyhHKqoQE8pAVtentl
	25sReCZbewAmYyo8CmZPQ1+24gB0e0rFXxpvfJMQR72aHC9o3fwDJxFTf0ySt8X5ucVyl/Xfsnt
	8q7Bg8OmxtR5zggMF+ucQj5GilG9uK3PJngqvjpJvqP9+Qvvc5kwaaQIxSXHfJMrUPy4ODrQBUg
	8HI3z8wm9qaubXFTAkMH/vLMm1DMrEyYhUe5FR8MqKqJijOrjVM6DSXWz0Ace1aiRtnWVTb4q//
	N4UWEVx2/8goUNLjixTh6uFc7LeLhDpL/2shDIiK59pyeomsc0Wvbq8C6oykRvGf8tPG6pNi09V
	b3PmUtfCVGC7zb2fTAfPRc/OlMjxI6wrWevkLn2eSGjyKJZHqVmZrnovtib9HPMHGr+zTtFQ=
X-Received: by 2002:a05:620a:261b:b0:92e:c118:18d9 with SMTP id af79cd13be357-93083dc8f4fmr281429185a.80.1784031906057;
        Tue, 14 Jul 2026 05:25:06 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5b4a0a6sm1474337885a.8.2026.07.14.05.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 05:25:05 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjcC8-0000000FRl8-3aT6;
	Tue, 14 Jul 2026 09:25:04 -0300
Date: Tue, 14 Jul 2026 09:25:04 -0300
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
	Jiri Pirko <jiri@nvidia.com>, Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v7 11/22] dma-pool: track decrypted atomic pools and
 select them via attrs
Message-ID: <20260714122504.GG3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-12-aneesh.kumar@kernel.org>
 <20260713175616.GJ3133966@ziepe.ca>
 <yq5atsq2md64.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5atsq2md64.fsf@kernel.org>

On Tue, Jul 14, 2026 at 09:32:27AM +0530, Aneesh Kumar K.V wrote:

> If we want to warn about such failures, we should add the warning
> consistently across the code. We may also want to handle decrypt
> failures by encrypting the page again to avoid leaking it.
> 
> I will work on that as a tree-wide change in a separate patch.

IMHO the WARN should be inside set_memory_encrypted(), and maybe it
should be a BUG_ON...

"free" functions shouldn't fail, and returning the memory back to
normal is a "free" operation.

Jason
