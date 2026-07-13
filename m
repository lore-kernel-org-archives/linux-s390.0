Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C9F35AC31
	for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2026 19:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783971806; cv=none; b=KMxkJ5MXi/tStaAF9nuOQXkvWvD6KA+BbWEl1aABueb6oK3wrAVn+YSG8gWdJY7r8Rnq0NmkChapVLBs7rbPJvXvtZHndgrRsgofesVBLQV4493l27OEiTPQRaOy0Q3RmI23kiJxixd4JqNj7l7dHstRzpjtx5Z8ocpvC6mwWS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783971806; c=relaxed/simple;
	bh=0npl5BvtjzaikMt6SIylqQSymiXrW9C26cahZl14wSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b1QUFaiRfKFCGlTivnvsuCHKjUWsBV3QoeBy1GvCVOPvzqXr2dHGirZFgCTQUUb50LVYs1wDFEA9e4hJvoYfcWqdd3vAL+AhAPD5uHoKmvbC/W9/q6pFQi0T4M2jubnnDt2PfEz6rcPyiq6JWeaMw4tjSWyly0lZHxLoixLyxSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=pX2Mrtzt; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="pX2Mrtzt"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8efcfdb2b43so27586556d6.3
        for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2026 12:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783971804; x=1784576604; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0npl5BvtjzaikMt6SIylqQSymiXrW9C26cahZl14wSc=;
        b=pX2Mrtztb6akx3yFAd/MK1EzbebW6FRNJE7JIlzF/3uLuSgq+ore+m8j7uqhBniz+l
         tvGgjsnvRRqGOmNFRB7ICOVmg2+9yywbA4ePLBuki2yjJI6i143BjMZiRrckvOrZy+kC
         Hg0DAHp+UUiE3YcOBQYhsP1tPopDeJOWpuzDh1aHTAt+g7jRpxPDqZFjaA0DMszlAKbx
         IS/z+iJWq1rkRFSgW2ZdRhVu3/f6mfTLFSuhKvM+72jfjg8SSYHHpd0dMPWDJHmTHz+9
         +tSdGTvhvPUj0IFy4/Ti7dXo0NqANP++TbiPkcw3BLP2gqdLRJZBVOhu98NTUnXy8G4W
         t33A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783971804; x=1784576604;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0npl5BvtjzaikMt6SIylqQSymiXrW9C26cahZl14wSc=;
        b=PSJFoQ5nD0c29IgXwDprhaS0ZOGYW8zLJGfr8M3uRll9ejN7dgWgr4vzl2FBpEA89j
         PhLpFMLntvHyDiYCWVzw9DkY3V8wqWf+GWephiJZwTSTuM/ZRmPsT6tMg7zqyqTnZhfs
         oceEf4Rt1X258GhWLd9Owd7RupgTipyS45M97GW4c/fsq6VAjGWjb+vufuKVflIRtnZ8
         cTRexycJFq8OsnZQLofC/xlb5CiWPkmIuEUSCCUOqY460IvqCFD96pLa9gaj54V6QOh+
         d7xREXINXqAHSPsiIxqNNufacrGVOo4hwcnmEXA+K1Kx7mLXBNgVxD2OAzuN0AvymaGZ
         n1CQ==
X-Forwarded-Encrypted: i=1; AHgh+RrQ95BlEm+zrTIw3O6B/OmXSz52H8j8cEto3pi5mdNHQ6nlQGuzpwQdTUKtonWLn+h0zMujUiPt/hJx@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9CteuLyFfuYOE3E3YmKKagCQfcO5HIkzQHT+GrMQAUOmtycs+
	WDibjAlurG0EkkXX1dY/6lkZbZ5W6C5maLciCFrQEu9/fTRWI7gg7p2b2Dv/v1CpBgI=
X-Gm-Gg: AfdE7claXjWASXxfOYxAA/lXm+GX10JbyxWW4FwtJSQbhsDs+BJQFHFW1+uiW9ZzdYE
	ew0n1G9JNH7W5ipHfMvl1b6GSuphtmRsjMHa8WXBhcXDRWya8v2vn5DKESgF0DPHqxciKH5z39H
	NUNY0yuDK28PIBavZ0v2jfjWhW7iQmd0IoesN1p5HEPcBVU0xE4ut2Mfnf7Yk2luLvlv7ghkC/V
	APc44szzm398CGMJMULmUMyy7a4JqJl3J9Hb+poSXXExh0DvLL55w7w7AAGm0uYYGPTpI879meb
	TSy7sfaU7b7VXF+Z7gWoLUtdVd62/gHPRwqeh0wOqqLenAQV0/KY3I1Z90XYf+14y+y0Mzb8sfJ
	SGaESJB+hVDRXcNpzPyNtXpzj+NMLvtC5Eaxudx6xoy+HoOMwHZY6hdgNOTwQ3xOkZHUUfYU=
X-Received: by 2002:a05:6214:3302:b0:8f0:63b6:5881 with SMTP id 6a1803df08f44-9040236cc47mr114290366d6.26.1783971804298;
        Mon, 13 Jul 2026 12:43:24 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd87c9500sm137858946d6.46.2026.07.13.12.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 12:43:23 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjMYl-0000000E6yO-1CDU;
	Mon, 13 Jul 2026 16:43:23 -0300
Date: Mon, 13 Jul 2026 16:43:23 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
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
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v7 00/22] dma-mapping: Track shared DMA state through
 direct, pool and swiotlb paths
Message-ID: <20260713194323.GC3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <CGME20260707080628eucas1p13fa8a57e60ef5dd3ec651e19e42af0a1@eucas1p1.samsung.com>
 <yq5av7argr65.fsf@kernel.org>
 <fc804746-4fb8-4ea9-997f-a4cae9ba8c14@samsung.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fc804746-4fb8-4ea9-997f-a4cae9ba8c14@samsung.com>

On Tue, Jul 07, 2026 at 03:03:48PM +0200, Marek Szyprowski wrote:

> I'm fine with merging on top of the topic branch and I assume that this
> patchset is mature enough to give it a try in linux-next, but first I
> would like to get a review or at least acks from others with good CC
> knowledge or experience.

I think it is good to go from a CC perspective, there are still some
more items to fix up (like the MMIO) but I'd rather they be followups
at this point.

Thanks,
Jason
