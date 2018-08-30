From: David Hildenbrand <david@redhat.com>
Date: Thu, 30 Aug 2018 15:28:54 +0000
Subject: Re: [PATCH v2] KVM: s390: Fix pfmf and conditional skey emulation
Message-Id: <5fd1ed91-1eaa-3946-4bd5-9219f7132d06@redhat.com>
In-Reply-To: <11dc25a6-e00f-8dae-3a72-89604683ad79@de.ibm.com>
References: <11dc25a6-e00f-8dae-3a72-89604683ad79@de.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 30.08.2018 17:25, Christian Borntraeger wrote:
> 
> 
> On 08/30/2018 04:22 PM, David Hildenbrand wrote:
>> On 30.08.2018 12:11, Christian Borntraeger wrote:
>>> Please re-add the "Fixes" tag. While not relevant for stable, it might be
>>> relevant for backport.
>>
>> Isn't that a potential endless loop in the pfmf handler? (!PFMF_SK)
>>
>> If so, this should be stable no?
> 
> the patches made it in after 4.18 (for 4.19) so no stable if I got that
> right.
> 

ahh right, missed that ...


-- 

Thanks,

David / dhildenb
