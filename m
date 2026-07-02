Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A711030E82D
	for <linux-s390@vger.kernel.org>; Thu,  2 Jul 2026 15:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783005580; cv=none; b=NTY84zGIkxyfe3qc/47ULz154OAp1lKc66WcbWHpvBTDMN/AJKNN39VzxRTKn1dpI17wbbHAKhEKOPJrc7B7ICSfZH3s6OMhFYKBQuL2VPkg76Ze7JBYUFpXTlV7iWVRnNKy5wVtmka18vlMhzPWOtpHn+48BiJUExTn/pGxayI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783005580; c=relaxed/simple;
	bh=una0b7iSQE3/1X7UfiBFNzSBZGQVECZybRvoQUF1H+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m35COz0KsmTxEk/AbPE/M5NKBbwcEhrUEnhHmAIdaPPw/xGiMVkPcm5XQ5efhIS1kkOO3NWyR2yjxdADtblofrJfwfMnnff3DLD6eOxtrZHAmPtVgwYYaoln2QprtovgHjkJQqnWTYCSXCJt5fNeklbtIk3FSxkOOQEWmtdX/14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Q6rAF95k; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Q6rAF95k"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8f29ec73064so11895506d6.1
        for <linux-s390@vger.kernel.org>; Thu, 02 Jul 2026 08:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783005579; x=1783610379; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=una0b7iSQE3/1X7UfiBFNzSBZGQVECZybRvoQUF1H+I=;
        b=Q6rAF95kyKde/LHkeezOwOO4bCOvFEwZ8ve/TTPHGlZHLXiSrbSjRgy7SAQdPwzEac
         Y/bUdguxMqxquuqDcvLln4gz3cX7jEluVbFjKG+qXobIEaouJD9gG601uM12TGwh0iz3
         JadwhfLvuEIED28jnlAn893+sfXgBi2o8UmCWRXbgJzI/DN2DYekW1deTv3nevTdnOZI
         P7xbaEakoiUwNOikLbQ0VgD+1TFVhh3LuMg68LhkLPczkuSJhlx12yAoMf3REcXTVbs1
         21lLIXgLbEF8AXAL7mW5AnQ5uUePS72PI3pAOYTl289HRbww/i9aN+2aqSQN4KgfEsYj
         ts1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783005579; x=1783610379;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=una0b7iSQE3/1X7UfiBFNzSBZGQVECZybRvoQUF1H+I=;
        b=aUC/Ebc6rbYRxMUARYu5IM3NcKFNzSqJfBjDO1ZEP1kB5KUve4hXy5hGjjv52S3qfu
         5U4/a1OSoe1E+ZhVwSzH83DL/LBvcZmzA+PPr02ITbQ77+/Mt0eY6w6WgLxMJCIWrVJ/
         B1UmPX8KMXmbQ0e7xoL/REukkM8Bt3Hp82RWaOsgKz64/NW9fdWXvjotSVR8R6+XJzN7
         7H5xkgKr5jKAKqWi0uloWPRVcFrQKXSqiXFgcI1LpNYAr01jcFyrbH+tIpF1gHajbQqN
         f7jX6Ac31Cx2gu339TCersmm2MS331f+p3Ej36BPlgUs2HZtRYV5PC/18BCCxHYcusI8
         7gZw==
X-Forwarded-Encrypted: i=1; AHgh+RpH0GHL+jPcnrSjh+2eJb2cjq5qGv3rF0GknRCzqyffRCrVIHD0xg4B1gYp3lkRWihJKAL/t1EXlBvJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz3wtvYELJ0RUgEghtjOv48LpPfRokG1JEObxxKGSYWJf/2Vdr
	LMf9E8e84FqKWZafqbVmafAO/uvJFsndJ63yTo7W78+rm1AtAGtEHl9diUjVWMQ1rkw=
X-Gm-Gg: AfdE7cke1gujDoktOFDGeZZxgK87r1TxmLCBgL/I9LMIUAxxjMO0xyHpUcMjs+zcBMw
	O+A1rtU0nrbZItWcGnTkCIkly9s4f7/yjd9rfSwOAiDnyGUKzG6E+8wTgemIAh3Qed2d+Cm04vZ
	fquXdW+3OPRplH/8fgUAhHEVCgpMdFvCo+9v7W3FUFIi5DXR7+rflboMs1IeyaJLZteNcaw0mKP
	59OTjeDQ8r/z4YwmsmMFNlfetUjULw3IWJz/kwlfVb1GpQEDCUfZgzp8wLf1Ujgcn6VQoLbO+Zt
	TB0LRVhbDohZh2Y58DFruFaer2XdHsz6NKQ8dEvwHj443eTKJH+nfbesKXgSkf12d7QZIUHSAjs
	RzwmAehg48luHzdcXJKc5gdtxE/oSLNYfsKOK+DYiixwEKypMFO/MV5/PpTVGDJGtBGpNfNtlGd
	r90+uRDwIuZ3XjP8kbzyWf1y6Yw//YEUBShYkh6Zh4+8mSXANCwXirX+4rvMABTc7bgjk=
X-Received: by 2002:a05:6214:4208:b0:8de:16a7:fbe3 with SMTP id 6a1803df08f44-8f3c863d139mr68985636d6.31.1783005578597;
        Thu, 02 Jul 2026 08:19:38 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f471de93a1sm27985376d6.34.2026.07.02.08.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 08:19:36 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wfJCR-00000005wsj-2X8o;
	Thu, 02 Jul 2026 12:19:35 -0300
Date: Thu, 2 Jul 2026 12:19:35 -0300
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
Message-ID: <20260702151935.GR7525@ziepe.ca>
References: <2ecfa1a8-6202-4319-9692-a6ffeb5a3dbf@amd.com>
 <yq5aqzm4dz25.fsf@kernel.org>
 <20260618153705.GH231643@ziepe.ca>
 <yq5ao6h6enhm.fsf@kernel.org>
 <20260619122148.GL231643@ziepe.ca>
 <yq5aldcaejos.fsf@kernel.org>
 <20260619140616.GB1068655@ziepe.ca>
 <yq5ao6gtoncp.fsf@kernel.org>
 <20260630174216.GK7525@ziepe.ca>
 <yq5abjcro17x.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5abjcro17x.fsf@kernel.org>

On Wed, Jul 01, 2026 at 08:39:06AM +0530, Aneesh Kumar K.V wrote:

> This is the only code path where we need to special-case host memory
> encryption. For this reason, I have avoided renaming
> io_tlb_mem::cc_shared to io_tlb_mem::unencrypted. I can send a v7 with
> the above and we can review the changes based on that?

I'm OK with this

Jason
