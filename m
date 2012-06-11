From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 2/3] kvm: trace events: update list of exit reasons
Date: Mon, 11 Jun 2012 18:21:33 +0200
Message-ID: <4FD61B0D.8090207@suse.de>
References: <1339423619-42299-1-git-send-email-cornelia.huck@de.ibm.com> <1339423619-42299-3-git-send-email-cornelia.huck@de.ibm.com> <4FD6113A.8080501@suse.de> <20120611180054.19abe49f@BR9GNB5Z>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20120611180054.19abe49f@BR9GNB5Z>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On 06/11/2012 06:00 PM, Cornelia Huck wrote:
> On Mon, 11 Jun 2012 17:39:38 +0200
> Alexander Graf<agraf@suse.de>  wrote:
>
>> Patch description missing.
> Hm, I'd have thought $SUBJECT was enough?

Only when it's totally obvious what you're doing. As my comment tells 
you, that wasn't the case here :).

>
>> On 06/11/2012 04:06 PM, Cornelia Huck wrote:
>>> Reviewed-by: Christian Borntraeger<borntraeger@de.ibm.com>
>>> Signed-off-by: Cornelia Huck<cornelia.huck@de.ibm.com>
>>> ---
>>>    include/trace/events/kvm.h |    3 ++-
>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/trace/events/kvm.h b/include/trace/events/kvm.h
>>> index 46e3cd8..3df5925 100644
>>> --- a/include/trace/events/kvm.h
>>> +++ b/include/trace/events/kvm.h
>>> @@ -13,7 +13,8 @@
>>>    	ERSN(DEBUG), ERSN(HLT), ERSN(MMIO), ERSN(IRQ_WINDOW_OPEN),	\
>>>    	ERSN(SHUTDOWN), ERSN(FAIL_ENTRY), ERSN(INTR), ERSN(SET_TPR),	\
>>>    	ERSN(TPR_ACCESS), ERSN(S390_SIEIC), ERSN(S390_RESET), ERSN(DCR),\
>>> -	ERSN(NMI), ERSN(INTERNAL_ERROR), ERSN(OSI)
>>> +	ERSN(NMI), ERSN(INTERNAL_ERROR), ERSN(OSI), ERSN(PAPR_HCALL),	\
>> PAPR?
>  From include/linux/kvm.h:
>
> #define KVM_EXIT_PAPR_HCALL       19
>
> No idea what it is, though :)

That's the PowerPC hypercall :). I just now realized that this is 
generic code, sorry.


Alex
