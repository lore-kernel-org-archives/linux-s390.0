From: Alexander Graf <agraf@suse.de>
Subject: Re: [Qemu-devel] [RFC PATCH v2 04/15] cpu-model/s390: Introduce S390
 CPU models
Date: Fri, 20 Feb 2015 17:57:52 +0100
Message-ID: <54E76790.1030700@suse.de>
References: <1424183053-4310-1-git-send-email-mimu@linux.vnet.ibm.com>	<1424183053-4310-5-git-send-email-mimu@linux.vnet.ibm.com>	<54E73C8F.7000202@suse.de>	<20150220160046.4743acc8@bee>	<89E3550E-9E2B-4D95-A809-B7C64EBCD7C5@suse.de> <20150220164944.4eb4eeb3@bee>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150220164944.4eb4eeb3@bee>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Michael Mueller <mimu@linux.vnet.ibm.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Andreas Faerber <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>
List-ID: <linux-s390.vger.kernel.org>



On 20.02.15 16:49, Michael Mueller wrote:
> On Fri, 20 Feb 2015 16:22:20 +0100
> Alexander Graf <agraf@suse.de> wrote:
> 
>>>>
>>>> Just make this uint64_t fac_list[2]. That way we don't have to track any
>>>> messy allocations.  
>>>
>>> It will be something like "uint64_t fac_list[S390_CPU_FAC_LIST_SIZE_UINT64]" and in total 2KB
>>> not just 16 bytes but I will change it.   
>>
>> Why? Do we actually need that many? This is a qemu internal struct.
> 
> How do you know that 2 is a good size?

Because all CPUs we have in our list only expose 128 bits?

> I want to have this independent from a future machine of the z/Arch. The kernel stores the full
> facility set, KVM does and there is no good reason for QEMU not to do. If other accelerators
> decide to just implement 64 or 128 bits of facilities that's ok...

So you want to support CPUs that are not part of the list?


Alex
