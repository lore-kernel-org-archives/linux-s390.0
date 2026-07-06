Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD1E3C6A43
	for <linux-s390@vger.kernel.org>; Mon,  6 Jul 2026 19:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783367532; cv=none; b=fHFdpVzUbOQLS1bKt9WRbSf/KIHl1j7xg0Skonym2neOSMrQkJUf+8Pd4ki/nsRVoF2Tw8YUyrmCKYucu++EveE1WQCnGfZFHkmzoKap++162go+PPCnbc6edu3L3A2cK21nU0HyRcY9pizsG1mdeQ9lpRwKpU0c0F0hln/OUjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783367532; c=relaxed/simple;
	bh=hKPpU41kPhzJrO0I4v1JFTcP1rq+uvMCyjdGLEJkQ9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e569PPRgR1nmP25RNI7poddrFSGuXN+9zvNOxo7QrpWHi2F9DhVFNrvcazhJiD1LXTmK6MRatns9zWFPRDKAXZBO+E+2pBcjaRuK3FuLsaOZ6M0ZH3vPgS9udIpcQH4Lq+uX4TvevZrxwrZqmgxDMjTEcNncBB8udPArbORMeUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=bMjGwiW8; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="bMjGwiW8"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92e7632b193so216623785a.2
        for <linux-s390@vger.kernel.org>; Mon, 06 Jul 2026 12:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783367529; x=1783972329; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hKPpU41kPhzJrO0I4v1JFTcP1rq+uvMCyjdGLEJkQ9c=;
        b=bMjGwiW89yNmKf1kdANLQsrDg9bXYFcWb3LFwediYSx9BPsxJ25iVJG7amJt6E+CCS
         CM1+KwqM16rt3s9+oVtKVi/dBGkjtQGZV3B6+FFewF7ffsLDRH5WaAXE25IYZMuEcW61
         WFYEaEzSbRsjHppR8KNGN2UUxth6+C0zAhi7+fEU/nitCt4wpalWlefln6uqazdcjJQg
         YxymOYgeydrgkTdbVkPYZw6VjcAz6bsQ+oht6o4yz7wLf2FJrfkVlHN8wZGrUrcd60o+
         x9lQXq/L/ZkUcuvNgymDIPtIj04I2pO7tt8sjVFAQYXqRCpIo5kn9IO2MuIEOu3xFeWy
         qqAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783367529; x=1783972329;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hKPpU41kPhzJrO0I4v1JFTcP1rq+uvMCyjdGLEJkQ9c=;
        b=gqsu7ah8Px1inNqEn4iOqdviaCUmc8evlRWrzOxjGHB3ygMGZQKroiNMrh8cqYcS8x
         +QTX7OSi67hTJ7R9ArR8v56ah5hH987si5IMrPFnutWVsAJYeauaG4Od7HORrhmmg3S8
         or0gYcjV7cmZB59EJrgP/ko8f1rmK3EQD6xwQ9/raEJyKQAbaJILA5evKzrQ4YY7Smtn
         VcqT/9IGIf1RHs4PvcaXcJx/sUGY96AFGNxbeguPcGVX/Tgv81K1BVz382hzn+jn05bN
         hZxbO3Kri715zWB/5XjrQa0xfBLEB+DqH5a2mzqVphmMKYFSNOrb/KbqSqXRDeY3Do5X
         crug==
X-Forwarded-Encrypted: i=1; AHgh+RreaGAklGRiA/n4K9uGaWe20l5LNmgN8AJX4McgW4EnmfC+plYLv43LzEFRd0yI/e83Qz0479YAmqbo@vger.kernel.org
X-Gm-Message-State: AOJu0YyiZxQUmfa4+xAoujrWNU+pWmcQMvScfnv57c0Lg+gA9A8Grmp3
	s/229hQW6jDkaPf7gfvyrLWLB9df5vrPa387PiyA8+VCk0ibp/acvRBkGSO8g1BKdhY=
X-Gm-Gg: AfdE7ckxcYTXxtm7YIha6gtTPtgXcIfKb4Z1b/6JxQg8GnAiBg3c4c6w1PBgAU/17Q4
	F2b1zKXobtXykmH7CDbNpYs/yinacSVHO8CRhTYja7WA2K+ybcog8ol5s6sVBsd7pwCQyJj43z7
	+Sqf2Q+aySKQXxlzcEI7zbj26VwePz4eJpjbLvQmVQ0aRV2G2//zw2dSPbaKztrd1m/82qAXonP
	tKKmh3faA7AVGp4DHgDezOk0BmShDcLd63JrvC9XgZW5Gey4/JEbnZzKgUSUrAIReeU1ZaCIkyo
	AhUMB6KZNbsiKNjB0oH/0jirjo6DnMOaBVw3x3DJ0DYXgkfRRdJrTOH/pJYejMPBGhCuLw6/sz2
	QCC8s9qv/qxHz9IO7d3vZhUbko85Z0+FxrxtiAAOe/zPmy3WOjnnq4wLqaQff
X-Received: by 2002:a05:620a:2911:b0:92e:70e9:6865 with SMTP id af79cd13be357-92ebb585521mr281465085a.59.1783367529434;
        Mon, 06 Jul 2026 12:52:09 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90b800efsm972606685a.4.2026.07.06.12.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 12:52:08 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wgpMO-00000000etJ-0DJM;
	Mon, 06 Jul 2026 16:52:08 -0300
Date: Mon, 6 Jul 2026 16:52:08 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
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
Message-ID: <20260706195208.GD118978@ziepe.ca>
References: <yq5aqzm4dz25.fsf@kernel.org>
 <20260618153705.GH231643@ziepe.ca>
 <yq5ao6h6enhm.fsf@kernel.org>
 <20260619122148.GL231643@ziepe.ca>
 <yq5aldcaejos.fsf@kernel.org>
 <20260619140616.GB1068655@ziepe.ca>
 <yq5ao6gtoncp.fsf@kernel.org>
 <20260630174216.GK7525@ziepe.ca>
 <fd135adc-a8a4-48e5-b649-2a29789b22d8@amd.com>
 <d7afa22d-5a41-491f-b945-289ab78080e7@amd.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7afa22d-5a41-491f-b945-289ab78080e7@amd.com>

On Mon, Jul 06, 2026 at 01:45:33PM -0500, Tom Lendacky wrote:

> In that situation, with SME enabled on the host, the SWIOTLB must be
> mapped by the kernel without the encryption bit set and DMA addresses
> must be provided to devices without the encryption bit set. This is
> because if SWIOTLB is mapped encrypted, requiring the encryption bit be
> part of the DMA address, any device that cannot perform DMA at the
> address width where the encryption bit exists will fail to DMA properly.

Ideally there would be two SWIOTLBs and "decrypted" aka low address,
one is only used if the device requires it.

Alternatively we don't support this questionable security choice and
using swiotlb with an incapable device just fails. Use the iommu, or
don't force swiotlb.

Jason
