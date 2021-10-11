Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F44EC433EF
	for <linux-s390@archiver.kernel.org>; Mon, 11 Oct 2021 17:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C3B560C41
	for <linux-s390@archiver.kernel.org>; Mon, 11 Oct 2021 17:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234037AbhJKR7I (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 11 Oct 2021 13:59:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31861 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233422AbhJKR7I (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 11 Oct 2021 13:59:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633975027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E/5bZi3m0cV+//b6WevzGww5yl4Hu1ZXn87oh0/epQQ=;
        b=Q2qPRz5n1Glh8l6GD6pdwEf5vmtGVC6XVl7alSyTx4Dptsj06CvBfNUUSJTwej/slO4fwg
        /yaQ79xL9H1oLOmRxVsDZR8Iklase2Rznk6BAgMf8xKN0TG9lVt1QfcFWdF0sFPT4Qmkb3
        F50XG2NiI2aw/l00D4/WZgTHeSnFl8E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-HL90x-2kOZCC59Vj-qq4_g-1; Mon, 11 Oct 2021 13:57:06 -0400
X-MC-Unique: HL90x-2kOZCC59Vj-qq4_g-1
Received: by mail-wr1-f71.google.com with SMTP id h11-20020adfa4cb000000b00160c791a550so13674178wrb.6
        for <linux-s390@vger.kernel.org>; Mon, 11 Oct 2021 10:57:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=E/5bZi3m0cV+//b6WevzGww5yl4Hu1ZXn87oh0/epQQ=;
        b=2JM0h7P2224VBVnQ97pg4KAWOlUvLyS/zXPuB5ZLEFTN1cXmCK5rPD7vLSWoKM2UUt
         fWFmqLlPLohair28Sm57t4gYXyjkytdcgwo4VKhy0uYlr8mhHgHDdLCrZ6YjwvaBMPay
         dnsZECG8++2u9J039ztMtgMeO7XTh2sYS02LYd788AxY8X7YQYRZEu7X8JcOWBUmClET
         9MBeHDfrCPHeJ3fkEp2/pCR4QY81INAgp4xz2rV4a175kjB1Vjm/YZv05/f6djO4EbxY
         HJw0e0tXLgOt/hUwyKUH8pLJ0SgOXKR32l5lDUEFl5IK90chE9VTwue/ltOPJZFPwSDJ
         7ehw==
X-Gm-Message-State: AOAM533EAuEL0b5P6KsSBr/GkOpACQE6iqts1radSzEv8L06DiR2RT4l
        AoWxE5pkTDwCZJ313IBcWNyfO523i56qk/ZCgk5fQrfTrpDayCUNBkZbBHEzPq8o7MVOQ2v6/Pp
        SLjQfPwklordwQ1SpDMVofSrjrlJzyXReBlbpVWj1ncbX/KrZzT1ivSiwc9KRULScBveMmA==
X-Received: by 2002:adf:fb0a:: with SMTP id c10mr27837011wrr.354.1633975025063;
        Mon, 11 Oct 2021 10:57:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzKGGwyIKO0k01yOuR3wlxMM05AG04P32tsZWeSIbZoC0xX0DuRbe/iFHxbaDWGM6c3TDR0dg==
X-Received: by 2002:adf:fb0a:: with SMTP id c10mr27836982wrr.354.1633975024834;
        Mon, 11 Oct 2021 10:57:04 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c64ba.dip0.t-ipconnect.de. [91.12.100.186])
        by smtp.gmail.com with ESMTPSA id d8sm8372925wrz.84.2021.10.11.10.57.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Oct 2021 10:57:04 -0700 (PDT)
Subject: Re: [RFC PATCH v1 1/6] KVM: s390: Simplify SIGP Set Arch handling
To:     Eric Farman <farman@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org
References: <20211008203112.1979843-1-farman@linux.ibm.com>
 <20211008203112.1979843-2-farman@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <de4726aa-aa72-7e17-8bc6-9d42ca6125a8@redhat.com>
Date:   Mon, 11 Oct 2021 19:57:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211008203112.1979843-2-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 08.10.21 22:31, Eric Farman wrote:
> The Principles of Operations describe the various reasons that
> each individual SIGP orders might be rejected, and the status
> bit that are set for each condition.
> 
> For example, for the Set Architecture order, it states:
> 
>    "If it is not true that all other CPUs in the configu-
>     ration are in the stopped or check-stop state, ...
>     bit 54 (incorrect state) ... is set to one."
> 
> However, it also states:
> 
>    "... if the CZAM facility is installed, ...
>     bit 55 (invalid parameter) ... is set to one."
> 
> Since the Configuration-z/Architecture-Architectural Mode (CZAM)
> facility is unconditionally presented, there is no need to examine
> each VCPU to determine if it is started/stopped. It can simply be
> rejected outright with the Invalid Parameter bit.
> 
> Fixes: b697e435aeee ("KVM: s390: Support Configuration z/Architecture Mode")
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>   arch/s390/kvm/sigp.c | 14 +-------------
>   1 file changed, 1 insertion(+), 13 deletions(-)
> 
> diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/sigp.c
> index 683036c1c92a..cf4de80bd541 100644
> --- a/arch/s390/kvm/sigp.c
> +++ b/arch/s390/kvm/sigp.c
> @@ -151,22 +151,10 @@ static int __sigp_stop_and_store_status(struct kvm_vcpu *vcpu,
>   static int __sigp_set_arch(struct kvm_vcpu *vcpu, u32 parameter,
>   			   u64 *status_reg)
>   {
> -	unsigned int i;
> -	struct kvm_vcpu *v;
> -	bool all_stopped = true;
> -
> -	kvm_for_each_vcpu(i, v, vcpu->kvm) {
> -		if (v == vcpu)
> -			continue;
> -		if (!is_vcpu_stopped(v))
> -			all_stopped = false;
> -	}
> -
>   	*status_reg &= 0xffffffff00000000UL;
>   
>   	/* Reject set arch order, with czam we're always in z/Arch mode. */
> -	*status_reg |= (all_stopped ? SIGP_STATUS_INVALID_PARAMETER :
> -					SIGP_STATUS_INCORRECT_STATE);
> +	*status_reg |= SIGP_STATUS_INVALID_PARAMETER;
>   	return SIGP_CC_STATUS_STORED;
>   }
>   
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

