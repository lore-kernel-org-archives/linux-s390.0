Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49255 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726008AbgDVJHJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 22 Apr 2020 05:07:09 -0400
Subject: Re: [kvm-unit-tests PATCH v5 02/10] s390x: Use PSW bits definitions
 in cstart
References: <1582200043-21760-1-git-send-email-pmorel@linux.ibm.com>
 <1582200043-21760-3-git-send-email-pmorel@linux.ibm.com>
 <aae40a5a-63a6-e802-53bb-9683d03ad57d@linux.ibm.com>
 <d4e66e9b-ed68-e7ef-4b9d-8af879e44813@redhat.com>
 <e1050532-72ee-210c-822a-f1eb91c6d388@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <6df50ddc-8d58-13d6-8143-471ec690c17f@redhat.com>
Date: Wed, 22 Apr 2020 11:07:00 +0200
MIME-Version: 1.0
In-Reply-To: <e1050532-72ee-210c-822a-f1eb91c6d388@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, cohuck@redhat.com

On 22.04.20 10:59, Pierre Morel wrote:
> 
> 
> On 2020-04-22 09:44, David Hildenbrand wrote:
>>
>>>> diff --git a/s390x/cstart64.S b/s390x/cstart64.S
>>>> index 45da523..2885a36 100644
>>>> --- a/s390x/cstart64.S
>>>> +++ b/s390x/cstart64.S
>>>> @@ -12,6 +12,7 @@
>>>>    */
>>>>   #include <asm/asm-offsets.h>
>>>>   #include <asm/sigp.h>
>>>> +#include <asm/arch_def.h>
>>>>   
>>>>   .section .init
>>>>   
>>>> @@ -214,19 +215,19 @@ svc_int:
>>>>   
>>>>   	.align	8
>>>>   reset_psw:
>>>> -	.quad	0x0008000180000000
>>>> +	.quad	PSW_EXCEPTION_MASK
>>>
>>> That won't work, this is a short PSW and you're removing the short
>>> indication here. Notice the 0008 at the front.
> 
> hum... :(
> 
>>
>> Good catch! Guess it would have bailed out when testing.
>>
>>
> 
> Yes it does. Sorry.

No worries, I run everything through the machinery before picking
patches up.

Feel free to resend only the 4/5 patches you want to have in first.

-- 
Thanks,

David / dhildenb
