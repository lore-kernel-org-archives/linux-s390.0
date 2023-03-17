Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245E3C6FD1D
	for <linux-s390@archiver.kernel.org>; Fri, 17 Mar 2023 16:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjCQQiT (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 17 Mar 2023 12:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjCQQiS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 17 Mar 2023 12:38:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6E7E5024
        for <linux-s390@vger.kernel.org>; Fri, 17 Mar 2023 09:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679071031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/y8zeyjefSkAOA8QaVCpOrFBrFGYMJHgyLbILMS2iqI=;
        b=GjqNFiInqfzZKKi24ecNhpSChM2h5bJk9xE73lFSXcxuefhL9PPQ1IJ+7HnkeWUDoX3o0n
        ozQKmE8kFagTkSa7xZHn3373We9Gv8MflUvWFrQCIBssk/jfsu9XstnO4lWXqEx2aAYt9Y
        5LYL0ZvyH+yMWH/3AjcwuXYuqVSW8w0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-1pSHkb4JOFOfZFV70om5fw-1; Fri, 17 Mar 2023 12:37:09 -0400
X-MC-Unique: 1pSHkb4JOFOfZFV70om5fw-1
Received: by mail-wm1-f69.google.com with SMTP id j36-20020a05600c1c2400b003ed245a452fso2495943wms.3
        for <linux-s390@vger.kernel.org>; Fri, 17 Mar 2023 09:37:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679071028;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/y8zeyjefSkAOA8QaVCpOrFBrFGYMJHgyLbILMS2iqI=;
        b=BC1PfckgabX7k6TiRXP7xUA6vDfMZclhDCc8++591i3PFwEkLyq4nuc8LxTToRO7Nv
         bGmNeggjHytDW1nR3rwrFflpXyTloKcoJiCMwUOfZc/gRbuZV3gzHMgLyqMuKuFozTmr
         +ME1uORu0asJTMLvVFJfWmMjhKkWqOLS65nMX3Rvp3iKUrdooxeSk69PefOD3gDpq2BA
         sVon2PL7QuIDJTzMv3Vnd7EtT5jVvDqOS0+Y3tEKpisafZbDGVFrRZKNNi4pzalgl9Ev
         c4W3M980/NjFHBhTrbbmbEnCt7rVWeZO3nkdqH9AVej7RPhrwFO9pRSkZsmTJ4wiT+Ru
         pTbQ==
X-Gm-Message-State: AO0yUKXNKBB3rFeZdV4CvlwbncM93aUIxJDJwbGIerF5di+Q565Hl++w
        Rmy9Y7ixG8cRrbmmEPKizYA+q6uqOvgKav3iq9mw5ihJ/6CtZE8LBpaPerHZo3ItRhHjutiX0iZ
        S4yKyDaVOwlffno/9gMjLRQ==
X-Received: by 2002:a05:600c:1ca3:b0:3ed:2606:d236 with SMTP id k35-20020a05600c1ca300b003ed2606d236mr16059364wms.38.1679071028477;
        Fri, 17 Mar 2023 09:37:08 -0700 (PDT)
X-Google-Smtp-Source: AK7set9Ka1YJT0wlT1v41EY76h2N25wauHSUbnsUXmKdCysd1FXD0NvtHiK6LvC3TM0IMjwUTmDwSQ==
X-Received: by 2002:a05:600c:1ca3:b0:3ed:2606:d236 with SMTP id k35-20020a05600c1ca300b003ed2606d236mr16059346wms.38.1679071028165;
        Fri, 17 Mar 2023 09:37:08 -0700 (PDT)
Received: from [192.168.8.107] (tmo-099-146.customers.d1-online.com. [80.187.99.146])
        by smtp.gmail.com with ESMTPSA id l26-20020a05600c2cda00b003dd1bd0b915sm8514948wmc.22.2023.03.17.09.37.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 09:37:07 -0700 (PDT)
Message-ID: <d9d18828-596f-cd92-887d-aa3c7cbb6e6f@redhat.com>
Date:   Fri, 17 Mar 2023 17:37:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Content-Language: en-US
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>
References: <20230315155445.1688249-1-nsg@linux.ibm.com>
 <20230315155445.1688249-4-nsg@linux.ibm.com>
 <86aa2246-07ff-8fb9-ad97-3b68e8b8f109@redhat.com>
 <8deaddfe-dc69-ec3c-4c8c-a76ee17e6513@redhat.com>
 <20230317163654.211830c0@p-imbrenda>
From:   Thomas Huth <thuth@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v3 3/3] s390x/spec_ex: Add test of EXECUTE
 with odd target address
In-Reply-To: <20230317163654.211830c0@p-imbrenda>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 17/03/2023 16.36, Claudio Imbrenda wrote:
> On Fri, 17 Mar 2023 15:11:35 +0100
> Thomas Huth <thuth@redhat.com> wrote:
> 
>> On 17/03/2023 15.09, Thomas Huth wrote:
>>> On 15/03/2023 16.54, Nina Schoetterl-Glausch wrote:
>>>> The EXECUTE instruction executes the instruction at the given target
>>>> address. This address must be halfword aligned, otherwise a
>>>> specification exception occurs.
>>>> Add a test for this.
>>>>
>>>> Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
>>>> ---
>>>>    s390x/spec_ex.c | 25 +++++++++++++++++++++++++
>>>>    1 file changed, 25 insertions(+)
>>>>
>>>> diff --git a/s390x/spec_ex.c b/s390x/spec_ex.c
>>>> index 83b8c58e..5fa05dba 100644
>>>> --- a/s390x/spec_ex.c
>>>> +++ b/s390x/spec_ex.c
>>>> @@ -177,6 +177,30 @@ static int short_psw_bit_12_is_0(void)
>>>>        return 0;
>>>>    }
>>>> +static int odd_ex_target(void)
>>>> +{
>>>> +    uint64_t pre_target_addr;
>>>> +    int to = 0, from = 0x0dd;
>>>> +
>>>> +    asm volatile ( ".pushsection .text.ex_odd\n"
>>>> +        "    .balign    2\n"
>>>> +        "pre_odd_ex_target:\n"
>>>> +        "    . = . + 1\n"
>>>> +        "    lr    %[to],%[from]\n"
>>>> +        "    .popsection\n"
>>>> +
>>>> +        "    larl    %[pre_target_addr],pre_odd_ex_target\n"
>>>> +        "    ex    0,1(%[pre_target_addr])\n"
>>>> +        : [pre_target_addr] "=&a" (pre_target_addr),
>>>> +          [to] "+d" (to)
>>>> +        : [from] "d" (from)
>>>> +    );
>>>> +
>>>> +    assert((pre_target_addr + 1) & 1);
>>>> +    report(to != from, "did not perform ex with odd target");
>>>> +    return 0;
>>>> +}
>>>
>>> Can this be triggered with KVM, or is this just a test for TCG?
>>
>> With "triggered" I mean: Can this cause an interception in KVM?
> 
> AFAIK no, but KVM and TCG are not the only things we might want to test.

Ok, fair, KVM unit tests are not for KVM only anymore since quite a while, 
so if this is helpful elsewhere, I'm fine with this.

Acked-by: Thomas Huth <thuth@redhat.com>

