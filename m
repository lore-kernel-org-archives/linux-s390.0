Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09760C48BE5
	for <linux-s390@archiver.kernel.org>; Tue, 22 Jun 2021 07:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3D156108E
	for <linux-s390@archiver.kernel.org>; Tue, 22 Jun 2021 07:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbhFVHsi (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 22 Jun 2021 03:48:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41481 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229789AbhFVHsh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 22 Jun 2021 03:48:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624347982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zdjETLWkSvHACmbeGDp6CeV86yBVSR0D+qi5o0JktrI=;
        b=a5cAsDqLh4KWniTTI2g3LdvD0xiCG2fVQmJ7fwJgrzpOAYNX1VDfuVwLrbWcOLyRna80lL
        b36zWz0/D+9AEGm71PMJjnZemfDuHeHM2IRbQTS5bqAMvo9QhnATBNgTXQnv8kMkXcjlkk
        A9WZkMjgD4yDboEercw9KW2wsbJCGAE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-rhIlsLVyNsCgGsscPHlW_A-1; Tue, 22 Jun 2021 03:46:21 -0400
X-MC-Unique: rhIlsLVyNsCgGsscPHlW_A-1
Received: by mail-wr1-f71.google.com with SMTP id u16-20020a5d51500000b029011a6a17cf62so9017097wrt.13
        for <linux-s390@vger.kernel.org>; Tue, 22 Jun 2021 00:46:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zdjETLWkSvHACmbeGDp6CeV86yBVSR0D+qi5o0JktrI=;
        b=EcfgciUc2DJLeIc22YVulaU37/qMi6Lp0jIFCCIDlp3yMrKCuojirgeY0w8OGd8fix
         Has9jZW/czU6Ulnx33nQOhxP18JrmGcA6VL1rX9Yy6lgJuab8wPomyvMyn6Y4/Bn4Qqw
         XPMNMO8iaOhoi+vH2kv4XnVY8C3Vx2QDqF/yamjS63R6gU9Hq6zrN9wxGG58tjZ/Bo/Q
         R3UxNimQPEVPsI5nn3wB20xGHgdpIZmjk3ztiI1z7zPwJPd5krmtUyRaqCSmhcnbl0Zj
         m7kkZFVzorDzLfNaeafD4DuFHkAuBEkDASeBxRU/gR3QzaA6Eqkzhw6rweqn4JmmYXGE
         vSFQ==
X-Gm-Message-State: AOAM53364mKHnb8v/GUaNT3jMc+xHEbBkvTBmM42yiTqaS57NjNH+DIS
        QyYPIR7DIWzUiJ1QX6tegtYKFJ6LrA+46Qy9ULLeS/hif7YpEmoZwiLfvY2rB7BhCGxTPDB/VT9
        LdgF6srrc3m7s+8OEq0Ygr/WJM44jz+MKUe4rDHW9afJW02DedrB+Cx5HD06ydjqv4JkBwA==
X-Received: by 2002:adf:df88:: with SMTP id z8mr3068992wrl.330.1624347979850;
        Tue, 22 Jun 2021 00:46:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/4/G2PxtiD/pGBQ55k66zKhlU49Oijo/ZQjvEF9XdqD9q69xzWzjBdHStOlC86RQEXONIpQ==
X-Received: by 2002:adf:df88:: with SMTP id z8mr3068964wrl.330.1624347979649;
        Tue, 22 Jun 2021 00:46:19 -0700 (PDT)
Received: from thuth.remote.csb (pd9575f2f.dip0.t-ipconnect.de. [217.87.95.47])
        by smtp.gmail.com with ESMTPSA id w2sm17487101wrp.14.2021.06.22.00.46.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 00:46:19 -0700 (PDT)
Subject: Re: [PATCH] KVM: s390: get rid of register asm usage
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Janosch Frank <frankja@linux.vnet.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20210621140356.1210771-1-hca@linux.ibm.com>
 <7edaf85c-810b-e0f9-5977-6e89270f0709@redhat.com>
 <ef34e1df-b56d-8123-60c7-e56d00cd01ca@de.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Message-ID: <67653df1-1a9e-c406-c45c-f30b69a2ee8a@redhat.com>
Date:   Tue, 22 Jun 2021 09:46:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <ef34e1df-b56d-8123-60c7-e56d00cd01ca@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 22/06/2021 09.43, Christian Borntraeger wrote:
> 
> 
> On 22.06.21 09:36, Thomas Huth wrote:
>> On 21/06/2021 16.03, Heiko Carstens wrote:
>>> Using register asm statements has been proven to be very error prone,
>>> especially when using code instrumentation where gcc may add function
>>> calls, which clobbers register contents in an unexpected way.
>>>
>>> Therefore get rid of register asm statements in kvm code, even though
>>> there is currently nothing wrong with them. This way we know for sure
>>> that this bug class won't be introduced here.
>>>
>>> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
>>> ---
>>>   arch/s390/kvm/kvm-s390.c | 18 +++++++++---------
>>>   1 file changed, 9 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>>> index 1296fc10f80c..4b7b24f07790 100644
>>> --- a/arch/s390/kvm/kvm-s390.c
>>> +++ b/arch/s390/kvm/kvm-s390.c
>>> @@ -329,31 +329,31 @@ static void allow_cpu_feat(unsigned long nr)
>>>   static inline int plo_test_bit(unsigned char nr)
>>>   {
>>> -    register unsigned long r0 asm("0") = (unsigned long) nr | 0x100;
>>> +    unsigned long function = (unsigned long) nr | 0x100;
>>>       int cc;
>>>       asm volatile(
>>> +        "    lgr    0,%[function]\n"
>>>           /* Parameter registers are ignored for "test bit" */
>>>           "    plo    0,0,0,0(0)\n"
>>>           "    ipm    %0\n"
>>>           "    srl    %0,28\n"
>>>           : "=d" (cc)
>>> -        : "d" (r0)
>>> -        : "cc");
>>> +        : [function] "d" (function)
>>> +        : "cc", "0");
>>>       return cc == 0;
>>>   }
>>>   static __always_inline void __insn32_query(unsigned int opcode, u8 *query)
>>>   {
>>> -    register unsigned long r0 asm("0") = 0;    /* query function */
>>> -    register unsigned long r1 asm("1") = (unsigned long) query;
>>> -
>>>       asm volatile(
>>> -        /* Parameter regs are ignored */
>>> +        "    lghi    0,0\n"
>>> +        "    lgr    1,%[query]\n"
>>> +        /* Parameter registers are ignored */
>>>           "    .insn    rrf,%[opc] << 16,2,4,6,0\n"
>>>           :
>>> -        : "d" (r0), "a" (r1), [opc] "i" (opcode)
>>> -        : "cc", "memory");
>>> +        : [query] "d" ((unsigned long)query), [opc] "i" (opcode)
>>
>> Wouldn't it be better to keep the "a" constraint instead of "d" to avoid 
>> that the compiler ever passes the "query" value in r0 ?
>> Otherwise the query value might get trashed if it is passed in r0...
> 
> I first thought the same, but if you look closely the value is only used by 
> the lgr, to load
> the value finally into r1. So d is correct as lgr can take all registers.

But what about the "lghi    0,0" right in front of it? ... I've got the 
feeling that I'm missing something here...
Heiko, maybe you could at least swap the initialization of r0 and r1, then 
I'd feel a little bit better...

  Thomas

