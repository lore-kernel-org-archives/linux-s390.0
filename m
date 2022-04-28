Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690DDC433F5
	for <linux-s390@archiver.kernel.org>; Thu, 28 Apr 2022 13:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347753AbiD1NyU (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 28 Apr 2022 09:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347747AbiD1NyS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 28 Apr 2022 09:54:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2AF5A5EBFB
        for <linux-s390@vger.kernel.org>; Thu, 28 Apr 2022 06:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651153863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FuiynTfD1RLuR66vVTzTONoWwWN8fYgLX9NPTT/dKvI=;
        b=H40Vs0hZYK73Ys0lWamTM8JWe4QaEQLb/LhhkoP4Kef281TsVKJAsHBUFz+aM2C+Zxz2ny
        XoPNOtEq5eklxSbaWi38aoq2CulY6BnxH86EpxT3pyNNTIl3n2KoSPNzkxudEi7TH05HLo
        /uTxz55vWKrJB+RAh4Zl88iCAhRMpLw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-169-1EGBl-3mP1eUALWBz5preQ-1; Thu, 28 Apr 2022 09:50:58 -0400
X-MC-Unique: 1EGBl-3mP1eUALWBz5preQ-1
Received: by mail-wm1-f71.google.com with SMTP id p32-20020a05600c1da000b00393fbf9ab6eso3459457wms.4
        for <linux-s390@vger.kernel.org>; Thu, 28 Apr 2022 06:50:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=FuiynTfD1RLuR66vVTzTONoWwWN8fYgLX9NPTT/dKvI=;
        b=pFWuzKBMm42De3AyUfhe4yuSr5UoIpduAHXVzW7MefN4zspiehTqF5K7tkMUIGiBQh
         hrk4uMdi4g8fe/3v3l8GptSaW8whEoQunUjYeDZTYc3IDeEIzXegAL32o62LakXu+7p6
         0W3Bxg8/3ZlMoT9YLKHEj75+oiqNoBQkjYu+cQTfFBC0stH3b5Ex3LCZCdvavUKZGTzY
         uOkYXepDXF+J7u7s0DXLtrhTH4kVhaX07mYksYFgW6SrSxlAL/8fk/T1HTfomySgaknt
         7hVRBqhkHi3lydfFhWXJpgivQiuLJ6Lz8JBR9EoFlOEyXrfZ/iSB5TFQ2u0f6tSYN1YB
         69Ng==
X-Gm-Message-State: AOAM530ADcrZUOKKp+AvgRo8sG8AUXOuHMiW+xFgnUh/R45t18X3cBap
        N7dyn02mVbhASj1gOf+wQ/qRALV+iRS0cm7EKIByWrAPAmN4tbsIlkbYWFxfbJM4MRRXrLSvWaV
        QX7RDyF5IWAMYmtkUfk6kpA==
X-Received: by 2002:a05:600c:190b:b0:392:95b8:5b18 with SMTP id j11-20020a05600c190b00b0039295b85b18mr39560231wmq.152.1651153857205;
        Thu, 28 Apr 2022 06:50:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzeVPvVPpXXrRQLuvUge6iFuS32PuH9PMzyLJBTvWQmhu79zqAA4V53hn1tleu4LtR6OCxdgA==
X-Received: by 2002:a05:600c:190b:b0:392:95b8:5b18 with SMTP id j11-20020a05600c190b00b0039295b85b18mr39560218wmq.152.1651153856918;
        Thu, 28 Apr 2022 06:50:56 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:ef00:7443:a23c:26b8:b96? (p200300cbc708ef007443a23c26b80b96.dip0.t-ipconnect.de. [2003:cb:c708:ef00:7443:a23c:26b8:b96])
        by smtp.gmail.com with ESMTPSA id p18-20020adfa212000000b0020adf08d88asm8984368wra.116.2022.04.28.06.50.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 06:50:55 -0700 (PDT)
Message-ID: <22f7742e-c009-c53b-8f14-34156ea1d135@redhat.com>
Date:   Thu, 28 Apr 2022 15:50:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-US
To:     Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, cohuck@redhat.com,
        thuth@redhat.com, imbrenda@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, wintera@linux.ibm.com, seiden@linux.ibm.com,
        nrb@linux.ibm.com
References: <20220420113430.11876-1-pmorel@linux.ibm.com>
 <20220420113430.11876-3-pmorel@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v8 2/2] s390x: KVM: resetting the Topology-Change-Report
In-Reply-To: <20220420113430.11876-3-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 20.04.22 13:34, Pierre Morel wrote:
> During a subsystem reset the Topology-Change-Report is cleared.
> Let's give userland the possibility to clear the MTCR in the case
> of a subsystem reset.
> 
> To migrate the MTCR, let's give userland the possibility to
> query the MTCR state.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  arch/s390/include/uapi/asm/kvm.h |   9 +++
>  arch/s390/kvm/kvm-s390.c         | 103 +++++++++++++++++++++++++++++++
>  2 files changed, 112 insertions(+)
> 
> diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
> index 7a6b14874d65..bb3df6d49f27 100644
> --- a/arch/s390/include/uapi/asm/kvm.h
> +++ b/arch/s390/include/uapi/asm/kvm.h
> @@ -74,6 +74,7 @@ struct kvm_s390_io_adapter_req {
>  #define KVM_S390_VM_CRYPTO		2
>  #define KVM_S390_VM_CPU_MODEL		3
>  #define KVM_S390_VM_MIGRATION		4
> +#define KVM_S390_VM_CPU_TOPOLOGY	5
>  
>  /* kvm attributes for mem_ctrl */
>  #define KVM_S390_VM_MEM_ENABLE_CMMA	0
> @@ -171,6 +172,14 @@ struct kvm_s390_vm_cpu_subfunc {
>  #define KVM_S390_VM_MIGRATION_START	1
>  #define KVM_S390_VM_MIGRATION_STATUS	2
>  
> +/* kvm attributes for cpu topology */
> +#define KVM_S390_VM_CPU_TOPO_MTR_CLEAR	0
> +#define KVM_S390_VM_CPU_TOPO_MTR_SET	1
> +
> +struct kvm_s390_cpu_topology {
> +	__u16 mtcr;
> +};

Just wondering:

1) Do we really need a struct for that
2) Do we want to leave some room for later expansion?

> +
>  /* for KVM_GET_REGS and KVM_SET_REGS */
>  struct kvm_regs {
>  	/* general purpose regs for s390 */
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 925ccc59f283..755f325c9e70 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -1756,6 +1756,100 @@ static int kvm_s390_sca_set_mtcr(struct kvm *kvm)
>  	return 0;
>  }
>  
> +/**
> + * kvm_s390_sca_clear_mtcr
> + * @kvm: guest KVM description
> + *
> + * Is only relevant if the topology facility is present,
> + * the caller should check KVM facility 11
> + *
> + * Updates the Multiprocessor Topology-Change-Report to signal
> + * the guest with a topology change.
> + */
> +static int kvm_s390_sca_clear_mtcr(struct kvm *kvm)
> +{
> +	struct bsca_block *sca = kvm->arch.sca;
> +	struct kvm_vcpu *vcpu;
> +	int val;
> +
> +	vcpu = kvm_s390_get_first_vcpu(kvm);
> +	if (!vcpu)
> +		return -ENODEV;

It would be cleaner to have ipte_lock/ipte_unlock variants that are
independent of a vcpu.

Instead of checking for "vcpu->arch.sie_block->eca & ECA_SII" we might
just check for sclp.has_siif. Everything else that performs the
lock/unlock should be contained in "struct kvm" directly, unless I am
missing something.

[...]

> +
> +static int kvm_s390_get_topology(struct kvm *kvm, struct kvm_device_attr *attr)
> +{
> +	struct kvm_s390_cpu_topology *topology;
> +	int ret = 0;
> +
> +	if (!test_kvm_facility(kvm, 11))
> +		return -ENXIO;
> +
> +	topology = kzalloc(sizeof(*topology), GFP_KERNEL);
> +	if (!topology)
> +		return -ENOMEM;

I'm confused. We're allocating a __u16 to then free it again below? Why
not simply use a value on the stack like in kvm_s390_vm_get_migration()?



u16 mtcr;
...
mtcr = kvm_s390_sca_get_mtcr(kvm);

if (copy_to_user((void __user *)attr->addr, &mtcr, sizeof(mtcr)))
	return -EFAULT;
return 0;



> +
> +	topology->mtcr =  kvm_s390_sca_get_mtcr(kvm);

s/  / /

> +	if (copy_to_user((void __user *)attr->addr, topology,
> +			 sizeof(struct kvm_s390_cpu_topology)))
> +		ret = -EFAULT;
> +
> +	kfree(topology);
> +	return ret;
> +}
> +


-- 
Thanks,

David / dhildenb

