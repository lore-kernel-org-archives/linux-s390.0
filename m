Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236A3408015
	for <linux-s390@vger.kernel.org>; Tue, 19 May 2026 15:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779204465; cv=none; b=pAsXYV9s7Hbt9Eq8E9/8lJCZJSMub30f44o8+D3owNCao+QfwPCrx4rs17MQ3zY1D/6Z5Kc64mD2wkYEbAeQf6PW5S+vHPtVhdXFint4mDfcrMGmSNsTzqLFOs6XFjnLsz9gd2R6xtHpHbZ9lIu8mS4EUcLlop83uwuC3bgk2X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779204465; c=relaxed/simple;
	bh=uW4Yk0igRBmfLaBkig6+ozw+XI5e0m0/JIVGZ2INarE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZpO9ZScOuQSuLwkr77Iuv5VnrD3BURYsiXa9DFF9dGjto/ClvOyLafqFiXCtHYYOMxwzYvU/tL4c4tiVaNXAs4kFHWMLGmjgoKxc3xSGqffBgKo9ijNGlS73A003Xy3EXGY8aelTcky+2QmYtT0fqzbnyi7bhpMmCW9157yVClc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=e4/A9DgA; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="e4/A9DgA"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-902deb2412fso474735185a.3
        for <linux-s390@vger.kernel.org>; Tue, 19 May 2026 08:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779204463; x=1779809263; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kt+hX5KDw0Kh9RBmOyjzabH+WBL9dObDUAkuMZR7Klg=;
        b=e4/A9DgAhgdmpn86dYUZvT6UlTRIYuuxWftI8xvUoI2lNAbWxrLPg7CVVUhlDS80VP
         FYCsgHMkTSx90VisyM9paq2SH78ErveY+jkOWxu5wNWcVMaOWpCiVYhF7ocaYoGWqm80
         SOmi8ExuP6TSP0CwHjhN417PtR8YTXARAW72lLRhIgE5/MgAzD524g8E4mLe5zgABIwO
         Tvm0AILaqJmJhhrL+ImZ+x1FMY39r/+L04SQaHn+N6OBDHCowCPteteOpje169a5UE3l
         5ds0iSZTxvbvqo15i9MDRBbVjgz2ImGtoA7HlWyVJs8n/DYhddwmgZwBkPkTTwyt+Bic
         iRLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779204463; x=1779809263;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kt+hX5KDw0Kh9RBmOyjzabH+WBL9dObDUAkuMZR7Klg=;
        b=ik0g+O9POg9TksuDe3HTILX+WcmCxNGLroxmwmx1U3Jt3Sh3RU/y7fx0no8fHWUu+a
         Gyh/7hcYA2RHkU59PM7t/MGc6KcKBan4G+oB1iU+V+dkD4RZrsiAAZ2wVg8FG6vQZWzK
         0EKC0CVQLvRcmLIonz2rBSHYoLe0b4mhc51g18l0Oohd74ldmnF5VmDOCxfTS8KTzoTm
         3lVAMTG2sM7/lqxWuGXW6Ev8Q9Dabqj6YIlInjX9rXpV1ZS6hmIqX2Swj8FrLzxqubMt
         s0UoUQNWuBaJBB1nG3cVFqPxJruTYM/VcJR3UKBtzm9cu71NXe7AWopBItW6H8ZL6Zw5
         IqsQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Fw/YCNplFP1XDUjRvGhwSDmTw7oXVqFmDWbunErASA3UN5Wdv8KAJ6AcYv21uQwAueF+4JxgRhHV9@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5eXHWct1FIICHJhiSqJ8QBzdeSwGSpKSGmR46xlIheT7nVyzY
	20nPmrU1tPstI5A56ZD8bZGcGINHYAtrhiFRWSQgPAn4kdeL/i/iR3/B7lxNQaqR5mg=
X-Gm-Gg: Acq92OFw9SKVlKcmusvSLjHe1bGnPr7OL4s3UhQsl0QAso7kb9EKMg3a8TMER9AHOeV
	Nkq4AjeknuZ+5qDiOHmPW0Dq5QFgDVaZ07yTDcmgizwiR+vbIVK4qXDFrD5Zw+H5UqGL9y5zmEb
	cHmjtkwoEaJ4wAM5FckQH9GbVD9c0adJwuDNFM/CdycWVu7Lj+G5gjq6rdiksNIsOFCHiE3aDX7
	cQ3TYVWTVWXE0nPFnTLrxE11XHilyCXr4VAe3vMNm1r7QeVLqQuZ6n5XLYefelnF8+8rTJPdMGv
	Go1/LmN3lYAa6F8xIMzLFUcPrnCdJDmVnjkZlk3lKPCG/ih90VZWcLBVYBdVgifkagS3cybg7qg
	ly7lB0YtPEBCuG4uuanzdS18NLB8YhFhrNAiCSImD0GqeWAZXjTa/8sW3hCOKqJzmCRHewXWK9r
	6e8vb8TgDIEiGTAyyXfmhN5c9BfYX1bXIlO4WfexECQZFZOyV/8/jqwSUKd49ear/ZoN6+Tm5v/
	UoVs8r4cfKdqGrP
X-Received: by 2002:a05:620a:45a5:b0:912:671b:d098 with SMTP id af79cd13be357-912671bd4e8mr2727065785a.51.1779204462879;
        Tue, 19 May 2026 08:27:42 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910ba943761sm1881906785a.11.2026.05.19.08.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 08:27:42 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wPMM9-0000000FCKQ-2JCd;
	Tue, 19 May 2026 12:27:41 -0300
Date: Tue, 19 May 2026 12:27:41 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
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
Message-ID: <20260519152741.GM7702@ziepe.ca>
References: <20260512090408.794195-5-aneesh.kumar@kernel.org>
 <agSKQrSIhizCXKwx@google.com>
 <yq5ah5oaa63h.fsf@kernel.org>
 <agW5rhE9n2gDQ0w5@google.com>
 <yq5apl2y5f96.fsf@kernel.org>
 <agXaby-7L7yS3Vva@google.com>
 <yq5ah5oa59wy.fsf@kernel.org>
 <agxDxdxynp4KEovA@google.com>
 <yq5amrxvshxg.fsf@kernel.org>
 <yq5abjebsaid.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5abjebsaid.fsf@kernel.org>

On Tue, May 19, 2026 at 08:37:54PM +0530, Aneesh Kumar K.V wrote:

> if we get force_dma_unencrypted(dev) correct, we won't need the above.
> 
> for dma_direct_alloc and dma_direct_alloc_pages() we have
> 
> 	if (force_dma_unencrypted(dev))
> 		attrs |= DMA_ATTR_CC_SHARED;
> 
> 
> for dma_direct_map_phys(), if we have swiotlb bouncing forced,
> 
> swiotlb_tbl_map_single():
> 
> 	if ((attrs & DMA_ATTR_CC_SHARED) || force_dma_unencrypted(dev))
> 		require_decrypted = true;

IMHO I really do prefer the DMA_ATTR_CC_SHARED flows closer to the
thing that did the decryption. While the above is possibly sound it is
very obtuse to be guessing what kind of memory swiotlb decided to
return..

Can we pass a pointer to the attrs into the swiotlb stuff and it can
update it based on the kind of memory it has allocated?

Jason
