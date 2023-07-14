Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47B5EB64DA
	for <linux-s390@archiver.kernel.org>; Fri, 14 Jul 2023 08:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235403AbjGNIld (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 14 Jul 2023 04:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233172AbjGNIl0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 14 Jul 2023 04:41:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41926A7
        for <linux-s390@vger.kernel.org>; Fri, 14 Jul 2023 01:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689324037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F/KmbwnX7NVY1zqVVU7jiAJ2hZEsMsYigvpdfYup594=;
        b=Iug/Ue4GZe7Gj6w1+eYZp4aVTfvOZHbCJa6HCjVlOjmoWA9RIEsl6MkUBBh3Hd5yL3m+Ta
        Hnn9n4x4DK5xB6txolzD6yYS9NssDZqNffHSjhxrl4C8O1ng1dLIURvP3A9CCUw7gw3YML
        gqVrmJeYUjuPAoaDFwObuxpZIwPFZsQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-dbTKsOIfM56oG0cTaQqfdQ-1; Fri, 14 Jul 2023 04:40:35 -0400
X-MC-Unique: dbTKsOIfM56oG0cTaQqfdQ-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7656c94fc4eso210589185a.2
        for <linux-s390@vger.kernel.org>; Fri, 14 Jul 2023 01:40:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689324035; x=1691916035;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F/KmbwnX7NVY1zqVVU7jiAJ2hZEsMsYigvpdfYup594=;
        b=axGRIjw5Sn/RZCld5AgNz6UUTzgLZsfHCQ3+lMYcoslVbXQcvgISse+vvedLQKxUvJ
         hvqM5Z0pT4Nj3CE6lzzTvG+TkFmO+vOCVLBgzwBnt469S1Ib9ukKOhQ9gH4z7wsIpw0o
         uMbDgjhMBuMfl+1fX9aV2RCE1PPeZgWem8/MzZbNHHbUMXLXBUkTBB8seu6QuKJEEGyP
         8r0O7pabB8qIRE+4xBzDdslpuVWlTUJy2a+L9wpSd3Q/O0I5pcgTew578it5UlIwXFOu
         mrQh4oqdRLIrFNJu2JCjIxDznM8hBnsoUyzEVjVmNOzZWsmlXqSeF3eCYnBSNoejiu+t
         0uJg==
X-Gm-Message-State: ABy/qLb+DxX5ocg/3QbcthsQCo9pydsag3P/pJKcXHbuIxohRO6laB1U
        dXPauALlxx2MIjrSVQG0V0Ko+P2DMTpd5+dKYG+SxmXVARm8bpbCb7W2TR4qpjX1I+1iueZEg4T
        sp+soV10IcULpOUHiGAss2g==
X-Received: by 2002:a05:620a:17a6:b0:768:75c:a323 with SMTP id ay38-20020a05620a17a600b00768075ca323mr565987qkb.30.1689324035304;
        Fri, 14 Jul 2023 01:40:35 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEgmtTUCwZm2WZZc0jcBtZlr5BseMuc6KO7LOvD7/6BapD0snfeJ+d7X9tS+NnZ1fYp0beiwA==
X-Received: by 2002:a05:620a:17a6:b0:768:75c:a323 with SMTP id ay38-20020a05620a17a600b00768075ca323mr565977qkb.30.1689324035087;
        Fri, 14 Jul 2023 01:40:35 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-177-249.web.vodafone.de. [109.43.177.249])
        by smtp.gmail.com with ESMTPSA id f23-20020a05620a069700b00767d4c68725sm3562612qkh.133.2023.07.14.01.40.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 01:40:34 -0700 (PDT)
Message-ID: <fd822214-ce34-41dd-d0b6-d43709803958@redhat.com>
Date:   Fri, 14 Jul 2023 10:40:28 +0200
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
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <168932372015.12187.10530769865303760697@t14-nrb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 14/07/2023 10.35, Nico Boehr wrote:
> Quoting Thomas Huth (2023-07-13 10:29:48)
> [...]
>>> diff --git a/s390x/sie-dat.c b/s390x/sie-dat.c
>>> new file mode 100644
>>> index 000000000000..b326995dfa85
>>> --- /dev/null
>>> +++ b/s390x/sie-dat.c
>>> @@ -0,0 +1,115 @@
>>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>> +/*
>>> + * Tests SIE with paging.
>>> + *
>>> + * Copyright 2023 IBM Corp.
>>> + *
>>> + * Authors:
>>> + *    Nico Boehr <nrb@linux.ibm.com>
>>> + */
>>> +#include <libcflat.h>
>>> +#include <vmalloc.h>
>>> +#include <asm/pgtable.h>
>>> +#include <mmu.h>
>>> +#include <asm/page.h>
>>> +#include <asm/interrupt.h>
>>> +#include <alloc_page.h>
>>> +#include <sclp.h>
>>> +#include <sie.h>
>>> +#include <snippet.h>
>>> +
>>> +static struct vm vm;
>>> +static pgd_t *guest_root;
>>> +
>>> +/* keep in sync with TEST_PAGE_COUNT in s390x/snippets/c/sie-dat.c */
>>> +#define GUEST_TEST_PAGE_COUNT 10
>>> +
>>> +/* keep in sync with TOTAL_PAGE_COUNT in s390x/snippets/c/sie-dat.c */
>>> +#define GUEST_TOTAL_PAGE_COUNT 256
>>
>> I'd maybe put the defines rather in a header a la s390x/snippets/c/sie-dat.h
>> and include that header here and in the snippet C code.
> 
> I'd have to
> 
> #include "../s390x/snippets/c/sie-dat.h"
> 
> and it feels like I shouldn't be doing this, should I?

Why "../s390x/" ? Isn't #include "snippets/c/sie-dat.h" enough? ... that 
would look reasonable to me.

  Thomas

