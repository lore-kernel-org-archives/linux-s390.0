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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E644C433B4
	for <linux-s390@archiver.kernel.org>; Tue, 11 May 2021 11:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 421896192A
	for <linux-s390@archiver.kernel.org>; Tue, 11 May 2021 11:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbhEKLlK (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 11 May 2021 07:41:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46708 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231419AbhEKLlH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 11 May 2021 07:41:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620733201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yjB7dqXnO7Oz56DntzKqDo8+xChSMWY5z8HK6XFxLuk=;
        b=g90efToIPIDm0m3thXnBEhMe8weMkRl3ZE507fNMLAOBVbFRSJjIDHUapugZ4Fy2qzv3Zn
        JdANTFzanuWGc6bJNIYIhXGooUWbP+5OQ9kryylX2aR2fklTa3UeRnHmSLaqTRG5OaCjNb
        BYueZH4oen+koZ2hNW/pylaDeG5qgyk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-JLZSWdEiNP6l64ErKske0w-1; Tue, 11 May 2021 07:39:59 -0400
X-MC-Unique: JLZSWdEiNP6l64ErKske0w-1
Received: by mail-wm1-f70.google.com with SMTP id b16-20020a7bc2500000b029014587f5376dso341172wmj.1
        for <linux-s390@vger.kernel.org>; Tue, 11 May 2021 04:39:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=yjB7dqXnO7Oz56DntzKqDo8+xChSMWY5z8HK6XFxLuk=;
        b=d0KM/MbA1BAcpyD74Eyti2Yq3yqZ+tBAq2cBHCW+K0sdKHjVh1oxE7KfSFn2OvjVmE
         cVC4S9F7RpqQwm9TM6V44JGfvpOnxSDnBWyxlPumZDrOJxmtDXwTWvFv1IwUHuMGJdEQ
         uJ7yP6TOHgZAjYB7uHkpGE3hoEAmQzJm/ZeeaCOqynkN373BwZJN1EmgiC2vV0/4A6TQ
         KIMWThXJB5xvJdRwLaUeJBky5/WfeLFREOTe49+9e7mIWjZXSwsaY8Sh1UBOqSMCZiEk
         h0H5f2E+Ik2l1d0NMwL7qGWst3xVNRuzeHLBGadJwQ+V/4Pm1EdVSf9aO0Uy5tsd2ZrI
         EyRA==
X-Gm-Message-State: AOAM531T1DOh7ejjvh+Cjl7d9f7j4zB37cjM6kS9dogqcS0cji5DqZZR
        Nw59cpeNi5fS9UbIBnd/MSNEZbJaGKkXZ5i+zKgm1XLcv4mbXDpB66tV+viuRt09CvzWxRo0Elh
        dyM0OvrRZSPLp4AFJLNnuEA==
X-Received: by 2002:a1c:f70d:: with SMTP id v13mr3261104wmh.183.1620733198515;
        Tue, 11 May 2021 04:39:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzjkDdjJJUARQXp0aF3NmnJVwjOXlQUh4rTsb2x3SNnrK7lnD3VQRixmRuDTGJg/ahiLWsenA==
X-Received: by 2002:a1c:f70d:: with SMTP id v13mr3261085wmh.183.1620733198327;
        Tue, 11 May 2021 04:39:58 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6329.dip0.t-ipconnect.de. [91.12.99.41])
        by smtp.gmail.com with ESMTPSA id v1sm8221951wru.73.2021.05.11.04.39.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 May 2021 04:39:57 -0700 (PDT)
Subject: Re: [kvm-unit-tests PATCH 1/4] s390x: sclp: Only fetch read info byte
 134 if cpu entries are above it
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     cohuck@redhat.com, linux-s390@vger.kernel.org,
        imbrenda@linux.ibm.com, thuth@redhat.com
References: <20210510150015.11119-1-frankja@linux.ibm.com>
 <20210510150015.11119-2-frankja@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <450c17cf-4431-73dc-164d-725bb0626c9d@redhat.com>
Date:   Tue, 11 May 2021 13:39:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210510150015.11119-2-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 10.05.21 17:00, Janosch Frank wrote:
> The cpu offset tells us where the cpu entries are in the sclp read
> info structure.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>   lib/s390x/sclp.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/s390x/sclp.c b/lib/s390x/sclp.c
> index 7a9b2c52..f11c2035 100644
> --- a/lib/s390x/sclp.c
> +++ b/lib/s390x/sclp.c
> @@ -138,7 +138,8 @@ void sclp_facilities_setup(void)
>   	assert(read_info);
>   
>   	cpu = sclp_get_cpu_entries();
> -	sclp_facilities.has_diag318 = read_info->byte_134_diag318;
> +	if (read_info->offset_cpu > 134)
> +		sclp_facilities.has_diag318 = read_info->byte_134_diag318;
>   	for (i = 0; i < read_info->entries_cpu; i++, cpu++) {
>   		/*
>   		 * The logic for only reading the facilities from the
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

