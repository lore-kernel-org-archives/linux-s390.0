Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A333D7D8C
	for <linux-s390@vger.kernel.org>; Thu, 14 May 2026 08:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778745995; cv=pass; b=Sbxsd1ZovC3YrQsgH7qNaxjPSieCsJs92kM8toX9ObaCMRfpcj+Bm3kBD+kmbeKCCHgWsQB3XMrkJ6ry+95jpHB/S9bgu0AQdwLuK+LMr7pfoRSCQrb2g7906sC4FQWJ5dRLYefj4jA8aywSMLHZaUhRahNNLc8bkdWpn3BSV+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778745995; c=relaxed/simple;
	bh=kULtJx0tmeW4GuTbqeswULlbN9hTWpiDyjj2wWWYuV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c4T2/hjhnDe/XxQRi503QB8/bYg5C4msrmVdN7GzeGpJdgCo40YYeF1p/P4hlW+qEpJLrNU8dMPGtZAKpj1B4LUAq6bzkLDL3r6ybFGeGUDcxJOA6snHp1ic6q13OPz2oYiKhl2lph6GHj5Ze4RxvyW3HeiS8UuWZFZ3HNlgLXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CiMsbZpT; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CiMsbZpT"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-50e61648f10so351471cf.1
        for <linux-s390@vger.kernel.org>; Thu, 14 May 2026 01:06:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778745993; cv=none;
        d=google.com; s=arc-20240605;
        b=Hl2lul8solf1dju20lKrZ2GX3PyTstfJb3wwHv8KjYLeNPEUVTBr17nye5j1fvVG/7
         2xPtfA/9mTreAqkJu/Fm/Jr48CtXNMAlhnhxHrA7jVXnx/nh0Hfyzuw34pB/aeMM6NZ4
         ofEICsOE5uUEBxzww9yMFTz5qSS49EH2H8TbV0HR7pft9m+OMsYUJgqPwU+ffGHOtfpT
         wDGSdZ3ytYtYyN+A7CSoCGh3ykKjNu1In0iQid4j+pL1isca9mrjde2pYKGnyXwF7qeJ
         K/04+47VidvPbIAA8BWDFxyl7xaD3LK7PNW5EvPjHiHKwaoFL0sVNB9xNSKqH6J92sxZ
         EpcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QXdd7FnOAYRaLS7B63YJ6ysgGCzM3+RdD/s5lYMWf1I=;
        fh=+HQ+WVpdrgcleE/E5Zw7+aggu8sJInBWkZlb5TO9SKk=;
        b=DtMEsd1KbUb5TTNNcv2lKsb2E/oKBkBcfyxhn9yYHlQrXDWSGt016/lk30+SlGrnL5
         I7nYMg2EW6meNSEUXU0Lu5eE/Lk4RIkPr0TeDxuCwpiSZbGayYEXC3TTL3wnRgmvCSR7
         Oj4FsaW5SiqYyBV41eo9tgistf0O5kEbhq3zsiLlqNxm6yGCXPnOuQIdHVt0KDTc0pkG
         i35DKouVy3MOwTNLcPCaElDMgpCxt9TTjMsmfaDqUvFFd2Qu1gJTcFEU6W0ixhrdw3dJ
         qjXSxMSunogUPrU013HtGw7KCKr+WlVpvTBhlzqoeCzlnrykOCprHrrmifW11RgcIaqR
         MB0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778745993; x=1779350793; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QXdd7FnOAYRaLS7B63YJ6ysgGCzM3+RdD/s5lYMWf1I=;
        b=CiMsbZpTJXH8vxxOCEv6dnDTD0SJQFW+j0cOxb8e9xI9/5cg0ape+KLSDMqqwejI70
         +lhyRPgVzd4MOyiM3xQIevDTZ/srdAxDfbFKXA9lLElP4xpkQ9kt6DJmo7Zan9hy3dCZ
         MSy8wh+umftlYIGSq+IcgWgS0KlRMJgJcWpu6KUzRv5gbyDqv/FBNtkNvA1HqZp2e9RE
         kaNxerBZ/tENOHwR/bQ70Qr8lEXku6efxcWS94a5wgwjtHZgG+hh25Dy/fZFBX3B5wgy
         F/HHbYW86A1DM1G4l7N+6WaH0Eg6Hxdw8wLR4K8i03bL2E+i1f5Tks6uyx8Oy+7HUa2D
         Ibog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778745993; x=1779350793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QXdd7FnOAYRaLS7B63YJ6ysgGCzM3+RdD/s5lYMWf1I=;
        b=TZueMUStC1tXWNSm6Z4OSjeM7IuLNtvWPv4jllEmU8WZu6gwnaD/az7WGWiovDnutQ
         2Hj4U6dNywlqggDohWOUzqgcp2iHw0yWzyidlrfCBNZeq+NhMqK/soRPAiK9NM1LyGBL
         xJbXgitQSVvDBKijUjYF+Up/8rfjXdeiQM4I4NQMXJMpXeIh+oYL/6Ab3iy5DF6qpcq+
         Fm8Xwm93knAA66AmS0tZYx1F5/Uv7+ZKuAu+o8SqjIe7vkwl+g4IK0+gD3feaxsgzG8V
         pkTZ+nEmNfARWX06Rtj8ITFdbpsZ/avFFvaQL2X/q0/58sIB2Ilrg/41DFrgaPiqp2QS
         HMBQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Mf/ZXEGLtAht+SvioaoMnnz9eRB7c3lVL+dblzx83mgsF4UOfYQKheWaTtqtsvaeFnXKnz2PkhrCR@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6j5fBxJD87hmCsMUuMODiGDYWfHs3MkRIMQBvyDZIOLJBB9YV
	fQS+Qgot8pYJfYCMA2q0HeNcoawtkbwvJWjwGNxOnwr6eFcuDvIm2SBTfOIkw+t8RayRMpCzRmi
	boZogYy0fR+w68otq/RcRbQMwsVxmdEA8GdLxJAbu
X-Gm-Gg: Acq92OHOo8+Oe+wdeh7v08qEsJyMaeOgzYM6XaQ0+KJOSyfiRHLvyF3pF0WBYJb5xc7
	jGAdi+qfBHkhcnAl/7i0Y5Q7xjUA5JeoEJrFKKmC240DzgCkoE8H0WtFjINEmuV9aX0kfL/IJeo
	mZZWU05710R0W/Plm/pvx3CDTYRMBbhvrqvAt6GaZ0MCAMia/jL5KTX/CUYVqNMEo/CgaL9d5c9
	BvJd4nKudqQxKPjs0EumyU9aMlyzFLgODyEDqeYvUeFnu2maXBc6So+pQQNJcfFixExtmVGB9rf
	0htduHtkcCi44Qo6hY5biGUmLn1EKMNKQKWhAF07LeLnnNhl
X-Received: by 2002:a05:622a:9007:b0:50e:6360:96e with SMTP id
 d75a77b69052e-516420a4ecdmr12032231cf.0.1778745992401; Thu, 14 May 2026
 01:06:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
 <20260512090408.794195-4-aneesh.kumar@kernel.org> <agSED6BdSXBhbDYI@google.com>
 <yq5abjeia315.fsf@kernel.org>
In-Reply-To: <yq5abjeia315.fsf@kernel.org>
From: Mostafa Saleh <smostafa@google.com>
Date: Thu, 14 May 2026 09:06:19 +0100
X-Gm-Features: AVHnY4KFUT_Q3ProEjcPRlzXFAyPmNH0RBADajCyGfb0sF72QbGsmq65dFwn1XU
Message-ID: <CAFgf54qB0msUdKakDvh7hp0r5kokPV0vohBxUjkOz7sR1FZNuw@mail.gmail.com>
Subject: Re: [PATCH v4 03/13] dma-pool: track decrypted atomic pools and
 select them via attrs
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	Robin Murphy <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Steven Price <steven.price@arm.com>, 
	Suzuki K Poulose <Suzuki.Poulose@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Jiri Pirko <jiri@resnulli.us>, Jason Gunthorpe <jgg@ziepe.ca>, Petr Tesarik <ptesarik@suse.com>, 
	Alexey Kardashevskiy <aik@amd.com>, Dan Williams <dan.j.williams@intel.com>, 
	Xu Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-s390@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 8:01=E2=80=AFAM Aneesh Kumar K.V
<aneesh.kumar@kernel.org> wrote:
>
> Mostafa Saleh <smostafa@google.com> writes:
>
> ...
>
> >>  struct page *dma_alloc_from_pool(struct device *dev, size_t size,
> >> -            void **cpu_addr, gfp_t gfp,
> >> +            void **cpu_addr, gfp_t gfp, unsigned long attrs,
> >>              bool (*phys_addr_ok)(struct device *, phys_addr_t, size_t=
))
> >>  {
> >> -    struct gen_pool *pool =3D NULL;
> >> +    struct dma_gen_pool *dma_pool =3D NULL;
> >>      struct page *page;
> >>      bool pool_found =3D false;
> >>
> >> -    while ((pool =3D dma_guess_pool(pool, gfp))) {
> >> +    while ((dma_pool =3D dma_guess_pool(dma_pool, gfp))) {
> >> +
> >> +            if (dma_pool->unencrypted !=3D !!(attrs & DMA_ATTR_CC_SHA=
RED))
> >> +                    continue;
> >> +
> >
> > nit: If we fail to find a matching pool, a slightly misleading message
> > is printed as pool_found =3D false
> >
>
> The message printed is
>
>         WARN(1, "Failed to get suitable pool for %s\n", dev_name(dev));
>
> That is correct, isn=E2=80=99t it? The kernel failed to find a pool with =
the
> correct encryption attribute. For example, the request was for an
> encrypted allocation from the pool, but no encrypted pool was available.
>

Sure, I=E2=80=99d prefer a clearer print in that case, especially since tha=
t=E2=80=99s new code:
=E2=80=9COnly {encrypted/decrypted} pool found for a {encrypted/decrypted} =
alloction=E2=80=9D

But no strong opinion.

Thanks,
Mostafa



> >
> >>              pool_found =3D true;
> >> -            page =3D __dma_alloc_from_pool(dev, size, pool, cpu_addr,
> >> +            page =3D __dma_alloc_from_pool(dev, size, dma_pool->pool,=
 cpu_addr,
> >>                                           phys_addr_ok);
> >>              if (page)
> >>                      return page;
> >> @@ -296,12 +345,14 @@ struct page *dma_alloc_from_pool(struct device *=
dev, size_t size,
>
> -aneesh
