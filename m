Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A86FC433EF
	for <linux-s390@archiver.kernel.org>; Fri, 17 Dec 2021 14:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234577AbhLQOZD (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 17 Dec 2021 09:25:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57338 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230248AbhLQOZD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 17 Dec 2021 09:25:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639751102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yof0t9L7kPtXzpqrUUe+78TSbXMmLOHbqj/saGE07Ho=;
        b=R2jOI4z9HHfj1xCbm3Hk95yeL8PqCaJr2G7U3HyrFseVldPygCKgY+FimQ14ojQltfgMsY
        Tt80abZmKopsupT5yPU6HLqcz5feSeP4GeBKNuPQ9c8giqUsQoOwWlmr0HJbdA5KIqKXqm
        6AIMlZPoNd+m+LRCjUAEr8o1yE8QXik=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-300-UG4j_FAOP32e-eNzWi87-Q-1; Fri, 17 Dec 2021 09:25:01 -0500
X-MC-Unique: UG4j_FAOP32e-eNzWi87-Q-1
Received: by mail-wm1-f71.google.com with SMTP id p13-20020a05600c1d8d00b0034565e7e5c6so994259wms.9
        for <linux-s390@vger.kernel.org>; Fri, 17 Dec 2021 06:25:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Yof0t9L7kPtXzpqrUUe+78TSbXMmLOHbqj/saGE07Ho=;
        b=Iyq9EbBHpubJC1dGDbBU0d0BENQUjyfoGJ1kZDXcoTH88rbHjwMofDEqlQ1xULcLaq
         M6/hnn2VL2WeoJU3GQ1KRc/HGxy5bYXYhMj5htTR8dBt4AB5S5U0RxL3LCko8sgE8s+V
         Crtep/LBjbJT0fbirrG4GVt2EWh9cf5Nm7g9WhFVPjixMLCTODf4Z+nfrybFiTGh967P
         9n1BGwUp6Wn+NlSm3NzZUzxu1AeQFE2R3y7gtPyFkFRm5YoQuPgLvZfuZ7/Br5yndh2D
         ap4+h+VkEQaaW3NDvSM6pyKkC0VNdPVAotgLc0BpLnnAGX26bIYtjVrostfM15sorKUo
         +J5A==
X-Gm-Message-State: AOAM532her2zJMA3O46RuX3Z8ohUaSdCrKN/wcyJ6ckRGFxPoCtEGgzZ
        NRbu1W5mIXXZBihb7bB5lcsZ94HEmnwJVay6Zr5YuVOt0Y1/Wrz29kfqjaBi4xHYUFPzBfPrucl
        Scu5qxej/Z7/U/o4YcJ5LVQ==
X-Received: by 2002:a05:6000:15cd:: with SMTP id y13mr2793327wry.581.1639751099855;
        Fri, 17 Dec 2021 06:24:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyEZJhx0XW4LNBmwJ2SkNBM98b6Qaw95HU4EUxBpNOF+91SFyDFTqCn3IZXPp6VGf4cqVvfCQ==
X-Received: by 2002:a05:6000:15cd:: with SMTP id y13mr2793317wry.581.1639751099602;
        Fri, 17 Dec 2021 06:24:59 -0800 (PST)
Received: from [192.168.2.110] (p54886ae3.dip0.t-ipconnect.de. [84.136.106.227])
        by smtp.gmail.com with ESMTPSA id n8sm6835395wri.47.2021.12.17.06.24.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 06:24:59 -0800 (PST)
Message-ID: <f861e42c-bd52-2f35-b0da-c44500fff3b6@redhat.com>
Date:   Fri, 17 Dec 2021 15:24:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH kvm-unit-tests 1/2] s390x: diag288: Add missing clobber
Content-Language: en-US
To:     Janosch Frank <frankja@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        david@redhat.com
References: <20211217103137.1293092-1-nrb@linux.ibm.com>
 <20211217103137.1293092-2-nrb@linux.ibm.com>
 <3e2035bd-0929-488c-28f3-d8256bec14a4@redhat.com>
 <329aced6-df4f-2802-cbc6-99469c5f9462@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <329aced6-df4f-2802-cbc6-99469c5f9462@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 17/12/2021 15.16, Janosch Frank wrote:
> On 12/17/21 14:47, Thomas Huth wrote:
>> On 17/12/2021 11.31, Nico Boehr wrote:
>>> We clobber r0 and thus should let the compiler know we're doing so.
>>>
>>> Because we change from basic to extended ASM, we need to change the
>>> register names, as %r0 will be interpreted as a token in the assembler
>>> template.
>>>
>>> For consistency, we align with the common style in kvm-unit-tests which
>>> is just 0.
>>>
>>> Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
>>> ---
>>>    s390x/diag288.c | 7 ++++---
>>>    1 file changed, 4 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/s390x/diag288.c b/s390x/diag288.c
>>> index 072c04a5cbd6..da7b06c365bf 100644
>>> --- a/s390x/diag288.c
>>> +++ b/s390x/diag288.c
>>> @@ -94,11 +94,12 @@ static void test_bite(void)
>>>        /* Arm watchdog */
>>>        lc->restart_new_psw.mask = extract_psw_mask() & ~PSW_MASK_EXT;
>>>        diag288(CODE_INIT, 15, ACTION_RESTART);
>>> -    asm volatile("        larl    %r0, 1f\n"
>>> -             "        stg    %r0, 424\n"
>>> +    asm volatile("        larl    0, 1f\n"
>>> +             "        stg    0, 424\n"
>>
>> Would it work to use %%r0 instead?
> 
> Yes, but I told him that looks weird, so that one is on me.
> @claudio @thomas What's your preferred way of dealing with this?

I think it's mostly a matter of taste. I slightly prefer %%r0 to just 0 so 
that it is clear from the first sight that it is a register and not an 
immediate constant.
Additionally, there used to be a problem with older versions of Clang that 
required the %%rX syntax, see:

  https://git.qemu.org/?p=qemu.git;a=commitdiff;h=052b66e7211af6

But we're not supporting those Clang versions for the kvm-unit-tests anyway, 
so that doesn't really count.

Thus, I don't mind too much, if everybody else prefers the bare numbers, 
then let's go with this.

  Thomas

