Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D713ACA45;
	Thu, 14 May 2026 06:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778739883; cv=none; b=FWbXyPf+fdBlF4BY693o8P7C1tIOarYDY66JLg7UDK1iGlg2DTgZ42Qg+IvBetL7m0o/NDbeeK+nGB3ijeAid112/7gj4AkhnTNMXrTpDh/CdMCEIJ1/aEVGDSQxnLSzDJOT0bdr74C0RI+Ao54eALTJNNjpAAiJuc2E7WxOJ10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778739883; c=relaxed/simple;
	bh=ecGsHNVV/zGWfQo2KCz+UMgNIz0oxNVr7CL3H1ueicQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U2wO9yeBu9IkGAm6E1EPXsVvxVrNXEZ5f19GanipLRt8fcCO9rD+xavTFkA7DiLtwQ+mKuwilZ2mI/bDWmaDNhHR+i9RPpMhstoCg8o4HKK/hDJKrzgHjxg9dEyYGczF8jwQwe2MZixgbDifbkk5aRsTOWZJxv8tgXT5etxFAIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VIFBftDk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIFBftDk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A983DC2BCB7;
	Thu, 14 May 2026 06:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778739883;
	bh=ecGsHNVV/zGWfQo2KCz+UMgNIz0oxNVr7CL3H1ueicQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=VIFBftDkTqQvTeGSGdUb63C6Y5jX6Qcf/aCnqTSus57moAmWsHaY20Ek8+NzNXF7I
	 r30wh4vj1ifGB0fA2KjcIkRogw3gf/w/DwCz8rVK9iAc/K453wPiIu8E8hBCt7TUx+
	 djavHnjghAjLiadXV9zorYImb47+oIv4wV/oN58jnzuEcvJqM5fABJjEe+zUiHiIwr
	 2QhZIGpd2mWiRm0jNgOlqLkPgQDFCTqrCKFDe2+QllPsd7D5xi2BKD5Z4yDZF3gpjR
	 +BGATD5Q3YuIez48+zWs0mHgv5HFqviNpKfMGsjB3Cx0lI1Sy1ANa46iOb/RUQrXqA
	 h/GpqX2YIjQlQ==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
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
In-Reply-To: <20260513172450.GR7702@ziepe.ca>
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
 <20260512090408.794195-5-aneesh.kumar@kernel.org>
 <agSKQrSIhizCXKwx@google.com> <20260513172450.GR7702@ziepe.ca>
Date: Thu, 14 May 2026 11:54:30 +0530
Message-ID: <yq5aecjea4pt.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason Gunthorpe <jgg@ziepe.ca> writes:

>> And that brings us to the same point whether it=E2=80=99s better to retu=
rn
>> the memory along with it=E2=80=99s state or we pass the requested state.
>> I think for other cases it=E2=80=99s fine for the device/DMA-API to dict=
ate
>> the attrs, but not in restricted-dma case, the firmware just knows bette=
r.
>
> The memory type must be returned back at some level so downstream
> things can do the right transformation of the phys_addr_t.
>
> One of the aspirational CC things that should work is a T=3D1 device
> tries to DMA from a decrypted page, finds the address is above the dma
> limit of the device, so it bounces it with SWIOTLB to an encrypted low
> address page and then the DMA API internal flow switiches from working
> with decrypted to encrypted phys_addr_t.
>
> If we can make that work then maybe the flows are designed correctly.
>

That is what this patch series aims to do. dma_direct_map_phys() will
derive the DMA address based on the attributes of the physical address:

if (attrs & DMA_ATTR_CC_SHARED)
        dma_addr =3D phys_to_dma_unencrypted(dev, phys);
else
        dma_addr =3D phys_to_dma_encrypted(dev, phys);

If that fails the dma_capable() check, we fall back to swiotlb_map():

if (unlikely(!dma_capable(dev, dma_addr, size, true, attrs)))
        return swiotlb_map(dev, phys, size, dir, attrs);

We currently do not have an encrypted SWIOTLB pool, but once that is
supported, swiotlb_map() should do the right thing and return the
correct encrypted dma_addr_t based on io_tlb_mem->unencrypted:

if (dev->dma_io_tlb_mem->unencrypted) {
        dma_addr =3D phys_to_dma_unencrypted(dev, swiotlb_addr);
        attrs |=3D DMA_ATTR_CC_SHARED;
} else {
        dma_addr =3D phys_to_dma_encrypted(dev, swiotlb_addr);
}

-aneesh
