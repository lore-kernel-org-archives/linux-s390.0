Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473BD4746B1;
	Fri,  7 Aug 2026 15:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786118095; cv=none; b=rHCdto8CdfFMqaWYOmwwUH3gvJw1SLh5UuoX8uXd5NGP2WgkfXUvw+ojt3uGHwzahrFqAWOfc7qFDZv1ICGnEoijr4VF4mVsHTLxSUO0tG0u9CMShPbQctNmEaXrAC7WOSPtN4jSqPdz0CA6WAw3R2ru7QSYAhG8X/CuCyZecMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786118095; c=relaxed/simple;
	bh=klIMPnyANgSy/ng+RmKkjZQ0cx3W8zQnkFuBKihU8PQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UbAMf6KYJGrYGjWYUICBeutROIqWB73qM56jxTEbHfmiTi3cm8T9OxcN5IbgsDEtuG5Lr8aFrK1kyBpDRgzKhMN9ioyOzPhzLR0k4xOdPO4prM/VHLp0gQtfgYcjnNo6Mm5IaI0YdAWj6+2nqm1fX6qYy64gktcSSESlSPXyLq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=aovgNPAE; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="aovgNPAE"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5189D143D;
	Fri,  7 Aug 2026 08:54:48 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 851543F86F;
	Fri,  7 Aug 2026 08:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786118092; bh=klIMPnyANgSy/ng+RmKkjZQ0cx3W8zQnkFuBKihU8PQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aovgNPAEtin1OO4HfiSzNaKg/BVf6JUy74t18iDUy9r/nmoJtLq7DTDOD7C2UX7fE
	 aRAZKiTxIeaOZ/Le+sX7trawhvKYh0vOKjTrWwlv097egb3/nDxp/jBRVs9nakZwXc
	 cMRXRSiXxnHci10no0Aj/Kwn3nz4J8m6mIQ8wBJw=
Message-ID: <aefab683-598c-4cca-b5a0-c9081ccf9e1c@arm.com>
Date: Fri, 7 Aug 2026 16:54:35 +0100
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
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
 <20260717180442.110954-13-aneesh.kumar@kernel.org>
 <ami_mpd_1pF4Tmdu@google.com> <yq5a5x1ygo7z.fsf@kernel.org>
 <amnRB98ZZIysHuM3@google.com> <yq5acxw6dl1d.fsf@kernel.org>
 <20260804142032.GC27883@nvidia.com> <anL9-OrDGqYQAWNV@google.com>
 <20260805123023.GO27883@nvidia.com>
 <0ce2249d-3a64-4889-b455-0e8fddcc7282@arm.com>
 <20260807115500.GA158689@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260807115500.GA158689@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/08/2026 12:55 pm, Jason Gunthorpe wrote:
> On Fri, Aug 07, 2026 at 12:03:14PM +0100, Robin Murphy wrote:
>>> Each struct device will have a flag that shows if it is in T=1 or T=0
>>> state. The flag can only change while a driver is not bound, and
>>> changing the flag will update the DMA API configuration.
>>
>> I see we no longer seem to have the concern of devices in TDISP RUN state
>> being able to send T=0 transactions other than MSI writes,
> 
> Right it was too complex and nobody needed it, so Linux will not
> support T=0 through the DMA API on an T=1 device, and devices should
> be designed to only send T=1 to the greatest degree possible.
> 
> If someone foolishly makes a device that works otherwise they will
> have to take the difficult SW tasks of making it work.
> 
>> where GICv3 means the host is already going to have to be in on the
>> game to some degree there anyway.
> 
> As I understand it:
> 
> We will need to teach GIC to understand if/when the device uses a T=0
> translation for MSI and then use a shared physical address for the ITS
> IOVA instead of getting an IOVA translation from the iommu. The
> hypervisor will setup the S2 for the T=0 SMMU translation to be
> identity with all shared memory and the ITS page will be shared
> memory.

IIRC, for MSI or unlocked MSI-X it should look and work pretty much 
exactly like regular VFIO, as everything can be mediated by the VMM and 
host kernel.

> Presumably in future we will have HW to handle a T=1 ITS page access
> and some way to negotiate with devices if they should use a T=1 path
> for MSI or not.

Locked MSI-X would be a pain right now as we cannot intercept the Realm 
programming the MSI-X cap with a doorbell address and EventID value 
decided by the ITS driver in the Realm guest, so we'd somehow have to 
sniff those values out of the VMM's vITS emulation then try to configure 
an equivalent NS LPI to match, or have a hook in the ITS driver that 
knows when it's in a Realm and do some RSI handshake to proxy-allocate 
NS MSI vectors on the host and pass the real values back into the Realm.

I'm still hoping we (both CCA and possibly Linux in general) can get 
away with just refusing to support Locked MSI-X without GICv5, as once 
we have proper Realm MSIs with direct injection then all the problems go 
away (or at least become much smaller RMM problems that remain invisible 
to the host - the one "big" problem being that the RMM has to 
begrudgingly implement an entire GIC driver since it now has its own 
whole GIC to look after).

> There won't be a vSMMU attached to the T=0 instance at all, it is just
> wired to be bypass.

If that's all anyone will ever want then it does allow some degree of 
hackery like mirroring the whole of Realm S2 in an equivalent NS IOMMUFD 
domain, then forcing IOMMU_DOMAIN_IDENTITY for unaccepted devices within 
the guest. However I was under the impression that folks want to make 
meaningful use of devices while still in their untrusted pre-acceptance 
state (but maybe still switch them later), so it seems almost inevitable 
that eventually someone says "actually, we would like S1 vSMMU for 
untrusted scatter-gather as well..."

>> support in firmware bindings nor the IOMMU API itself to be able to describe
>> a single device being associated with both the RMM's vSMMU for the T=1
>> (Realm) VA space, and the NS VMM's vSMMU for the T=0 VA space, even
>> if we
> 
> Right!
> 
>> did only have to care about using strictly one or the other at any given
>> time based on device state. Having distinct struct devices is indeed clunky,
>> but does at least reduce the problem to a currently-manageable one of the
>> client driver having to wrangle them as a pair.
> 
> So hard! A meaningful goal here is to have existing drivers largely
> work unchanged in a CC world, so the device starts doing T=1 for
> almost everything and the existing driver just works.

Agreed, and I think with this series we should be pretty close now, at 
least for coherent devices with 64-bit DMA masks. And from the thread 
over at [1], it sounds like Hyper-V's VMbus is ready to go as 
potentially our first user independent of any other PCI/TSM dependencies.

Cheers,
Robin.

[1] https://lore.kernel.org/all/20260803033520.12930-1-tiala@microsoft.com/

> 
>> (And FWIW when we do get there, I'd be inclined to make the default SWIOTLB
>> the "private" one, so all the sharing/decryption stuff can be neatly
>> partitioned off into the CoCo etc. special cases...)
> 
> Yeah
>   
> Jason

