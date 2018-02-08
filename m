From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v1] KVM: s390: use switch vs jump table in interrupt.c
Date: Thu, 8 Feb 2018 11:04:53 +0100
Message-ID: <3f370b91-2679-8f10-98ae-7de05cae2f78@de.ibm.com>
References: <20180206141743.24497-1-david@redhat.com>
 <257bd198-dddc-fda2-e2ea-ae93eff5d158@de.ibm.com>
 <20180208091405.397e9178.cohuck@redhat.com>
 <c50299e3-0516-b590-1fee-25dbc8189830@de.ibm.com>
 <20180208110012.3c11b127.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180208110012.3c11b127.cohuck@redhat.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Janosch Frank <frankja@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>



On 02/08/2018 11:00 AM, Cornelia Huck wrote:
> On Thu, 8 Feb 2018 10:53:00 +0100
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> On 02/08/2018 09:14 AM, Cornelia Huck wrote:
>>> On Wed, 7 Feb 2018 19:28:04 +0100
>>> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>>>   
>>>> I see a minimal regression for uperf 1byte ping pong between two guests (~3%)
>>>> Probably because the old code first handled IO interrupts and then did the remaing
>>>> stuff.  Not sure if its worth to keep the old io_ioirq hack.  
>>>
>>> Hm, that confuses me a bit. We search the pending bit map, which should
>>> give us the irq with the highest priority, and the switch/case still
>>> starts out with I/O interrupts.  
>>
>> gcc does not obey the order of the case statements. It uses several heuristics depending
>> on the size and others. So gcc might fall back to jump tables for large switches, or
>> it uses bisecting or it might even split the search into a jump table and several
>> relative branches if there are strange distributions. Quite often the default 
>> case is evaulated first.
> 
> But should we really try to optimize something that may change with a
> different compiler anyway? The important thing is the priority in the
> bitmap.

An if before the switch would always prefer that condition. But I agree,we should
probably not go down this path of micro optimization.
