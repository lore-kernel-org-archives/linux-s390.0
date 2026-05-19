Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DF7352000
	for <linux-s390@vger.kernel.org>; Tue, 19 May 2026 16:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779207084; cv=none; b=aMsccPSjTSi7zSjj7BZ/gS/Zm4L8PxvGeZ2/pFMGhTLM6GIKNRYTSGL68U2QUo7ln+cTpZ/x5vnT03jz1VKoaFEEId9VdkOqU+JA4mW1PWH45pUbEclogR4KXEGbFTs/T4cesX/X+RUAV+Q3g93wtI74nRhPKYF35FEUQ+C8YhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779207084; c=relaxed/simple;
	bh=Hz7s4YAFSInfsBqTFwj3w4O7Cn5r1Vqd8t9F59UC66Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iqNbI7rSHHgw7g415Sb0nX3p1X7aWnPcrC0EkZqyP/OQ4d/7LFc53EyE6iXa0xqxphWGkWgpzmCkFpL2abD5zEIcZXj3QcFaeaDGL4nmRpYfHbY6Y/4WRM3+0SbYLG07AnJw8WcuL//jMokjFO4yWOgMewUTUkMB8tZdtyepoto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=b6JIM2AN; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="b6JIM2AN"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-65dbe04fc1bso3971543d50.1
        for <linux-s390@vger.kernel.org>; Tue, 19 May 2026 09:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779207082; x=1779811882; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UcSuL4+fBcC8SeCa+tlTSs00pii8MZZ+rCZs+NXP3JM=;
        b=b6JIM2ANdBPVbb1/ra5qBtOaSj5JxN3N9C1jue518JwHCpPKYkVuFqkU7obTypbAt4
         z8n13ceecy4hLBHsZ3LI7sCZrdY1FN7KDTsFPEXawdwl999mp3KmWh4NZpRNxk/j+0Uk
         vrGEjeuZIXD+rXoDi+bqP5zRCQQpG6PswaoSWSZIbZ+Ia9408qnX5kudVOwloaj75zcw
         E6cghLKyo9RWM0Ea42k102t2jsrl8qQAU5PQCjCz0k8QeBGsc/etDtHQEVpYONuplODl
         by60W7Zb0yyj2SAt6ZLzrhVnont3BI2MfYYtm17Y3tTmNmoPWdm9nApX6xFLzTgLtreB
         yV7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779207082; x=1779811882;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UcSuL4+fBcC8SeCa+tlTSs00pii8MZZ+rCZs+NXP3JM=;
        b=VWnieM1bauVHsUTNk4jf3YGMeeWyieHRRZUsxWRJ2/OCaVgD683pRp0JEFtxmKucec
         hmbP4g9Rd+GoeDmNXPuH3GJM7JVqd19P84knDRU5nHBpzV82V4BGqSUbOQiCHWpM2tGU
         Xf25RWQ8nyLryU4mZJFzXC4Py+jBIHbAFQJ96VWkJx1PZvZ0PDR33/EiJLEaPbXKqPW4
         aZcGUxn8ZwBI/xmu9+SaNwX9qwxDhQHL++j7FWgCBkU8lyuiRfzRgaaeovec3j+YhgLE
         u2NQ/ywr+9LuZbZI+G2L7rHSFo4s+KUdDHfYYWriJth5xdMYD7+eobQanmkcIMQmz7wY
         wbsg==
X-Forwarded-Encrypted: i=1; AFNElJ/7efrOUu4gv7Hc54C/TXxi/6RGHM6MkodAZUbh6gyp9LatvLXp2Q3rQE5+roVPKacF/zIs/F+sIqIx@vger.kernel.org
X-Gm-Message-State: AOJu0YzTonAsYEwTUodiS2G7X98Zz+y5WlOrWz/Qfdb+Ar4Xac9hEjpE
	ZvVaqPaquHhsG+pxuJZXNoTp1hiXs4OxLqtZrMA8b++ZmZQG5YIhBcfu2s4wGw3BVa4=
X-Gm-Gg: Acq92OH0RmeB5r8Apt8RG0FZD7p1Xtrc5Az6N5q0rase9/Kw4G8p5GtW8jhm9sPg2Ou
	cFCtkfxwYn+nD+lMOXW+9XWp8H0QZ5azr6/FlNTefASuB/7JhmDOe3v88ab9rXO7KbTWYezr0Ad
	77OovQNDgSPgLE3cYdz976jLHMBcrM4aJEis4WmX1cb4ybt2/XegBS4TpTj56mS8iZtqdpdw/iw
	MFIZN9XGA4/ptPMRXdmcdlfWZ/n8kVh7dwiosuxYAWnYT93dil0Us8oOnG900LsG4mkNOv6y6Jv
	Dx48Q6N7yZcwHZgWDCDX0lDPKpdlfRACX6DVSt4fZlvdv6aosmr4BzgqUphE/lVHe9xNTTzzOtq
	W6aygBL7f2tq+juEr2qjYksA7SmwW6X+OQSFBxPWS95pEWFZFPA2vAhIqYc6NKlxWAlzLN92IEx
	XRxU7njL+wigVb16eauSALpNwFLLPPTZLhxY9C7xBr1zGq76s2JaWm+cislFWbreEQ6Vrdsl9YB
	9Rw9g==
X-Received: by 2002:a05:690e:148b:b0:65e:18a4:3021 with SMTP id 956f58d0204a3-65e22839e72mr21408719d50.52.1779207081601;
        Tue, 19 May 2026 09:11:21 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca36086a61sm95500586d6.4.2026.05.19.09.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 09:11:20 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wPN2O-0000000FGo6-1YPM;
	Tue, 19 May 2026 13:11:20 -0300
Date: Tue, 19 May 2026 13:11:20 -0300
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
Message-ID: <20260519161120.GO7702@ziepe.ca>
References: <yq5ah5oaa63h.fsf@kernel.org>
 <agW5rhE9n2gDQ0w5@google.com>
 <yq5apl2y5f96.fsf@kernel.org>
 <agXaby-7L7yS3Vva@google.com>
 <yq5ah5oa59wy.fsf@kernel.org>
 <agxDxdxynp4KEovA@google.com>
 <yq5amrxvshxg.fsf@kernel.org>
 <yq5abjebsaid.fsf@kernel.org>
 <20260519152741.GM7702@ziepe.ca>
 <yq5a8q9fs7ud.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5a8q9fs7ud.fsf@kernel.org>

On Tue, May 19, 2026 at 09:35:30PM +0530, Aneesh Kumar K.V wrote:
> Yes, that also resulted in simpler and cleaner code.
> 
> swiotlb_tbl_map_single
> 	/*
> 	 * If the physical address is encrypted but the device requires
> 	 * decrypted DMA, use a decrypted io_tlb_mem and update the
> 	 * attributes so the caller knows that a decrypted io_tlb_mem
> 	 * was used.
> 	 */
> 	if (!(*attrs & DMA_ATTR_CC_SHARED) && force_dma_unencrypted(dev))
> 		*attrs |= DMA_ATTR_CC_SHARED;
> 
> 	if (mem->unencrypted != !!(*attrs & DMA_ATTR_CC_SHARED))
> 		return (phys_addr_t)DMA_MAPPING_ERROR;

Yeah, exactly that is so much clearer now that the mem->unecrypted is
tied directly.

That logic is reversed though, the incoming ATTR_CC doesn't matter for
swiotlb, that is just the source of the memcpy.

/* swiotlb pool is incorrect for this device */
if (mem->unencrypted != force_dma_unencrypted(dev))
    return (phys_addr_t)DMA_MAPPING_ERROR;

/* Force attrs to match the kind of memory in the pool */
if (mem->unencrypted)
     *attrs |= DMA_ATTR_CC_SHARED;
else
     *attrs &= ~DMA_ATTR_CC_SHARED;


Attrs should be forced to whatever memory swiotlb selected.

Jason
