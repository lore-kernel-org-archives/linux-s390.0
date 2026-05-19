Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB6F3ED3A9
	for <linux-s390@vger.kernel.org>; Tue, 19 May 2026 14:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779201333; cv=none; b=TS6m9ui9hNVLcOeVbouuglpY73svecYpCKeVn/U3zuCr3LPj5nghls0cOXteRjXKScgm49Kar7vFWJD++H71Tpk0uSTGHVwNVAOUatDn6IDw9LxBpZypXPTm3cOMcR1/VduT1JgCN2NnYCSFuhu6tluObf2toSJEFSjPRRQnCIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779201333; c=relaxed/simple;
	bh=SrJusYoqDcdUKkci3L7v9V2XCvsCIXynjFVOmsBOWE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mkfu97tmi0GQxRxtgmRYCPaJHGHTnPlIj0nKNKpxUK5Rhhr7gRH/v330dptBg0h4ritiTHt0iPP2wckP2HbkHQgrJxGicHxCqs9s4a2n7cdC+fAGj8ZA3iTuVyiYAeyRpvuUJmWO7NDgCezdFM915KVYK+Ir+oMOJ+5m7yeuDKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=GbZK3hXF; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="GbZK3hXF"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-9116861f004so875311985a.3
        for <linux-s390@vger.kernel.org>; Tue, 19 May 2026 07:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779201331; x=1779806131; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oQZO5nTRmEQFRCy1SP5NN6DtrD69wZAHlR442WwrJB4=;
        b=GbZK3hXFt2oQlforPXG1/rdvgcFSSgbgMc2AlwgDusD2YbzWI0mceqZ4tlKRQdAYLH
         u7lnq/JfwjPXpyS9QdBeR3m691TUxzDXVMz3T5oZTU/OpkYh3l6ezOe7nrA+UF8QUFuZ
         pDfwN59xKkIryJXI/3wB/6THdEnT+3S77fa6wjPJ/XIWxhnFXsTsFb35WNik/Qs3+KO5
         iC9oqDfwaMcaSpiKjKZPibxK9vWDsBMs9akjC5H69E2Icp9qwRHWnGxi4jsdPzWGkwSg
         OqOqxKI9IUWJwYq3b4AV7y47WcYca/6m5OdxtAcyYvlFIHipAW2eTlhXSPA+LN42ajbb
         l2Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779201331; x=1779806131;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oQZO5nTRmEQFRCy1SP5NN6DtrD69wZAHlR442WwrJB4=;
        b=eN8TlV9/mBnCRVq1hFKp1o51frSRwwRuhZhS1PCEoleRgAEz6GdBggo3lBlPWy/G+R
         N2dpTqiK2n5E26HBC1Z8gRkAoNn7VnUMR0oWq7eMkUmd8ztkjIis/tKSz6c8G4NPPcm5
         +x8j46PKa9RcVdZFfTNqwep2MxZTbGUPsgEScrSm/a/NWWyBPgd1C3JE3kUtmklZgeq3
         zGShoMzWiR7ftt36lMVt29Yx29YUAgar8knAhWGCyuVHe6C8TncCY21Z7ZIg6ybTNsHE
         L1PRijOZhCwSXnl/hytWvwRqOe45PzyTAAIH50ErIYLSE+LH8Wj7w//1olXlkQ1SHEEe
         ISrg==
X-Forwarded-Encrypted: i=1; AFNElJ92hpU5amYp4Zv6nohOToXV0mVlztGsFEMdb9eumx1EDxfG1l85UTVKq2IrM3ltA3lEBreVJeMQoiup@vger.kernel.org
X-Gm-Message-State: AOJu0Yxua1f2R5ssqteaA04jidBexg6qco+bqbhB6yIfcXLyf5u84JNR
	VOk0SDf6giOiHQdCnVTpYWzpxOWymf7V0XN20GvJp75AzABpB3eQfpSAidLHc2DRIkU=
X-Gm-Gg: Acq92OEOeCJ7q2QxEO4tyb5y8+SfPPWWo+8hyGklH/LjNj8gqEh08ij2ihektYOzaHC
	QB3Er51GJKHnxHMb/51O6aneu4vI0agUxPOyHw6D+UK/MBTzMtwApPfUMfX37FLeLGEKcJrIslB
	Ts3R1vFj1nLVqr5kVb6PKZRBMRQ91EAYs4l24OWTOoacS64N3DcwDXsPo5IJHn+BqvH6yu0LC40
	ey9Pk6ibvZXRgWD7x35AbNNbTUGI5a22WzrlASlrLfoPkjzR0vxwdcu6RFLk3IJ+Jd2ncYezlBt
	gjiv/9JzWPhUXFCL6+Kx3D+iAfAqrViOO7JB87ZqhPDX2sKFute4NF8hgE0jzVIp1p3rvlZYhi+
	YhIvnZFvZMlSvllM7c1RoW7FWvphLW+pmkEvQWblvgBdaBn4piUVdEGw6CTQfpCJrGEbji3f/Cb
	rioZVNXiH0+NF5CkW+vy6ThXevFw9HNDA0FvZz+JQ8mSW/cgIugnky+0F4f+UwFQCKgGGPuoU2V
	PWYaw==
X-Received: by 2002:a05:620a:d8a:b0:913:e5bb:3db6 with SMTP id af79cd13be357-913e5bb548amr1506341585a.31.1779201330581;
        Tue, 19 May 2026 07:35:30 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bc83ff00sm1849026185a.26.2026.05.19.07.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 07:35:30 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wPLXd-0000000F7pa-1dCL;
	Tue, 19 May 2026 11:35:29 -0300
Date: Tue, 19 May 2026 11:35:29 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
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
Message-ID: <20260519143529.GD7702@ziepe.ca>
References: <20260512090408.794195-5-aneesh.kumar@kernel.org>
 <agSKQrSIhizCXKwx@google.com>
 <yq5ah5oaa63h.fsf@kernel.org>
 <agW5rhE9n2gDQ0w5@google.com>
 <yq5apl2y5f96.fsf@kernel.org>
 <agXaby-7L7yS3Vva@google.com>
 <yq5ah5oa59wy.fsf@kernel.org>
 <agxDxdxynp4KEovA@google.com>
 <20260519132911.GA7702@ziepe.ca>
 <agxolksC_1nfO34X@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <agxolksC_1nfO34X@google.com>

On Tue, May 19, 2026 at 01:41:42PM +0000, Mostafa Saleh wrote:
> On Tue, May 19, 2026 at 10:29:11AM -0300, Jason Gunthorpe wrote:
> > On Tue, May 19, 2026 at 11:04:37AM +0000, Mostafa Saleh wrote:
> > > On Thu, May 14, 2026 at 08:13:25PM +0530, Aneesh Kumar K.V wrote:
> > > > >> 
> > > > >> What I meant was that we need a generic way to identify a pKVM guest, so
> > > > >> that we can use it in the conditional above.
> > > > >
> > > > > I have this patch, with that I can boot with your series unmodified,
> > > > > but I will need to do more testing.
> > > > >
> > > > 
> > > > Thanks, I can add this to the series once you complete the required testing.
> > > > 
> > > 
> > > I am still running more tests, but looking more into it. Setting
> > > force_dma_unencrypted() to true for pKVM guests is wrong, as the
> > > guest shouldn’t try to decrypt arbitrary memory as it can include
> > > sensitive information (for example in case of virtio sub-page
> > > allocation) and should strictly rely on the restricted-dma-pool
> > > for that.
> > 
> > ??
> > 
> > Where does force_dma_unencrypted() cause arbitary memory passed into
> > the DMA API to be decrypted? That should never happen???
> 
> Sorry, maybe arbitrary is not the right expression again :)
> I mean that, with emulated devices that use the DMA-API under pKVM,
> they will map memory coming from other layers (VFS, net) through
> vitrio-block, virtio-net... These can be smaller than a page, and
> using force_dma_unencrypted() will share the whole page.

force_dma_unencrypted() should only trigger swiotlb and that never
memcpy's more than necessary?

Where does it do otherwise? That sounds like a bug?

Jason
