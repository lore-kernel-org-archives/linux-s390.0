Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3052F376494
	for <linux-s390@vger.kernel.org>; Tue, 26 May 2026 15:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779809992; cv=none; b=V3g+zrs8oD9aiLQc9XxwRKRdfGC/HEpYASvNYVrtZnajVvvccFP6wpg7B2ed81l7i8U23bucE3msqwoA6S9Dx/MKX8i4VmJ2OVb3+Pqj0pVoymYCYV/Wju6kN3UwlxN3hWUmADw9h1Q18owJuxQh8ve9TvhVz2I5nQPwoefuZKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779809992; c=relaxed/simple;
	bh=ItPd3iMhIb7X3YkSIy7+Cw4n/7vOFcAzSgB6r5JqsAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Seuq5ILWzWSVQkpBRzU4/MK586GObJOU+ID9EcigoFTKGPp35LsqwxOJMfGqYZzudP8qbJxkbeHp11KZJy2ecQK/Y0F3hXr8a+d3+TMSwO3HVrW2RD3QdOcFR7JDSnlZ2NXXJo5zPOqIwPZGYiohM2Q96naJQuBCackyd+Dd+LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Bja1Llhh; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Bja1Llhh"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50fb8e9a4edso129198991cf.1
        for <linux-s390@vger.kernel.org>; Tue, 26 May 2026 08:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779809990; x=1780414790; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ItPd3iMhIb7X3YkSIy7+Cw4n/7vOFcAzSgB6r5JqsAg=;
        b=Bja1LlhhUBpr6G6uLE0EIoiKSbNqD32MKj8U6VLatww2tapL0NV/+DAKz21SOjGiCj
         Zuzf+Vl6rbkA1JaQnizJDK6t2bk8PmuIwUUdDC1jjh+igpz9spRZpTrgWEMcROoP+37m
         TmUjdI6EvkT6xfza+KqfgCF4AbnczlonK7qexfT/yntwt3RYCLLuFlnEBEoZiGIzcJ0A
         lxnRAmEOXcQ5FegBFmxFsaPGTWMLmIeKPpcYQ7p6NGZjdXH5XzukmsltXedvoTeKerle
         2E83aqkmPxazsqNqeZmA8QPDxEhh+Cx0Wli8Ppjqzt2ZCCFxmvtSm+WbLSU28Mkt90Ot
         ebUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779809990; x=1780414790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ItPd3iMhIb7X3YkSIy7+Cw4n/7vOFcAzSgB6r5JqsAg=;
        b=PLp9wyTGHcLlC61zfRvpP4vxp3VWi7lWSMvTeq+cqPsVBX3BOkKQeaakIDLSI+WWys
         9AOCRZF0Jg+MIIJYxFJcOVr8qFkHniwSxpDpZ0+vJh+/r3ZvhYVuL4o1bF4hvGd7Zoyt
         Vy1TX6PN+S2kFokHZ6Ce32UHj72tyOPnGUlDmNLZON1lvc+GLOu4wVOE5pEWnZy8her/
         2sHuTbErJ8fNjay4EMsdDbq1omTAs2HO/D+FOnUVFjvmFb/DCfcKFFG1XmSI/eJhk7ey
         ZXfa7PT3trWB2AFyqzdCW0OuEmHx9htLSj1sXc3/ZW8cetEmPzyHlGrFIctppV1IjPBl
         8G2g==
X-Forwarded-Encrypted: i=1; AFNElJ+qBkq41qG0aE1tfug9KCcNNXv6RVEQLgXhkLiGhddk0XTXvAgDgnROeDTrWNQQswlnBVje2RDqxRP5@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7BiIYnfUdKoaFNW92pF/BRj5qDZskGGEE0jbb0Xb7BoJ54CjG
	yO4BTxP8vu6i6+2EkUr99uPaxLdZvf2zlfdIHXUA0PfRNt5jygmTP+MBz5LN06OT/Hk=
X-Gm-Gg: Acq92OFkOd/ajxshtAz1rwpwnsNMKn8QX9fruHM5r8EJzy1Lsoa2kj0DfttEmhMD83G
	HlJ5G88xlpSjOR1wqkALiRnjeCEQg3XKz7DGnhK5SJOSy0DmJNVbTzJlHkJpJZDBEg2HvPzV0ir
	Cy5XuFPZ9c2XBGirf/Hdd++BpVBVmTpK9qHI/NZlwLbPi7k2EDPjv0/vijo6lEBsaYC5w2O1AEr
	j+lRjZkKqWakTexU4iVVgQRJjVrvojXXRz+yJNLrCGnkL88hzNlO+Z7P1QQUQWQt/+e8QboNQwf
	2RHkPGxyTfpNWYoIH50Q39aVaxjixV28h1u8VDAIf95Qiz+Hyj5Wnep90LpKBsc11mGO2QSMeNP
	nXBBP5YAnvJA8aLxmO3vHGT4zlJtZk3ras/Xuu9cnU/X/RrDdTdq7yb24eZ/ox3aOwzriQsbAbm
	PErsyQIS18VwXw2wmRYp81PS6piCPQ7Dq5HwkWgc9rcP63Y+5f9ej3cYmht3E/807YCW8QHfx98
	EDoUg==
X-Received: by 2002:a05:622a:1452:b0:50e:5cc3:6f3a with SMTP id d75a77b69052e-516d45eaf62mr265877421cf.26.1779809990039;
        Tue, 26 May 2026 08:39:50 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5170c403529sm7414661cf.10.2026.05.26.08.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 08:39:49 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wRtsi-0000000DiUf-2t1G;
	Tue, 26 May 2026 12:39:48 -0300
Date: Tue, 26 May 2026 12:39:48 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
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
Subject: Re: [PATCH v5 10/20] dma-direct: make dma_direct_map_phys() honor
 DMA_ATTR_CC_SHARED
Message-ID: <20260526153948.GH2487554@ziepe.ca>
References: <20260522042815.370873-1-aneesh.kumar@kernel.org>
 <20260522042815.370873-11-aneesh.kumar@kernel.org>
 <SN6PR02MB41574064D14D4A2734222C51D40B2@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB41574064D14D4A2734222C51D40B2@SN6PR02MB4157.namprd02.prod.outlook.com>

On Tue, May 26, 2026 at 02:56:57AM +0000, Michael Kelley wrote:

> With this patch removing SWIOTLB_FORCE from four places in
> kernel code, there are no remaining places where it is set.
> The test of SWIOTLB_FORCE could be removed from
> swiotlb_init_remap(), and its definition could be deleted
> from include/linux/swiotlb.h.

That's great! I think it shows this is the right approach!

Jason
