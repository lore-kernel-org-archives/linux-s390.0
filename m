Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179272D2382;
	Tue,  2 Jun 2026 06:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780380616; cv=none; b=dsoeW6QWCDWtiLy1bGTKT7ccpbyYXv/7PywkZKbHR90z8gjmOeRFQK3SIhtPHbhLI1BsJsdCB5X7bXBv7qtiql4idbZwHfgYOHS29GWCDn5RW5tEAsac6pwWbsRuRHQH63/fxLA5MwvZ7FA9+mCGsZt/XL9ZgOqu3N3TWaTUtYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780380616; c=relaxed/simple;
	bh=tFMH5l5MTUaf6Xe98VNs76Ti6mPZN2RO0Y2Ijj9ZpVQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uavwt5WzG+FCf33yw6XgvuXsPUWpBsdk+zRg9Jc0UldQYXeQTWN4GWA2HkrxDACQPowL2GA8bSfplXY7lJiHpwtLTRbIA/N0VaFyUQxSvdWgE/Md4L5V20vddPkSBMNLmPSijwRHYBEExcNO89TahfLZ1K7jyatGUz7mnCe1Gag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZHJyOBo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZHJyOBo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F4341F00893;
	Tue,  2 Jun 2026 06:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780380614;
	bh=tFMH5l5MTUaf6Xe98VNs76Ti6mPZN2RO0Y2Ijj9ZpVQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=fZHJyOBoEGHiD16yVMLzAjbsRhIR7CFE9cGa8xrtaW1fYnxZpDeAP0dlt+35R/Mt6
	 lwiApCD3vWaU5f/ov1UftsC46EHnWWu9gVCnryDWlTRVbG8/Awo2j7YCs1kkoKzFUW
	 CLiouOcaFGFR32sW24z1VM1bmsWZYup1WOlxsoyfafKWKAqaMUDNcPp6rSaZlrOose
	 2+KdIT0Et7q2lWeCijk6GKIW77oJ2/Hmw08YSLGVBKiEFhtlIH4Duf/oWZrG7NccM7
	 XJbsbh+yK33nHz1p9/ZqYXK8Iv1em79IHjEcPrS+wx+QrhI/G32wo36vWwfGqLIiXr
	 rc4x3UNOXfQIA==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Michael Kelley <mhklinux@outlook.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
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
	"x86@kernel.org" <x86@kernel.org>,
	Jiri Pirko <jiri@nvidia.com>
Subject: RE: [PATCH v5 10/20] dma-direct: make dma_direct_map_phys() honor
 DMA_ATTR_CC_SHARED
In-Reply-To: <SN6PR02MB41574064D14D4A2734222C51D40B2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260522042815.370873-1-aneesh.kumar@kernel.org>
 <20260522042815.370873-11-aneesh.kumar@kernel.org>
 <SN6PR02MB41574064D14D4A2734222C51D40B2@SN6PR02MB4157.namprd02.prod.outlook.com>
Date: Tue, 02 Jun 2026 11:40:00 +0530
Message-ID: <yq5acxy9scav.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Michael Kelley <mhklinux@outlook.com> writes:

> From: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org> Sent: Thursday, Ma=
y 21, 2026 9:28 PM
>>=20
>> Teach dma_direct_map_phys() to select the DMA address encoding based on
>> DMA_ATTR_CC_SHARED.
>>=20
>> Use phys_to_dma_unencrypted() for decrypted mappings and
>> phys_to_dma_encrypted() otherwise. If a device requires unencrypted DMA
>> but the source physical address is still encrypted, force the mapping
>> through swiotlb so the DMA address and backing memory attributes remain
>> consistent.
>>=20
>> Update the arm64, x86, s390 and powerpc secure-guest setup to not use
>> swiotlb force option
>>=20
>> Tested-by: Jiri Pirko <jiri@nvidia.com>
>> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

...

> With this patch removing SWIOTLB_FORCE from four places in
> kernel code, there are no remaining places where it is set.
> The test of SWIOTLB_FORCE could be removed from
> swiotlb_init_remap(), and its definition could be deleted
> from include/linux/swiotlb.h.
>

Sure, I=E2=80=99ll add that as a separate patch in the series.

-aneesh
