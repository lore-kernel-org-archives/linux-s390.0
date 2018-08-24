Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
Subject: Re: [PATCH v1] KVM: s390: store DXC/VXC in fpc on
 DATA/Vector-processing exceptions
References: <20180822095310.29145-1-david@redhat.com>
 <7c7e52aa-7b07-d146-ac4e-2b1afea6a83d@de.ibm.com>
 <b613c011-67f0-317d-c430-cdccfbded46f@redhat.com>
 <d8ab5075-c589-8a0b-516c-9cff79522abb@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <6c4f658b-139d-0771-ed35-d1d2df9b5f68@redhat.com>
Date: Fri, 24 Aug 2018 10:10:08 +0200
MIME-Version: 1.0
In-Reply-To: <d8ab5075-c589-8a0b-516c-9cff79522abb@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 24.08.2018 08:34, Christian Borntraeger wrote:
> 
> 
> On 08/23/2018 07:44 PM, David Hildenbrand wrote:
>> On 23.08.2018 17:43, Christian Borntraeger wrote:
>>>
>>>
>>> On 08/22/2018 11:53 AM, David Hildenbrand wrote:
>>>> When DATA exceptions and vector-processing exceptions (program interrupts)
>>>> are injected, the DXC/VXC is also to be stored in the fpc, if AFP is
>>>> enabled in CR0.
>>>>
>>>> This can happen inside KVM when reinjecting an interrupt during program
>>>> interrupt intercepts. These are triggered for example when debugging the
>>>> guest (concurrent PER events result in an intercept instead of an
>>>> injection of such interrupts).
>>>>
>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>> ---
>>>>
>>>> Only compile-tested.
>>>
>>> I checked the Linux code (arch/s390/kernel/traps.c) and Linux uses the FPC (and
>>> not the lowcore field) to decide about the signal (SIGFPE) and si_code. So we want
>>> to have the correct DXC/VXC value.
>>>
>>> Now, I wrote a short test program that does
>>> feenableexcept(FE_DIVBYZERO);
>>> and a division by zero.
>>> and attached gdb to that guest together with a breakpoint on the divide (and the instruction
>>> after).
>>> I get the pint exit for the instruction after (as it is suppressing) and at this point in
>>> time the guest fpc already contains the correct DXC value. So you patch will certainly not
>>> hurt, but it seems not necessary.
>>
>> Thanks for trying. Wonder if that is documented behavior or just works
>> by pure luck.
> 
> 
> My guess is, that this is works as designed. There is the interruption
> parameter block that is used instead of the guest lowcore for program
> interrupt exits. To me it looks like that everything is "prepared" except
> for the psw swap itself and the data in the lowcore. The data is written 
> to the interruption parameter block instead. So that the hypervisor then
> just has to move the data and do the psw swap. 
> 
>>
>> E.g. it would be interesting to see what other instructions do that
>> usually don't touch the DXC, except when injecting an exception. E.g. CRT.
>>
>> But if you believe this is not needed, we can also drop it. (if ever
>> somebody would want to inject from QEMU, he could also just set the fpc
>> directly)
> 
> The (unlikely to ever happen) inject from QEMU is indeed a thing where this
> patch would simplify things.
> 
> I will talk to some hardware folks to verify my assumption but for the time
> being, lets drop this patch.

Just tested CRTG, and it also seems to work fine when single-stepping
over it, landing in the PGM handler.

-- 

Thanks,

David / dhildenb
