Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370783D525E;
	Wed, 27 May 2026 15:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779896090; cv=none; b=qovODJWy3a3W0pzpg14QErV+lgsJ4d8ZanwmzT+gozn2oESU2WjoyVP4yyu/a5AyK60p9fSzAyNqtWMZUQbReNFcjSVjwYMSmbq6fXSKidS7YGpYnGsOSmiuBytPnIARPK/cKNn/4ZfcXbA4zplq8S4oPwB6JO4ofCLGqH4cB4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779896090; c=relaxed/simple;
	bh=eYVYYSuFVGmwCEA1eQW+wxuiUuETdO6GAvZY6GYSRBI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uPqoXveINm6y5XotvW9ckVkSsVBf/LSfJKlSy7HY4I8DfXeW/eO1F2Z0AMyvCSU7zvz0JiFd0X7U4WTQpLKifZQF+6j1YHtikido+4xjLkvmtvVgQHSO1gnCssDr7TKtmxQEQWVUKHHCAMp4ajJyDP+WwMBDSWrA/ofGR0Lt+CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRPgykzH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRPgykzH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF14D1F000E9;
	Wed, 27 May 2026 15:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779896086;
	bh=Qxk8LHEih46ikb9+5L8RXjEX9FaNqLHHuYYo/bGlo+Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=cRPgykzHCaDaqPzIDLPcbYrF2yAeUbZQs/LCNaCCcaTYYXFUr8NOYjCZYJttqRqoH
	 WgIDMzJMOfjtDQn5VA2Y4ylF19CJ26VwyK4P6zIfeku4eibJ43A/b/6S6Df7m9slJQ
	 dX8f3VVU6JpNGGdPJ9bF0ykKlEm7GwC39FeY6xH+Ik7sIxZqmnf0PjOz3Fini74040
	 yu+P78KT19LV/gZK0h08q4Qt/S4NO3AzAaUWGvOSXjvY1bipzp+CkcPdudfCa+MQn8
	 +S1VEaH4rLtMfpGnzAK/qlNr43ILziLgY67YfRoMKwn7F12Sa9BFgQGMUmEw1UnSO3
	 +BlfMwjxvqJ+Q==
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
In-Reply-To: <6a168c8ea7d10_2129b2100e@djbw-dev.notmuch>
References: <20260525154816.1029642-1-aneesh.kumar@kernel.org>
 <20260525154816.1029642-6-aneesh.kumar@kernel.org>
 <becd865d-09a4-4ac3-b719-4a0deae2692a@amd.com>
 <6a168c8ea7d10_2129b2100e@djbw-dev.notmuch>
Date: Wed, 27 May 2026 21:04:29 +0530
Message-ID: <yq5apl2gsw6y.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Dan Williams (nvidia)" <djbw@kernel.org> writes:

> Alexey Kardashevskiy wrote:
>> 
>> 
>> On 26/5/26 01:48, Aneesh Kumar K.V (Arm) wrote:
>> > Add IOMMU_VDEVICE_TSM_REQUEST for issuing TSM guest request/response
>> > transactions against an iommufd vdevice.
>> > 
>> > The ioctl takes a vdevice_id plus request/response user buffers and length
>> > fields, and forwards the request through tsm_guest_req() to the PCI TSM
>> > backend. This provides the host-side passthrough path used by CoCo guests
>> > for TSM device attestation and acceptance flows after the device has been
>> > bound to TSM.
>> > 
>> > Also add the supporting tsm_guest_req() helper and associated TSM core
>> > interface definitions.
>> > 
>> > Based on changes from: Alexey Kardashevskiy <aik@amd.com>
>> > 
>> > Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>> > ---
>> >   drivers/iommu/iommufd/iommufd_private.h |  6 ++
>> >   drivers/iommu/iommufd/main.c            |  3 +
>> >   drivers/iommu/iommufd/tsm.c             | 68 +++++++++++++++++++++
>> >   drivers/virt/coco/tsm-core.c            | 39 ++++++++++++
>> >   include/linux/pci-tsm.h                 |  9 +--
>> >   include/linux/tsm.h                     | 25 ++++++++
>> >   include/uapi/linux/iommufd.h            | 80 +++++++++++++++++++++++++
>> >   7 files changed, 226 insertions(+), 4 deletions(-)
> [..]
>> > diff --git a/drivers/iommu/iommufd/tsm.c b/drivers/iommu/iommufd/tsm.c
>> > index 09ee668dbed9..342fbdb6a6b9 100644
>> > --- a/drivers/iommu/iommufd/tsm.c
>> > +++ b/drivers/iommu/iommufd/tsm.c
>> > @@ -60,3 +60,71 @@ int iommufd_vdevice_tsm_op_ioctl(struct iommufd_ucmd *ucmd)
>> >   	iommufd_put_object(ucmd->ictx, &vdev->obj);
>> >   	return rc;
>> >   }
>> > +
>> > +static bool iommufd_vdevice_tsm_req_scope_valid(u32 scope)
>> > +{
>> > +	if (scope > IOMMU_VDEVICE_TSM_REQ_SCOPE_PCI_LAST)
>> > +		return false;
>> > +
>> > +	switch (scope) {
>> > +	case IOMMU_VDEVICE_TSM_REQ_PCI_INFO:
>> > +	case IOMMU_VDEVICE_TSM_REQ_PCI_STATE_CHANGE:
>> > +	case IOMMU_VDEVICE_TSM_REQ_PCI_DEBUG_READ:
>> > +	case IOMMU_VDEVICE_TSM_REQ_PCI_DEBUG_WRITE:
>> 
>> This scope thing still needs clarification.
>> 
>> I have 3 types of requests to fit here, all go via VM -> KVM -> QEMU -> IOMMUFD -> TSM.
>> 
>> 1) bind/unbind TDI <- moves to CONFIG_LOCKED, this is "OP";
>> 2) start/stop TDI <- moves to RUN, this is "GR"? Right now I route it via "OP";
>> 3) enable/disable MMIO/DMA <- no TDI state change, this is "GR" but which scope is it here?
>
> The scope parameter was meant to enumerate a security model for classes
> of commands that are otherwise opaque to the kernel. However, none of
> the commands we are targeting are opaque (private specification with
> unknown effect). It now turns out there is no role for @scope for
> security.
>
> Now a command family that iommufd can validate seems useful. As it
> stands this implementation aliases command codes across TSMs. Do we
> proceed with creating an actual shared command uapi for the truly shared
> commands:
>
> TSM_REQ_TYPE_DEFAULT: Commands every arch needs
> TSM_REQ_READ_OBJECT
> TSM_REQ_REGEN_OBJECT
> TSM_REQ_OBJECT_INFO
> TSM_REQ_VALIDATE_MMIO
> TSM_REQ_SET_TDI_STATE
>
> TSM_REQ_TYPE_SEV: Commands only SEV needs
> TSM_REQ_SEV_ENABLE_DMA
> TSM_REQ_SEV_DISABLE_DMA
>
> ...or just observe that per CC arch commands are needed to setup the VM
> so per CC arch commands are needed to marshal device assignment support
> requests.
>
> In that case pci_tsm_req_scope becomes tsm_req_type and is just:
>
> TSM_REQ_TYPE_CCA
> TSM_REQ_TYPE_SEV
> TSM_REQ_TYPE_TDX
>
> I am leaning towards the latter at this point.

But we already have struct pci_tsm_ops::guest_req, which is specific to
the underlying CC architecture. From the above, pci_tsm_req_scope also
appears to carry the same information. Is that useful?

-aneesh
