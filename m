From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH v9 04/22] s390/zcrypt: Integrate ap_asm.h into
 include/asm/ap.h.
Date: Fri, 17 Aug 2018 09:18:51 -0400
Message-ID: <49e99e8a-7de8-abde-6775-af11680db13d@linux.ibm.com>
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1534196899-16987-5-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180814104335.4bc3630a.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180814104335.4bc3630a.cohuck@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 08/14/2018 04:43 AM, Cornelia Huck wrote:
> On Mon, 13 Aug 2018 17:48:01 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>
>> From: Harald Freudenberger <freude@de.ibm.com>
>>
>> Move all the inline functions from the ap bus header
>> file ap_asm.h into the in-kernel api header file
>> arch/s390/include/asm/ap.h so that KVM can make use
>> of all the low level AP functions.
>>
>> Signed-off-by: Harald Freudenberger <freude@de.ibm.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> ---
>>   arch/s390/include/asm/ap.h     |  284 ++++++++++++++++++++++++++++++++++++----
>>   drivers/s390/crypto/ap_bus.c   |   23 +---
>>   drivers/s390/crypto/ap_bus.h   |    1 +
>>   drivers/s390/crypto/ap_card.c  |    1 -
>>   drivers/s390/crypto/ap_queue.c |    1 -
>>   5 files changed, 260 insertions(+), 50 deletions(-)
>>
>> diff --git a/arch/s390/include/asm/ap.h b/arch/s390/include/asm/ap.h
>> index c1bedb4..887494a 100644
>> --- a/arch/s390/include/asm/ap.h
>> +++ b/arch/s390/include/asm/ap.h
>> @@ -47,6 +47,50 @@ struct ap_queue_status {
>>   };
>>   
>>   /**
>> + * ap_intructions_available() - Test if AP instructions are available.
>> + *
>> + * Returns 1 if the AP instructions are installed, otherwise 0.
>> + */
>> +static inline int ap_instructions_available(void)
>> +{
>> +	register unsigned long reg0 asm ("0") = AP_MKQID(0, 0);
>> +	register unsigned long reg1 asm ("1") = 0;
>> +	register unsigned long reg2 asm ("2") = 0;
>> +
>> +	asm volatile(
>> +		"   .long 0xb2af0000\n"		/* PQAP(TAPQ) */
>> +		"0: la    %0,1\n"
>> +		"1:\n"
>> +		EX_TABLE(0b, 1b)
>> +		: "+d" (reg1), "+d" (reg2)
>> +		: "d" (reg0)
>> +		: "cc");
>> +	return reg1;
>> +}
> I think upstream this change (have this function return !0 when the
> instructions are installed) will be an addon patch to the one which has
> already made its way into master. Not really relevant for the remainder
> of this patch series, though.

I noticed that Harald's patches showed up in our master branch yesterday
without this change.

>
