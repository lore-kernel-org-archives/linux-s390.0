Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 370C6C001DC
	for <linux-s390@archiver.kernel.org>; Thu, 27 Jul 2023 07:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233232AbjG0Ht7 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 27 Jul 2023 03:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233194AbjG0Htd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 27 Jul 2023 03:49:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B894F5B8B
        for <linux-s390@vger.kernel.org>; Thu, 27 Jul 2023 00:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690443718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jy/+mq+zfjK/pKvOWbWBiTODc1/IxuABqjbbQY71ff4=;
        b=Mw5gLVaOGRKrIWcUMyX85EsCXw9wTdP0XTuYAS+010ieuZMU4fyDNH2xKbl/bGisxoYzd3
        JNdbkPQWIAVhK3V0cvBoSF3QTSmkWkXIM/5UQzhhKTFBgFR6cqBL5Xn59BSy/iFGAp7mDw
        DYD+Hcbq6f784OIobMOGuajOVydmtBA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-3bfWNZbuPKawmext6n3sZg-1; Thu, 27 Jul 2023 03:41:54 -0400
X-MC-Unique: 3bfWNZbuPKawmext6n3sZg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-315998d6e7fso339775f8f.3
        for <linux-s390@vger.kernel.org>; Thu, 27 Jul 2023 00:41:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690443713; x=1691048513;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jy/+mq+zfjK/pKvOWbWBiTODc1/IxuABqjbbQY71ff4=;
        b=jZZl0O38eDvmoAhE6z2vG6yUOwwhgUF4IgjlbQlP/CBCxBaTKnOEF5oGTQ8QJjGPsI
         8OVSD1JFPl4VtUzZZwcVbTJK8FYXkrmmitGAYo2rCZAOSH6DebK+h+ZvlnLZouyg0uf9
         EbvZnzvzKrL8PPqrqE9LhKx3isyUtZfsNOa2Bj3etKccg0Qi2BDqEGacsN3tWF3BTZlC
         veReh+7Ee3RmQgrgutX1UB/hFERu4c6rMFqHK/he4NVkWbaioKbsbpKWuFhMLaMo+Fph
         nXU0r1b7QkdfECqCleCKhyOrObo+ne0xi4bwJ8BsOnAoxLY+wnB5Im9ikyyJottdu+X5
         jGmw==
X-Gm-Message-State: ABy/qLa0UOxcBuEnqDl15muW7XgO8BN0shBI5UK+RdiyXmDfCr55Gbu3
        qrrov99lL+Ale0aN2udv3qauTy5rr7WcqhiMIg83mo/TErJDhY8gy5VT9UWZ0z8S0UYOxFuCU94
        zkvhct+mSBMfmSZCBJLshoCHFyJSEkQ==
X-Received: by 2002:adf:dd41:0:b0:315:a1bb:4d7b with SMTP id u1-20020adfdd41000000b00315a1bb4d7bmr975349wrm.35.1690443712956;
        Thu, 27 Jul 2023 00:41:52 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEWj6NWYz1V9DJZLTZS9vAF5zYV3B2QrEgtuXaicBFHgTO/JTDXFGo+ljlnKmZ0pNiQioKi9Q==
X-Received: by 2002:adf:dd41:0:b0:315:a1bb:4d7b with SMTP id u1-20020adfdd41000000b00315a1bb4d7bmr975337wrm.35.1690443712607;
        Thu, 27 Jul 2023 00:41:52 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id n1-20020a5d4c41000000b00314374145e0sm1177528wrt.67.2023.07.27.00.41.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 00:41:52 -0700 (PDT)
Message-ID: <6f8951e2-9ea6-5bad-9c2c-b27d70d57ffe@redhat.com>
Date:   Thu, 27 Jul 2023 09:41:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/2] KVM: s390: add tracepoint in gmap notifier
Content-Language: en-US
To:     Nico Boehr <nrb@linux.ibm.com>, borntraeger@linux.ibm.com,
        frankja@linux.ibm.com, imbrenda@linux.ibm.com
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org
References: <20230510121822.546629-1-nrb@linux.ibm.com>
 <20230510121822.546629-3-nrb@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230510121822.546629-3-nrb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 10.05.23 14:18, Nico Boehr wrote:
> The gmap notifier is called for changes in table entries with the
> notifier bit set. To diagnose performance issues, it can be useful to
> see what causes certain changes in the gmap.
> 
> Hence, add a tracepoint in the gmap notifier.
> 
> Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
> ---
>   arch/s390/kvm/kvm-s390.c   |  2 ++
>   arch/s390/kvm/trace-s390.h | 23 +++++++++++++++++++++++
>   2 files changed, 25 insertions(+)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index ded4149e145b..e8476c023b07 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -3982,6 +3982,8 @@ static void kvm_gmap_notifier(struct gmap *gmap, unsigned long start,
>   	unsigned long prefix;
>   	unsigned long i;
>   
> +	trace_kvm_s390_gmap_notifier(start, end, gmap_is_shadow(gmap));
> +
>   	if (gmap_is_shadow(gmap))
>   		return;
>   	if (start >= 1UL << 31)
> diff --git a/arch/s390/kvm/trace-s390.h b/arch/s390/kvm/trace-s390.h
> index 6f0209d45164..5dabd0b64d6e 100644
> --- a/arch/s390/kvm/trace-s390.h
> +++ b/arch/s390/kvm/trace-s390.h
> @@ -333,6 +333,29 @@ TRACE_EVENT(kvm_s390_airq_suppressed,
>   		      __entry->id, __entry->isc)
>   	);
>   
> +/*
> + * Trace point for gmap notifier calls.
> + */
> +TRACE_EVENT(kvm_s390_gmap_notifier,
> +		TP_PROTO(unsigned long start, unsigned long end, unsigned int shadow),
> +		TP_ARGS(start, end, shadow),
> +
> +		TP_STRUCT__entry(
> +			__field(unsigned long, start)
> +			__field(unsigned long, end)
> +			__field(unsigned int, shadow)
> +			),
> +
> +		TP_fast_assign(
> +			__entry->start = start;
> +			__entry->end = end;
> +			__entry->shadow = shadow;
> +			),
> +
> +		TP_printk("gmap notified (start:0x%lx end:0x%lx shadow:%d)",
> +			__entry->start, __entry->end, __entry->shadow)
> +	);
> +
>   
>   #endif /* _TRACE_KVMS390_H */
>   

In the context of vsie, I'd have thought you'd be tracing 
kvm_s390_vsie_gmap_notifier() instead.

This should work as well, as all notifier are called.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

