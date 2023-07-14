Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B947EEB64DA
	for <linux-s390@archiver.kernel.org>; Fri, 14 Jul 2023 06:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235151AbjGNGpS (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 14 Jul 2023 02:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbjGNGoy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 14 Jul 2023 02:44:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC4D2D61
        for <linux-s390@vger.kernel.org>; Thu, 13 Jul 2023 23:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689317056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P7wI4HqpTED2IIaIaUDlqBMuW2YXJR0KrL4qMzuFtLA=;
        b=KMlUhOz4uCH5wIkL0D/uH0pfgnvT0SRWNXqdNmKWIE6QgW/I78dv9Hxq8GrkQbfaoeZwtu
        951u53nmhbFIiAfjh96222rPGxY86Iqg0+A0R1XaNOT42ojfGUg3m+eBUexlR9AzG34D/e
        4+uYUVzNIX1vuXhl7nMgDfRSCs9ZJXg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-NDTRbfqDMZy9abIzdy0zWQ-1; Fri, 14 Jul 2023 02:44:15 -0400
X-MC-Unique: NDTRbfqDMZy9abIzdy0zWQ-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7679e5ebad2so219432385a.3
        for <linux-s390@vger.kernel.org>; Thu, 13 Jul 2023 23:44:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689317055; x=1691909055;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P7wI4HqpTED2IIaIaUDlqBMuW2YXJR0KrL4qMzuFtLA=;
        b=gWskutujyzLwTAMtvBmqZAfR93GHbcuifpADnMveoe+9c3S4QFzvo0DerdEnzNxQ8J
         q/AsZwFh80bj65NGNnX6TMr9RDUFhx2nnkPFn1O635+pbPagewKSKKwqAasiU8zB2hMJ
         n9Y0SBSOPre4opd6JIt2+pMHO/f0DxsibCBrUcFtm4wFFbv+VWvokHZP+haK0no7wg8D
         i+AnhnsYdqxd08hjCbrcvP8NmTeLaxvNAvgjnncBjt3bZTjZ4yhBk7Ah5DCQ6/gMz+sw
         W64mgFcgw76z6ryNBsf3O1Sxll7FlCAoN/Up9NtO4Navdi0GpVvW3YEus17ndNo11WWp
         U8aw==
X-Gm-Message-State: ABy/qLb79LMmqNxVfUmm/uZ6q62+qfBX2FkSbPOJjHxT1QkBXFf1eOiR
        7O3JVUKQM7mcu2u4X+wEN/kKRSXWMh3iWC87B5Y8daO+iL/imudB9w7sAo8U/jrHrcEGK+FO8FW
        GP2tS+PoWqUKDuQ/tVEGM7I5AOdzdNQ==
X-Received: by 2002:a05:620a:2551:b0:767:7de5:85f2 with SMTP id s17-20020a05620a255100b007677de585f2mr5141814qko.68.1689317054750;
        Thu, 13 Jul 2023 23:44:14 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFOtMJFMN4hoVS1MZBiqr+KAj8KEIDLVx0xnRGqzXMY7ww+OKhbLM270oXAaBzW+aiSImo8ww==
X-Received: by 2002:a05:620a:2551:b0:767:7de5:85f2 with SMTP id s17-20020a05620a255100b007677de585f2mr5141800qko.68.1689317054446;
        Thu, 13 Jul 2023 23:44:14 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-177-249.web.vodafone.de. [109.43.177.249])
        by smtp.gmail.com with ESMTPSA id oq25-20020a05620a611900b00767db6f47bbsm3552461qkn.73.2023.07.13.23.44.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 23:44:13 -0700 (PDT)
Message-ID: <ccb5001a-f904-aa97-e0ef-278723b39378@redhat.com>
Date:   Fri, 14 Jul 2023 08:44:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [kvm-unit-tests PATCH v5 2/6] s390x: add function to set DAT mode
 for all interrupts
Content-Language: en-US
To:     Nico Boehr <nrb@linux.ibm.com>, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org
References: <20230712114149.1291580-1-nrb@linux.ibm.com>
 <20230712114149.1291580-3-nrb@linux.ibm.com>
 <9b2cdc37-0b93-ff00-d077-397b8c0c2950@redhat.com>
 <168926224829.12187.2957278869966216471@t14-nrb>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <168926224829.12187.2957278869966216471@t14-nrb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 13/07/2023 17.30, Nico Boehr wrote:
> Quoting Thomas Huth (2023-07-13 09:17:28)
>> On 12/07/2023 13.41, Nico Boehr wrote:
>>> When toggling DAT or switch address space modes, it is likely that
>>> interrupts should be handled in the same DAT or address space mode.
>>>
>>> Add a function which toggles DAT and address space mode for all
>>> interruptions, except restart interrupts.
>>>
>>> Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
>>> ---
>>>    lib/s390x/asm/interrupt.h |  4 ++++
>>>    lib/s390x/interrupt.c     | 36 ++++++++++++++++++++++++++++++++++++
>>>    lib/s390x/mmu.c           |  5 +++--
>>>    3 files changed, 43 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/lib/s390x/asm/interrupt.h b/lib/s390x/asm/interrupt.h
>>> index 35c1145f0349..55759002dce2 100644
>>> --- a/lib/s390x/asm/interrupt.h
>>> +++ b/lib/s390x/asm/interrupt.h
>>> @@ -83,6 +83,10 @@ void expect_ext_int(void);
>>>    uint16_t clear_pgm_int(void);
>>>    void check_pgm_int_code(uint16_t code);
>>>    
>>> +#define IRQ_DAT_ON   true
>>> +#define IRQ_DAT_OFF  false
>>
>> Just a matter of taste, but IMHO having defines like this for just using
>> them as boolean parameter to one function is a little bit overkill already.
>> I'd rather rename the "bool dat" below into "bool use_dat" and then use
>> "true" and "false" directly as a parameter for that function instead.
>> Anyway, just my 0.02 \u20ac.
> 
> The point of having these defines was to convey the meaning of the parameter to my reader.
> 
> When I read
> 
>      irq_set_dat_mode(true, AS_HOME);
> 
> it's less clear to me that the first parameter toggles the DAT mode compared to this:
> 
>      irq_set_dat_mode(IRQ_DAT_ON, AS_HOME);
> 
> That being said, here it's pretty clear from the function name what the first parameter is, so what's the preferred opinion?

I see your point, but if it is clear from the function name like it is in 
this case, I'd go with "true" and "false" directly, without the indirection 
via #define.

...
>>> + * Since enabling DAT needs initalized CRs and the restart new PSW is often used
>>
>> s/initalized/initialized/
> 
> Argh, thanks.
> 
> *reprioritizes task to look for a spell checker*

codespell (https://github.com/codespell-project/codespell) is your friend!

  Thomas


