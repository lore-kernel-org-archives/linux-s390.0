Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42CFC433EF
	for <linux-s390@archiver.kernel.org>; Fri, 28 Jan 2022 09:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243616AbiA1J3t (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 28 Jan 2022 04:29:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:54186 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238330AbiA1J3s (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 28 Jan 2022 04:29:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643362188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BSmTf0PkmpxzGEv7CGniywGpBZgb3L46QMufpkSTzAE=;
        b=XaEJPWWYWTzYJuVgxQouTBolZFIWygn2ENShyzmNBVHXjMdMXTtQ8l+3EvV9O+p01T1PNH
        qEOwME8BjL4H1d0hlr3pi03V4SS0q/BvsoMwmly925p2xvZ+OZ9F71OFtPlSpuLAI2OgjS
        tbJ+//Zj/1Ru1x64X/iX1UjtZxXfwbQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-435-jmOvtZ2PMxib1iwovs0htQ-1; Fri, 28 Jan 2022 04:29:46 -0500
X-MC-Unique: jmOvtZ2PMxib1iwovs0htQ-1
Received: by mail-wm1-f72.google.com with SMTP id d140-20020a1c1d92000000b0034edefd55caso5607029wmd.4
        for <linux-s390@vger.kernel.org>; Fri, 28 Jan 2022 01:29:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BSmTf0PkmpxzGEv7CGniywGpBZgb3L46QMufpkSTzAE=;
        b=5zweOU4iM9AI2+B93ukWaIWYzRLzY8hIUaWBZOczGDSrlOMRA/LfHXP76D81hzC7Pm
         7YEqtXn4c4YsT7m4ZroCsBepSD/y7OrABOmhIW5gH/kFXCvmYoKOQcAhp99NT+l90QON
         nGF92+suS7Gv05ueu98q22NytZFwxn8684PrfP1jrt3M9v/+NQsWvRh7Z74KgKI6XMbt
         GgEsw+I+0MveozVczd/qru1G+ZAR7AK/J/hlho7xms+rTmGXojDVL/yn0X8DkOAK0EmA
         GwcyUDYL1eRhJNz0e6IIaVY70kdoscEmTEMjQtc9pKi/VwxqecruBVOm+E5pqNEPRqyy
         lWfg==
X-Gm-Message-State: AOAM531DveJMyLV66vEgKznuFAQqbvT1jAJ+fXzTJYiMU0UST5cQw7lJ
        +Catg6yRsaRu9apL3y5K9izOcrPmw/CPFdNEY5E5g+M9gWzmtUXwSGcVLfVb3ziE+7rxj+oeahK
        pilUeo+kCn4QCWPc/la7P+g==
X-Received: by 2002:adf:e48c:: with SMTP id i12mr6110312wrm.259.1643362184915;
        Fri, 28 Jan 2022 01:29:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxV+j5LuE+DLltcMeXQOl3t1Zlx784R3ML4MFC5Sqt+lzK8ni9wRGuIQQq6UqhnqGKFGlTSBA==
X-Received: by 2002:adf:e48c:: with SMTP id i12mr6110297wrm.259.1643362184725;
        Fri, 28 Jan 2022 01:29:44 -0800 (PST)
Received: from [192.168.8.100] (tmo-096-196.customers.d1-online.com. [80.187.96.196])
        by smtp.gmail.com with ESMTPSA id r7sm1515202wma.39.2022.01.28.01.29.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jan 2022 01:29:44 -0800 (PST)
Message-ID: <5ba3d0d1-ca47-2511-9e7d-2d0da26aa179@redhat.com>
Date:   Fri, 28 Jan 2022 10:29:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [kvm-unit-tests PATCH 1/4] s390x: uv-host: Add attestation test
Content-Language: en-US
To:     Janosch Frank <frankja@linux.ibm.com>,
        Steffen Eiden <seiden@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org
References: <20220127141559.35250-1-seiden@linux.ibm.com>
 <20220127141559.35250-2-seiden@linux.ibm.com>
 <a11c343b-16e6-727c-dbec-1edfe5375fcf@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <a11c343b-16e6-727c-dbec-1edfe5375fcf@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 28/01/2022 10.00, Janosch Frank wrote:
> On 1/27/22 15:15, Steffen Eiden wrote:
>> Adds an invalid command test for attestation in the uv-host.
>>
>> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> 
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
> 
>> ---
>>   lib/s390x/asm/uv.h | 24 +++++++++++++++++++++++-
>>   s390x/uv-host.c    |  3 ++-
>>   2 files changed, 25 insertions(+), 2 deletions(-)
>>
>> diff --git a/lib/s390x/asm/uv.h b/lib/s390x/asm/uv.h
>> index 97c90e81..38c322bf 100644
>> --- a/lib/s390x/asm/uv.h
>> +++ b/lib/s390x/asm/uv.h
>> @@ -1,10 +1,11 @@
>>   /*
>>    * s390x Ultravisor related definitions
>>    *
>> - * Copyright (c) 2020 IBM Corp
>> + * Copyright (c) 2020, 2022 IBM Corp
> 
> I'm not sure when we actually need/want to update this.

IANAL, but IIRC you can add/update the second year in the copyright 
statement if there has been a major change to the file in that year, so that 
should be fine. Not sure whether you still need the "(c)" these days, though.

  Thomas

