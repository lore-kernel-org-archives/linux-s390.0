Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF41C433EF
	for <linux-s390@archiver.kernel.org>; Wed, 18 May 2022 14:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238662AbiEROd7 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 18 May 2022 10:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238655AbiEROd6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 18 May 2022 10:33:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 38E2D1ACF86
        for <linux-s390@vger.kernel.org>; Wed, 18 May 2022 07:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652884436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S0qz9PSvGbMs60yKx28nBLXwqA08nBMklYt7Mvsb4Pk=;
        b=JlJOFk8Utvno2ggT67gfHhqEvb6f0WOyEhs4ylgtyaii8xWhbZ+jixQxcFdUsMKubP3X9G
        1uvBbsZtcTA+7Y4ZxNjTgz00mO7c4aFRhlPPX2RnheHNryeEyq3lLHhO1XdRpHV3R6qQVJ
        LQJ74Ngxy27lvFZfIOpcb9OSxQjzrLA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-616-bp-2V9vpMJmTnJeUQtGCuw-1; Wed, 18 May 2022 10:33:55 -0400
X-MC-Unique: bp-2V9vpMJmTnJeUQtGCuw-1
Received: by mail-ed1-f70.google.com with SMTP id q12-20020a056402040c00b0042a84f9939dso1756760edv.7
        for <linux-s390@vger.kernel.org>; Wed, 18 May 2022 07:33:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=S0qz9PSvGbMs60yKx28nBLXwqA08nBMklYt7Mvsb4Pk=;
        b=l3AFoUlwxT2gXKClo61BeOepvzzUggezlWHmOIDEWSkhI5UIt51RDqW6xyRQCO32LR
         PUickl3M1E+9/w6wHiqV8n3xmrQhWwoqgcTcQRIT9b1Puw+qNGeUcNFgP7gms5Lya+93
         UNXxk1YcnNZfPjSYHotgvtLszzxld0geAPkbiwB2UBSPCPox1x/ePgHltpmHXNm03B7a
         2JmKfTaYlbEQwiSn5wv5aFII1I1JKPSSxp7CeBY/gSb1BwGyil4hyW2+t2F1599sJnpO
         Dz8KCt1VhT3pUybENAK9cQAQrodpwgYT7J5ZT56sItFKnUfGR0n3jYqANZ/D4sCZgpbX
         OiPQ==
X-Gm-Message-State: AOAM532msY0EzVge2mr7dP4AVzXiciPGvUqFMfUd/XbF2biMD31BkwDz
        erQI8bRTlw3oTso9Y5LAjtHLD64eOnDizjZ+7ngXJ0zYBFyqHkUsBZyFrfmDmu/pMtnMmx147Rv
        WClfwqBDcIhNjYAKjD07uUw==
X-Received: by 2002:a05:6402:348c:b0:42a:e4e5:c63a with SMTP id v12-20020a056402348c00b0042ae4e5c63amr4607332edc.419.1652884433862;
        Wed, 18 May 2022 07:33:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx5Uure55BHoOkTp7UVKFreQZ5rHKj7fvnOcH/AKP9Y2Tq1lVxIdQXxgxNVGpBLQ6V8bwpceQ==
X-Received: by 2002:a05:6402:348c:b0:42a:e4e5:c63a with SMTP id v12-20020a056402348c00b0042ae4e5c63amr4607302edc.419.1652884433583;
        Wed, 18 May 2022 07:33:53 -0700 (PDT)
Received: from [172.29.4.249] ([45.90.93.190])
        by smtp.gmail.com with ESMTPSA id k23-20020aa7d8d7000000b0042aa153e73esm1440476eds.12.2022.05.18.07.33.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 07:33:53 -0700 (PDT)
Message-ID: <cfe448f7-0b4e-680d-46a7-33ad25a4c09b@redhat.com>
Date:   Wed, 18 May 2022 16:33:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v9 3/3] s390x: KVM: resetting the Topology-Change-Report
Content-Language: en-US
To:     Pierre Morel <pmorel@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, cohuck@redhat.com, thuth@redhat.com,
        hca@linux.ibm.com, gor@linux.ibm.com, wintera@linux.ibm.com,
        seiden@linux.ibm.com, nrb@linux.ibm.com
References: <20220506092403.47406-1-pmorel@linux.ibm.com>
 <20220506092403.47406-4-pmorel@linux.ibm.com>
 <76fd0c11-5b9b-0032-183b-54db650f13b1@redhat.com>
 <20220512115250.2e20bfdf@p-imbrenda>
 <70a7d93c-c1b1-fa72-0eb4-02e3e2235f94@redhat.com>
 <bae4e416-b0e9-31c6-c9d0-df6b5a5fd46f@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <bae4e416-b0e9-31c6-c9d0-df6b5a5fd46f@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 16.05.22 16:21, Pierre Morel wrote:
> 
> 
> On 5/12/22 12:01, David Hildenbrand wrote:
>>>>
>>>> I think we prefer something like u16 when copying to user space.
>>>
>>> but then userspace also has to expect a u16, right?
>>
>> Yep.
>>
> 
> Yes but in fact, inspired by previous discussion I had on the VFIO 
> interface, that is the reason why I did prefer an int.
> It is much simpler than a u16 and the definition of a bit.
> 
> Despite a bit in a u16 is what the s3990 achitecture proposes I thought 
> we could make it easier on the KVM/QEMU interface.
> 
> But if the discussion stops here, I will do as you both propose change 
> to u16 in KVM and userland and add the documentation for the interface.

In general, we pass via the ABI fixed-sized values -- u8, u16, u32, u64
... instead of int. Simply because sizeof(int) is in theory variable
(e.g., 32bit vs 64bit).

Take a look at arch/s390/include/uapi/asm/kvm.h and you won't find any
usage of int or bool.

Having that said, I'll let the maintainers decide. Using e.g., u8 is
just the natural thing to do on a Linux ABI, but we don't really support
32 bit ... maybe we'll support 128bit at one point? ;)

-- 
Thanks,

David / dhildenb

