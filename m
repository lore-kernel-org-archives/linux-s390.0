Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C421C07E99
	for <linux-s390@archiver.kernel.org>; Mon,  5 Jul 2021 10:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A1BF60200
	for <linux-s390@archiver.kernel.org>; Mon,  5 Jul 2021 10:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbhGEKT3 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 5 Jul 2021 06:19:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22823 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230421AbhGEKT1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 5 Jul 2021 06:19:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625480210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nbFoAzVILeq1vaQ6QYXxMMsMhWIu9fZZUnayrh9ZvL0=;
        b=RVXZERP5aSYjgdQjMHoG8uXMSlryLFcKw4t7PHhsWS17F02cJ1iNbEW/cWtth7G4WCd6fI
        ASBwDrmPD3OX6IXwW47uO3i9v68zN1+VFjkkBZzc5pfFE3hFYwwu3NdBzf7JCyyM+4ErrX
        LkkIVRXxEqkFUCf+VrSbxCrewNdB2Kc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-MVLOahjDPhuxtgFZrbVQ1Q-1; Mon, 05 Jul 2021 06:16:49 -0400
X-MC-Unique: MVLOahjDPhuxtgFZrbVQ1Q-1
Received: by mail-wr1-f69.google.com with SMTP id i17-20020a5d43910000b02901258b767ad5so6049023wrq.2
        for <linux-s390@vger.kernel.org>; Mon, 05 Jul 2021 03:16:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nbFoAzVILeq1vaQ6QYXxMMsMhWIu9fZZUnayrh9ZvL0=;
        b=VK2ZWVxnPQBPlmuADI4oHIjk9LJVq5tH7WbHOu1uF692IPN4+2+DIZndMxCFWi9fEM
         VNQrvVa60ixtlUnOIVJ8Lg1Y1+g3FvZcKGPRkEstPMYgsPkY+UyULZ+ZJzgEi+5udp5B
         XLBSAGwcKdM6F2YKwrj+0eUQA4IA6Iq9enDchrdW0Na9o9SpQWwDzY3n3l44fcykrFNH
         HWSunIeWZq3jdNizqu/LdH0FeP9B4/FMSE0JdEDpUGq02nA+Mjx+AeQuhqszd/mpntsy
         mEt/afxN3cH2GpXf5jgKUxW9Ix+uU17fs6qqqpLALIyGPCwAWV4KQF5GeBDjKQiiYkug
         5PNw==
X-Gm-Message-State: AOAM530Wni4aAuDKOVRBk+9ZA2XQRXZ+glszASZOyltV+BRJLL47kCTo
        vhNxUaJkrfUMSNf6UKU+g4aBg6BJP1LsY52moOlclH0Gy+CrG6otdzihIMyStY7XcUiQiY7pewa
        cDfoiyWobimNIjPyMRv4n4w==
X-Received: by 2002:a5d:5985:: with SMTP id n5mr8607900wri.63.1625480208089;
        Mon, 05 Jul 2021 03:16:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1AYbsAxlmgoUz32zzV3wCNrATL42NVs9zK91n/Mwbq4wN1u52Qc566qS9clkG8rFnSVPr+g==
X-Received: by 2002:a5d:5985:: with SMTP id n5mr8607875wri.63.1625480207894;
        Mon, 05 Jul 2021 03:16:47 -0700 (PDT)
Received: from thuth.remote.csb (pd9575e1e.dip0.t-ipconnect.de. [217.87.94.30])
        by smtp.gmail.com with ESMTPSA id h15sm12284938wrq.88.2021.07.05.03.16.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jul 2021 03:16:47 -0700 (PDT)
Subject: Re: [PATCH/RFC] KVM: selftests: introduce P44V64 for z196 and EC12
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        KVM <kvm@vger.kernel.org>
Cc:     Cornelia Huck <cohuck@redhat.com>,
        Janosch Frank <frankja@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <20210701153853.33063-1-borntraeger@de.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Message-ID: <9b80d35e-0696-5938-8565-9e92aa359829@redhat.com>
Date:   Mon, 5 Jul 2021 12:16:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210701153853.33063-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 01/07/2021 17.38, Christian Borntraeger wrote:
> Older machines likes z196 and zEC12 do only support 44 bits of physical
> addresses. Make this the default and check via IBC if we are on a later
> machine. We then add P47V64 as an additional model.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Fixes: 1bc603af73dd ("KVM: selftests: introduce P47V64 for s390x")
> ---
>   tools/testing/selftests/kvm/include/kvm_util.h |  3 ++-
>   tools/testing/selftests/kvm/lib/guest_modes.c  | 16 ++++++++++++++++
>   tools/testing/selftests/kvm/lib/kvm_util.c     |  5 +++++
>   3 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> index 35739567189e..74d73532fce9 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> @@ -44,6 +44,7 @@ enum vm_guest_mode {
>   	VM_MODE_P40V48_64K,
>   	VM_MODE_PXXV48_4K,	/* For 48bits VA but ANY bits PA */
>   	VM_MODE_P47V64_4K,
> +	VM_MODE_P44V64_4K,
>   	NUM_VM_MODES,
>   };
>   
> @@ -61,7 +62,7 @@ enum vm_guest_mode {
>   
>   #elif defined(__s390x__)
>   
> -#define VM_MODE_DEFAULT			VM_MODE_P47V64_4K
> +#define VM_MODE_DEFAULT			VM_MODE_P44V64_4K
>   #define MIN_PAGE_SHIFT			12U
>   #define ptes_per_page(page_size)	((page_size) / 16)
>   
> diff --git a/tools/testing/selftests/kvm/lib/guest_modes.c b/tools/testing/selftests/kvm/lib/guest_modes.c
> index 25bff307c71f..c330f414ef96 100644
> --- a/tools/testing/selftests/kvm/lib/guest_modes.c
> +++ b/tools/testing/selftests/kvm/lib/guest_modes.c
> @@ -22,6 +22,22 @@ void guest_modes_append_default(void)
>   		}
>   	}
>   #endif
> +#ifdef __s390x__
> +	{
> +		int kvm_fd, vm_fd;
> +		struct kvm_s390_vm_cpu_processor info;
> +
> +		kvm_fd = open_kvm_dev_path_or_exit();
> +		vm_fd = ioctl(kvm_fd, KVM_CREATE_VM, 0);
> +		kvm_device_access(vm_fd, KVM_S390_VM_CPU_MODEL,
> +				  KVM_S390_VM_CPU_PROCESSOR, &info, false);
> +		close(vm_fd);
> +		close(kvm_fd);
> +		/* Starting with z13 we have 47bits of physical address */
> +		if (info.ibc >= 0x30)
> +			guest_mode_append(VM_MODE_P47V64_4K, true, true);

Wouldn't it make more sense to check the processor number in /proc/cpuinfo? 
... well, I guess both ways of checking have their advantages and 
disadvantages, so anyway:

Reviewed-by: Thomas Huth <thuth@redhat.com>

