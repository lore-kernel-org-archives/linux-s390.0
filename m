From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v9 21/22] KVM: s390: CPU model support for AP
 virtualization
Date: Thu, 23 Aug 2018 15:38:48 +0200
Message-ID: <e782de8d-45d8-79fd-165c-c84f431e1d34@redhat.com>
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1534196899-16987-22-git-send-email-akrowiak@linux.vnet.ibm.com>
 <2c2c4859-ed3e-a492-dd59-78529c7768b2@redhat.com>
 <95e6ee74-69aa-9805-3233-b9ec81fce516@redhat.com>
 <7e7a35f5-d1eb-7719-c5e8-57d6f19db675@linux.ibm.com>
 <f5ec13ae-75b4-918e-aaf1-ed97944ff16e@redhat.com>
 <fec90446-7f94-da28-d958-427a0446854e@linux.ibm.com>
 <ef6082b7-da96-3a0b-77a0-f41d113d058a@redhat.com>
 <8d6ae58f-967b-5e4e-0e54-8fb4962cb843@linux.ibm.com>
 <be13d8fa-1ff7-6800-36b9-7f8320724cbf@redhat.com>
 <049c5e8a-4f21-a079-0eb6-abe78d812de7@linux.ibm.com>
 <1721a153-13f0-e695-6c01-cf6b65e1bbfa@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1721a153-13f0-e695-6c01-cf6b65e1bbfa@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>, pmorel@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 23.08.2018 15:22, Halil Pasic wrote:
> 
> 
> On 08/23/2018 02:47 PM, Pierre Morel wrote:
>> On 23/08/2018 13:12, David Hildenbrand wrote:
> [..]
>>>>>>
>>>>>> I'm confused, which 128 bit?
>>>>>
>>>>>
>>>>> Me too :) , I was assuming this block to be 128bit, but the qci block
>>>>> has 128 bytes....
>>>>>
>>>>> And looking at arch/s390/include/asm/ap.h, there is a lot of information
>>>>> contained that is definitely not of interest for CPU models...
>>>>>
>>>>> I wonder if there is somewhere defined which bits are reserved for
>>>>> future features/facilities, compared to ap masks and such.
>>>>>
>>>>> This is really hard to understand/plan without access to documentation.
>>>>>
>>>>> You (Halil, Tony, Pier, ...) should have a look if what I described
>>>>> related to PQAP(QCI) containing features that should get part of the CPU
>>>>> model makes sense or not. For now I was thinking that there is some part
>>>>> inside of QCI that is strictly reserved for facilities/features that we
>>>>> can use.
> 
> No there is no such part. The architecture documentation is quite confusing
> with some aspects (e.g. persistence) of how exactly some of these features
> work and are indicated. I'm having a hard time finding my opinion. I may
> end up asking some questions later, but for now i have to think first.
> 
> Just one hint. There is a programming note stating that if bit 2 of the
> QCI block is one there is at least one AP card in the machine that actually
> has APXA installed.
> 
> I read the architecture so that the APXA has a 'cpu part' (if we are
> doing APXA the cpu can't spec exception on certain bits not being zor9)
> and a 'card(s) part'.
> 
> Since the stuff seems quite difficult to sort out properly, I ask myself
> are there real problems we must solve?
> 
> This ultimately seems to be  about the migration, right? You say 'This helps
> to catch nasty migration bugs (e.g. APXA suddenly disappearing).' at the very
> beginning of the discussion. Yes, we don't have to have an vfio_ap device,
> he guest can and will start looking for AP resources if
> only the cpu model features installed. So the guest could observe
> a disappearing APXA, but I don't think that would lead to problems (with
> Linux at least).
> 
> And there ain't much AP a guest can sanely do without if no AP resources
> are there.
> 
> I would really prefer not rushing a solution if we don't have to.
> 
>>
>>
>>>
>>> What is apsc, qact, rc8a in the qci blocks? are the facility bits?
>>
>> Yes, facility bits concerning the AP instructions
>>
> 
> According to the current AR document rc8a ain't a facility but bits
> 0-2 and 4-7 kind of are.
> 

Easy ( :) ) answer. Everything that is the CPU part should get into the
CPU model. Everything that is AP specific not. If APXA is not a CPU
facility, fine with me to leave it out.

Ack to not rushing, but also ack to not leaving out important things.
Ack that this stuff is hard to ficure out.

> Regards,
> Halil
> 


-- 

Thanks,

David / dhildenb
