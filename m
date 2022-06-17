Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E569C433EF
	for <linux-s390@archiver.kernel.org>; Fri, 17 Jun 2022 16:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbiFQQPs (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 17 Jun 2022 12:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiFQQPs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 17 Jun 2022 12:15:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 40C08220FA
        for <linux-s390@vger.kernel.org>; Fri, 17 Jun 2022 09:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655482546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G9hj+GC+aBxxfrK7yuFLDUJOFaX8GPKOTNDfbOgBveY=;
        b=UgzTbiM7C/OtPS42a/pxfF48F9Wy0xRN3NtxKB2p4Hwli4MS/opfP5zuPp+4YP4hqqOXr/
        J71Baj+zruD0aLBXSw3jr5xNBEtAu1Lkp9Qx37SIBpQx/ZP0ke4i3RX3krOUuddsvyRgxR
        rQwhmkF9yBj3LJJEGIhzY7r0RLxqcv0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-672-VO8PoQDUNCyqoKvjjUsPhA-1; Fri, 17 Jun 2022 12:15:44 -0400
X-MC-Unique: VO8PoQDUNCyqoKvjjUsPhA-1
Received: by mail-wm1-f69.google.com with SMTP id o3-20020a05600c510300b0039743540ac7so1699667wms.5
        for <linux-s390@vger.kernel.org>; Fri, 17 Jun 2022 09:15:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=G9hj+GC+aBxxfrK7yuFLDUJOFaX8GPKOTNDfbOgBveY=;
        b=qSVuEx3sltq2VoGrBJ+Qh5AFfanl0fp+pQCaQrXZ3wPJyjGEkzEftOlGcInCRXBr7L
         HegmG2MyAtfb6Y2xPNnEOwPfMWHCp3ZXZhbF4fP9kEhlMFye34/0qnZu67e6bTIENvkj
         FfR0VZU0Ztn2MrgtDOJ4l1UK3Bly+Ljak7OslXin7MbIpZTbXBcstGKrsKMqteKut0Fv
         kBQg5BNfodN0RL8NN8RTcMsZ2KuUgg2ahcWQQtr2b4xQRCsNIwvmJWSiAArmreoU2Km6
         puFQQ5DXFY0FVEGZ1rT2kpHR3Z2GZGlTPOuGFC6vMJKAqrBESYp3BneYVgLZuEjLMAhC
         dKYg==
X-Gm-Message-State: AOAM533GaC0p4ss5OQdwcjlfuIuEVpB2g01Rt2hsKpDIW/p/aPAEZ/dF
        btY95z4rP1Eg753UT3M5yzTgWKMVFNQCynehaxAftFdRwQjTk3JnJPR2KkKY1sRJ3tAvcewA3/a
        wXWkO3w2pWgt294ncucwJFA==
X-Received: by 2002:a05:600c:1e1c:b0:39c:65a1:7c3a with SMTP id ay28-20020a05600c1e1c00b0039c65a17c3amr21846093wmb.6.1655482543313;
        Fri, 17 Jun 2022 09:15:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxNQe0PgFJtejDko6ChfFkosKXqzaWavu1x2uNghCcippSLjJ1BbZ5IDIaHpE1QnmVpjqgpaQ==
X-Received: by 2002:a05:600c:1e1c:b0:39c:65a1:7c3a with SMTP id ay28-20020a05600c1e1c00b0039c65a17c3amr21846038wmb.6.1655482542887;
        Fri, 17 Jun 2022 09:15:42 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-42-114-75.web.vodafone.de. [109.42.114.75])
        by smtp.gmail.com with ESMTPSA id c7-20020a05600c0a4700b003942a244f51sm8708616wmq.42.2022.06.17.09.15.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 09:15:42 -0700 (PDT)
Message-ID: <08c0cf37-afd2-bad3-d1e4-88667e3e5b69@redhat.com>
Date:   Fri, 17 Jun 2022 18:15:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v9 10/21] vfio/pci: introduce CONFIG_VFIO_PCI_ZDEV_KVM
Content-Language: en-US
To:     Pierre Morel <pmorel@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        linux-s390@vger.kernel.org
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        schnelle@linux.ibm.com, farman@linux.ibm.com,
        borntraeger@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com,
        imbrenda@linux.ibm.com, vneethv@linux.ibm.com,
        oberpar@linux.ibm.com, freude@linux.ibm.com, pasic@linux.ibm.com,
        pbonzini@redhat.com, corbet@lwn.net, jgg@nvidia.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20220606203325.110625-1-mjrosato@linux.ibm.com>
 <20220606203325.110625-11-mjrosato@linux.ibm.com>
 <025699e6-b870-2648-d4a4-ffbc5fff22e8@redhat.com>
 <ac5cd90a-c92b-1bad-fbec-d1ca6287e826@linux.ibm.com>
 <69ec8abd-c579-46d0-08cd-2714de91b6cb@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <69ec8abd-c579-46d0-08cd-2714de91b6cb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 14/06/2022 10.56, Pierre Morel wrote:
> 
> 
> On 6/8/22 15:15, Matthew Rosato wrote:
>> On 6/8/22 2:19 AM, Thomas Huth wrote:
>>> On 06/06/2022 22.33, Matthew Rosato wrote:
>>>> The current contents of vfio-pci-zdev are today only useful in a KVM
>>>> environment; let's tie everything currently under vfio-pci-zdev to
>>>> this Kconfig statement and require KVM in this case, reducing complexity
>>>> (e.g. symbol lookups).
>>>>
>>>> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> 
> Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
> 
> 
>>>> ---
>>>>   drivers/vfio/pci/Kconfig      | 11 +++++++++++
>>>>   drivers/vfio/pci/Makefile     |  2 +-
>>>>   include/linux/vfio_pci_core.h |  2 +-
>>>>   3 files changed, 13 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
>>>> index 4da1914425e1..f9d0c908e738 100644
>>>> --- a/drivers/vfio/pci/Kconfig
>>>> +++ b/drivers/vfio/pci/Kconfig
>>>> @@ -44,6 +44,17 @@ config VFIO_PCI_IGD
>>>>         To enable Intel IGD assignment through vfio-pci, say Y.
>>>>   endif
>>>> +config VFIO_PCI_ZDEV_KVM
>>>> +    bool "VFIO PCI extensions for s390x KVM passthrough"
>>>> +    depends on S390 && KVM
>>>> +    default y
>>>> +    help
>>>> +      Support s390x-specific extensions to enable support for enhancements
>>>> +      to KVM passthrough capabilities, such as interpretive execution of
>>>> +      zPCI instructions.
>>>> +
>>>> +      To enable s390x KVM vfio-pci extensions, say Y.
>>>
>>> Is it still possible to disable CONFIG_VFIO_PCI_ZDEV_KVM ? Looking at the 
>>> later patches (e.g. 20/21 where you call kvm_s390_pci_zpci_op() from 
>>> kvm-s390.c), it rather seems to me that it currently cannot be disabled 
>>> independently (as long as KVM is enabled).
>>
>> Yes, you can build with, for example, CONFIG_VFIO_PCI_ZDEV_KVM=n and 
>> CONFIG_KVM=m -- I tested it again just now.  The result is kvm and 
>> vfio-pci are built and vfio-pci works, but none of the vfio-pci-zdev 
>> extensions are available (including zPCI interpretation).
>>
>> This is accomplished via the placement of some IS_ENABLED checks.  Some 
>> calls (e.g. AEN init) are fenced by IS_ENABLED(CONFIG_VFIO_PCI_ZDEV_KVM).  
>> There are also some areas that are fenced off via a call to 
>> kvm_s390_pci_interp_allowed() which also includes an IS_ENABLED check 
>> along with checks for facility and cpu id.
>>
>> Using patch 20 as an example, KVM_CAP_S390_ZPCI_OP will always be reported 
>> as unavailable to userspace if CONFIG_VFIO_PCI_ZDEV_KVM=n due to the call 
>> to kvm_s390_pci_interp_allowed().  If userspace sends us the ioctl anyway, 
>> we will return -EINVAL because there is again a 
>> IS_ENABLED(CONFIG_VFIO_PCI_ZDEV_KVM) check before we read the ioctl args 
>> from userspace.
> 
> Yes and the code will not be generated by the compiler in patch 20 after the 
> break if CONFIG_VFIO_PCI_ZDEV_KVM is not enabled.
> 
> +    case KVM_S390_ZPCI_OP: {
> +        struct kvm_s390_zpci_op args;
> +
> +        r = -EINVAL;
> +        if (!IS_ENABLED(CONFIG_VFIO_PCI_ZDEV_KVM))
> +            break;
> 
> Code not generated----v
> 
> +        if (copy_from_user(&args, argp, sizeof(args))) {
> +            r = -EFAULT;
> +            break;
> +        }
> +        r = kvm_s390_pci_zpci_op(kvm, &args);
> +        break;
> 
> ----------^

OK, good to know, thanks for the clarification!

  Thomas

