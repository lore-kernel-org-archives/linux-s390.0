Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BA3C433ED
	for <linux-s390@archiver.kernel.org>; Tue, 11 May 2021 15:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BA93616EA
	for <linux-s390@archiver.kernel.org>; Tue, 11 May 2021 15:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbhEKPjR (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 11 May 2021 11:39:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45384 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231835AbhEKPjP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 11 May 2021 11:39:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620747488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lA3YA8wLy3fJ4pK+UdDswwsR291TTeUp7+xqxJEhVYY=;
        b=QejC1jdoj7rk+w0HbzMcaA8qwETHKN+qOQsiz/X2L/UK70Tc5Ga0xRDZflkOelrmqPA4nd
        JsWhF62ep5rpu9aF6kNl4/PdFxaAGi8ZEyDbueE42Qkut7+p9OKNc6eKh/PNX2QyqcHWCW
        26F7XomfsMZrRX8Pa+YZ9HI8EHiRJ/c=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-a4QpbGwcM1ihCT_2gvF22w-1; Tue, 11 May 2021 11:38:07 -0400
X-MC-Unique: a4QpbGwcM1ihCT_2gvF22w-1
Received: by mail-ej1-f71.google.com with SMTP id z6-20020a17090665c6b02903700252d1ccso6095294ejn.10
        for <linux-s390@vger.kernel.org>; Tue, 11 May 2021 08:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=lA3YA8wLy3fJ4pK+UdDswwsR291TTeUp7+xqxJEhVYY=;
        b=YoqzWM9NDUaFacb/nxK7nPDZA6MgmQ1e+JrbWrkz/B0Yq2D1fgCDTNg07BblGs/4/B
         /m7ZN/8fP0uFFEOiuchmDt4zqmFZKZJN1B8Ql9BdKFyrb7ekOvHjQSkspidBMfTljEXn
         kLwmKrkOq+cDJvo0bq9E8GRz9aPczCg0MAR4gDT03oxyPpJ2utQqU93582Cj1f3NhW8g
         6Uyma6AWxJoYFP+M+9c5tnYcYm6aDtLwHVllW8Son1tibUy/vFhGsht3T530S2lkjnfx
         pnuT3LT2QwvVBX0+6euReG4KXRwE+z9Xvcz4FtmU7zPee8ohMmCFzPcxpjufV9tmW0a7
         HVLw==
X-Gm-Message-State: AOAM533YRt0165FK5yrH6dn4e5/eAlX0cGQh5q7haBa7RrKEz23N66e6
        cBsLYDjwjN+7WI3+pipN26qMpE+Ux56eONItdtmRiqJPHZhHrKvc8anlRnyx5/UfYJ846fKxob3
        kIlGD0/8qxZ9o+qagvxQsRw==
X-Received: by 2002:a17:907:f81:: with SMTP id kb1mr32986019ejc.476.1620747485809;
        Tue, 11 May 2021 08:38:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+4xR4cq7DP1xS9MpVHR7xeg5rXqtoQ4ZWLRP0+lX+o33jqwD6v8lig6L4cWx0D+FfjDusqw==
X-Received: by 2002:a17:907:f81:: with SMTP id kb1mr32985989ejc.476.1620747485534;
        Tue, 11 May 2021 08:38:05 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6329.dip0.t-ipconnect.de. [91.12.99.41])
        by smtp.gmail.com with ESMTPSA id p2sm11700066ejo.108.2021.05.11.08.38.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 May 2021 08:38:05 -0700 (PDT)
Subject: Re: [kvm-unit-tests PATCH 2/4] lib: s390x: sclp: Extend feature
 probing
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org,
        cohuck@redhat.com, linux-s390@vger.kernel.org, thuth@redhat.com
References: <20210510150015.11119-1-frankja@linux.ibm.com>
 <20210510150015.11119-3-frankja@linux.ibm.com>
 <b0db681f-bfe3-5cf3-53f8-651bba04a5c5@redhat.com>
 <20210511164137.0bba2493@ibm-vm>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <2f0284e1-b1e0-39d6-1fe0-3be808be1849@redhat.com>
Date:   Tue, 11 May 2021 17:38:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210511164137.0bba2493@ibm-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 11.05.21 16:41, Claudio Imbrenda wrote:
> On Tue, 11 May 2021 13:43:36 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> On 10.05.21 17:00, Janosch Frank wrote:
>>> Lets grab more of the feature bits from SCLP read info so we can use
>>> them in the cpumodel tests.
>>>
>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
>>> ---
>>>    lib/s390x/sclp.c | 20 ++++++++++++++++++++
>>>    lib/s390x/sclp.h | 38 +++++++++++++++++++++++++++++++++++---
>>>    2 files changed, 55 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/lib/s390x/sclp.c b/lib/s390x/sclp.c
>>> index f11c2035..f25cfdb2 100644
>>> --- a/lib/s390x/sclp.c
>>> +++ b/lib/s390x/sclp.c
>>> @@ -129,6 +129,13 @@ CPUEntry *sclp_get_cpu_entries(void)
>>>    	return (CPUEntry *)(_read_info + read_info->offset_cpu);
>>>    }
>>>    
>>> +static bool sclp_feat_check(int byte, int mask)
>>> +{
>>> +	uint8_t *rib = (uint8_t *)read_info;
>>> +
>>> +	return !!(rib[byte] & mask);
>>> +}
>>
>> Instead of a mask, I'd just check for bit (offset) numbers within the
>> byte.
>>
>> static bool sclp_feat_check(int byte, int bit)
>> {
>> 	uint8_t *rib = (uint8_t *)read_info;
>>
>> 	return !!(rib[byte] & (0x80 >> bit));
>> }
> 
> using a mask might be useful to check multiple facilities at the same
> time, but in that case the check should be

IMHO checking with a mask here multiple facilities will be very error 
prone either way ... and we only have a single byte to check for.


-- 
Thanks,

David / dhildenb

