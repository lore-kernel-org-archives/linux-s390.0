Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC9D3EDE60;
	Mon, 10 Aug 2026 14:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786371491; cv=none; b=IfeA2xNLqlAyrdVjunL4f3+glszrkmr7NplKjwleHmuBrAnQs8S5pJZPdbo1wc3ZdKfjFsWVKVYNuMVHQAknI0wW+ts7JMbbRN/fEkGbjiaitHavUIMa8wxI4GC+H2hyHDDfo7CKGYFXDmghAmhq073Wbq2ixG8ZVYF14ammeHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786371491; c=relaxed/simple;
	bh=9IZsYULiK1AGwxTWlN7Ujyjc0tW5fdqucDUHcjUe8vM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ckbXMXXViQbtAwT/2EUlan1r+vjPYPu6TRZy1sAAQcbIp0ztwudym0RJVtA8wSv8/R9feQGhq2VzZg0bMbSC1DB4odh9SvcbDFH2Vi0kqT923J3qIpr2IzEjfw7BKow8+ErR99bDH09Wx1TxNthB9l7VXRKf6/Sxr7RKyvtH6rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=NoEqCvjs; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="NoEqCvjs"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 740071516;
	Mon, 10 Aug 2026 07:18:05 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 266163F86F;
	Mon, 10 Aug 2026 07:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786371489; bh=9IZsYULiK1AGwxTWlN7Ujyjc0tW5fdqucDUHcjUe8vM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NoEqCvjse7Mrq4aOnrWgAYUVbUD+P6fgX9iChFnY1gjZ5NOopP7tM++y+YQsIJOQe
	 zL208fDHqvlgnN0I7fyFFWMxgH9JNWDKqLLnsKcgPuSc/GPjAtockiGu16g+N2xXhi
	 ITkmeOFAd3RzdKnSwAvP8g7QlEZ16KLsURRsNdsg=
Message-ID: <21813ccf-96e5-4a7e-a3b3-aaaec7e0d23c@arm.com>
Date: Mon, 10 Aug 2026 15:18:03 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 12/23] dma: swiotlb: pass mapping attributes by
 reference
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Mostafa Saleh <smostafa@google.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, Marek Szyprowski <m.szyprowski@samsung.com>,
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Steven Price <steven.price@arm.com>,
 Suzuki K Poulose <Suzuki.Poulose@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Jiri Pirko <jiri@resnulli.us>,
 Petr Tesarik <ptesarik@suse.com>, Alexey Kardashevskiy <aik@amd.com>,
 Dan Williams <dan.j.williams@intel.com>, Xu Yilun
 <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org,
 Michael Kelley <mhklinux@outlook.com>
References: <ami_mpd_1pF4Tmdu@google.com> <yq5a5x1ygo7z.fsf@kernel.org>
 <amnRB98ZZIysHuM3@google.com> <yq5acxw6dl1d.fsf@kernel.org>
 <20260804142032.GC27883@nvidia.com> <anL9-OrDGqYQAWNV@google.com>
 <20260805123023.GO27883@nvidia.com>
 <0ce2249d-3a64-4889-b455-0e8fddcc7282@arm.com>
 <20260807115500.GA158689@nvidia.com>
 <aefab683-598c-4cca-b5a0-c9081ccf9e1c@arm.com>
 <20260807170104.GB158689@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260807170104.GB158689@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/08/2026 6:01 pm, Jason Gunthorpe wrote:
> On Fri, Aug 07, 2026 at 04:54:35PM +0100, Robin Murphy wrote:
> 
>>> We will need to teach GIC to understand if/when the device uses a T=0
>>> translation for MSI and then use a shared physical address for the ITS
>>> IOVA instead of getting an IOVA translation from the iommu. The
>>> hypervisor will setup the S2 for the T=0 SMMU translation to be
>>> identity with all shared memory and the ITS page will be shared
>>> memory.
>>
>> IIRC, for MSI or unlocked MSI-X it should look and work pretty much exactly
>> like regular VFIO, as everything can be mediated by the VMM and host kernel.
> 
> Right
> 
>>> Presumably in future we will have HW to handle a T=1 ITS page access
>>> and some way to negotiate with devices if they should use a T=1 path
>>> for MSI or not.
>>
>> Locked MSI-X would be a pain right now as we cannot intercept the Realm
>> programming the MSI-X cap with a doorbell address and EventID value decided
>> by the ITS driver in the Realm guest, so we'd somehow have to sniff those
>> values out of the VMM's vITS emulation then try to configure an equivalent
>> NS LPI to match, or have a hook in the ITS driver that knows when it's in a
>> Realm and do some RSI handshake to proxy-allocate NS MSI vectors on the host
>> and pass the real values back into the Realm.
> 
> Yes, we'd need to move to a model where the guest programs MSI
> directly and we learn the configuration required to emulate through
> the vGIC, not through MSI trapping. This broadly is the "righter" way
> to do interrupt routing but it will be hard to get there, if ever.
> 
>> I'm still hoping we (both CCA and possibly Linux in general) can get away
>> with just refusing to support Locked MSI-X without GICv5, as once we have
>> proper Realm MSIs with direct injection then all the problems go away (or at
>> least become much smaller RMM problems that remain invisible to the host -
>> the one "big" problem being that the RMM has to begrudgingly implement an
>> entire GIC driver since it now has its own whole GIC to look after).
> 
> Yeah, I'm fine with this, if GICv5 can allow direct MSI-X programming
> then great.
> 
> Devices are going to need some way to negotiate if MSI-X is locked, and
> if MSI is T=1 or not, I don't know if PCI has something for that
> already..
> 
>>> There won't be a vSMMU attached to the T=0 instance at all, it is just
>>> wired to be bypass.
>>
>> If that's all anyone will ever want then it does allow some degree of
>> hackery like mirroring the whole of Realm S2 in an equivalent NS IOMMUFD
>> domain, then forcing IOMMU_DOMAIN_IDENTITY for unaccepted devices within the
>> guest. However I was under the impression that folks want to make meaningful
>> use of devices while still in their untrusted pre-acceptance state (but
>> maybe still switch them later), so it seems almost inevitable that
>> eventually someone says "actually, we would like S1 vSMMU for untrusted
>> scatter-gather as well..."
> 
> So far almost all VMs today don't use vIOMMU at all, the ones that do
> are using it for things like PASID (or interrupt remapping on x86),
> not for translation. The cases where a vIOMMU is deliberately needed
> for translation seem to be mostly around SVA and PASID which isn't
> going to meaningfully work out of the box on a T=0 device.
> 
> My prediction is this is fine.
> 
> At least it is sufficiently hard to make two parallel vSMMU's
> controlling the same PCI device, and to make the ITS routing also
> somehow work right, that it isn't worth doing at this point when there
> is so much other more basic stuff to get done.

Cool. So in fact that puts us in an interesting position for now where 
non-CoCo "untrusted" (i.e. external) devices should have IOMMU 
translation forced on by default, while CoCo "unaccepted" devices (i.e. 
those which do have a mechanism to transition into a T=1 or equivalent 
state) should *not* try to use an associated IOMMU, on the assumption 
that it may only work for T=1 traffic. All the more reason to sort these 
abstractions out so we can make the right distinctions clearly :)

(And while untrusted vIOMMUs for purely-untrusted devices in CoCo 
environments would be pretty straightforward as well, I guess we might 
need some sort of acceptance status for trusted vIOMMU devices 
themselves? Hmm...)

Cheers,
Robin.

> I imagine the ACPI might someday gain a description of the T=0 vSMMU
> in a way that is invisible to todays Linux and a future Linux could
> understand how to juggle the two iommu drivers for the same struct
> device, somehow.
> 
> Regards,
> Jason

