Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CF2C4338F
	for <linux-s390@archiver.kernel.org>; Wed, 18 Aug 2021 07:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE72160E78
	for <linux-s390@archiver.kernel.org>; Wed, 18 Aug 2021 07:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239275AbhHRHz3 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 18 Aug 2021 03:55:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51374 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239187AbhHRHz2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 18 Aug 2021 03:55:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629273293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rHHegR8YoGT81fHSlGS+4eqOOM+TED5s1uOzx8W7ou0=;
        b=VJjMqpRpw/EueTnDh4iiD/Z9/gqgoXn9g0uPnJ7jWOOwhcaV5pbD27ZG4MXNUDCNIYxQns
        Q79gsCk3Lfka3YMsxbCj2vi5TvSf6UuqRWTsFeka64oCzOs3Jdcwp0jPpiHjxe/Q8YBV/A
        CmXFaqCJCZkchHW2kmRBQjdNNZekftw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-4aKOHOgcO2SEY0sm13R8Aw-1; Wed, 18 Aug 2021 03:54:52 -0400
X-MC-Unique: 4aKOHOgcO2SEY0sm13R8Aw-1
Received: by mail-wr1-f69.google.com with SMTP id p4-20020a5d59a4000000b00156992180dbso313465wrr.10
        for <linux-s390@vger.kernel.org>; Wed, 18 Aug 2021 00:54:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=rHHegR8YoGT81fHSlGS+4eqOOM+TED5s1uOzx8W7ou0=;
        b=QX0ouc4VuqysIAoodYjL56ivbFy8fcsIvQXTpX+Kl9XcU6F9wd6LNtJUxKA3Gki8Po
         KMvGUo97NB9aJgfrXRmzDoghfolRZDSOWqk6KRVZEHBTL2mpVWCnIV4FJpmmNo0bH9S/
         BvRfEDbwqdw8xlWGAvB/bCBqAFXtROVQIEONmfx7a9ALJSY9/FmEILYBiGYQCGBC2iYs
         fEZGM9j3nUL6FJ1Sxz9YotyRIc0mWI5Igetpyf6t4MiJxU8QxDjv50yM9m3ARIZQI5L1
         E+ZJgxCu+FIR3emw00v7HX+Aaztnn8eNlxdndsWBIMnIXbw1tI5WD6RzxPofG8nWnjw4
         adPg==
X-Gm-Message-State: AOAM531GrDttNFQqdjgioFBHSfYryci8FdHagJP+jR9kgiJwgb7kscel
        V/d+37ct2m6pRTAvxzuDwfeVw/WPF35+PJvo9I2W7/V2BdBsH5HXAIeHfgcS13f/oHXuWJHohOv
        IBnLJ7eg50Hz7yUsbnNt3CA==
X-Received: by 2002:a1c:2905:: with SMTP id p5mr7253517wmp.146.1629273291342;
        Wed, 18 Aug 2021 00:54:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxTn9JozhHmC98KaokBtJ55BnGOTt9cwSgq6tHNIiBtm8UI2eAVrwAyAnivCF2wQXM6+PL5FQ==
X-Received: by 2002:a1c:2905:: with SMTP id p5mr7253507wmp.146.1629273291144;
        Wed, 18 Aug 2021 00:54:51 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6417.dip0.t-ipconnect.de. [91.12.100.23])
        by smtp.gmail.com with ESMTPSA id b12sm4702991wmd.42.2021.08.18.00.54.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Aug 2021 00:54:50 -0700 (PDT)
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>, kvm@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Cc:     cohuck@redhat.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210816150718.3063877-1-scgl@linux.ibm.com>
 <20210816150718.3063877-2-scgl@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 1/2] KVM: s390: gaccess: Cleanup access to guest frames
Message-ID: <d11128bb-18f6-5210-6f42-74a89d8edcf7@redhat.com>
Date:   Wed, 18 Aug 2021 09:54:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210816150718.3063877-2-scgl@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 16.08.21 17:07, Janis Schoetterl-Glausch wrote:
> Introduce a helper function for guest frame access.
> Rewrite the calculation of the gpa and the length of the segment
> to be more readable.
> 
> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> ---
>   arch/s390/kvm/gaccess.c | 48 +++++++++++++++++++++++++----------------
>   1 file changed, 29 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
> index b9f85b2dc053..df83de0843de 100644
> --- a/arch/s390/kvm/gaccess.c
> +++ b/arch/s390/kvm/gaccess.c
> @@ -827,11 +827,26 @@ static int guest_page_range(struct kvm_vcpu *vcpu, unsigned long ga, u8 ar,
>   	return 0;
>   }
>   
> +static int access_guest_frame(struct kvm *kvm, enum gacc_mode mode, gpa_t gpa,
> +			      void *data, unsigned int len)

I know, "frame" is a beautiful term for "page" -- can we just avoid 
using it because we're not using it anywhere else here? :)

What's wrong with "access_guest_page()" ?


> +{
> +	gfn_t gfn = gpa_to_gfn(gpa);
> +	unsigned int offset = offset_in_page(gpa);
> +	int rc;

You could turn both const. You might want to consider 
reverse-christmas-treeing this.

> +
> +	if (mode == GACC_STORE)
> +		rc = kvm_write_guest_page(kvm, gfn, data, offset, len);
> +	else
> +		rc = kvm_read_guest_page(kvm, gfn, data, offset, len);

Personally, I prefer passing in pfn + offset instead of a gpa. Also 
avoids having to convert back and forth.

> +	return rc;
> +}
> +
>   int access_guest(struct kvm_vcpu *vcpu, unsigned long ga, u8 ar, void *data,
>   		 unsigned long len, enum gacc_mode mode)
>   {
>   	psw_t *psw = &vcpu->arch.sie_block->gpsw;
> -	unsigned long _len, nr_pages, gpa, idx;
> +	unsigned long nr_pages, gpa, idx;
> +	unsigned int seg;

Dito, reverse christmas tree might be worth keeping.

>   	unsigned long pages_array[2];
>   	unsigned long *pages;
>   	int need_ipte_lock;
> @@ -855,15 +870,12 @@ int access_guest(struct kvm_vcpu *vcpu, unsigned long ga, u8 ar, void *data,
>   		ipte_lock(vcpu);
>   	rc = guest_page_range(vcpu, ga, ar, pages, nr_pages, asce, mode);
>   	for (idx = 0; idx < nr_pages && !rc; idx++) {
> -		gpa = *(pages + idx) + (ga & ~PAGE_MASK);
> -		_len = min(PAGE_SIZE - (gpa & ~PAGE_MASK), len);
> -		if (mode == GACC_STORE)
> -			rc = kvm_write_guest(vcpu->kvm, gpa, data, _len);
> -		else
> -			rc = kvm_read_guest(vcpu->kvm, gpa, data, _len);
> -		len -= _len;
> -		ga += _len;
> -		data += _len;
> +		gpa = pages[idx] + offset_in_page(ga);
> +		seg = min(PAGE_SIZE - offset_in_page(gpa), len);
> +		rc = access_guest_frame(vcpu->kvm, mode, gpa, data, seg);
> +		len -= seg;
> +		ga += seg;
> +		data += seg;
>   	}
>   	if (need_ipte_lock)
>   		ipte_unlock(vcpu);
> @@ -875,19 +887,17 @@ int access_guest(struct kvm_vcpu *vcpu, unsigned long ga, u8 ar, void *data,
>   int access_guest_real(struct kvm_vcpu *vcpu, unsigned long gra,
>   		      void *data, unsigned long len, enum gacc_mode mode)
>   {
> -	unsigned long _len, gpa;
> +	unsigned long gpa;
> +	unsigned int seg;
>   	int rc = 0;
>   
>   	while (len && !rc) {
>   		gpa = kvm_s390_real_to_abs(vcpu, gra);
> -		_len = min(PAGE_SIZE - (gpa & ~PAGE_MASK), len);
> -		if (mode)
> -			rc = write_guest_abs(vcpu, gpa, data, _len);
> -		else
> -			rc = read_guest_abs(vcpu, gpa, data, _len);
> -		len -= _len;
> -		gra += _len;
> -		data += _len;
> +		seg = min(PAGE_SIZE - offset_in_page(gpa), len);

What does "seg" mean? I certainly know when "len" means -- which is also 
what the function eats.

> +		rc = access_guest_frame(vcpu->kvm, mode, gpa, data, seg);
> +		len -= seg;
> +		gra += seg;
> +		data += seg;
>   	}
>   	return rc;
>   }
> 


-- 
Thanks,

David / dhildenb

