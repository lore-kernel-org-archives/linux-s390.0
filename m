Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E2FCC48BDF
	for <linux-s390@archiver.kernel.org>; Tue, 22 Jun 2021 08:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75237610C7
	for <linux-s390@archiver.kernel.org>; Tue, 22 Jun 2021 08:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhFVIGn (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 22 Jun 2021 04:06:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49131 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230013AbhFVIGl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 22 Jun 2021 04:06:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624349065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MjeXPHu/4UDH7ZPmnA9R3lgnej3JwJud2wr6WbqhTls=;
        b=Vy1/2hywVhCDmXmqwxb0kU8YhN0a1Ju+RtLkaXRDW3ZqCHrmfWdAvWLEDDNW1xCVk+BJV7
        quA2EXxLROfUqNX7+GV0nzdpSz+IWp0fwCI+JhmzmUZFdf3v3La6ORIo2dCoiE59vyoY3/
        qq54lcuWKEI78uunEHd4GBJP7sfoTpc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-Vin2uvg2PKa_wwEdI_57Cg-1; Tue, 22 Jun 2021 04:04:22 -0400
X-MC-Unique: Vin2uvg2PKa_wwEdI_57Cg-1
Received: by mail-wr1-f70.google.com with SMTP id d9-20020adffbc90000b029011a3b249b10so9316833wrs.3
        for <linux-s390@vger.kernel.org>; Tue, 22 Jun 2021 01:04:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MjeXPHu/4UDH7ZPmnA9R3lgnej3JwJud2wr6WbqhTls=;
        b=toEWDwDSwdkBrl6nw3EkPewlE2OEKim4t2BFHyeKyKWUJ8yyUAPBr7nKRn4Ko8E5SL
         lb7by3vMrZQe2Y5nzLG9JcPkdNGv6gjqsaPgiQZf0+Mls3DC+97Vc6syS42eTCRsluFW
         8b6HzuzCXsLLSwxtTwlVM9lG+lFeLxmyCGsrTxZVLmrr+4SYxhQ7MbnrOW138joj99Tr
         tofXF8Ugx0I6KOzlaA7nsW6PYWbLjqOPiz367Xbc4RG9RUPUVRrpAhwZtvsP/lUhD3z8
         mo5pEpUXw52TTyJ1hNbhPEDxId/eSa6Y0u3x8BfYTCIVjwylqxNSdvoGokGP1uO9B80+
         TaIQ==
X-Gm-Message-State: AOAM5319LUz04bHcnH5VktTvzxQ6wcnoqsEqU5neD5JKQk+33k6Hqipl
        qKbw3Y5ujRxB/+pL7AS6QjlfoQt038fwbgj/CFqRL4vYBIhmIkY8GPuog41EVM12XEyhZCFbQf5
        MsWBFK5ZUO8f5c7DSbi/J1nx3Yz3ufeekK0XuwgOjLkYnMcOP3xzqIIrfpp6C4AzEC2XsJg==
X-Received: by 2002:a5d:6c65:: with SMTP id r5mr3017437wrz.339.1624349061267;
        Tue, 22 Jun 2021 01:04:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzP2X/sZQGxlaQWDDJPAzf130gZnIwkW/gBhndKOL1M4X1zpFcyW3GSC7MTxOzii1AEVqwhLQ==
X-Received: by 2002:a5d:6c65:: with SMTP id r5mr3017414wrz.339.1624349061051;
        Tue, 22 Jun 2021 01:04:21 -0700 (PDT)
Received: from thuth.remote.csb (pd9575f2f.dip0.t-ipconnect.de. [217.87.95.47])
        by smtp.gmail.com with ESMTPSA id c13sm20717808wrb.5.2021.06.22.01.04.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 01:04:20 -0700 (PDT)
Subject: Re: [PATCH] KVM: s390: get rid of register asm usage
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Janosch Frank <frankja@linux.vnet.ibm.com>,
        Andreas Krebbel <krebbel@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20210621140356.1210771-1-hca@linux.ibm.com>
 <7edaf85c-810b-e0f9-5977-6e89270f0709@redhat.com>
 <ef34e1df-b56d-8123-60c7-e56d00cd01ca@de.ibm.com>
 <67653df1-1a9e-c406-c45c-f30b69a2ee8a@redhat.com>
 <b537af91-87a5-a1f7-343b-5b36b72d57a0@de.ibm.com>
 <fcee5e74-efe3-f0eb-feac-d50f7ec4a0c8@redhat.com>
 <1b8583e7-a39d-10ca-982f-d513b3f9016a@de.ibm.com>
 <facc1000-e8dc-c373-5db0-1ca5c25c6bb8@de.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Message-ID: <98cd63e6-25c9-52e7-fc3c-fc994db6a262@redhat.com>
Date:   Tue, 22 Jun 2021 10:04:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <facc1000-e8dc-c373-5db0-1ca5c25c6bb8@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 22/06/2021 10.00, Christian Borntraeger wrote:
> 
> 
> On 22.06.21 09:57, Christian Borntraeger wrote:
>>
>>
>> On 22.06.21 09:53, Thomas Huth wrote:
>>> On 22/06/2021 09.50, Christian Borntraeger wrote:
>>>>
>>>>
>>>> On 22.06.21 09:46, Thomas Huth wrote:
>>>>> On 22/06/2021 09.43, Christian Borntraeger wrote:
>>>>>>
>>>>>>
>>>>>> On 22.06.21 09:36, Thomas Huth wrote:
>>>>>>> On 21/06/2021 16.03, Heiko Carstens wrote:
>>>>>>>> Using register asm statements has been proven to be very error prone,
>>>>>>>> especially when using code instrumentation where gcc may add function
>>>>>>>> calls, which clobbers register contents in an unexpected way.
>>>>>>>>
>>>>>>>> Therefore get rid of register asm statements in kvm code, even though
>>>>>>>> there is currently nothing wrong with them. This way we know for sure
>>>>>>>> that this bug class won't be introduced here.
>>>>>>>>
>>>>>>>> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>>>>>>> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
>>>>>>>> ---
>>>>>>>>   arch/s390/kvm/kvm-s390.c | 18 +++++++++---------
>>>>>>>>   1 file changed, 9 insertions(+), 9 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>>>>>>>> index 1296fc10f80c..4b7b24f07790 100644
>>>>>>>> --- a/arch/s390/kvm/kvm-s390.c
>>>>>>>> +++ b/arch/s390/kvm/kvm-s390.c
>>>>>>>> @@ -329,31 +329,31 @@ static void allow_cpu_feat(unsigned long nr)
>>>>>>>>   static inline int plo_test_bit(unsigned char nr)
>>>>>>>>   {
>>>>>>>> -    register unsigned long r0 asm("0") = (unsigned long) nr | 0x100;
>>>>>>>> +    unsigned long function = (unsigned long) nr | 0x100;
>>>>>>>>       int cc;
>>>>>>>>       asm volatile(
>>>>>>>> +        "    lgr    0,%[function]\n"
>>>>>>>>           /* Parameter registers are ignored for "test bit" */
>>>>>>>>           "    plo    0,0,0,0(0)\n"
>>>>>>>>           "    ipm    %0\n"
>>>>>>>>           "    srl    %0,28\n"
>>>>>>>>           : "=d" (cc)
>>>>>>>> -        : "d" (r0)
>>>>>>>> -        : "cc");
>>>>>>>> +        : [function] "d" (function)
>>>>>>>> +        : "cc", "0");
>>>>>>>>       return cc == 0;
>>>>>>>>   }
>>>>>>>>   static __always_inline void __insn32_query(unsigned int opcode, u8 
>>>>>>>> *query)
>>>>>>>>   {
>>>>>>>> -    register unsigned long r0 asm("0") = 0;    /* query function */
>>>>>>>> -    register unsigned long r1 asm("1") = (unsigned long) query;
>>>>>>>> -
>>>>>>>>       asm volatile(
>>>>>>>> -        /* Parameter regs are ignored */
>>>>>>>> +        "    lghi    0,0\n"
>>>>>>>> +        "    lgr    1,%[query]\n"
>>>>>>>> +        /* Parameter registers are ignored */
>>>>>>>>           "    .insn    rrf,%[opc] << 16,2,4,6,0\n"
>>>>>>>>           :
>>>>>>>> -        : "d" (r0), "a" (r1), [opc] "i" (opcode)
>>>>>>>> -        : "cc", "memory");
>>>>>>>> +        : [query] "d" ((unsigned long)query), [opc] "i" (opcode)
>>          : "cc", "memory", "0", "1");
>>>>>>>
>>>>>>> Wouldn't it be better to keep the "a" constraint instead of "d" to 
>>>>>>> avoid that the compiler ever passes the "query" value in r0 ?
>>>>>>> Otherwise the query value might get trashed if it is passed in r0...
>>>>>>
>>>>>> I first thought the same, but if you look closely the value is only 
>>>>>> used by the lgr, to load
>>>>>> the value finally into r1. So d is correct as lgr can take all registers.
>>>>>
>>>>> But what about the "lghi    0,0" right in front of it? ... I've got the 
>>>>> feeling that I'm missing something here...
>>>>
>>>> It does load an immediate value of 0 into register 0. Are you afraid of 
>>>> an early clobber if
>>>> gcc decides to use r0 for query?
>>>
>>> Right, that was my concern. It's a "static __always_inline" function, so 
>>> can we be sure that query is still always located in a register that is 
>>> reserved for parameters (i.e. >= r2) ?
>>
>> Adding Andreas. I know that gcc provides the early clobber "&" if an 
>> output is written before all imputs are used.
>> but in this case it is not an output but a clobbered register.
>> The clobber list contains 0 and 1, so I guess gcc will never use those as 
>> input register.
>> Andreas, is that correct?
>>
>>
>> PS: Of course switching both instructions does not hurt
> 
> Answering myself:
> 
> https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html#Clobbers-and-Scratch-Registers 
> 
> When the compiler selects which registers to use to represent input and 
> output operands, it does not use any of the clobbered registers. As a 
> result, clobbered registers are available for any use in the assembler code.

Ah, ok, TIL, thanks, then it is fine as it is. Feel free to add my 
Reviewed-by without any further modifications.

  Thomas

