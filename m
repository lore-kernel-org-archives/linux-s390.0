Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E01BC0015E
	for <linux-s390@archiver.kernel.org>; Tue, 15 Aug 2023 14:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237466AbjHOOJP (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 15 Aug 2023 10:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237502AbjHOOIo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 15 Aug 2023 10:08:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B933199B
        for <linux-s390@vger.kernel.org>; Tue, 15 Aug 2023 07:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692108477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g0ud9ITO1ZEXvHWeeknbA+wMUjqz5W6XeOhuU+ePqbs=;
        b=gVUbg1degcLQ9uVvaoeb7cwtCOwbCcAiOTTL2jITENonvC0+kLJHS942EqAdmrfDtGivXi
        gZyMVw7Bk6aU0/USsB5Pxyc7i7tOZNP4uVCM6bfRTB6IeITKNEHu0XHwiZXAC537BnzP0w
        ZpgjBukVcI0PxOLoO6PLezcw9VRLiEI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-5D5GWA2OO4ybP47fTzW-tQ-1; Tue, 15 Aug 2023 10:07:56 -0400
X-MC-Unique: 5D5GWA2OO4ybP47fTzW-tQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f42bcef2acso33403235e9.2
        for <linux-s390@vger.kernel.org>; Tue, 15 Aug 2023 07:07:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692108474; x=1692713274;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g0ud9ITO1ZEXvHWeeknbA+wMUjqz5W6XeOhuU+ePqbs=;
        b=CaS70HITQein2QFN5nEu3DR1GiF8PeL68Fw531Fz5D7K+XY+XOOAlFBZw4iqeuCaT6
         0tplb/7fY6iClEJWNY3IWKpjqILPG4oBCfOmN25EHMlssw8KmSmK7PsEoXm19x1C1j3v
         IS25toeCFkhEKcajTOHa6GcWwr6SXffMVxxFxOZSFTczIq+Jdl/AY+u6JqgbLKySa9pt
         CJJEY4hBoNUFWnYJeRfaWX8phCdCsts+4C7cx2ogbHwmIESYJM4xKUobi2I2zQI4T5K5
         axKCnTyMbHJMbVW9jlEW4dEX6kONDozSXRFsw3agK7nSLgBVDqD45VmdLHdX8sPF7FLL
         rn1A==
X-Gm-Message-State: AOJu0YxJ1asNVS/svR7VAQshWuDlqOUVGzK6AbHIbJS9XKVnF8pJJq1L
        98XCGyKkmMeVZrtiRmB7HTQnXCnJhEpcSHbUmUB7ycu3F12VxXcNpJ/BxrtjWqZNX02pBrRhS8P
        +LudTWQs0VakqGjbYvYvBQQ==
X-Received: by 2002:a7b:c4d7:0:b0:3fe:1db2:5179 with SMTP id g23-20020a7bc4d7000000b003fe1db25179mr10563881wmk.19.1692108473982;
        Tue, 15 Aug 2023 07:07:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhWnL9nlm+m1nVt+Nniw6twZtB0zoqSzUtdSSCWEkkLEVm5X76D6NkyIKxY2FCMi+v9zbSKg==
X-Received: by 2002:a7b:c4d7:0:b0:3fe:1db2:5179 with SMTP id g23-20020a7bc4d7000000b003fe1db25179mr10563862wmk.19.1692108473708;
        Tue, 15 Aug 2023 07:07:53 -0700 (PDT)
Received: from [192.168.8.105] (dynamic-046-114-247-132.46.114.pool.telefonica.de. [46.114.247.132])
        by smtp.gmail.com with ESMTPSA id l6-20020adff486000000b003143867d2ebsm18062361wro.63.2023.08.15.07.07.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 07:07:53 -0700 (PDT)
Message-ID: <02b01a3a-368a-c7f5-1f9a-fc3139078109@redhat.com>
Date:   Tue, 15 Aug 2023 16:07:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [kvm-unit-tests PATCH v5 6/6] s390x: add a test for SIE without
 MSO/MSL
To:     Janosch Frank <frankja@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>, imbrenda@linux.ibm.com
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        David Hildenbrand <dhildenb@redhat.com>
References: <20230712114149.1291580-1-nrb@linux.ibm.com>
 <20230712114149.1291580-7-nrb@linux.ibm.com>
 <1aac769e-7523-a858-8286-35625bfb0145@redhat.com>
 <168932372015.12187.10530769865303760697@t14-nrb>
 <fd822214-ce34-41dd-d0b6-d43709803958@redhat.com>
 <168933116940.12187.12275217086609823396@t14-nrb>
 <000b74d7-0b4f-d2b5-81b4-747c99a2df42@redhat.com>
 <169087269702.10672.8933292419680416340@t14-nrb>
 <0fc509e0-7c58-fc97-45bc-319d126417c2@redhat.com>
 <6815b8a5-c501-9d76-7032-1b388ed75669@linux.ibm.com>
Content-Language: en-US
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <6815b8a5-c501-9d76-7032-1b388ed75669@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 15/08/2023 13.30, Janosch Frank wrote:
> On 8/14/23 16:59, Thomas Huth wrote:
>> On 01/08/2023 08.51, Nico Boehr wrote:
>>> Quoting Thomas Huth (2023-07-14 12:52:59)
>>> [...]
>>>> Maybe add $(SRCDIR)/s390x to INCLUDE_PATHS in the s390x/Makefile ?
>>>
>>> Yeah, that would work, but do we want that? I'd assume that it is a
>>> concious decision not to have tests depend on one another.
>>
>> IMHO this would still be OK ... Janosch, Claudio, what's your opinion on 
>> this?
> 
> And the headers are then ONLY available via snippets/* ?
> Pardon my question, not enough cycles, too much work.

No, it's about being able to #include "snippets/c/sie-dat.h" from 
s390x/sie-dat.c, so that guest and host code can share some #defines.

  Thomas

