Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AEECC433F5
	for <linux-s390@archiver.kernel.org>; Thu, 11 Nov 2021 09:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 113DF61247
	for <linux-s390@archiver.kernel.org>; Thu, 11 Nov 2021 09:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbhKKJSY (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 11 Nov 2021 04:18:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57595 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232507AbhKKJSV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 11 Nov 2021 04:18:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636622128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DzCdrCFqHqD5LUIO8ALhA8bCX0Qre82GhYz5NpefANo=;
        b=dSNLJE+h/gfclR4YFSTvIxOX5eIKqfAlKmWam/hfxGEi+uQBb0FsSBZ0ZdU25f+l/hYWb/
        scvQ96dlMVAqAA8I06OUY90FVzDMacP0ajkE6XsW94IYg4hQ8yqbLxc3OgOmXVhVw/jBmf
        buAOA2nbkvENQVx1Z3aUMpZHt2xRlvc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-mB_N7CKMNQejRVcm6knILQ-1; Thu, 11 Nov 2021 04:15:26 -0500
X-MC-Unique: mB_N7CKMNQejRVcm6knILQ-1
Received: by mail-wm1-f70.google.com with SMTP id r6-20020a1c4406000000b0033119c22fdbso2399293wma.4
        for <linux-s390@vger.kernel.org>; Thu, 11 Nov 2021 01:15:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=DzCdrCFqHqD5LUIO8ALhA8bCX0Qre82GhYz5NpefANo=;
        b=lGTDfIDhG0X5v/Gk8QIXrVXQWcG2Kb1y0fGqF0LNvROxVO+r5GiyG84KLkpjS5Yytz
         6BiAIESSr+VR8kFWPdS8NaMgsKi2mKf/K3zob5isUHA38HKBwMvPNsxuREfkRYDflVKC
         JHJ4EXyl56BhNNH4QZbVf8jWxjTj5/6gOu95v6AzBH83mlzJ5pqg6eET60IolGwjlHC3
         SQsyEcPZS+ghly3U9kz3XYGQXllsM/fP8VoP5fRX0nayl5arn14KhN4oPA5zZbQ+ISOt
         htnEqpPMg9SF6r33kgBrpiI1fsslustVfhqdceoinU/XMqBnOom+SZSAXtbGe+eB+yfp
         dOSg==
X-Gm-Message-State: AOAM530EytS2n1VYs2TRqVQJ9JDLyZIsn0+bMSvVeUJ+cCRomHW+hjfG
        z5K1Ctuy4NqhZw7oKEgFSa4dQwg+UWu09SO2/3HT/q6+efKdjjnr/J1Y4EIuwwIpUq/WqODjWAJ
        4trYWXPbrEZoUk6tTfByFlw==
X-Received: by 2002:a1c:4c13:: with SMTP id z19mr23975896wmf.143.1636622125419;
        Thu, 11 Nov 2021 01:15:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzh330gSY0Wg+GWDvGgC36HQMM3ih3srEzvOlbqcm9uHU3iw5G29Vc0cEhVoNESFTvXDKc8rQ==
X-Received: by 2002:a1c:4c13:: with SMTP id z19mr23975871wmf.143.1636622125222;
        Thu, 11 Nov 2021 01:15:25 -0800 (PST)
Received: from [192.168.3.132] (p4ff23ee8.dip0.t-ipconnect.de. [79.242.62.232])
        by smtp.gmail.com with ESMTPSA id g18sm2299923wrv.42.2021.11.11.01.15.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Nov 2021 01:15:24 -0800 (PST)
Message-ID: <dd8a8b49-da6d-0ab8-dc47-b24f5604767f@redhat.com>
Date:   Thu, 11 Nov 2021 10:15:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Eric Farman <farman@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Thomas Huth <thuth@redhat.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20211110203322.1374925-1-farman@linux.ibm.com>
 <20211110203322.1374925-3-farman@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH v3 2/2] KVM: s390: Extend the USER_SIGP capability
In-Reply-To: <20211110203322.1374925-3-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 10.11.21 21:33, Eric Farman wrote:
> With commit 2444b352c3ac ("KVM: s390: forward most SIGP orders to user
> space") we have a capability that allows the "fast" SIGP orders (as
> defined by the Programming Notes for the SIGNAL PROCESSOR instruction in
> the Principles of Operation) to be handled in-kernel, while all others are
> sent to userspace for processing.
> 
> This works fine but it creates a situation when, for example, a SIGP SENSE
> might return CC1 (STATUS STORED, and status bits indicating the vcpu is
> stopped), when in actuality userspace is still processing a SIGP STOP AND
> STORE STATUS order, and the vcpu is not yet actually stopped. Thus, the
> SIGP SENSE should actually be returning CC2 (busy) instead of CC1.
> 
> To fix this, add another CPU capability, dependent on the USER_SIGP one,
> and two associated IOCTLs. One IOCTL will be used by userspace to mark a
> vcpu "busy" processing a SIGP order, and cause concurrent orders handled
> in-kernel to be returned with CC2 (busy). Another IOCTL will be used by
> userspace to mark the SIGP "finished", and the vcpu free to process
> additional orders.
> 

This looks much cleaner to me, thanks!

[...]

> diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
> index c07a050d757d..54371cede485 100644
> --- a/arch/s390/kvm/kvm-s390.h
> +++ b/arch/s390/kvm/kvm-s390.h
> @@ -82,6 +82,22 @@ static inline int is_vcpu_idle(struct kvm_vcpu *vcpu)
>  	return test_bit(vcpu->vcpu_idx, vcpu->kvm->arch.idle_mask);
>  }
>  
> +static inline bool kvm_s390_vcpu_is_sigp_busy(struct kvm_vcpu *vcpu)
> +{
> +	return (atomic_read(&vcpu->arch.sigp_busy) == 1);

You can drop ()

> +}
> +
> +static inline bool kvm_s390_vcpu_set_sigp_busy(struct kvm_vcpu *vcpu)
> +{
> +	/* Return zero for success, or -EBUSY if another vcpu won */
> +	return (atomic_cmpxchg(&vcpu->arch.sigp_busy, 0, 1) == 0) ? 0 : -EBUSY;

You can drop () as well.

We might not need the -EBUSY semantics after all. User space can just
track if it was set, because it's in charge of setting it.

> +}
> +
> +static inline void kvm_s390_vcpu_clear_sigp_busy(struct kvm_vcpu *vcpu)
> +{
> +	atomic_set(&vcpu->arch.sigp_busy, 0);
> +}
> +
>  static inline int kvm_is_ucontrol(struct kvm *kvm)
>  {
>  #ifdef CONFIG_KVM_S390_UCONTROL
> diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/sigp.c
> index 5ad3fb4619f1..a37496ea6dfa 100644
> --- a/arch/s390/kvm/sigp.c
> +++ b/arch/s390/kvm/sigp.c
> @@ -276,6 +276,10 @@ static int handle_sigp_dst(struct kvm_vcpu *vcpu, u8 order_code,
>  	if (!dst_vcpu)
>  		return SIGP_CC_NOT_OPERATIONAL;
>  
> +	if (kvm_s390_vcpu_is_sigp_busy(dst_vcpu)) {
> +		return SIGP_CC_BUSY;
> +	}

You can drop {}

> +
>  	switch (order_code) {
>  	case SIGP_SENSE:
>  		vcpu->stat.instruction_sigp_sense++;
> @@ -411,6 +415,12 @@ int kvm_s390_handle_sigp(struct kvm_vcpu *vcpu)
>  	if (handle_sigp_order_in_user_space(vcpu, order_code, cpu_addr))
>  		return -EOPNOTSUPP;
>  
> +	/* Check the current vcpu, if it was a target from another vcpu */
> +	if (kvm_s390_vcpu_is_sigp_busy(vcpu)) {
> +		kvm_s390_set_psw_cc(vcpu, SIGP_CC_BUSY);
> +		return 0;
> +	}


I don't think we need this. I think the above (checking the target of a
SIGP order) is sufficient. Or which situation do you have in mind?



I do wonder if we want to make this a kvm_arch_vcpu_ioctl() instead,
essentially just providing a KVM_S390_SET_SIGP_BUSY *and* providing the
order. "order == 0" sets it to !busy. Not that we would need the value
right now, but who knows for what we might reuse that interface in the
future.

Thanks!

-- 
Thanks,

David / dhildenb

