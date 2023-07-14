Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5840EB64DA
	for <linux-s390@archiver.kernel.org>; Fri, 14 Jul 2023 10:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235764AbjGNKxz (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 14 Jul 2023 06:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235906AbjGNKxy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 14 Jul 2023 06:53:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7ECA30F8
        for <linux-s390@vger.kernel.org>; Fri, 14 Jul 2023 03:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689331984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RHdpOT/q/j3g2ZXTEVHCgPBZy+YbuKzCMJ/tr+CG9fE=;
        b=cFa1q9n5Btn0gqZkMWHSXbUt7/sIyGdrpmNPDexTh39+x41ZVjUC9qE8Q9bzWOeg2XrQQ+
        FD1kBoF8RiVPmnPGDrlcXqXr+eMSeIF9Y9iSveWD7g1ZD5/M1p61BfBzV6VfRRT64F8KzM
        k0Hr31Kh+9BdlMIc0idZIir78eBkj7w=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-0iEm7z-xMlC9NOPzx8TSaw-1; Fri, 14 Jul 2023 06:53:03 -0400
X-MC-Unique: 0iEm7z-xMlC9NOPzx8TSaw-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-635e10763f3so13870796d6.1
        for <linux-s390@vger.kernel.org>; Fri, 14 Jul 2023 03:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689331983; x=1691923983;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RHdpOT/q/j3g2ZXTEVHCgPBZy+YbuKzCMJ/tr+CG9fE=;
        b=JYQX7No7jLtJl9G0yiAoYt6ZLCqXDnCRjQSnjN5e1gu6yCkVgzzvJbkU5gA/BerC8+
         QREzpfU3JuAcNHHtJhVHINX1cFChS8sR7goUd516mpTU1veniOvgHmQAARiWJQCauUKE
         O2EvOZwBUyJiPHP5NvKQPkyBZFyse+fliWIUf9I7akfO+XPcjbfCt/GvRbleekPDfoAi
         lRc2uRtYNIR4NSqw2aGXc3jd7shKrr09laNQNDFBouKsLMyLB6vfpX2aZAYBVycYwQ2O
         fxH/E9H1XHwxRudy1FnVfaJpug7oRYIQukM9Rt2HD3NJIuwhvSFZsFihPpQC54vUA3K8
         IHkQ==
X-Gm-Message-State: ABy/qLaL6XotCB61qVcJ5hDFCGmVpy064byR0nqzzZlgE3vQPrL7JlxA
        W+Le7Xc6YvUXCi45YRrLal3hwL+U48Rg+NweFIhbIWgHvpu3ZNv9Aut+pEySV3a+60lFr7FoG7/
        hEQh0hATHqJvkqWiQcPymTA==
X-Received: by 2002:ad4:4507:0:b0:635:f335:2aa7 with SMTP id k7-20020ad44507000000b00635f3352aa7mr3329463qvu.26.1689331983101;
        Fri, 14 Jul 2023 03:53:03 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH39nBnAYhB/PTimqNPnNptaGgyNdJBGRtIYlkskNKQZTW5HQiX8Vg9aDP1XAmz+JJ59L+9ew==
X-Received: by 2002:ad4:4507:0:b0:635:f335:2aa7 with SMTP id k7-20020ad44507000000b00635f3352aa7mr3329457qvu.26.1689331982831;
        Fri, 14 Jul 2023 03:53:02 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-177-249.web.vodafone.de. [109.43.177.249])
        by smtp.gmail.com with ESMTPSA id w7-20020a0cdf87000000b0063c7037f85fsm372693qvl.73.2023.07.14.03.53.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 03:53:02 -0700 (PDT)
Message-ID: <000b74d7-0b4f-d2b5-81b4-747c99a2df42@redhat.com>
Date:   Fri, 14 Jul 2023 12:52:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [kvm-unit-tests PATCH v5 6/6] s390x: add a test for SIE without
 MSO/MSL
Content-Language: en-US
To:     Nico Boehr <nrb@linux.ibm.com>, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org
References: <20230712114149.1291580-1-nrb@linux.ibm.com>
 <20230712114149.1291580-7-nrb@linux.ibm.com>
 <1aac769e-7523-a858-8286-35625bfb0145@redhat.com>
 <168932372015.12187.10530769865303760697@t14-nrb>
 <fd822214-ce34-41dd-d0b6-d43709803958@redhat.com>
 <168933116940.12187.12275217086609823396@t14-nrb>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <168933116940.12187.12275217086609823396@t14-nrb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 14/07/2023 12.39, Nico Boehr wrote:
> Quoting Thomas Huth (2023-07-14 10:40:28)
>> On 14/07/2023 10.35, Nico Boehr wrote:
>>> Quoting Thomas Huth (2023-07-13 10:29:48)
>>> [...]
>>>>> diff --git a/s390x/sie-dat.c b/s390x/sie-dat.c
>>>>> new file mode 100644
>>>>> index 000000000000..b326995dfa85
>>>>> --- /dev/null
>>>>> +++ b/s390x/sie-dat.c
>>>>> @@ -0,0 +1,115 @@
>>>>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>>>> +/*
>>>>> + * Tests SIE with paging.
>>>>> + *
>>>>> + * Copyright 2023 IBM Corp.
>>>>> + *
>>>>> + * Authors:
>>>>> + *    Nico Boehr <nrb@linux.ibm.com>
>>>>> + */
>>>>> +#include <libcflat.h>
>>>>> +#include <vmalloc.h>
>>>>> +#include <asm/pgtable.h>
>>>>> +#include <mmu.h>
>>>>> +#include <asm/page.h>
>>>>> +#include <asm/interrupt.h>
>>>>> +#include <alloc_page.h>
>>>>> +#include <sclp.h>
>>>>> +#include <sie.h>
>>>>> +#include <snippet.h>
>>>>> +
>>>>> +static struct vm vm;
>>>>> +static pgd_t *guest_root;
>>>>> +
>>>>> +/* keep in sync with TEST_PAGE_COUNT in s390x/snippets/c/sie-dat.c */
>>>>> +#define GUEST_TEST_PAGE_COUNT 10
>>>>> +
>>>>> +/* keep in sync with TOTAL_PAGE_COUNT in s390x/snippets/c/sie-dat.c */
>>>>> +#define GUEST_TOTAL_PAGE_COUNT 256
>>>>
>>>> I'd maybe put the defines rather in a header a la s390x/snippets/c/sie-dat.h
>>>> and include that header here and in the snippet C code.
>>>
>>> I'd have to
>>>
>>> #include "../s390x/snippets/c/sie-dat.h"
>>>
>>> and it feels like I shouldn't be doing this, should I?
>>
>> Why "../s390x/" ? Isn't #include "snippets/c/sie-dat.h" enough? ... that
>> would look reasonable to me.
> 
> No, it isn't at least on my box:
> 
> s390x/snippets/c/sie-dat.c:15:10: fatal error: snippets/c/sie-dat.h: No such file or directory
>     15 | #include "snippets/c/sie-dat.h"
>        |          ^~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.

Maybe add $(SRCDIR)/s390x to INCLUDE_PATHS in the s390x/Makefile ?

  Thomas


