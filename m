Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDEAC001B0
	for <linux-s390@archiver.kernel.org>; Mon, 24 Jul 2023 11:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjGXLdi (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 24 Jul 2023 07:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjGXLcx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 24 Jul 2023 07:32:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DDD1700
        for <linux-s390@vger.kernel.org>; Mon, 24 Jul 2023 04:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690198278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JfpT+mnZfrCac16v3aInlmHimudhY8zZWOx9+CfU5jI=;
        b=GQvO7aICKvu/RXr6lTBdWrb/116vxCs6mrf/5bYBz5vwKwvY/AxfKNDthtfRG1zQG0d6DK
        ni3e86mR04dyfhYH8CsKXIQTO2w/2brQtrvYHuMGhRTf8VWOzRebrWZ8W8EELvaGbShkaK
        QbcnXJIpuB3MOaCRHoqHytw8mDpjjBE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-L_npn5FGNSyl719Iwi3RNg-1; Mon, 24 Jul 2023 07:31:17 -0400
X-MC-Unique: L_npn5FGNSyl719Iwi3RNg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fbb0fdd060so26568475e9.0
        for <linux-s390@vger.kernel.org>; Mon, 24 Jul 2023 04:31:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690198276; x=1690803076;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JfpT+mnZfrCac16v3aInlmHimudhY8zZWOx9+CfU5jI=;
        b=KtsbthUEQFag0CkxO918m+2fpiZ3PTVDs+07RDtx8l0QH7+Fot6ClYINeN/ploL1Cr
         nHz66TlyVhCC0RPPGEwDqLEvGUSx2czU+RIdtssAKXcK6E1hjfDnd3PRvAahXrdEx1GQ
         D9PkvG2XBivKWPt5WotwPEDHRirLnSyj9ro/PJf4nD63cUVxN+DmATvOXqrtbyrarMTQ
         94pxQ5Q48pYQ5AU4C9qss1TNEsLpA78fqFBXqFLWozcSEgu19dHyhnVh1OW3ZPs48e+J
         wJ3Cysxg566DgisT6dHAms2lxEAAjZavUQbRm2g8XBJH0zEWlnUwJI+LRYgbuQDHOJEv
         eRcA==
X-Gm-Message-State: ABy/qLbvZpXNDhJ15OMWmPYdzqJLdOoqHcNYGQ0Q3jdrFIKb4j5mb5tq
        6DMvXPVUV2P3yvnjHfVyLf7fgwYZUSWkNSGxU3wdazusZ0sg+9yc+l/bdv5Ml7aSZlH8dv3Vx/g
        zVz0g9G81ZsJMIDxnZGQCQQ==
X-Received: by 2002:a05:600c:2242:b0:3fb:c990:3b2 with SMTP id a2-20020a05600c224200b003fbc99003b2mr7772964wmm.34.1690198276013;
        Mon, 24 Jul 2023 04:31:16 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGUPL3n/cnC/PIyIMNs1cuvjFmNfmTxRquxzSGXY0jphihcdCijrhdx91U2TwsjxeP5mV4SyQ==
X-Received: by 2002:a05:600c:2242:b0:3fb:c990:3b2 with SMTP id a2-20020a05600c224200b003fbc99003b2mr7772946wmm.34.1690198275671;
        Mon, 24 Jul 2023 04:31:15 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73d:bb00:91a5:d1c:3a7e:4c77? (p200300cbc73dbb0091a50d1c3a7e4c77.dip0.t-ipconnect.de. [2003:cb:c73d:bb00:91a5:d1c:3a7e:4c77])
        by smtp.gmail.com with ESMTPSA id y19-20020a05600c20d300b003fd2d33f972sm5802964wmm.38.2023.07.24.04.31.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 04:31:15 -0700 (PDT)
Message-ID: <170e3285-2e01-840e-21bc-39dbad256542@redhat.com>
Date:   Mon, 24 Jul 2023 13:31:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 4/6] KVM: s390: interrupt: Fix single-stepping
 userspace-emulated instructions
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Sven Schnelle <svens@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Freimann <jfreimann@redhat.com>
References: <20230724094716.91510-1-iii@linux.ibm.com>
 <20230724094716.91510-5-iii@linux.ibm.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230724094716.91510-5-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 24.07.23 11:44, Ilya Leoshkevich wrote:
> Single-stepping a userspace-emulated instruction that generates an
> interrupt causes GDB to land on the instruction following it instead of
> the respective interrupt handler.
> 
> The reason is that after arranging a KVM_EXIT_S390_SIEIC exit,
> kvm_handle_sie_intercept() calls kvm_s390_handle_per_ifetch_icpt(),
> which sets KVM_GUESTDBG_EXIT_PENDING. This bit, however, is not
> processed immediately, but rather persists until the next ioctl(),
> causing a spurious single-step exit.
> 
> Fix by clearing this bit in ioctl().
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   arch/s390/kvm/kvm-s390.c | 23 ++++++++++++++++++++---
>   1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 0c6333b108ba..e6511608280c 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -5383,6 +5383,7 @@ long kvm_arch_vcpu_async_ioctl(struct file *filp,
>   {
>   	struct kvm_vcpu *vcpu = filp->private_data;
>   	void __user *argp = (void __user *)arg;
> +	int rc;
>   
>   	switch (ioctl) {
>   	case KVM_S390_IRQ: {
> @@ -5390,7 +5391,8 @@ long kvm_arch_vcpu_async_ioctl(struct file *filp,
>   
>   		if (copy_from_user(&s390irq, argp, sizeof(s390irq)))
>   			return -EFAULT;
> -		return kvm_s390_inject_vcpu(vcpu, &s390irq);
> +		rc = kvm_s390_inject_vcpu(vcpu, &s390irq);
> +		break;
>   	}
>   	case KVM_S390_INTERRUPT: {
>   		struct kvm_s390_interrupt s390int;
> @@ -5400,10 +5402,25 @@ long kvm_arch_vcpu_async_ioctl(struct file *filp,
>   			return -EFAULT;
>   		if (s390int_to_s390irq(&s390int, &s390irq))
>   			return -EINVAL;
> -		return kvm_s390_inject_vcpu(vcpu, &s390irq);
> +		rc = kvm_s390_inject_vcpu(vcpu, &s390irq);
> +		break;
>   	}
> +	default:
> +		rc = -ENOIOCTLCMD;
> +		break;
>   	}
> -	return -ENOIOCTLCMD;
> +
> +	/*
> +	 * To simplify single stepping of userspace-emulated instructions,
> +	 * KVM_EXIT_S390_SIEIC exit sets KVM_GUESTDBG_EXIT_PENDING (see
> +	 * should_handle_per_ifetch()). However, if userspace emulation injects
> +	 * an interrupt, it needs to be cleared, so that KVM_EXIT_DEBUG happens
> +	 * after (and not before) the interrupt delivery.
> +	 */
> +	if (!rc)
> +		vcpu->guest_debug &= ~KVM_GUESTDBG_EXIT_PENDING;
> +
> +	return rc;
>   }
>   
>   static int kvm_s390_handle_pv_vcpu_dump(struct kvm_vcpu *vcpu,

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

