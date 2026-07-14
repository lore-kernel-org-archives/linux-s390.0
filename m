Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A5C44839B
	for <linux-s390@vger.kernel.org>; Tue, 14 Jul 2026 12:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784032007; cv=none; b=D9shCbPbaVvWqYSwT4gJhRKKWHOs48WLCz3ocOpmJvq+Fg6g+av87QIQVnqhYeL1kjiWpKKv4zF8tGWl/f54MimhRcRV7ZUO4f/cIbW0JmoV0qUbd8uc3qY01UzHTdtaROhU/WGZe2fapCpMYGV/IfDeCj4wbzS0XYr89qI7Gcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784032007; c=relaxed/simple;
	bh=EyC6N0xAwYeQ07+jukS70K/lUL1qxajRoHTimoin/A8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ooKvJkT8qXlhNMmKUlvagiBBWDcaKkKkNM4XfXrwGubkPUk/WU8mK4HSZBVVzrD8RXvdVwxHNonq1Zt529gU2vQWK4/Au7st/32O421+G9O0IMf6qC7YL83dnwx78w9Q75B+9KKcvgC0ZKaeL+YEPVFS1OLWxZz9AwYEl2qXrBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=boLAbqr0; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="boLAbqr0"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8f18d92172aso12773476d6.2
        for <linux-s390@vger.kernel.org>; Tue, 14 Jul 2026 05:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1784032000; x=1784636800; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AuDF+BU2wT5tVoACVa1l/BwLN4UR/axOeynKCGX6Iio=;
        b=boLAbqr0JYcFO7/aj4gJCdrDNMNI7YjDhHvA4Jy05IWte2oWzKhvZXD/pMEOyTzIsm
         aG9nOna/0E/DaefTKfbe2kpuychVOjllXj4qrVvodD6MS/L2toK5GuQHXfhaFC3bsD1z
         DO6lSOtS85tz04ZHNIE3Bxj+42RItmWkrTIr9cp8usqVkjfiOxUcXoJmIVlvMT5oNLmt
         c+XgPgdGXQRlr+1X3gOj5ARBimvDjsuXSlBYzy80kfR9T1ACA7umHPEcYVlvFs7MSsOl
         R+OElYvnBteFGGp0BZn0RAbG/9oUfOEeOyRPjTPD3so9377gTzeoEQdpnIUmmAPVDwqy
         XQkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784032000; x=1784636800;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AuDF+BU2wT5tVoACVa1l/BwLN4UR/axOeynKCGX6Iio=;
        b=NwQmsGirTW58hKzB7ogZTdpve6yRc4jxNXQ4aiU6whHISx7fGzlSaPq6ndC0PwPc5R
         g6VHw8sDllbXXYlhNQidu1sM8mAs4hjbHw6Y2QiKhHySmKtIu6CBNA0Xo0lKSXE5jDPo
         ZATEU/sAhXWVS4UpkM+MlfIRrqpJ0u0H2nELT087zO14QpFp0jFXESV9c24Rg8o1ZqUr
         mw/lMArdBZeGwWRvNf/TprmOWMqIZNs7Yndi7UgtMNlyIAN/iER4C0c2wSj8NzxyCC9c
         zgY8Gwn7AdBE9bUJBUWxOVcYudZVcW4AQdFJkBn6JD6BUoprMqi6G8oLCmGTADSWB/fi
         SSug==
X-Forwarded-Encrypted: i=1; AHgh+RqWZ/koDyOeYr9LqJX572spH9mmBHO49QC10ic6ZRfz/mKRP8SobECVsPTsk0LDTZYLjC/Iws7flwuJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzCK+xo45A6y21Ist0x3wxFyGdJMHQyHWbCHgsoViBG8ebYoXLw
	5wxrypsoDJ6lHZd0We5wPojQG1YyxTrOBEqzwFDmulOIIceWAsqVXHVDGAaRi1xiYLM=
X-Gm-Gg: AfdE7ckLXuC0y5Vv+931AqeHij5qTrzqrCFd5DWbeSMN/P++p6KgqEVv5lqEuaFX62L
	vaX+aAhI+P4Wywb+AvgGvTBu/SqR66ypF19V1fYWsbnHoZY5FdGISHx3qDomlmjH6UZupm8Gy21
	qrgjq/E92a4/yZOB8wEF4vBC29o/JRd2iHvFuB5mf02mtHES0jTqdEepr0MKLLhOEVBMJ/E9MBZ
	eA/sXthKpUATOilFS1YD1vjrRuV0IaOF3Yp26aCu9mLYvq6i8jfh8gH81PFTe0IPfS8cfBD6oI2
	1EY/2QiT5ocKSCtdjUJxrUwWSbcHjlbK6wBdBPAaMuVO3eJpxZSgaDlfaRcLWidTHbynZkMXTRF
	8jm4dq9qALaxtWmhhWFrPzYlq5LDWxIbWDfdNdcGZ9O/XjLcLvhG4SakAdA0u
X-Received: by 2002:a05:6214:1cc6:b0:8e9:f5de:d629 with SMTP id 6a1803df08f44-9040423dcecmr141353846d6.56.1784032000167;
        Tue, 14 Jul 2026 05:26:40 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd7c1ec84sm168106996d6.29.2026.07.14.05.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 05:26:39 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjcDf-0000000FRvu-0Ugk;
	Tue, 14 Jul 2026 09:26:39 -0300
Date: Tue, 14 Jul 2026 09:26:39 -0300
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
Message-ID: <20260714122639.GH3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-12-aneesh.kumar@kernel.org>
 <20260713184810.GM3133966@ziepe.ca>
 <yq5aqzl6mc00.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5aqzl6mc00.fsf@kernel.org>

On Tue, Jul 14, 2026 at 09:57:43AM +0530, Aneesh Kumar K.V wrote:
> >
> > But I don't view this as that important, the CC hypervisor is probably
> > going to use the S2 page table to force cachable on all system memory
> > so the non-cached pgprot is a NOP, but the extra vmap is wasteful and
> > it is confusing.. So maybe a little fixme is all that is needed here.
> >
> 
> Something like?

Yeah

Jason
