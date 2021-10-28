Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B0CC433EF
	for <linux-s390@archiver.kernel.org>; Thu, 28 Oct 2021 14:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40DC161106
	for <linux-s390@archiver.kernel.org>; Thu, 28 Oct 2021 14:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbhJ1O1j (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 28 Oct 2021 10:27:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32282 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230479AbhJ1O1j (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 28 Oct 2021 10:27:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635431111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0G7LmSeoTaOCEDD4Qdow17gIDFlX8I4Q0C2wC4wNyVM=;
        b=UzdMzX1Cm7GtivQ3CecDSYQMcD1E7MLbGPFjrZTsAPqT7ivP7gFQirNFk64VuSVqgtnoq6
        e+Xu3aO7MB21MpwjphrmO69R5GsQ9urRvAziOgs6DBON1SfMjkZybH2qr/EvHegLdvt30G
        Ybj8HZ8EsuXxydQPKxK0Zyi88/LQhnQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-IwxeKJKbPHijXROvJuBJkw-1; Thu, 28 Oct 2021 10:25:10 -0400
X-MC-Unique: IwxeKJKbPHijXROvJuBJkw-1
Received: by mail-wm1-f69.google.com with SMTP id i15-20020a05600c354f00b0032cda87b22cso1113054wmq.5
        for <linux-s390@vger.kernel.org>; Thu, 28 Oct 2021 07:25:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=0G7LmSeoTaOCEDD4Qdow17gIDFlX8I4Q0C2wC4wNyVM=;
        b=VI+wUM6/CWcGtjqQ3YJmAiRFkG3vBpYVZIQ9uLHPYL99kuWUoAkAFLC01yAzo+rQF0
         Dmy+YxwTeMG5wOV1qRlT6DlmanE9k4w9muCEA5hYfBLGKhrvv33eIrlHEFv76UDQQttH
         AL+khmCUeWcLgP7Y1kjaMrFmlzie3WFF9tqabHWdhoWKTi0oN5hr6qzxXl0c/rCZHbiP
         ZWllWdgUo/IsxOKpdEIzdiLk/+zk1d+IwBuuYusXgkXOoxeLlPJ87LCdxAHuqdjio408
         hmlKVk/Vq0CdieliGPlukZemm+86pXpuq6yFdVzdTzOtMnpYC9sd0jK9tvxqNJeIXnY6
         zv7w==
X-Gm-Message-State: AOAM530HG8GEF1lwNu3t3DEvXARd3uVzM7sMuYJTxAQ/z3ltXOFVVf2G
        h1JiMAs3o9e+z6EWDBFMfMwB7iITaZaj2bkmskGUiQ5UCfVKgRzuskqMeNw79o/ElPpf6LXEm8X
        DbWJ0fVxayvm0+5k8F+vDFw==
X-Received: by 2002:a05:6000:186a:: with SMTP id d10mr6384579wri.279.1635431109200;
        Thu, 28 Oct 2021 07:25:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxOi9O+vaOwxJUXA6a+jCK0+01FKTzme4s23K0tex2QVjKnfZgH01pT2wTLAsv8N0KStFFkhg==
X-Received: by 2002:a05:6000:186a:: with SMTP id d10mr6384549wri.279.1635431108942;
        Thu, 28 Oct 2021 07:25:08 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23b52.dip0.t-ipconnect.de. [79.242.59.82])
        by smtp.gmail.com with ESMTPSA id x21sm6332839wmc.14.2021.10.28.07.25.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Oct 2021 07:25:08 -0700 (PDT)
Message-ID: <4ac7c459-8e13-087a-f98d-9f3e0e6d8ee6@redhat.com>
Date:   Thu, 28 Oct 2021 16:25:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Content-Language: en-US
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Cc:     Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211028135556.1793063-1-scgl@linux.ibm.com>
 <20211028135556.1793063-4-scgl@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 3/3] KVM: s390: gaccess: Cleanup access to guest frames
In-Reply-To: <20211028135556.1793063-4-scgl@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 28.10.21 15:55, Janis Schoetterl-Glausch wrote:
> Introduce a helper function for guest frame access.

"guest page access"

But I do wonder if you actually want to call it

"access_guest_abs"

and say "guest absolute access" instead here.

Because we're dealing with absolute addresses and the fact that we are
accessing it page-wise is just because we have to perform a page-wise
translation in the callers (either virtual->absolute or real->absolute).

Theoretically, if you know you're across X pages but they are contiguous
in absolute address space, nothing speaks against using that function
directly across X pages with a single call.

> 
> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> ---
>  arch/s390/kvm/gaccess.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
> index f0848c37b003..9a633310b6fe 100644
> --- a/arch/s390/kvm/gaccess.c
> +++ b/arch/s390/kvm/gaccess.c
> @@ -866,6 +866,20 @@ static int guest_range_to_gpas(struct kvm_vcpu *vcpu, unsigned long ga, u8 ar,
>  	return 0;
>  }
>  
> +static int access_guest_page(struct kvm *kvm, enum gacc_mode mode, gpa_t gpa,
> +			      void *data, unsigned int len)
> +{
> +	const unsigned int offset = offset_in_page(gpa);
> +	const gfn_t gfn = gpa_to_gfn(gpa);
> +	int rc;
> +
> +	if (mode == GACC_STORE)
> +		rc = kvm_write_guest_page(kvm, gfn, data, offset, len);
> +	else
> +		rc = kvm_read_guest_page(kvm, gfn, data, offset, len);
> +	return rc;
> +}
> +
>  int access_guest(struct kvm_vcpu *vcpu, unsigned long ga, u8 ar, void *data,
>  		 unsigned long len, enum gacc_mode mode)
>  {
> @@ -896,10 +910,7 @@ int access_guest(struct kvm_vcpu *vcpu, unsigned long ga, u8 ar, void *data,
>  	rc = guest_range_to_gpas(vcpu, ga, ar, gpas, len, asce, mode);
>  	for (idx = 0; idx < nr_pages && !rc; idx++) {
>  		fragment_len = min(PAGE_SIZE - offset_in_page(gpas[idx]), len);
> -		if (mode == GACC_STORE)
> -			rc = kvm_write_guest(vcpu->kvm, gpas[idx], data, fragment_len);
> -		else
> -			rc = kvm_read_guest(vcpu->kvm, gpas[idx], data, fragment_len);
> +		rc = access_guest_page(vcpu->kvm, mode, gpas[idx], data, fragment_len);
>  		len -= fragment_len;
>  		data += fragment_len;
>  	}
> @@ -920,10 +931,7 @@ int access_guest_real(struct kvm_vcpu *vcpu, unsigned long gra,
>  	while (len && !rc) {
>  		gpa = kvm_s390_real_to_abs(vcpu, gra);
>  		fragment_len = min(PAGE_SIZE - offset_in_page(gpa), len);
> -		if (mode)
> -			rc = write_guest_abs(vcpu, gpa, data, fragment_len);
> -		else
> -			rc = read_guest_abs(vcpu, gpa, data, fragment_len);
> +		rc = access_guest_page(vcpu->kvm, mode, gpa, data, fragment_len);
>  		len -= fragment_len;
>  		gra += fragment_len;
>  		data += fragment_len;
> 


-- 
Thanks,

David / dhildenb

