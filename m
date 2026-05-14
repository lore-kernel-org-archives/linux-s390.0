Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A3E41B36D
	for <linux-s390@vger.kernel.org>; Thu, 14 May 2026 15:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778773447; cv=none; b=FH2g5hZSUg5PmEm2Wrp55kUfa4CtC/hOvxPSUPBkR9p/NefF5ZRoTMDA9hBpsCYpEp71bg4v3UBIU/4UwPhWrnuhDRzBaFeG76Z2K/j3wNW89IKLqk6ZNPr33y4Vh4eGqJFUXQRui8SuwEpoQmMTT7hbx9s6f8hCDFotVLE9N4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778773447; c=relaxed/simple;
	bh=RPg0i4XM92mQzsrFW8OMk2e1DfkKszLgHmEy1kgrd5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WARa//j3YpSVJG/bNem5AjwSpXgYk14t8xj5sEBst5KbZtjFDjsLukmjqPxmr9Qj9VeiucEZ35A0E4OKzkbwbhK7CvQL0jnOSq16Ylip0K2MoDjjF0u9IIhDIltcECrETm/xv0wHCio+fM4GjNSjtXjut5TXqF408xrpuNPUNBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JrCvnCWK; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JrCvnCWK"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4891b4934ffso120345e9.0
        for <linux-s390@vger.kernel.org>; Thu, 14 May 2026 08:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778773444; x=1779378244; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lh6aFT9PQ6X1PkDdo12UH9E/whRlrKT0Rk5qkvPCSq8=;
        b=JrCvnCWK3D/xpb6D18vIO23Pr7WcS0RlqnvJFuNMrnA/0Un7xHuqGFsZhf+Wvxctz0
         7KkGjFx2tTCFYKiYbO7NH30qslJNn/Gxk06VJWlA8gW8inZqD6nBaJQxT6qnbsw/6gGt
         XBko/G+/+6ll6axxQUDIUe+unqvBmLDyo8xTLEN3aRRFXRa9NcJWxWYTGiBuAZX5CHgB
         seGdCix6VltkbXe2XA6OvL35KecAjtqof7SXo4hzlpNbzq68oEbWJAimiaA8qKkoTr3X
         +ifzpcaRSJuqlBNrfjzU0MssQf9f2TV2zhEEsa/gcIXj+n3celAQlGMtKTt0FZ5ErGSX
         gMew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778773444; x=1779378244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lh6aFT9PQ6X1PkDdo12UH9E/whRlrKT0Rk5qkvPCSq8=;
        b=QulObnTthkWGmVJcQhfc7Gs7Fq0v5Ok5vgLUJmnC9Fs1iD+ZQiFi+V7mwyaUAYtUAp
         fo2UtpPFEjC4I++Cu74zOvJ0XWW/GkYcdZaIT2MTaOvDNdG7P5AVfdYLDt06aqc369Hj
         AIPpTIyF80j0LnMr/8l1F+qvIFW9M1w6KTNU5+IC9ZsnqzHEQDj4ytQ/aqRvFrXAsKhY
         Bx8Jgyk45341EjEgKlKT6KVGXJoBccBNsLASGX19YjCRRxoMVenMYCWvvsHuTrpVTHSO
         DxhRTlADlRFej1ND9Z3boMscajfz20yM+VI4zgFjYK+KFXvDFySFN3zVJGd+721fSQcJ
         FU2w==
X-Forwarded-Encrypted: i=1; AFNElJ8nB2IQDgW1R4AXgsIFTNZ3/AtygLhWGJRej0BcT8CzBR58ynNskTdCMg7LYj6iHHrtzcAaOA8D7X+E@vger.kernel.org
X-Gm-Message-State: AOJu0YzCUGRPanxiPJUkvcJYGgbgnMlVpq2A/Wmn4j4Dq6rSb4r6t5oJ
	LIzI1qBOlpTNlklegB3VGE9yz5Xtuwv2Vh0ESt5OCdJo1ofgfrjXZB1+IZrmXyWwmA==
X-Gm-Gg: Acq92OEpdD5M2bK2SXhgah9I1P7tZ/Zz2Q8AS96aF8k1MtJH89WfWGz+mBl6tkBQ7oD
	NnlE+5VG0wEL0wwY+YWwKLmLzzZQwKlc2TXn8pSlqymyluQfrFoOglmyiaej1N+qk1CISRyaq7i
	clGeR70eqeRvXFROCz9oJAsxF9yHQMfjOxpP2M62UCDAIJbvMAYs63WUdBLxrPLNHmkO1NkP+bN
	epqOKHGvCvZXBDgkuRL8a4PxcX9sCm2TniTVE6E8zSd1k4myphKmiNhIJ3rPfIofit9Hg/GMISY
	5tmSUPDTis4bRPGINcZpsRHYF+PtsxV1/mBy83/Mx5r47cY1ZxCBu9cXqZaiH2YEenfaXVxzxmu
	1xKWK5vNrd2lHSSz2snpgqO0sJs3mYTbGXhMXwy/lmMMQTWAOsbPU0ftwzf0mbvrwioFMuyQmWL
	GFtIY536i5zVH/vdVYKqWPX3PN5kyOp9nc4rehkwm6aD03LWEFm9GueFShvGTd/gbMqZM=
X-Received: by 2002:a05:600c:c04b:10b0:48a:5d95:d33e with SMTP id 5b1f17b1804b1-48fd6e10247mr915845e9.6.1778773444106;
        Thu, 14 May 2026 08:44:04 -0700 (PDT)
Received: from google.com (8.181.38.34.bc.googleusercontent.com. [34.38.181.8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe0f72sm7842670f8f.25.2026.05.14.08.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 08:44:03 -0700 (PDT)
Date: Thu, 14 May 2026 15:43:59 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
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
Message-ID: <agXtv-Wsun82SRmf@google.com>
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
 <20260512090408.794195-5-aneesh.kumar@kernel.org>
 <agSKQrSIhizCXKwx@google.com>
 <yq5ah5oaa63h.fsf@kernel.org>
 <agW5rhE9n2gDQ0w5@google.com>
 <yq5apl2y5f96.fsf@kernel.org>
 <20260514143733.GB7702@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514143733.GB7702@ziepe.ca>

On Thu, May 14, 2026 at 11:37:33AM -0300, Jason Gunthorpe wrote:
> On Thu, May 14, 2026 at 06:18:05PM +0530, Aneesh Kumar K.V wrote:
> > > There is no problem with non-protected guests as they don't use memory
> > > encryption, my initial thought was that th encrpyted/decrypted is
> > > per-pool property which is decided by FW (device-tree).
> > 
> > What I meant was that we need a generic way to identify a pKVM guest, so
> > that we can use it in the conditional above.
> 
> If I understood Mostafa's remarks I think different devices in the
> guest need shared/decrypted and some don't? Ie a virtio hypervisor
> device needs shared while a real PCI device doesn't? Is that right?

In upstream, device passthrough is not supported, but that case is
supported in Android and we plan to upstream it (it currently
depends on the SMMUv3 series first)

> 
> In CC terms that would be a mixture of T=0 and T=1 devices hardwired
> and signaled by firwmare..
> 
> Ideally we'd have a flow where if the arch precreates a swiotlb pool
> with special parameters this overrides all other decision making. Then
> this series is about making CC NOT use that flow... ??

Yes, I believe that will be needed, we do this at android by a per-pool
property added in the device tree.

Thanks,
Mostafa

> 
> Jason
