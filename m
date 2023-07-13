Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC61EB64DD
	for <linux-s390@archiver.kernel.org>; Thu, 13 Jul 2023 06:58:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234117AbjGMG6w (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 13 Jul 2023 02:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234122AbjGMG6t (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 13 Jul 2023 02:58:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624572684
        for <linux-s390@vger.kernel.org>; Wed, 12 Jul 2023 23:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689231473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FkUDksLkfPco+7wyI296HUS7y9CDt8j4euYQ6B06Lss=;
        b=PleqlY9BwqTEmUUNhJrkMcJ9fpOSsJqHK1XGZhPDmEjwswuuWoIMm/SfyuXcEtrcO+ckad
        nIMDC9E74E5fyAu3/6YLK5U4+9jlQN1nregsRlyMB7ynuvQluJneOuVqCFbZnlgRubJGWB
        Qk+8+jqScr05fX09HVpAOM0NlOGzZIM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-L5gKJsHhNQKW2yggoI3QKg-1; Thu, 13 Jul 2023 02:57:52 -0400
X-MC-Unique: L5gKJsHhNQKW2yggoI3QKg-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7675fc3333eso27048385a.0
        for <linux-s390@vger.kernel.org>; Wed, 12 Jul 2023 23:57:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689231472; x=1691823472;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FkUDksLkfPco+7wyI296HUS7y9CDt8j4euYQ6B06Lss=;
        b=WZAMqbaF25x3igutHMPt1STpm2JsSqPWBvBurIfRQOQdamflEgMd9BRW9TP9PCzZic
         BKRDo9XT3RFnWjraV8Y1/02ypHj4u3ogVF3E2bV+7Er3LfHz6s/7M1xW97heHDG1Ca1A
         FIqY3np3g05VzTX57Uwrh55L8Xd5+dfZmsGTLA3muvx8ALmhIW+w8Iexrzq021HWLzAq
         NTilQRj+Gwbv9EzOUP845z4+Hlf40G/XZ0XOQv5E/fZS+vRcWSz0W2iuGRmBEQDh+P4t
         3WFd3LHSU8B4S9dlIOUnCV3aPrL2ismSHWykkJ/SFODUHvP30hKZYvALZFf0t0U5BxkL
         yE2w==
X-Gm-Message-State: ABy/qLaT8Tt6yYYe4C2coPOQ1EMWwIYE59teIkL7mNeqqVrIbAnYR4LV
        d2RKb2KYtJoSQDHDAQKcpXeNlvBdCatZq3gwfyJv7QdxMKA5FYvFjugz3+x6yB6QzGgU8eoXJce
        DTef1yAMDmGRYiAX+g/pQQvrh3Sbgjw==
X-Received: by 2002:a05:620a:394a:b0:767:e55c:d3ba with SMTP id qs10-20020a05620a394a00b00767e55cd3bamr1006452qkn.3.1689231471925;
        Wed, 12 Jul 2023 23:57:51 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEltUOn6hK/qYK9V7xYjCXYyprYEc23ogRF1mZF4E/ap9JA7M7qdA/lRoz3YOmRByG6OE2hJw==
X-Received: by 2002:a05:620a:394a:b0:767:e55c:d3ba with SMTP id qs10-20020a05620a394a00b00767e55cd3bamr1006443qkn.3.1689231471470;
        Wed, 12 Jul 2023 23:57:51 -0700 (PDT)
Received: from [10.33.192.205] (nat-pool-str-t.redhat.com. [149.14.88.106])
        by smtp.gmail.com with ESMTPSA id i6-20020a37c206000000b00767e669d5d6sm1967452qkm.50.2023.07.12.23.57.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 23:57:51 -0700 (PDT)
Message-ID: <4919d35f-7a3c-89c7-4287-c1a30508524d@redhat.com>
Date:   Thu, 13 Jul 2023 08:57:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [kvm-unit-tests PATCH v5 1/6] lib: s390x: introduce bitfield for
 PSW mask
Content-Language: en-US
From:   Thomas Huth <thuth@redhat.com>
To:     Nico Boehr <nrb@linux.ibm.com>, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org
References: <20230712114149.1291580-1-nrb@linux.ibm.com>
 <20230712114149.1291580-2-nrb@linux.ibm.com>
 <53d9d63f-e207-23a6-faea-8bad8b22a375@redhat.com>
In-Reply-To: <53d9d63f-e207-23a6-faea-8bad8b22a375@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 13/07/2023 08.56, Thomas Huth wrote:
> On 12/07/2023 13.41, Nico Boehr wrote:
>> Changing the PSW mask is currently little clumsy, since there is only the
>> PSW_MASK_* defines. This makes it hard to change e.g. only the address
>> space in the current PSW without a lot of bit fiddling.
>>
>> Introduce a bitfield for the PSW mask. This makes this kind of
>> modifications much simpler and easier to read.
>>
>> Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
>> ---
>>   lib/s390x/asm/arch_def.h | 26 +++++++++++++++++++++++++-
>>   s390x/selftest.c         | 40 ++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 65 insertions(+), 1 deletion(-)
>>
>> diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
>> index bb26e008cc68..53279572a9ee 100644
>> --- a/lib/s390x/asm/arch_def.h
>> +++ b/lib/s390x/asm/arch_def.h
>> @@ -37,12 +37,36 @@ struct stack_frame_int {
>>   };
>>   struct psw {
>> -    uint64_t    mask;
>> +    union {
>> +        uint64_t    mask;
>> +        struct {
>> +            uint8_t reserved00:1;
>> +            uint8_t per:1;
>> +            uint8_t reserved02:3;
>> +            uint8_t dat:1;
>> +            uint8_t io:1;
>> +            uint8_t ext:1;
>> +            uint8_t key:4;
>> +            uint8_t reserved12:1;
>> +            uint8_t mchk:1;
>> +            uint8_t wait:1;
>> +            uint8_t pstate:1;
>> +            uint8_t as:2;
>> +            uint8_t cc:2;
>> +            uint8_t prg_mask:4;
>> +            uint8_t reserved24:7;
>> +            uint8_t ea:1;
>> +            uint8_t ba:1;
>> +            uint32_t reserved33:31;
>> +        };
>> +    };
>>       uint64_t    addr;
>>   };
>> +_Static_assert(sizeof(struct psw) == 16, "PSW size");
>>   #define PSW(m, a) ((struct psw){ .mask = (m), .addr = (uint64_t)(a) })
>> +
>>   struct short_psw {
>>       uint32_t    mask;
>>       uint32_t    addr;
>> diff --git a/s390x/selftest.c b/s390x/selftest.c
>> index 13fd36bc06f8..8d81ba312279 100644
>> --- a/s390x/selftest.c
>> +++ b/s390x/selftest.c
>> @@ -74,6 +74,45 @@ static void test_malloc(void)
>>       report_prefix_pop();
>>   }
>> +static void test_psw_mask(void)
>> +{
>> +    uint64_t expected_key = 0xF;
>> +    struct psw test_psw = PSW(0, 0);
>> +
>> +    report_prefix_push("PSW mask");
>> +    test_psw.dat = 1;
>> +    report(test_psw.mask == PSW_MASK_DAT, "DAT matches expected=0x%016lx 
>> actual=0x%016lx", PSW_MASK_DAT, test_psw.mask);
>> +
>> +    test_psw.mask = 0;
>> +    test_psw.io = 1;
>> +    report(test_psw.mask == PSW_MASK_IO, "IO matches expected=0x%016lx 
>> actual=0x%016lx", PSW_MASK_IO, test_psw.mask);
>> +
>> +    test_psw.mask = 0;
>> +    test_psw.ext = 1;
>> +    report(test_psw.mask == PSW_MASK_EXT, "EXT matches expected=0x%016lx 
>> actual=0x%016lx", PSW_MASK_EXT, test_psw.mask);
>> +
>> +    test_psw.mask = expected_key << (63 - 11);
>> +    report(test_psw.key == expected_key, "PSW Key matches expected=0x%lx 
>> actual=0x%x", expected_key, test_psw.key);
> 
> Patch looks basically fine to me, but here my mind stumbled a little bit. 
> This test is written the other way round than the others. Nothing wrong with 
> that, it just feels a little bit inconsistent. I'd suggest to either do:
> 
>      test_psw.mask = 0;
>      test_psw.key = expected_key;
>      report(test_psw.mask == expected_key << (63 - 11), ...);
> 
> or maybe even switch all the other tests around instead, so you could get 
> rid of the "test_psw.mask = 0" lines, e.g. :
> 
>      test_psw.mask == PSW_MASK_IO;

s/==/=/ of course!

Sorry for that typo.

  Thomas


>      report(test_psw.io, "IO matches ...");
> 
> etc.
> 
>   Thomas
> 

