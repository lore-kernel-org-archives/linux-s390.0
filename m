Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CEF3C433F5
	for <linux-s390@archiver.kernel.org>; Wed, 18 May 2022 09:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbiERJUG (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 18 May 2022 05:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234045AbiERJUD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 18 May 2022 05:20:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 61C4A14916A
        for <linux-s390@vger.kernel.org>; Wed, 18 May 2022 02:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652865599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FfQDoCx9YIWbfG5ICgqi0/8r2euHWDbQ6lJ6poxNOJI=;
        b=ZkjXhH/NcCwRG4rvdYS3MEITDDOBZzCaALIlKD4MfDw4KQeOn1t5ZfbBE/xt4u/ATIUcK9
        9Xc5T+TMPAcC10vT8bPs+QtDprhiG7TZJvw/zIpsKndQcwNXLinbh3zhMMzVcZL1s7QoXv
        O++SHnUrlhnOOKA0xmp9wmYzMJypjrc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-395-O3A9AJa3NUO4yvQtxeNJ9w-1; Wed, 18 May 2022 05:19:50 -0400
X-MC-Unique: O3A9AJa3NUO4yvQtxeNJ9w-1
Received: by mail-wm1-f72.google.com with SMTP id k35-20020a05600c1ca300b003946a9764baso2626081wms.1
        for <linux-s390@vger.kernel.org>; Wed, 18 May 2022 02:19:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FfQDoCx9YIWbfG5ICgqi0/8r2euHWDbQ6lJ6poxNOJI=;
        b=G/HcSY7HyjBu3Kc216veoEX+zjAMzWmkbG+hqlnHC6glZXSTkLYvDLUgOqTaavUt7X
         b3l4WLGxZAAbTlhZqVdjMd2f+jUcskcglzPFIv0gfK3WXNBu0xhYoSlr4F0kjSHl88mB
         P5qD4NF3ksXzgDZWjMf2WwkKYuT81/PI5JpvDQ0frd3JYK2gQdqU6Uc8AUtTLYPv35bY
         TjCGwDNN18UOeHPd5IDf2KPWDpJXleU56Q6/Yiyfr70fO+d7ov0kLIppnth+RZtGIHqo
         tHovaoYEfVJSOrMmNIN1D2tNhLEMx2msjcw7jpYwz9Med8djoeUwcuEQVJotPM9JPOhp
         RilQ==
X-Gm-Message-State: AOAM530+yOPxAuusTfGWQ2GqGQj4yXpuM1MQB4r1PwmnU85+SUu77u/J
        vG3dHbVaxL85P8dt9POyxyulLO0eJUPST8qqjREI0gyMf9K/Qn575XJ05Ko8QQSzLgbqcdHPQYU
        LvqTi+jZ9T4iKVoYFAqlNng==
X-Received: by 2002:a5d:620c:0:b0:20c:f50a:dafa with SMTP id y12-20020a5d620c000000b0020cf50adafamr19134854wru.460.1652865589422;
        Wed, 18 May 2022 02:19:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzHrtbhj492w0kHpkAlu6o5m/V/peik9KAB4tIG5515RWJkzoHRSpTFHl1FPFzCrDotK9xN7A==
X-Received: by 2002:a5d:620c:0:b0:20c:f50a:dafa with SMTP id y12-20020a5d620c000000b0020cf50adafamr19134831wru.460.1652865589144;
        Wed, 18 May 2022 02:19:49 -0700 (PDT)
Received: from [10.33.192.183] (nat-pool-str-t.redhat.com. [149.14.88.106])
        by smtp.gmail.com with ESMTPSA id p14-20020a05600c1d8e00b0039456fb80b3sm3774686wms.43.2022.05.18.02.19.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 02:19:48 -0700 (PDT)
Message-ID: <a44b1bd2-db54-6c8a-d80f-e2cc645207b2@redhat.com>
Date:   Wed, 18 May 2022 11:19:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v7 20/22] KVM: s390: add KVM_S390_ZPCI_OP to manage guest
 zPCI devices
Content-Language: en-US
To:     Matthew Rosato <mjrosato@linux.ibm.com>, linux-s390@vger.kernel.org
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        schnelle@linux.ibm.com, farman@linux.ibm.com, pmorel@linux.ibm.com,
        borntraeger@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com,
        imbrenda@linux.ibm.com, vneethv@linux.ibm.com,
        oberpar@linux.ibm.com, freude@linux.ibm.com, pasic@linux.ibm.com,
        pbonzini@redhat.com, corbet@lwn.net, jgg@nvidia.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20220513191509.272897-1-mjrosato@linux.ibm.com>
 <20220513191509.272897-21-mjrosato@linux.ibm.com>
 <7b13aca2-fb3e-3b84-8d3d-e94966fac5f2@redhat.com>
 <0c6a4f7b-f43a-8f4c-49bb-db10ca010f1f@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <0c6a4f7b-f43a-8f4c-49bb-db10ca010f1f@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 16/05/2022 17.35, Matthew Rosato wrote:
> On 5/16/22 5:52 AM, Thomas Huth wrote:
>> On 13/05/2022 21.15, Matthew Rosato wrote:
>>> The KVM_S390_ZPCI_OP ioctl provides a mechanism for managing
>>> hardware-assisted virtualization features for s390X zPCI passthrough.
>>
>> s/s390X/s390x/
>>
>>> Add the first 2 operations, which can be used to enable/disable
>>> the specified device for Adapter Event Notification interpretation.
>>>
>>> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
>>> ---
>>>   Documentation/virt/kvm/api.rst | 45 +++++++++++++++++++
>>>   arch/s390/kvm/kvm-s390.c       | 23 ++++++++++
>>>   arch/s390/kvm/pci.c            | 81 ++++++++++++++++++++++++++++++++++
>>>   arch/s390/kvm/pci.h            |  2 +
>>>   include/uapi/linux/kvm.h       | 31 +++++++++++++
>>>   5 files changed, 182 insertions(+)
>>>
>>> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
>>> index 4a900cdbc62e..a7cd5ebce031 100644
>>> --- a/Documentation/virt/kvm/api.rst
>>> +++ b/Documentation/virt/kvm/api.rst
>>> @@ -5645,6 +5645,51 @@ enabled with ``arch_prctl()``, but this may change 
>>> in the future.
>>>   The offsets of the state save areas in struct kvm_xsave follow the 
>>> contents
>>>   of CPUID leaf 0xD on the host.
>>> +4.135 KVM_S390_ZPCI_OP
>>> +--------------------
>>> +
>>> +:Capability: KVM_CAP_S390_ZPCI_OP
>>> +:Architectures: s390
>>> +:Type: vcpu ioctl
>>
>> vcpu? ... you're wiring it up in  kvm_arch_vm_ioctl() later, so I assume 
>> it's rather a VM ioctl?
> 
> Yup, VM ioctl, bad copy/paste job...
> 
>>
>>> +:Parameters: struct kvm_s390_zpci_op (in)
>>> +:Returns: 0 on success, <0 on error
>>> +
>>> +Used to manage hardware-assisted virtualization features for zPCI devices.
>>> +
>>> +Parameters are specified via the following structure::
>>> +
>>> +  struct kvm_s390_zpci_op {
>>> +    /* in */
>>
>> If all is "in", why is there a copy_to_user() in the code later?
>>
> 
> Oh no, this is a leftover from a prior version...  Good catch.  There should 
> no longer be a copy_to_user.
> 
>>> +    __u32 fh;        /* target device */
>>> +    __u8  op;        /* operation to perform */
>>> +    __u8  pad[3];
>>> +    union {
>>> +        /* for KVM_S390_ZPCIOP_REG_AEN */
>>> +        struct {
>>> +            __u64 ibv;    /* Guest addr of interrupt bit vector */
>>> +            __u64 sb;    /* Guest addr of summary bit */
>>
>> If this is really a vcpu ioctl, what kind of addresses are you talking 
>> about here? virtual addresses? real addresses? absolute addresses?
> 
> It's a VM ioctl.  These are guest kernel physical addresses that are later 
> pinned in arch/s390/kvm/pci.c:kvm_s390_pci_aif_enable() as part of handling 
> the ioctl.
> 
>>
>>> +            __u32 flags;
>>> +            __u32 noi;    /* Number of interrupts */
>>> +            __u8 isc;    /* Guest interrupt subclass */
>>> +            __u8 sbo;    /* Offset of guest summary bit vector */
>>> +            __u16 pad;
>>> +        } reg_aen;
>>> +        __u64 reserved[8];
>>> +    } u;
>>> +  };
>>> +
>>> +The type of operation is specified in the "op" field.
>>> +KVM_S390_ZPCIOP_REG_AEN is used to register the VM for adapter event
>>> +notification interpretation, which will allow firmware delivery of adapter
>>> +events directly to the vm, with KVM providing a backup delivery mechanism;
>>> +KVM_S390_ZPCIOP_DEREG_AEN is used to subsequently disable interpretation of
>>> +adapter event notifications.
>>> +
>>> +The target zPCI function must also be specified via the "fh" field. For the
>>> +KVM_S390_ZPCIOP_REG_AEN operation, additional information to establish 
>>> firmware
>>> +delivery must be provided via the "reg_aen" struct.
>>> +
>>> +The "reserved" field is meant for future extensions.
>>
>> Maybe also mention the "pad" fields? And add should these also be 
>> initialized to 0 by the calling userspace program?
> 
> Sure, I can mention them.  And yes, I agree that userspace should initialize 
> them to 0, I'll update the QEMU series accordingly.

I just spotted the corresponding patch in the QEMU series, and I think it 
should already be fine there, since you're using "= { ... }" while declaring 
the variables:

+int s390_pci_kvm_aif_disable(S390PCIBusDevice *pbdev)
+{
+    struct kvm_s390_zpci_op args = {
+        .fh = pbdev->fh,
+        .op = KVM_S390_ZPCIOP_DEREG_AEN
+    };

That means unspecified fields will be set to 0 by the compiler already, as 
far as I know.

  Thomas

