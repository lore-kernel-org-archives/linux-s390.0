Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55118C4332F
	for <linux-s390@archiver.kernel.org>; Wed,  8 Nov 2023 17:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbjKHRrl (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 8 Nov 2023 12:47:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbjKHRrj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 8 Nov 2023 12:47:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598651BEF
        for <linux-s390@vger.kernel.org>; Wed,  8 Nov 2023 09:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699465608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=onqupeUG78+mEU+ZWvy+wvhifXweK14Yjrxwf2b2OCM=;
        b=QR8QaUMWVmvkOxX3TmlxuwxUDxeocTZfxGzau+EsXJBm/iyHwu6Yf4rZIj9trCaeQyZPHP
        /qacJX2I6D1Xk/rzw0clw+orxvlbgyjk8tj3TAnHm/ib0zvs4AXzkdKvzhVBUAUBuyRv0c
        4gt5FPMxdLgsiMG7UxWRtWblShIVBN4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-uDZRurb2MfylrJYR_RQchw-1; Wed, 08 Nov 2023 12:46:47 -0500
X-MC-Unique: uDZRurb2MfylrJYR_RQchw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4090fa518bbso48017495e9.2
        for <linux-s390@vger.kernel.org>; Wed, 08 Nov 2023 09:46:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699465606; x=1700070406;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=onqupeUG78+mEU+ZWvy+wvhifXweK14Yjrxwf2b2OCM=;
        b=RjVUMtR5GZ7AzKEb2dgRHGubjNWc8FjC1GlVaYj7POEQ/H01nFY+TpAx+ZRomnR4CC
         8YD6Zi2ZaYjsHIOjU+/7se4jSkcediBsDoJjtgfS+UFdt1ZjsM+5u2OH2m2EEmlZL5A8
         JKy0pyClw8yeZPRO/dMe1h1quh8QQH2ZHZAE1P5HZ5gG3vwq7oWgFaLWlOHex5kFfI6b
         dyY8uaRD9tSs0dg60kFdRxt1aP4HTOJ/EiWC3Jmx8KBqnL+Iti7gZwXQfLMcGH+FpxL9
         331O017979B1gd8jg3iBvEUhdP7qVt2L/CPxVYF24fq0Yg9e1yHOHCyDryoaj29uy10o
         t3Aw==
X-Gm-Message-State: AOJu0YyJw6rPpeD/BfGUFT8cs+TWGLGpzay/DOysvaNJ4cWzTlksztvw
        HeDwHMgZYQpYTpyiH5wt8Fyc16tJ/nUeprEiVOsQuNXcdTb7EfSBR4Al0KeY+c0KsVlwcI4yWOS
        BbTLQ6jqhQE+1fYyHz5ocsg==
X-Received: by 2002:a05:6000:1564:b0:32d:aabd:d70f with SMTP id 4-20020a056000156400b0032daabdd70fmr2681672wrz.46.1699465606186;
        Wed, 08 Nov 2023 09:46:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGfpUcJygumLPv96UDlR5FUmq2JmUADA5v0M+Maw9BgL9Eso99C9wHi1mY3b/4SaLWoC45jsQ==
X-Received: by 2002:a05:6000:1564:b0:32d:aabd:d70f with SMTP id 4-20020a056000156400b0032daabdd70fmr2681648wrz.46.1699465605725;
        Wed, 08 Nov 2023 09:46:45 -0800 (PST)
Received: from ?IPV6:2003:cb:c712:c800:c9f8:7b16:67ce:ff2a? (p200300cbc712c800c9f87b1667ceff2a.dip0.t-ipconnect.de. [2003:cb:c712:c800:c9f8:7b16:67ce:ff2a])
        by smtp.gmail.com with ESMTPSA id a10-20020a5d53ca000000b00326dd5486dcsm5391438wrw.107.2023.11.08.09.46.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Nov 2023 09:46:45 -0800 (PST)
Message-ID: <3fae63a4-6ddf-48c5-a8df-080dc088f683@redhat.com>
Date:   Wed, 8 Nov 2023 18:46:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] KVM: s390: cpu model: Use proper define for
 facility mask size
Content-Language: en-US
To:     Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>, kvm@vger.kernel.org
References: <20231108171229.3404476-1-nsg@linux.ibm.com>
 <20231108171229.3404476-4-nsg@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20231108171229.3404476-4-nsg@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 08.11.23 18:12, Nina Schoetterl-Glausch wrote:
> Use the previously unused S390_ARCH_FAC_MASK_SIZE_U64 instead of
> S390_ARCH_FAC_LIST_SIZE_U64 for defining the fac_mask array.
> Note that both values are the same, there is no functional change.
> 
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> ---
>   arch/s390/include/asm/kvm_host.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index 427f9528a7b6..46fcd2f9dff8 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -811,7 +811,7 @@ struct s390_io_adapter {
>   
>   struct kvm_s390_cpu_model {
>   	/* facility mask supported by kvm & hosting machine */
> -	__u64 fac_mask[S390_ARCH_FAC_LIST_SIZE_U64];
> +	__u64 fac_mask[S390_ARCH_FAC_MASK_SIZE_U64];
>   	struct kvm_s390_vm_cpu_subfunc subfuncs;
>   	/* facility list requested by guest (in dma page) */
>   	__u64 *fac_list;

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

