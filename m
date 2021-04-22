Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFB6C433B4
	for <linux-s390@archiver.kernel.org>; Thu, 22 Apr 2021 09:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FCB5613DB
	for <linux-s390@archiver.kernel.org>; Thu, 22 Apr 2021 09:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235555AbhDVJiW (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 22 Apr 2021 05:38:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21701 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230285AbhDVJiV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 22 Apr 2021 05:38:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619084267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=92nwvpG04WD4NVWeRes937L3vx8UtkIYushEuYfIPR4=;
        b=got1PIvyyIz1UX/db7HdRbCUmhb0JjTXIrDQKASa4L5IQ3SYyJPB2ABHjL21FeXfJLcbXj
        CHFu/NO7MgFpivk3NG8SfEtgWA16EL2x6COWUWo0N8J1Qiu5kP0/lNfyyaHLkyhIQG+Esy
        rmlIQ6d/aT4f3jeJR5051B0sKD2z5qY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-551-n7w-X-0NOYibU3-9VgFE1g-1; Thu, 22 Apr 2021 05:37:08 -0400
X-MC-Unique: n7w-X-0NOYibU3-9VgFE1g-1
Received: by mail-wr1-f70.google.com with SMTP id y13-20020adfdf0d0000b02901029a3bf796so13578745wrl.15
        for <linux-s390@vger.kernel.org>; Thu, 22 Apr 2021 02:37:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=92nwvpG04WD4NVWeRes937L3vx8UtkIYushEuYfIPR4=;
        b=ZYxcW2fP390zRqTfX1ou5Z5xshB7HTQk709FSMYhAAN6v8iWVrGDomzziIoqRNrKjs
         ZhEg2DDOMEhPLeajPLNOZeOLU0W1AZE9sR4XKoTP5bopPgJnlD9B6CJvjf0fCztGW8mq
         6/VJtm6jln2qZSo1K+f+inZkbe3L8VzvdfQ/K78+r0QhzehlKVkbftBUABc/YlrP9okl
         rZrNDNAjsgDPToid73WuMW4UZO6AXPpz3n94Cncl+hvR3flJvPssgAb61SJOvfkSfRD+
         12aNR99w/J1eG/oxgYQ0oIbDxZAQ/XgCFPqujLHla9o7LOzGewhozn1/Ao37p3plm4+C
         IqJw==
X-Gm-Message-State: AOAM533JbLg/yRe4B3y87ii8etmRHyBwsYlYBc16XSbDMGp0yANPqA07
        LETDT/DLEHPRm73fpXaNE77iHy3I39GUk0jSnZmO5SWyrjUkvgByAVrSfc6GaKGqW/wZw8Upeor
        zJmvWX87FzlpESVUC61TpvA==
X-Received: by 2002:adf:a1db:: with SMTP id v27mr3000390wrv.181.1619084227659;
        Thu, 22 Apr 2021 02:37:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw6+utQiD61Y5IOvGNjyr/njut4uxGj5SoOGPkTc18xAOAUfRtrcCKozUOITQtMMUbmwvIlQw==
X-Received: by 2002:adf:a1db:: with SMTP id v27mr3000369wrv.181.1619084227488;
        Thu, 22 Apr 2021 02:37:07 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23eb0.dip0.t-ipconnect.de. [79.242.62.176])
        by smtp.gmail.com with ESMTPSA id c1sm2569703wrx.89.2021.04.22.02.37.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 02:37:07 -0700 (PDT)
To:     "lipeifeng@oppo.com" <lipeifeng@oppo.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        peifengl55 <peifengl55@gmail.com>,
        schwidefsky <schwidefsky@de.ibm.com>,
        "heiko.carstens" <heiko.carstens@de.ibm.com>
Cc:     linux-s390 <linux-s390@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        zhangshiming <zhangshiming@oppo.com>,
        guoweichao <guoweichao@oppo.com>,
        zhouhuacai <zhouhuacai@oppo.com>
References: <20210414023803.937-1-lipeifeng@oppo.com>
 <a7bb16c0-31b2-6aa5-2186-8c957955649e@suse.cz>
 <2021041910374593320011@oppo.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC] mm: support multi_freearea to the reduction of external
 fragmentation
Message-ID: <0585db50-e8d5-e6d8-9d41-fc398f292d91@redhat.com>
Date:   Thu, 22 Apr 2021 11:37:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <2021041910374593320011@oppo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 19.04.21 04:37, lipeifeng@oppo.com wrote:
> Hi Vlastimil Babka:
> Thank you very much indeed for your advice.
> 
> 
> Hi Vlastimil Babka, schwidefsky,heiko.carstens:
> 
> It is a temporary patch to consult experts:
> Is it possible to merge the optimization idea and the implementation
> method to the baseline?

Well, we cannot really say that :)

History taught that merging large and invasive buddy changes is a 
tedious task, can take a long time, and can fail even after a lot of 
discussions and patch series.

Further, usually there has to be a very compelling reason to merge 
large, invasive buddy changes (read: not only optimize very specific 
scenarios); otherwise there will just push back because the invasive 
changes might introduce additional problems or degrade other special 
cases or even the general case.

Last but not least, there have to be more benchmarks and test cases that 
proof that other workload won't be degraded to a degree that people 
care; as one example, this includes runtime overhead when 
allocating/freeing pages.

What usually works best is improving the code in small steps, doing 
minor adjustments but moving into the desired direction.

-- 
Thanks,

David / dhildenb

