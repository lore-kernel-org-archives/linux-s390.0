Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6579EC4332F
	for <linux-s390@archiver.kernel.org>; Fri, 26 Nov 2021 17:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239428AbhKZROi (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 26 Nov 2021 12:14:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41378 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240211AbhKZRMi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 26 Nov 2021 12:12:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637946565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oJRbVgERr9nHJtHlBxfAUiQ5IlIj7tB/ekCKPBmxO0Q=;
        b=FPjwXyHyu3kjx4vRgo/PNWrtWSPXXE3vgVMD/mOgTjbD8AxUxGR9wwd3GTzQ17RXNzEnc3
        qXxGTkh3a1KAbgDmwzDMGn/mrV69K14fmRNWZaTNxyfVzSoHfileWhrOCNt9QvROAOMtdS
        vE+Pp66SrlJGGPyHPvmMC+gkcOrFz7U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-434-tHHh0gWAMKu_ruOZGQO39A-1; Fri, 26 Nov 2021 12:09:21 -0500
X-MC-Unique: tHHh0gWAMKu_ruOZGQO39A-1
Received: by mail-wm1-f70.google.com with SMTP id k25-20020a05600c1c9900b00332f798ba1dso7181877wms.4
        for <linux-s390@vger.kernel.org>; Fri, 26 Nov 2021 09:09:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=oJRbVgERr9nHJtHlBxfAUiQ5IlIj7tB/ekCKPBmxO0Q=;
        b=Y087MOuDNkFz9+uhZkQrVq28Rc5wAbQU3WUWsKWCrfoPZrCpD7mdw8kN16xxYisYKC
         vpsUplE/uNL4E3w/e88abbqtugYF5ZVPHBNdJxf2KRggnbKXobH+xY6EwFaWz1psSxf9
         dev2yAz3xJWHCnSGNN53kcTQi/uqcNRyW7BAbJO6TKaoQ3Asrt9vgs7uhxYrRwzoa96K
         jYpTLPDVgYQ1jRlRuBOXyMKxc3v2pVqjmbSVm4UV+7Lnpoe1wtjiB6gv9bYT9wfOsVXb
         JGGlHwDnVLrNW/71/09UgBXsjy6pSwd6Q+t1rTrVewLPCQWB8PsJpnz6UYPZCBb0N8p3
         v16w==
X-Gm-Message-State: AOAM531DmhpWv0GQCMYMB8V0L6CiJvXR76mxZI1U4aokQx1VBrOT2Ims
        pndyl7rSUBj14P1Vr4LWGadIAxzoywwr8m4vhZ/dqkeu6UH4J//S3eiB2oF+4mV6Tf4NJWJGre6
        AQYlTPreN22GLc6NfWA3GGw==
X-Received: by 2002:adf:f542:: with SMTP id j2mr15018870wrp.616.1637946560600;
        Fri, 26 Nov 2021 09:09:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwL5L/tD86RCqX1ISPfhzJW00g+afueiNingL26c2hmcDa5qME3mu8KGtYbsk2q2oF3mxNTgQ==
X-Received: by 2002:adf:f542:: with SMTP id j2mr15018833wrp.616.1637946560333;
        Fri, 26 Nov 2021 09:09:20 -0800 (PST)
Received: from [192.168.3.132] (p5b0c69e1.dip0.t-ipconnect.de. [91.12.105.225])
        by smtp.gmail.com with ESMTPSA id j40sm7815934wms.16.2021.11.26.09.09.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Nov 2021 09:09:19 -0800 (PST)
Message-ID: <963e5934-094d-3ed5-3a49-c25dd7a17fb8@redhat.com>
Date:   Fri, 26 Nov 2021 18:09:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3 3/3] KVM: s390: gaccess: Cleanup access to guest pages
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
References: <20211126164549.7046-1-scgl@linux.ibm.com>
 <20211126164549.7046-4-scgl@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20211126164549.7046-4-scgl@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 26.11.21 17:45, Janis Schoetterl-Glausch wrote:
> Introduce a helper function for guest frame access.
> 
> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  arch/s390/kvm/gaccess.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
> index c09659609d68..9193f0de40b1 100644
> --- a/arch/s390/kvm/gaccess.c
> +++ b/arch/s390/kvm/gaccess.c
> @@ -866,6 +866,20 @@ static int guest_range_to_gpas(struct kvm_vcpu *vcpu, unsigned long ga, u8 ar,
>  	return 0;
>  }
>  
> +static int access_guest_page(struct kvm *kvm, enum gacc_mode mode, gpa_t gpa,
> +			     void *data, unsigned int len)
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

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

