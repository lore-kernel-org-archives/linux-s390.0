Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00964C433FE
	for <linux-s390@archiver.kernel.org>; Fri, 18 Nov 2022 15:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235310AbiKRP53 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 18 Nov 2022 10:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234447AbiKRP52 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 18 Nov 2022 10:57:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08208C48D
        for <linux-s390@vger.kernel.org>; Fri, 18 Nov 2022 07:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668786993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ttcW/rTHlQzNT+/Ls7pIym1RVV80wz0SllrC7rwVQ0I=;
        b=Ufx+iI2DT0FgN5cAzZwy3H8V3ytbToSVgFE0aVXW0593lqLco9vL8jCRfdScjbVfZ3U3bR
        r0O43ewFWQVVgOJKruUJCuiqnyfj3dASP1tEwfgoM789PzUc6SY99txMGND8WlLvbnsP0h
        KeZ/gvktuWBpWat3g4YSd0auOmblZmU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-54-CX0NSgI0OWiiT2Kia5JyPg-1; Fri, 18 Nov 2022 10:56:31 -0500
X-MC-Unique: CX0NSgI0OWiiT2Kia5JyPg-1
Received: by mail-wr1-f69.google.com with SMTP id q2-20020adfab02000000b00241b8f7efc5so1574906wrc.19
        for <linux-s390@vger.kernel.org>; Fri, 18 Nov 2022 07:56:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ttcW/rTHlQzNT+/Ls7pIym1RVV80wz0SllrC7rwVQ0I=;
        b=LSX7AQXNwXBf17aYB17jTekshab5PPnfynfnTyVSGhZi8KNwLRct/O3IFqE0oHBQ6q
         u5VPUKcphdmx7S0mUaBqlvZsfvISETk3Gj50gKxdSO6jx59Ar0w1ymM0eng/Cy7UlaPT
         WOMNX5/Ou+OveY1nrIDh3eO97L4Rr+cLMQd33Y2VSsQ3WqfLeGK+pV7xbF+s/2osv9F+
         JIiJoW4KNdfud5d6D6SkCT5hF50bEYole1+AOQqQiG47Vx8XUhPQy3nH3qh7fK8e5e0v
         4xE64NZzRUJVjtgsdNXkLKSNd0XVlK3mTPbUywtjUsgF562KgP0GYoMhLTVpviY2avRY
         us5A==
X-Gm-Message-State: ANoB5pkaM8YXIB//vOIOAAl2wMHImBJJrcFv7YZqE8Zr9OPuY0aDNceH
        HXEqoH1Uy6PS8CKRgGN37TIFrQQq4jisd8+3xUo8kn+A1ZvRjgm5EHdYdDNxnSgHbbVjV3cSJuJ
        RuZQ5zt/wxcgOSgHup3klcA==
X-Received: by 2002:a5d:65ca:0:b0:236:8322:4be9 with SMTP id e10-20020a5d65ca000000b0023683224be9mr4655989wrw.171.1668786990627;
        Fri, 18 Nov 2022 07:56:30 -0800 (PST)
X-Google-Smtp-Source: AA0mqf58mrK6oiHpi4faJvPVWUqYvGFYBoXQhcAxwtKY/EG4WxmJJRZvPL83uAm+5Q05Js1Mu2Iusg==
X-Received: by 2002:a5d:65ca:0:b0:236:8322:4be9 with SMTP id e10-20020a5d65ca000000b0023683224be9mr4655980wrw.171.1668786990434;
        Fri, 18 Nov 2022 07:56:30 -0800 (PST)
Received: from [192.168.8.100] (tmo-113-203.customers.d1-online.com. [80.187.113.203])
        by smtp.gmail.com with ESMTPSA id bg21-20020a05600c3c9500b003b497138093sm5529105wmb.47.2022.11.18.07.56.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 07:56:29 -0800 (PST)
Message-ID: <5407a498-2f29-e17d-949b-a9cf43eaa01e@redhat.com>
Date:   Fri, 18 Nov 2022 16:56:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] KVM: s390: remove unused gisa_clear_ipm_gisc() function
Content-Language: en-US
To:     Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Michael Mueller <mimu@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20221118151133.2974602-1-hca@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20221118151133.2974602-1-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 18/11/2022 16.11, Heiko Carstens wrote:
> clang warns about an unused function:
> arch/s390/kvm/interrupt.c:317:20:
>    error: unused function 'gisa_clear_ipm_gisc' [-Werror,-Wunused-function]
> static inline void gisa_clear_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc)
> 
> Remove gisa_clear_ipm_gisc(), since it is unused and get rid of this
> warning.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>   arch/s390/kvm/interrupt.c | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index ab569faf0df2..1dae78deddf2 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -314,11 +314,6 @@ static inline u8 gisa_get_ipm(struct kvm_s390_gisa *gisa)
>   	return READ_ONCE(gisa->ipm);
>   }
>   
> -static inline void gisa_clear_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc)
> -{
> -	clear_bit_inv(IPM_BIT_OFFSET + gisc, (unsigned long *) gisa);
> -}

Unused since its introduction in commit d77e64141e322.

Reviewed-by: Thomas Huth <thuth@redhat.com>

