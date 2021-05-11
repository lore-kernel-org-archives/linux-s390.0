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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB3AC433B4
	for <linux-s390@archiver.kernel.org>; Tue, 11 May 2021 11:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C380B61155
	for <linux-s390@archiver.kernel.org>; Tue, 11 May 2021 11:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbhEKLor (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 11 May 2021 07:44:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39696 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231422AbhEKLoq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 11 May 2021 07:44:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620733420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R61d3xwdyDD7x6c1LP7evU2g3D1imnjYhld/TmvsON0=;
        b=XFjgUPNxvWF2030fKjYYJYBrnotjao9nvLKtspOPCsEfpcZc1kTPRGSwW2ce7Wi5SPhH0z
        ysB3ne45w5w9NY1mnXTfzqJcYAdgFIHORPUQ30bKmheD8ilHz8QJ7mgTHTBdYVGq1vNw/D
        37yJO9EE3NQ81KdirYUDQoqIFnS0ptE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-r-gIWFcIMXap_HB08NbxnQ-1; Tue, 11 May 2021 07:43:38 -0400
X-MC-Unique: r-gIWFcIMXap_HB08NbxnQ-1
Received: by mail-wm1-f69.google.com with SMTP id d199-20020a1c1dd00000b02901492c14476eso623279wmd.2
        for <linux-s390@vger.kernel.org>; Tue, 11 May 2021 04:43:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=R61d3xwdyDD7x6c1LP7evU2g3D1imnjYhld/TmvsON0=;
        b=EAm0nCgsDRe84/fS7ZA/pZiAWP+NdBa6P60KK7DHoeIKrMQW5T588v/KU+C8dv2pDm
         koxIW4JrBXaSvLP9+cZieqNofMtW6sw9HfARIt/XzC+iPvh9J14haqn/eYj3XJJZQHBW
         rpO57yYoGsk6iAD3c9sjOrTO3yMqe1g5Z2bHGeiYSbGnWAsJX4oCCjUpSLP3I5DA1yQv
         0hPwFzAjbBiHWfJIcMeAHAlKSRH6RNJuXP7A7e3fXYiF3udsSjuZphB/5NBLO8hc9oII
         oeFQwVqtJ2ntNQYdhqtqpw4ewkZq4ZHWY9fbfmn+k50GG3x69tT8Ewt4AsxgkSgJyq47
         qmZg==
X-Gm-Message-State: AOAM530pCgnIK3yCgA+91kXulJoPiQ6bFafXwt5DCifyDgYDnSDCrS1i
        X6dFIyzWzs95nwUCHLUi22lJVwlXFxZ7zkLdc241+1c+ubZqnWMlXgAHzSRdwZReuM7hHX0qSYt
        hlgNda2lcuv1y5q8dleCzDw==
X-Received: by 2002:a05:6000:1286:: with SMTP id f6mr734418wrx.226.1620733417405;
        Tue, 11 May 2021 04:43:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwaFJoiMBvy0DznXdcNHkbHPAkZjMIyDw0VJ4Zof2iz9Vz6sy3hBLp7VRZ/8RXV5oH4v/pBYg==
X-Received: by 2002:a05:6000:1286:: with SMTP id f6mr734402wrx.226.1620733417244;
        Tue, 11 May 2021 04:43:37 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6329.dip0.t-ipconnect.de. [91.12.99.41])
        by smtp.gmail.com with ESMTPSA id k10sm4640820wmf.0.2021.05.11.04.43.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 May 2021 04:43:37 -0700 (PDT)
Subject: Re: [kvm-unit-tests PATCH 2/4] lib: s390x: sclp: Extend feature
 probing
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     cohuck@redhat.com, linux-s390@vger.kernel.org,
        imbrenda@linux.ibm.com, thuth@redhat.com
References: <20210510150015.11119-1-frankja@linux.ibm.com>
 <20210510150015.11119-3-frankja@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <b0db681f-bfe3-5cf3-53f8-651bba04a5c5@redhat.com>
Date:   Tue, 11 May 2021 13:43:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210510150015.11119-3-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 10.05.21 17:00, Janosch Frank wrote:
> Lets grab more of the feature bits from SCLP read info so we can use
> them in the cpumodel tests.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>   lib/s390x/sclp.c | 20 ++++++++++++++++++++
>   lib/s390x/sclp.h | 38 +++++++++++++++++++++++++++++++++++---
>   2 files changed, 55 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/s390x/sclp.c b/lib/s390x/sclp.c
> index f11c2035..f25cfdb2 100644
> --- a/lib/s390x/sclp.c
> +++ b/lib/s390x/sclp.c
> @@ -129,6 +129,13 @@ CPUEntry *sclp_get_cpu_entries(void)
>   	return (CPUEntry *)(_read_info + read_info->offset_cpu);
>   }
>   
> +static bool sclp_feat_check(int byte, int mask)
> +{
> +	uint8_t *rib = (uint8_t *)read_info;
> +
> +	return !!(rib[byte] & mask);
> +}

Instead of a mask, I'd just check for bit (offset) numbers within the byte.

static bool sclp_feat_check(int byte, int bit)
{
	uint8_t *rib = (uint8_t *)read_info;

	return !!(rib[byte] & (0x80 >> bit));
}

-- 
Thanks,

David / dhildenb

