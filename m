Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9141445AC5
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 10:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785319696; cv=none; b=Tf6EQruRF87yJauJrtrGWT7V1VzVwnH2F3VhzxroX0Gf9OV9x73JXliakgHSfCc/FIGwPgoR+vMu+uZAFlPDuF9mi4mGOPxFoMSDAo4SGxgkYVvDxqWPxNwjzWLr1Vu2xQEl29d3Paxy90/vTOv2tzEjHRZ3hKnM/qKNBWWP8v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785319696; c=relaxed/simple;
	bh=lGLVQcsztY5awYnmlsVk+k+eu0JF7WHu3B8vPUeejOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cvMHtnNci0SgXSdblre+meT9IhIhAiTD412fgrygclkjy4QQuSCKIdBHLIgqlR16sn4w4opZ9SPXVznjn53hIBrwGk/6vqiAUqm2iFkOtAR6B2yFopRu+c16R9/nXl/+csjXbG+zkR9d/Xu75oMYXaDwqlJRml/boz+6o9gRO4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jyZE0fjt; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jyZE0fjt"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-69fec8b4638so10913a12.0
        for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 03:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785319693; x=1785924493; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y+s7LRa+xfn1TaMGIJNFktf1+ZXT37mg0JkHIAIfYYQ=;
        b=jyZE0fjtQCvK0JOrpc8lQ1H8DmQyY8YqfyFx+YevzJs0u0T62j3SAoDvB3+w1vAE5t
         UlwlsKKlJ3XZ6Wk0LAMOGv6XXXHajeTeO5JJfYYcCL80GZ5CpSdBHWjl8DBQ4VEvm3HS
         3iT/J+87UOWjb3edwYAekfqJEIr936GiMRianAL3U1olywP/Ch/tkn869SoNId4mmID7
         M5m982FbzAU9w/D3WlM3yMWtdIK3KQiPBupTyZlmcN72ej0woDu301qC/D7+UOjGX7eP
         PobDr3hPzF6NClaf2HWtRnTRWsevCPlT+Q909YrQvmPu3U3uOrPr073OiIWTSbGd1VFE
         FbzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785319693; x=1785924493;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y+s7LRa+xfn1TaMGIJNFktf1+ZXT37mg0JkHIAIfYYQ=;
        b=mat3rCZG90YVlg5SDDVUOzufQICWlDWzVOmfTDgGPaVx3dFfukFcpGANr4uTqO7Kge
         7FLY/luogjmPHh34zrW4pMp+XcQgozNu2s+eYX1LdBzkrxzDC9IoSTRHJFUmRceEEUUK
         cXDZewNCMNQAlKeQAUvAWjAo+0JyhAENhZn/VarkidHHI2iU/X6YQxr009EVMYB24rgu
         Bsc7AMAWIJK4YB/vDy3ttcJYqnvLtoL5iSAL5hh8dNoFeDvXRg1/B+a2ZqAdfA0F2Xdg
         L4YbdTa6U58ZjTrxXuuqy9PU19rchrYqxb4OF5tUdM1I7Yo6ozrT3R2zQx/UAKNOeb4q
         ZOMw==
X-Forwarded-Encrypted: i=1; AHgh+Ro5R4EltgUOJfqCSRjEQjRN32ipU6S4d1WzqcjWBy+XtxV0JhtZZPWQhxcckvr/CWKSzs4iPfniGRnH@vger.kernel.org
X-Gm-Message-State: AOJu0Yw66bj0ushJOfmiCkRoxWR6mPbpLp7Ija3YZNtbGenYVC+hd5bf
	rIUJTFiodS9vJ6rGFzXyfICzXCCTtLnO/u2lrVisfDQwvIQQ9qRN/HpeC9/M/cd4Cw==
X-Gm-Gg: AR+sD10ar62Y4OLz1cm9iy2BmT+Xf5DQeZl+k9YhF/F9MPw9HPZcofXF64JUQb/gKYb
	awlGt5A/rj3mmOOCtABZk5AZG9IkMfxk36kbfHXQJ2uzhTuoLHOFnVBGTuVgN6fVUbVU4HRmb9e
	YvkmVNQmfmrH30u3d7f4IfR5eqvvdtmRt9KKXmVuzhYa2GCuTJ9n6XzkEjGHVPdr/wrLtr2wDH8
	qUOlqeRS6K5+FUayF9vuWnikqgsQV0Mv70aSRG/t+nVijYsdyDZnv6n6KU1z0gxzybnESqqecZn
	IPnLrhYhG2D90lvOvUvyhCTrZVB5EtBVk6v3YnvB3rjaR4431us1V+Di1Ch7pp8y1eF/tskcLef
	YGSHxZFnZCCjDpllQmJGt5X28vdxKWpsG/vbWgedtxBGtg2MDdrpL4OJbRWmz6u82vun+/6Y+Vk
	1rP/d+QoBda3pH0msNyq5aUPP3QrUo8B9IHrQlmKUr9uc3Qzz1oLG0P0xMA9LyUPYMgueMiDxX1
	R7SnL9L3l/S8FVo+H5hzCi7jpdQ+A==
X-Received: by 2002:a05:6402:4244:10b0:69c:83f3:4831 with SMTP id 4fb4d7f45d1cf-6a063f622a5mr16396a12.7.1785319692673;
        Wed, 29 Jul 2026 03:08:12 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1f83f4dda2sm89863166b.36.2026.07.29.03.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 03:08:11 -0700 (PDT)
Date: Wed, 29 Jul 2026 10:08:07 +0000
From: Mostafa Saleh <smostafa@google.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Jason Gunthorpe <jgg@ziepe.ca>,
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
	Jason Gunthorpe <jgg@nvidia.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v8 12/23] dma: swiotlb: pass mapping attributes by
 reference
Message-ID: <amnRB98ZZIysHuM3@google.com>
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
 <20260717180442.110954-13-aneesh.kumar@kernel.org>
 <ami_mpd_1pF4Tmdu@google.com>
 <yq5a5x1ygo7z.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5a5x1ygo7z.fsf@kernel.org>

On Wed, Jul 29, 2026 at 02:35:36PM +0530, Aneesh Kumar K.V wrote:
> Mostafa Saleh <smostafa@google.com> writes:
> 
> > On Fri, Jul 17, 2026 at 11:34:30PM +0530, Aneesh Kumar K.V (Arm) wrote:
> >> Change swiotlb_tbl_map_single() to take the DMA mapping attributes by
> >> reference and update the direct callers accordingly.
> >> 
> >> This is a preparatory change for a follow-up patch which updates the
> >> attributes based on the selected swiotlb pool. Keeping the signature change
> >> separate makes the follow-up patch easier to review.
> >> 
> >
> > I do not understand the point of this, why would
> > swiotlb_tbl_map_single() force attrs over the caller which should
> > already know the context (whether DMA is shared or not) which case
> > would this be useful to force from the SWIOTLB code?
> >
> 
> The mapping request was for private memory, but the device could not use
> it because the dma_capable() (force_dma_unencrypted() == true) check
> failed. As a result, dma_direct_map_phys() allocated a swiotlb bounce
> buffer, which is shared. Since the DMA now targets the shared bounce
> buffer rather than the original private memory, the attributes must be
> updated to reflect the new shared mapping.
> 
> dma_addr = phys_to_dma(dev, phys);
> if (unlikely(!dma_capable(dev, dma_addr, size, true)))
> 	if (is_swiotlb_active(dev))
> 		return swiotlb_map(dev, phys, size, dir, attrs);
> 
> 

But it does not make sense to me to have it in such a low level
function, and it shouldn't change the attrs that was passed.

dma_direct_map_phys() is the right place to do this it should set
the correct attrs before calling swiotlb_map().

Thanks,
Mostafa

> -aneesh
