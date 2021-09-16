Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E04FC433FE
	for <linux-s390@archiver.kernel.org>; Thu, 16 Sep 2021 14:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CF1361246
	for <linux-s390@archiver.kernel.org>; Thu, 16 Sep 2021 14:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238088AbhIPOFK (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 16 Sep 2021 10:05:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44624 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236033AbhIPOFJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 16 Sep 2021 10:05:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631801029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=InkSSQy+zkt1/Sq2nJaTJOAqUI+Qk6BMdAVU8hoiD9c=;
        b=d6fYM85CEiuYMIoPJsIOhzcmAWs5KBdSY8HEDffpebTX1zTw0V6aOcWTjoFoUoE/Mfa/lw
        +xbMXfuMBk+XXKjnIv/605UW/T40suHoHU/HQeu+rRO9QH4yloOsV1qpotsY8y4c8SG+CU
        17ncpiiXLf8ECcwSf1mWWiGyk/1+hBc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-yKj_PdmkOoexsRZY5VUQFg-1; Thu, 16 Sep 2021 10:03:46 -0400
X-MC-Unique: yKj_PdmkOoexsRZY5VUQFg-1
Received: by mail-wr1-f72.google.com with SMTP id r15-20020adfce8f000000b0015df1098ccbso2471349wrn.4
        for <linux-s390@vger.kernel.org>; Thu, 16 Sep 2021 07:03:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=InkSSQy+zkt1/Sq2nJaTJOAqUI+Qk6BMdAVU8hoiD9c=;
        b=rv0y5vn1VP7aMvQJTGV7Y1GdXFf3iYHWUOgM0yLOg7aM7B133fRk6go+xsSiOBJ5oF
         IIpVuj0aZLFZfDOlP14rpU6xPn2mSVP+LZ12y7Cco8ud59UfnsgrrpEVQq4JTtnuy2mt
         LRaJRhK+cAUYndWJU9Tr8G/ZolOIZN26YZZx4DF1tpDmBjKcb9UP3uYboHHjUJFmCIv9
         AW1NjinMXVGULjzwCQa7YyeXSVeGqSzwceigzoR7pP2jUhwQsL0SuH5hf+74524tWxga
         5iA3cwwIqz6Kaen669HxzSL5QmlKYmRMsX/lcxPBwdvFL5uaBmf7dbYYJYCTNQhF5IPp
         gn/g==
X-Gm-Message-State: AOAM531gp5RV77jlxkAmVGU/RCuv9ex9+j8tYago+vXyCV5b2FkHsOww
        Enx3qzZKnmbcN1c84uLXTWMVyULepJCSHACdEKCpybY6/P+X7bpUWG9GjX7QELu3EOJggz1QfwM
        hG2YDSd8Af3FfFmcRbE6Y0g==
X-Received: by 2002:adf:e74b:: with SMTP id c11mr6371107wrn.101.1631801025691;
        Thu, 16 Sep 2021 07:03:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/lhk0vbwJSHMlHYygHpizbHLXpjbz403gb1bSwePYyjBwbWX/UNKyVaKVGPdD3tXAKLjHow==
X-Received: by 2002:adf:e74b:: with SMTP id c11mr6371074wrn.101.1631801025407;
        Thu, 16 Sep 2021 07:03:45 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23828.dip0.t-ipconnect.de. [79.242.56.40])
        by smtp.gmail.com with ESMTPSA id s15sm3612858wrb.22.2021.09.16.07.03.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Sep 2021 07:03:44 -0700 (PDT)
Subject: Re: [PATCH v4 1/1] s390x: KVM: accept STSI for CPU topology
 information
To:     Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, cohuck@redhat.com,
        thuth@redhat.com, imbrenda@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
References: <1631799845-24860-1-git-send-email-pmorel@linux.ibm.com>
 <1631799845-24860-2-git-send-email-pmorel@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <eef5ed95-3f54-b709-894d-cdf75bc3180b@redhat.com>
Date:   Thu, 16 Sep 2021 16:03:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1631799845-24860-2-git-send-email-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

>   struct kvm_vm_stat {
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 51d1594bd6cd..f3887e13c5db 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -608,6 +608,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>   	case KVM_CAP_S390_PROTECTED:
>   		r = is_prot_virt_host();
>   		break;
> +	case KVM_CAP_S390_CPU_TOPOLOGY:
> +		r = test_facility(11);
> +		break;
>   	default:
>   		r = 0;
>   	}
> @@ -819,6 +822,19 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm, struct kvm_enable_cap *cap)
>   		icpt_operexc_on_all_vcpus(kvm);
>   		r = 0;
>   		break;
> +	case KVM_CAP_S390_CPU_TOPOLOGY:

As given in my example, this should be

r = -EINVAL;
mutex_lock(&kvm->lock);
if (kvm->created_vcpus) {
	r = -EBUSY;
} else if (test_facility(11)) {
...
}

Similar to how we handle KVM_CAP_S390_VECTOR_REGISTERS.

[...]

> +
> +	/* PTF needs both host and guest facilities to enable interpretation */
> +	if (test_kvm_facility(vcpu->kvm, 11) && test_facility(11))
> +		vcpu->arch.sie_block->ecb |= ECB_PTF;

This should be simplified to

if (test_kvm_facility(vcpu->kvm, 11))

then. (vsie code below is correct)


-- 
Thanks,

David / dhildenb

