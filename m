Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3C9369D44
	for <linux-s390@vger.kernel.org>; Tue, 19 May 2026 13:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779198112; cv=none; b=FBB4kQwt8pCteKFYA1kqkla5pY06ESIKNgGafMVlRWYb9NdImMy0kwGJE1scdNZDCpL7h/cD+fCb83hqkojwZC9A3YSKBHiScu8/ZceCGDp/igY9gFUV0vUM14Pmj21vMj+lOgbEVw/k8SsUwLWJ/LTuawssViIHWe0JNDVg9lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779198112; c=relaxed/simple;
	bh=XBOffOhB/9qLimda2QAP8c1r3War90H/Z69bX8D7upY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ndy7DpjwcdT0pUUdXTdcpIKZlk2Fz3sjUOe8ywHiAdOixs9nVgPijEy897If15Y8WHxSQZ7s2j1WEbC0L3dZ1AdU9xoKgm09AontSC6K8wDQI3wxoKE1Alqv1xA416GDJRAuCqsIffjPeDB0/+xLpJucJSmtQYrOMXVFZKx1sLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CGkzjxjf; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CGkzjxjf"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-67c1eea6b4dso47a12.1
        for <linux-s390@vger.kernel.org>; Tue, 19 May 2026 06:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779198108; x=1779802908; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b0rbd5r2XPU85ZjN9Z8MDWtjzmRcNTYnxCurh+UMIug=;
        b=CGkzjxjfmx4htFn3TrFLJlcY9nT9OBXht34NxAdzSNtI7xQ1wyzmeNCAQEkb90WYKT
         yHgKM5s1mN6zLXtVHDugD9zGC5h7Pj1/ae1WwjH0y1DLDSMyR2kO98STN/fT23OmfG/N
         GdZeu1f4Layq9WOqkNXhrk0yu3ZDM2OuwM7R6RMvfRbPVG0hMlQJQAcLzVNnEUigZAj4
         Wxkve4Rh0vwB9OWbqfOhLh9hWgfUuN8UW0ago3enTLXfKrLQy8tXFS6gybTyzdsqlYRr
         I+9BROI1yM7bYUwbluQ3VDsFFbIdMi2Qpku0etewAwexGfyih8iitT9DvQvjO4ecuclv
         +Weg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779198108; x=1779802908;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b0rbd5r2XPU85ZjN9Z8MDWtjzmRcNTYnxCurh+UMIug=;
        b=RGnEHp8hGXaSq8xfalKfozgG4ihiUEhcEhSFv7e/3D1iwVnc1oL9LsHOB2EIS5CC5P
         kH+xUqOGzOMS/4pZcQst/LF+Rk/bg9kqYnqFz3OtG21xWibXwcX3TkVhXqRQzCoYZnWd
         tTefn0AqXfcMdIoa62IY2C3LalG3DVxuiThl1nh8rvgng17mzviMXnu7Xu8p+L/5dBgk
         RbWYildBvAfb9hSKryI3Z3Mh2xsKYvTsYhu9MkbZXQJCc9tIlsEbwlZj6l7C1kVJHOod
         6dXtra3gHO1vfZFAa/gEHgiK579vBaZvpAU+xyt7Xp/MyUZT50cAK3WUnspRa4Ut+CNc
         lFMg==
X-Forwarded-Encrypted: i=1; AFNElJ+AlCypQNHKl+RDGvnLJ/tF7U5PLoDP+iBjUSTardxG8gZxXUkP9yAkJTX9QmPWXxZR6Wvlo55r1FLm@vger.kernel.org
X-Gm-Message-State: AOJu0YwMZsGMo00sDiHOwSoYUG6IfuJCeUF8Za9kKoWPyc2KDPpg6Xxu
	KIBQuR9B9l56tXOCPIyAVlJeP7OTsAjXEOoLwqJD0PZtrNGEc51UFqpw/pXR59R5Bg==
X-Gm-Gg: Acq92OHrUsg/eAap/+XMhsPSmWeNqrd5lcOtX9mo8iqHU273noG5MFnvCps738BJOy3
	SPGJiDSFKt+i8XwwUptGgQtDpWDazvnX1PqTOCfOEWYjewr6NX4rsBsdqWHleCklwr7yRHZKgV/
	SKm97DAa4Pry59LfcuX5H5lK4H27ipihEarzIu0ealxHOy5/xQahOnFi7wIyzhCe5Z16zX/PRFP
	/v5an+ynGxxdViCkEGhV9Kxnd/tVTtQOpf75f4tvD4QQUaG2yZtBYazyaFshTlcvLHXJZfFaXlg
	jkYND1JJZctwBF7r5SaxT0xULeL2YtG5EpaZRd9AA7JxfvwzXXnrlOopzfMlJVg5EI89yoRwuEN
	qtopsEXosctK12Y6+IhZg3CZ/LbuspWr8bEK5oX5xExDDqYg//Rftzmvr4pnhGjt25Q9l1Pg3EU
	uzj2OXuKNKSWFqtHs/ISLD2L/yKuvHxtM1WGyjpy9YxOUbdri/L6Z6xPfBoJGHvIdnAuma0p4eU
	lA=
X-Received: by 2002:a05:6402:21d3:b0:672:9c8f:910a with SMTP id 4fb4d7f45d1cf-6848a7425fdmr177638a12.8.1779198107616;
        Tue, 19 May 2026 06:41:47 -0700 (PDT)
Received: from google.com (136.41.155.104.bc.googleusercontent.com. [104.155.41.136])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4ded942sm705903166b.36.2026.05.19.06.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 06:41:46 -0700 (PDT)
Date: Tue, 19 May 2026 13:41:42 +0000
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
Message-ID: <agxolksC_1nfO34X@google.com>
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
 <20260512090408.794195-5-aneesh.kumar@kernel.org>
 <agSKQrSIhizCXKwx@google.com>
 <yq5ah5oaa63h.fsf@kernel.org>
 <agW5rhE9n2gDQ0w5@google.com>
 <yq5apl2y5f96.fsf@kernel.org>
 <agXaby-7L7yS3Vva@google.com>
 <yq5ah5oa59wy.fsf@kernel.org>
 <agxDxdxynp4KEovA@google.com>
 <20260519132911.GA7702@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260519132911.GA7702@ziepe.ca>

On Tue, May 19, 2026 at 10:29:11AM -0300, Jason Gunthorpe wrote:
> On Tue, May 19, 2026 at 11:04:37AM +0000, Mostafa Saleh wrote:
> > On Thu, May 14, 2026 at 08:13:25PM +0530, Aneesh Kumar K.V wrote:
> > > >> 
> > > >> What I meant was that we need a generic way to identify a pKVM guest, so
> > > >> that we can use it in the conditional above.
> > > >
> > > > I have this patch, with that I can boot with your series unmodified,
> > > > but I will need to do more testing.
> > > >
> > > 
> > > Thanks, I can add this to the series once you complete the required testing.
> > > 
> > 
> > I am still running more tests, but looking more into it. Setting
> > force_dma_unencrypted() to true for pKVM guests is wrong, as the
> > guest shouldn’t try to decrypt arbitrary memory as it can include
> > sensitive information (for example in case of virtio sub-page
> > allocation) and should strictly rely on the restricted-dma-pool
> > for that.
> 
> ??
> 
> Where does force_dma_unencrypted() cause arbitary memory passed into
> the DMA API to be decrypted? That should never happen???

Sorry, maybe arbitrary is not the right expression again :)
I mean that, with emulated devices that use the DMA-API under pKVM,
they will map memory coming from other layers (VFS, net) through
vitrio-block, virtio-net... These can be smaller than a page, and
using force_dma_unencrypted() will share the whole page.
And as discussed, that leaks sensitive information to the untrusted
host.
I am currently investigating passing iova/phys/size
to force_dma_unencrypted() and then we can share pages inplace only
if possible without leaking extra information.
I am trying to get some performance results first. But the tricky part
is to get the semantics right, I believe in that case those devices
shouldn’t use restricted-dma-pools as those should always force
bouncing. Instead bouncing happens through the default SWIOTLB pool,
if not possible to decrypt in place.

Thanks,
Mostafa

> 
> Jason
