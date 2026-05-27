Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDA2453495;
	Wed, 27 May 2026 17:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779904172; cv=none; b=eOlyilXIuBwLuZyp5s2BsKu50xi9KYDFxivjl8ddib3b6/1MnpDmQuGmXkvq3CWncyzM9t/XD3gSdGuefpClYI6uQeGhLeRJq+Y/t5qCPdXGQuGPB+zO7NeUjQrKWRnGPTTyKgpAXiF0RahzWLDmeIf0C5z5SRpc0nq1YWw32j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779904172; c=relaxed/simple;
	bh=QHo4vfpTo+OuuUOJhK/ykgVt9OF28GCINhc8L0+DwLY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fiyJhb5cvnenwkyAJFA6taOBPqVNkVMNmqxcTHPR5Ov+mS3Os5368YxSY8A+uF6pgBFxeP7f21FXO3NT+MZ7T40S7l8ZohPDOWm3FF5r+8v65rgEAZWdWxNc1YiM3e5NEvz7iwaDG2YMAm6u75Ki5dRs2bQ8ypPelvZktMsmK3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QmO3s03N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QmO3s03N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D841F000E9;
	Wed, 27 May 2026 17:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779904171;
	bh=SGme9EGefoC4cL8s1RAk5wHcM5ST2icrcVT0s+6JiQc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=QmO3s03NUjN2KFqtIUNtplCgcfaiu+Zcwi+mR9p0ChcHpkFSiBa0c8XOUU77YxoRC
	 EC+3w96HLGEGLX4iD+1lIV1YJB2h6ncGaOV1DRryGf8wiB26VaRL2WTfu258Kmv5bR
	 9tJMY3nZ/suiqDc9/rWUBVC85sqTB51FU27hoFmjA/mIY50pjtjg2DEyP+xmAhKoWi
	 VylILIA7GlyRI9PuJlsSklRpORIYI4TWUAWhtTUvqOy6DyFkVqoQZCTx7cDZUbtGd+
	 D3A+64reAFfrEt8eJ7xuksT7wzZdkmXU91SPyGB6Sq1fXqjNLqLp3x9pnD417T3vMq
	 fRws0Ks1kio+g==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: "Dan Williams (nvidia)" <djbw@kernel.org>,
	Alexey Kardashevskiy <aik@amd.com>, linux-coco@lists.linux.dev,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Dan Williams <djbw@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Joerg Roedel <joro@8bytes.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Tony Krowiak <akrowiak@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Jason Herne <jjherne@linux.ibm.com>,
	Harald Freudenberger <freude@linux.ibm.com>,
	Holger Dengler <dengler@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alex Williamson <alex@shazbot.org>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Farhan Ali <alifm@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v5 5/5] iommufd/vdevice: add TSM request ioctl
In-Reply-To: <yq5apl2gsw6y.fsf@kernel.org>
References: <20260525154816.1029642-1-aneesh.kumar@kernel.org>
 <20260525154816.1029642-6-aneesh.kumar@kernel.org>
 <becd865d-09a4-4ac3-b719-4a0deae2692a@amd.com>
 <6a168c8ea7d10_2129b2100e@djbw-dev.notmuch> <yq5apl2gsw6y.fsf@kernel.org>
Date: Wed, 27 May 2026 23:19:15 +0530
Message-ID: <yq5aldd4spyc.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Aneesh Kumar K.V <aneesh.kumar@kernel.org> writes:

> "Dan Williams (nvidia)" <djbw@kernel.org> writes:
>
>> Alexey Kardashevskiy wrote:
>>>

......

>>>=20
>>> I have 3 types of requests to fit here, all go via VM -> KVM -> QEMU ->=
 IOMMUFD -> TSM.
>>>=20
>>> 1) bind/unbind TDI <- moves to CONFIG_LOCKED, this is "OP";
>>> 2) start/stop TDI <- moves to RUN, this is "GR"? Right now I route it v=
ia "OP";
>>> 3) enable/disable MMIO/DMA <- no TDI state change, this is "GR" but whi=
ch scope is it here?
>>
>> The scope parameter was meant to enumerate a security model for classes
>> of commands that are otherwise opaque to the kernel. However, none of
>> the commands we are targeting are opaque (private specification with
>> unknown effect). It now turns out there is no role for @scope for
>> security.
>>
>> Now a command family that iommufd can validate seems useful. As it
>> stands this implementation aliases command codes across TSMs. Do we
>> proceed with creating an actual shared command uapi for the truly shared
>> commands:
>>
>> TSM_REQ_TYPE_DEFAULT: Commands every arch needs
>> TSM_REQ_READ_OBJECT
>> TSM_REQ_REGEN_OBJECT
>> TSM_REQ_OBJECT_INFO
>> TSM_REQ_VALIDATE_MMIO
>> TSM_REQ_SET_TDI_STATE
>>
>> TSM_REQ_TYPE_SEV: Commands only SEV needs
>> TSM_REQ_SEV_ENABLE_DMA
>> TSM_REQ_SEV_DISABLE_DMA
>>
>> ...or just observe that per CC arch commands are needed to setup the VM
>> so per CC arch commands are needed to marshal device assignment support
>> requests.
>>
>> In that case pci_tsm_req_scope becomes tsm_req_type and is just:
>>
>> TSM_REQ_TYPE_CCA
>> TSM_REQ_TYPE_SEV
>> TSM_REQ_TYPE_TDX
>>
>> I am leaning towards the latter at this point.
>
> But we already have struct pci_tsm_ops::guest_req, which is specific to
> the underlying CC architecture. From the above, pci_tsm_req_scope also
> appears to carry the same information. Is that useful?
>

I think there is value in having the VMM express the guest=E2=80=99s
confidential computing architecture, so that the TSM backend can
validate whether it should handle that guest request ?.

So it would not be the IOMMU validating the scope value, but rather
pci_tsm_ops::guest_req.

static ssize_t cca_tsm_guest_req(struct pci_tdi *tdi, enum pci_tsm_req_scop=
e scope,
		sockptr_t req, size_t req_len, sockptr_t resp,
		size_t resp_len, u64 *tsm_code)
{
	struct pci_dev *pdev =3D tdi->pdev;

	/* reject the guest request if VMM was using the link tsm wrongly. The gue=
st
	 * was using a wrong CC archiecture with this link tsm
	 */
	if (scope !=3D TSM_REQ_TYPE_CCA)
		return -EINVAL;


Jason Gunthorpe <jgg@ziepe.ca> writes:

> On Tue, May 26, 2026 at 11:17:50PM -0700, Dan Williams (nvidia) wrote:
>
>> In that case pci_tsm_req_scope becomes tsm_req_type and is just:
>>=20
>> TSM_REQ_TYPE_CCA
>> TSM_REQ_TYPE_SEV
>> TSM_REQ_TYPE_TDX
>>=20
>> I am leaning towards the latter at this point.
>
> Yeah, this sounds good. I would also include an common op field that
> can be decoded by the TSM driver based on the TYPE above, and the
> usual in/out message buffers.

We already have iommufd_vdevice_tsm_op_ioctl() to handle common
operations. Right now, it handles IOMMU_VDEVICE_TSM_BIND and
IOMMU_VDEVICE_TSM_UNBIND. I guess we should move TSM_REQ_SET_TDI_STATE
operations to that as well?

-aneesh
