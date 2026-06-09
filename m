Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21D53F1ADD;
	Tue,  9 Jun 2026 09:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780995604; cv=none; b=f80Fm2eABtYJ0g4b6TIWnVJlrAIIQUtOezGstwARukx/A/dUxLaEMSn+GhmQQnU75B3qxYeiWSRVXW2/dm1PqSYLvoNrczfyU9xY4gmyjXnvQ+zJc1n4JU0wbpdR88nzsWdYGsGkwN0swsVyWSttEhKaMmk30u6rk82/Jm7E4NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780995604; c=relaxed/simple;
	bh=2QEP28zLm/5WdjCEqhLpCisxt20Jp0JzixfLVYeCmP0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LkukA0a/jVwo5hCWWqpmOBXhnvnr2E9p0dUnQKU7UbdrMjtskccdvO7eQ/CrlIRGjaY4IfEm/AH5jF27m/ocaZBpp94L3qJ5xUGCOtAbHhsGG52wlMzNuEWS57GzO1aBM9HQHjv4RnH2cx1q/dGPR2i4nEaOAeuKq+c9z3UMBm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/lD6ewV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/lD6ewV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0471B1F00893;
	Tue,  9 Jun 2026 08:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780995603;
	bh=5PZ+LrewxpCuXLMvn3PnybJtDeV/69ic6D4NMS386sQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=V/lD6ewVP+EoDqUMcEVKI2sD1hyaOO3BkeKU6RSif2kdo5jrK/Pz3dGH+nKy0yiwl
	 GkcFRWm1bfXDZ5G+6pXWLYyeUfJWm7+IZ0B9df71sjZwwF60I0iqK3CtHdpIwD+SvD
	 18pe11K69nHGIbmpkB0Onj2R9KYyHN9PZUhNMsk8rdNJq+9c33Er41sVQJlVkBhvbX
	 p7cjR5sypoB2y0AuL5w7gBsZAQUVbp0Fkizy+sRFRMauWGHF9nWPKvukIs6VPyCwk/
	 qbJNUFrr28q96fsjSCKVnrZKa39ARSwnvxyBNlZFOWdhgDxqz6S8YASpiFX/604Ble
	 GhuJ3zRxhL8+w==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: "Dan Williams (nvidia)" <djbw@kernel.org>,
	"Dan Williams (nvidia)" <djbw@kernel.org>,
	"Dan Williams (nvidia)" <djbw@kernel.org>,
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
In-Reply-To: <6a272cebec4af_4fa7810048@djbw-dev.notmuch>
References: <20260525154816.1029642-1-aneesh.kumar@kernel.org>
 <20260525154816.1029642-6-aneesh.kumar@kernel.org>
 <becd865d-09a4-4ac3-b719-4a0deae2692a@amd.com>
 <6a168c8ea7d10_2129b2100e@djbw-dev.notmuch> <yq5apl2gsw6y.fsf@kernel.org>
 <yq5aldd4spyc.fsf@kernel.org> <6a1774dd80f74_19737610095@djbw-dev.notmuch>
 <yq5aik81sf22.fsf@kernel.org> <6a272cebec4af_4fa7810048@djbw-dev.notmuch>
Date: Tue, 09 Jun 2026 14:29:49 +0530
Message-ID: <yq5aik7sytq2.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Dan Williams (nvidia)" <djbw@kernel.org> writes:

> Aneesh Kumar K.V wrote:
> [..]
>> > I think we can wait to move it to its own IOMMU operation unless/until
>> > there is a need to set RUN outside of an explicit guest request, right?
>> 
>> Something like the below? (the diff against this series)
>> 
>> I have not yet integrated this into the full CCA patchset for testing,
>> but I wanted to make sure we are aligned on the UAPI.
> [..]
>> -static bool iommufd_vdevice_tsm_req_scope_valid(u32 scope)
>> +static bool iommufd_vdevice_tsm_req_arch_valid(u32 tvm_arch)
>>  {
>> -	if (scope > IOMMU_VDEVICE_TSM_REQ_SCOPE_PCI_LAST)
>> +	switch (tvm_arch) {
>> +	case IOMMU_VDEVICE_TSM_TVM_ARCH_CCA:
>> +	case IOMMU_VDEVICE_TSM_TVM_ARCH_SEV:
>> +	case IOMMU_VDEVICE_TSM_TVM_ARCH_TDX:
>
> Makes sense for any command that needs tunneling. However, see below, what is
> that set, and do we need a IOMMU_VDEVICE_TSM_COMMON when architecture
> differentiation is not required?
>
>> +		return true;
>> +	default:
>>  		return false;
>> +	}
>> +}
>>  
>> -	switch (scope) {
>> -	case IOMMU_VDEVICE_TSM_REQ_PCI_INFO:
>> -	case IOMMU_VDEVICE_TSM_REQ_PCI_STATE_CHANGE:
>> -	case IOMMU_VDEVICE_TSM_REQ_PCI_DEBUG_READ:
>> -	case IOMMU_VDEVICE_TSM_REQ_PCI_DEBUG_WRITE:
>> +static bool iommufd_vdevice_tsm_req_op_valid(u32 op, u32 tvm_arch)
>> +{
>> +	switch (op) {
>> +	case TSM_REQ_READ_OBJECT:
>> +	case TSM_REQ_REGEN_OBJECT:
>> +	case TSM_REQ_OBJECT_INFO:
>
> The design goal of the netlink device-evidence interface is to be able
> to respond to all shapes of requests for evidence. So netlink caches
> objects that the hypercall handler can fill responses from.
>
> It eliminates a class of commands that need tunneling.
>

Sure, I can drop this from the iommufd ioctl and use netlink to read and
regenerate the objects from the VMM.

Can I use netlink to find the cached object size? CCA supports
RHI_DA_OBJECT_SIZE, which can be used to query the object size.
If not should we have TSM_REQ_OBJECT_INFO? 

>
>> +	case TSM_REQ_VALIDATE_MMIO:
>> +	case TSM_REQ_SET_TDI_STATE:
>
> Are these potentially candidates for a IOMMU_VDEVICE_TSM_COMMON? The
> handler knows how to do the arch-specific response from the common
> iommufd result, or is there TSM-specific payload beyond @tsm_code for
> these.
>
> Make it the case that guest_req only needs non-common arch for
> operations that are implementation unique, or where the response payload
> exceeds what can be conveyed via @tsm_code.
>

I am not sure I follow the IOMMU_VDEVICE_TSM_COMMON feedback above.

Earlier discussions around this concluded that we may want iommufd
to validate all input commands, rather than making the guest request
ioctl a passthrough interface.

If we make the ops IOMMU_VDEVICE_TSM_COMMON, we would still need to add
TSM_REQ_VALIDATE_MMIO and TSM_REQ_SET_TDI_STATE for the arch-specific
handler. Why not expose those to the generic iommufd layer, so that we
can add operation validation there and completely drop IOMMU_VDEVICE_TSM_COMMON?

>>  		return true;
>> +	case TSM_REQ_SEV_ENABLE_DMA:
>> +	case TSM_REQ_SEV_DISABLE_DMA:
>> +		return tvm_arch == IOMMU_VDEVICE_TSM_TVM_ARCH_SEV;
>
> Right, this appears to be the only case where the command is
> implementation unique. The handler can only ask iommufd to take
> arch-specific action.

-aneesh
