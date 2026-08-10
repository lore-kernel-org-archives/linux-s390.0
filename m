Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCB63D6498;
	Mon, 10 Aug 2026 14:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786370908; cv=none; b=VxCl/EhWwspfwoybrz1zcKWrDeTn5qCK1mfApCw/0O950KElrWngx6yTPXvaKgZz5zRePnwHjKTlgEWyDYLuCnqrM4CCYCNgkjgqu2QFG8Pu9smKSbVKTFbiWd+FL6xYSx3mMwUb4rIs+l4z4coFgG8hEVf9PmZETkhkGdtWFrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786370908; c=relaxed/simple;
	bh=WIG5gWxWn/Ev2rkfLIG3WmO0JyDYfhFXREH1iOSeZTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sPsn5OG1Sc/oAi3Xg/rrmq2TpLesysoFqCcIV2TRXDTZL+Ez1/Od4vUrMjMoKXr6mlm0c1vd4Fnrjps/DgMVx2ak2UBhfZULjn4k5HUe2tK8OcTKuQCqOo1nhIZSmWrD6foF/8rcXOEMNedm41JAwQGyHQKYFAieUQ2J7bXo8pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ZXStNpjX; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ZXStNpjX"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A7941516;
	Mon, 10 Aug 2026 07:08:22 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA3DB3F86F;
	Mon, 10 Aug 2026 07:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786370906; bh=WIG5gWxWn/Ev2rkfLIG3WmO0JyDYfhFXREH1iOSeZTw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZXStNpjXVYvpxTBkP3rWmmwVPR479gsTPUbyBMBR8VKOLTsj4ratjHRO92RiDGFax
	 IG5dbWhAWx0ncg0zwRBfNQKPrft0K+c13K0wFbEYz8ngMLcySRRYMCHpujbZ48aqGf
	 1iA6qXJ9C3VW4Jm34gws0KQ9bPcSOJKgwmrVFNto=
Message-ID: <3cccd2d2-b59c-47ec-8a87-f504a5427576@arm.com>
Date: Mon, 10 Aug 2026 15:08:19 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: swiotlb: Keep the default size for protected
 guests
To: Jason Gunthorpe <jgg@ziepe.ca>, Will Deacon <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, Marc Zyngier <maz@kernel.org>,
 Steven Price <steven.price@arm.com>,
 Suzuki K Poulose <Suzuki.Poulose@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Jiri Pirko <jiri@resnulli.us>,
 Petr Tesarik <ptesarik@suse.com>, Alexey Kardashevskiy <aik@amd.com>,
 Dan Williams <dan.j.williams@intel.com>, Xu Yilun
 <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
References: <anX7F7dnKOtAOIIe@google.com> <20260807164734.GE200537@ziepe.ca>
 <anYgXSR4VAi3TpOj@google.com>
 <CGME20260807182023eucas1p1f653436207b2b00338e99ea1d8f847df@eucas1p1.samsung.com>
 <20260807182017.GH200537@ziepe.ca>
 <7d22482f-d5fd-4cf4-9d32-6a54e02f2fbb@samsung.com>
 <yq5av79iiard.fsf@kernel.org> <anml6lLRERm1Iv-_@willie-the-truck>
 <28442500-1d53-4776-bae5-459c3ffc1cc6@samsung.com>
 <anm6K2umtx4iKnyZ@willie-the-truck> <20260810130818.GN200537@ziepe.ca>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260810130818.GN200537@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/08/2026 2:08 pm, Jason Gunthorpe wrote:
> On Mon, Aug 10, 2026 at 12:46:51PM +0100, Will Deacon wrote:
>> On Mon, Aug 10, 2026 at 01:37:11PM +0200, Marek Szyprowski wrote:
>>> On 10.08.2026 12:20, Will Deacon wrote:
>>>> On Mon, Aug 10, 2026 at 02:59:42PM +0530, Aneesh Kumar K.V wrote:
>>>>> Marek Szyprowski <m.szyprowski@samsung.com> writes:
>>>>>
>>>>>> On 07.08.2026 20:20, Jason Gunthorpe wrote:
>>>>>>> On Fri, Aug 07, 2026 at 06:13:49PM +0000, Mostafa Saleh wrote:
>>>>>>>> But the whole thing is best effort anyway, the kernel picks
>>>>>>>> IO_TLB_DEFAULT_SIZE which does not depend on the system topology or
>>>>>>>> how many devices or how much DMA they do.
>>>>>>>> SWIOTLB memory is wasted if unused so we should be careful around
>>>>>>>> that as it would be the other way around and users would have to
>>>>>>>> decrease it manually.
>>>>>>> Yeah, it is why the arch code shouldn't really be sizing it directly,
>>>>>>> it should be done in common code and, yes, we are probably going to
>>>>>>> have to do something alot smarter to have the common code better
>>>>>>> auto-tune this for the CC case..
>>>>>> What about the $subject patch? I assume that it is still needed to
>>>>>>
>>>>>> restore the behavior that was altered by the "[PATCH v8 00/23]
>>>>>>
>>>>>> dma-mapping: Track shared DMA state through direct, pool and swiotlb
>>>>>>
>>>>>> paths?" patchset?
>>>>>>
>>>>> I would request that we pick this patch to fix the regression described
>>>>> in https://lore.kernel.org/all/yq5azeyxyfol.fsf@kernel.org/.
>>>> I really don't think we need it. CCA hardware isn't exactly widespread
>>>> and the KVM host side patches don't appear close to being merged.
>>>
>>> Does this mean that the branch for-next/coco [1] won't go to v7.3-rc1?
> 
> Let's not make progress on guest support contingent on KVM CCA host
> side patches please. I expect the CSPs will have VM instance types
> available based on CCA within quarters, and Linux as a Guest should
> work in those environments regardless of what KVM is doing. I don't
> really expect full KVM support for years, frankly, the patchset is
> massive. Even Intel and AMD don't have full KVM support yet.
> 
> People already have CCA capable HW, are already testing this stuff and
> the closer upstream can get to being workable as a guest without a
> mountain of OOT patches the better.
> 
> I agree the thing is not ideal, but it was merged to ARM like this a
> long time ago, this patch is just fixing a small oopsie (was it a
> merge conflict?) to put it back. I don't the objection.

Yup, it seems pretty clearly like a straightforward bug in this series 
(or maybe even just the merge resolution), where it should have just 
removed the use of SWIOTLB_FORCE, but changing the if/else structure 
inadvertently upset the whole flow in a way that it shouldn't have.

For a fix patch it might be clearer to restore the "(is_realm_world() || 
is_protected_kvm_guest())" condition exactly as before, then save any 
further refactoring for the next round of new development. And if there 
is a concern that skipping the resizing wastes memory for pKVM, then 
surely that falls on e62decaf98e7 ("arm64/coco: Add pKVM as a CC 
platform") which intentionally added that logic.

I do concur that there's not necessarily a mad panic to get this into 
Marek's 7.3 pull, as folks trying to use linux-next or bleeding-edge 
mainline for CCA work (or indeed anything) should know the risks, but it 
should at least be one for the 7.3-rc fixes cycle. Aneesh, FYI generally 
once things are queued, please just send follow-up fixes as their own 
thing rather than replies, for maximum clarity.

Thanks,
Robin.
