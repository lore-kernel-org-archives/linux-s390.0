Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35487C197A0
	for <linux-s390@archiver.kernel.org>; Fri, 17 Nov 2023 15:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbjKQPiD (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 17 Nov 2023 10:38:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbjKQPiC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 17 Nov 2023 10:38:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E75D73
        for <linux-s390@vger.kernel.org>; Fri, 17 Nov 2023 07:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700235474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=fweTSD3me3Mx8GyQIQZU14sJeAzjgkPwJ7KyqiFU4BQ=;
        b=A6+QOV28p073u7cAcu6x4pwZsD4bPDUdp1pSzacr1JP4B2s2XgbDZRrCiKj0/MoYxebBoV
        4pBrVHgG+D0L24B9azFjXTrRginjVXCMsm0RsFCOVg7Hu/zn1YTE2CboyIMGBIPVIkt51n
        pSHb+/GtjaAlgoXTWQjpuc8oJ0LzKCI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-L7t_yeiXM8-cYlff2F1VDQ-1; Fri, 17 Nov 2023 10:37:52 -0500
X-MC-Unique: L7t_yeiXM8-cYlff2F1VDQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-408f9e9e9b0so12122965e9.2
        for <linux-s390@vger.kernel.org>; Fri, 17 Nov 2023 07:37:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700235471; x=1700840271;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fweTSD3me3Mx8GyQIQZU14sJeAzjgkPwJ7KyqiFU4BQ=;
        b=Sfheqa9bIKFJln8+el2ewPDGSV/KvtI6Cf2uqgclPGIH6QyHPLWM1mJi2xdRLgriY3
         agAMhcxh42k9FIE+p2tzZQ2nG7uRkR7FzK149xBkwdMXjyppRR16fL+ePhUZg0pDLTT/
         Zxgu5msSAuW/XP87ht7RcpnbNpAfpsNePiCSfc9KEScqRAe8czcV1/muc5LWojtOlioR
         rwDrR0fw4E9HPbtolcLCAIfBZeuIYwmMDSazenwXeP46KQbi3IVakrEf6m3hkD5GjeGx
         T9dIa30ga1ke3RJyaOojk/F2TQ37tpsNdCEGrznD8AsCj0SNcsbwKELd/d9CKJv+tOhm
         uMfg==
X-Gm-Message-State: AOJu0YwRM7GgK+UgIdboFHB1o/8K/Z9hdG8csA7K6MjT2eKxc5/PzqD8
        7DpnkbGKEAsJoJeR0dwdv84cj44spxazA/2dRKVEI4XZzN7ZMbe+EXtDRJyVIfZiGBQQCeyrdL6
        y39uvORku5iPHHq2xbelwHw==
X-Received: by 2002:a05:600c:2e4c:b0:408:3f87:cba with SMTP id q12-20020a05600c2e4c00b004083f870cbamr15450233wmf.39.1700235471093;
        Fri, 17 Nov 2023 07:37:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFXiSLvfsFsx2ecWHmPMg5XOcGZDFC3T/0kLsJ3TJWJXg6BmsCf7Un0EtNCoPcc+mfW8Jei1A==
X-Received: by 2002:a05:600c:2e4c:b0:408:3f87:cba with SMTP id q12-20020a05600c2e4c00b004083f870cbamr15450212wmf.39.1700235470731;
        Fri, 17 Nov 2023 07:37:50 -0800 (PST)
Received: from [192.168.3.108] (p4ff23170.dip0.t-ipconnect.de. [79.242.49.112])
        by smtp.gmail.com with ESMTPSA id z16-20020a05600c221000b0040472ad9a3dsm3084684wml.14.2023.11.17.07.37.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 07:37:50 -0800 (PST)
Message-ID: <57762a6b-24c1-44a7-b1f3-4e73fe3b963d@redhat.com>
Date:   Fri, 17 Nov 2023 16:37:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] implement "memmap on memory" feature on s390
Content-Language: en-US
To:     Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc:     linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20231114180238.1522782-1-sumanthk@linux.ibm.com>
 <ec3fcd7d-17a0-4901-9261-a204c2c50c52@redhat.com>
 <ZVdxInFyS8YtNOjF@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZVdxInFyS8YtNOjF@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 17.11.23 14:56, Sumanth Korikkar wrote:
> On Fri, Nov 17, 2023 at 12:08:31AM +0100, David Hildenbrand wrote:
>> On 14.11.23 19:02, Sumanth Korikkar wrote:
>>> Hi All,
>>>
>>> The patch series implements "memmap on memory" feature on s390 and
>>> provides the necessary fixes for it.
>>
>> Thinking about this, one thing that makes s390x different from all the other
>> architectures in this series is the altmap handling.
>>
>> I'm curious, why is that even required?
>>
>> A memmep that is not marked as online in the section should not be touched
>> by anybody (except memory onlining code :) ). And if we do, it's usually a
>> BUG because that memmap might contain garbage/be poisoned or completely
>> stale, so we might want to track that down and fix it in any case.
>>
>> So what speaks against just leaving add_memory() populate the memmap from
>> the altmap? Then, also the page tables for the memmap are already in place
>> when onlining memory.
>>
> 
> we do have page_init_poison() in sparse_add_section() which should be
> handled later then. not in add_pages()

Was that all, or did you stumble over other things?

-- 
Cheers,

David / dhildenb

