From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH v8 04/22] s390/zcrypt: Integrate ap_asm.h into
 include/asm/ap.h.
Date: Thu, 9 Aug 2018 12:06:56 -0400
Message-ID: <323af125-f078-919c-3117-f9022f5529ae@linux.ibm.com>
References: <1533739472-7172-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1533739472-7172-5-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180809110645.33b20c1f.cohuck@redhat.com>
 <aec0af21-270f-c4c5-3aea-f6854ca2fb07@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <aec0af21-270f-c4c5-3aea-f6854ca2fb07@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Harald Freudenberger <freude@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 08/09/2018 05:17 AM, Harald Freudenberger wrote:
> On 09.08.2018 11:06, Cornelia Huck wrote:
>> On Wed,  8 Aug 2018 10:44:14 -0400
>> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>>
>>> From: Harald Freudenberger <freude@de.ibm.com>
>>>
>>> Move all the inline functions from the ap bus header
>>> file ap_asm.h into the in-kernel api header file
>>> arch/s390/include/asm/ap.h so that KVM can make use
>>> of all the low level AP functions.
>>>
>>> Signed-off-by: Harald Freudenberger <freude@de.ibm.com>
>>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> You should add your own s-o-b if you are sending on patches written by
>> others (even if it does not matter in the end, when they are merged
>> through a different path anyway.)
>>
>>> ---
>>>   arch/s390/include/asm/ap.h     |  284 ++++++++++++++++++++++++++++++++++++----
>>>   drivers/s390/crypto/ap_asm.h   |  261 ------------------------------------
>>>   drivers/s390/crypto/ap_bus.c   |   21 +---
>>>   drivers/s390/crypto/ap_bus.h   |    1 +
>>>   drivers/s390/crypto/ap_card.c  |    1 -
>>>   drivers/s390/crypto/ap_queue.c |    1 -
>>>   6 files changed, 259 insertions(+), 310 deletions(-)
>>>   delete mode 100644 drivers/s390/crypto/ap_asm.h
>>>
>>> diff --git a/arch/s390/include/asm/ap.h b/arch/s390/include/asm/ap.h
>>> index c1bedb4..046e044 100644
>>> --- a/arch/s390/include/asm/ap.h
>>> +++ b/arch/s390/include/asm/ap.h
>>> @@ -47,6 +47,50 @@ struct ap_queue_status {
>>>   };
>>>   
>>>   /**
>>> + * ap_intructions_available() - Test if AP instructions are available.
>>> + *
>>> + * Returns 0 if the AP instructions are installed.
>> Stumbled over this when I was looking at the usage in patch 7: if I see
>> a function called '_available' return 0, I'd assume that whatever the
>> function tests for is *not* available.
>>
>> Rather call this function ap_instructions_check_availability() (and
>> keep the return code convention), or switch this to return 0 if not
>> available and !0 if available?
> Good catch, Cony you are right. I'll fix this to return 1 if AP instructions
> are available and 0 if not. However, this patch will come via Martin's pipe
> to the Linus Torwald kernel sources.

Is your intent to simply indicate whether the AP instructions are 
available or
not; or is the intention to indicate whether the AP instructions are 
available
and if not, they why? In the former, then I agree that a boolean should be
returned; however, if the case is the latter, then what you have is fine but
maybe the function name should be changed as Connie suggests.

>>> + */
>>> +static inline int ap_instructions_available(void)
>>> +{
>>> +	register unsigned long reg0 asm ("0") = AP_MKQID(0, 0);
>>> +	register unsigned long reg1 asm ("1") = -ENODEV;
>>> +	register unsigned long reg2 asm ("2");
>>> +
>>> +	asm volatile(
>>> +		"   .long 0xb2af0000\n"		/* PQAP(TAPQ) */
>>> +		"0: la    %0,0\n"
>>> +		"1:\n"
>>> +		EX_TABLE(0b, 1b)
>>> +		: "+d" (reg1), "=d" (reg2)
>>> +		: "d" (reg0)
>>> +		: "cc");
>>> +	return reg1;
>>> +}
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-s390" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
