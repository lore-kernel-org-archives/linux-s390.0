Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5342AEB64D7
	for <linux-s390@archiver.kernel.org>; Tue, 20 Jun 2023 04:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjFTEPY (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 20 Jun 2023 00:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbjFTEPU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 20 Jun 2023 00:15:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC9D10F3
        for <linux-s390@vger.kernel.org>; Mon, 19 Jun 2023 21:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687234473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kszkYteYWv+XtAexqVvmgcXaELYsNbs5H3NgHpBVfI0=;
        b=YtNsENjUhJyA/2xADAAkkDyb1ju2rces6Kzl6Di9uWLAwHE2+M+iCmnX5joFosB+S+KtqJ
        lnGjFnSTI649Q2YsaLnNn9qYv/cx/ABcu0cuC0qo/73+yem3yzRWyV0sn1zk7UPqwgFLuP
        5K88eKfHAEKF4IRHv5FRDqa+ZeNJBCU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-Tn1CWZBMOzKruf4dxh05_Q-1; Tue, 20 Jun 2023 00:14:31 -0400
X-MC-Unique: Tn1CWZBMOzKruf4dxh05_Q-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-76240ab6d72so520115385a.2
        for <linux-s390@vger.kernel.org>; Mon, 19 Jun 2023 21:14:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687234471; x=1689826471;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kszkYteYWv+XtAexqVvmgcXaELYsNbs5H3NgHpBVfI0=;
        b=cmkmrGeXsTnsolNaqutNoi903vjsnFBvq9U6tFfRKPVQXYVJzdIk4baP3R7bbVuUva
         R8+tFJCsuEbxiP3txFolNa/iFI9D0CJ7Drvjc2yFRchGUdE5k4lk9DEDaPuAWaWKh0Fk
         68CXgUiVcB2gsiJ9bf3pvl28pXET9MybVocETmFk46a1Wqo7QRdP1G4Ft9GDZ7vyE5O5
         SkIxE4TyYZEnSvHc0hujFsBoz3vYlLckqiZfU1ALMf0fmuWE1b3Ki+js5XAAKzIRvFSW
         PwntN3E5i7syuf/qWqyJYZMPvwk0o3G5gdxCZAi6NzTIfN00joeS8ROuw2hAUAdQpJAx
         yG3w==
X-Gm-Message-State: AC+VfDzp6dvChGbVNdRtLhMLJHX+1we0FhmcACMW/CrNDgpBaQeKQRXU
        0XUXsirvb51fB3qxmW7/zoFDuRIXVHuD1rrrbq8d7dlSaU5ObpSTaAPfpZDmt/45C1UDHjfKWxS
        JhVH4zYxILP4B7S9HaCLi3Q==
X-Received: by 2002:a05:620a:3183:b0:763:a424:5dbd with SMTP id bi3-20020a05620a318300b00763a4245dbdmr3589608qkb.2.1687234471022;
        Mon, 19 Jun 2023 21:14:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4gW1E2NFiG64aP6Q7aBRg7mPoTusI/LU7bI2NbcO70Vkb+Rj1NqHa4a0RmDzta5GE1vaqT6w==
X-Received: by 2002:a05:620a:3183:b0:763:a424:5dbd with SMTP id bi3-20020a05620a318300b00763a4245dbdmr3589589qkb.2.1687234470774;
        Mon, 19 Jun 2023 21:14:30 -0700 (PDT)
Received: from ?IPV6:2001:8003:7475:6e00:1e1e:4135:2440:ee05? ([2001:8003:7475:6e00:1e1e:4135:2440:ee05])
        by smtp.gmail.com with ESMTPSA id d16-20020a17090abf9000b00260cce91d20sm241091pjs.33.2023.06.19.21.14.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 21:14:29 -0700 (PDT)
Message-ID: <7ab8dba3-a3a2-c9e6-f78f-de77a2adc72f@redhat.com>
Date:   Tue, 20 Jun 2023 14:14:22 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [kvm-unit-tests PATCH v3] runtime: Allow to specify properties
 for accelerator
Content-Language: en-US
To:     Andrew Jones <andrew.jones@linux.dev>
Cc:     Nico Boehr <nrb@linux.ibm.com>, kvmarm@lists.linux.dev,
        kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
        linux-s390@vger.kernel.org, lvivier@redhat.com, thuth@redhat.com,
        frankja@linux.ibm.com, imbrenda@linux.ibm.com, david@redhat.com,
        pbonzini@redhat.com, shan.gavin@gmail.com
References: <20230615062148.19883-1-gshan@redhat.com>
 <168683636810.207611.6242722390379085462@t14-nrb>
 <2a1b0e2b-a412-143a-9a57-5f2c12e8944c@redhat.com>
 <20230619-5565bc462dab3f2d6f7f26c3@orel>
From:   Gavin Shan <gshan@redhat.com>
In-Reply-To: <20230619-5565bc462dab3f2d6f7f26c3@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Drew,

On 6/19/23 18:44, Andrew Jones wrote:
> On Fri, Jun 16, 2023 at 10:41:29AM +1000, Gavin Shan wrote:
>>
>> On 6/15/23 23:39, Nico Boehr wrote:
>>> Quoting Gavin Shan (2023-06-15 08:21:48)
>>>> There are extra properties for accelerators to enable the specific
>>>> features. For example, the dirty ring for KVM accelerator can be
>>>> enabled by "-accel kvm,dirty-ring-size=65536". Unfortuntely, the
>>>> extra properties for the accelerators aren't supported. It makes
>>>> it's impossible to test the combination of KVM and dirty ring
>>>> as the following error message indicates.
>>>>
>>>>     # cd /home/gavin/sandbox/kvm-unit-tests/tests
>>>>     # QEMU=/home/gavin/sandbox/qemu.main/build/qemu-system-aarch64 \
>>>>       ACCEL=kvm,dirty-ring-size=65536 ./its-migration
>>>>        :
>>>>     BUILD_HEAD=2fffb37e
>>>>     timeout -k 1s --foreground 90s /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64 \
>>>>     -nodefaults -machine virt -accel kvm,dirty-ring-size=65536 -cpu cortex-a57             \
>>>>     -device virtio-serial-device -device virtconsole,chardev=ctd -chardev testdev,id=ctd   \
>>>>     -device pci-testdev -display none -serial stdio -kernel _NO_FILE_4Uhere_ -smp 160      \
>>>>     -machine gic-version=3 -append its-pending-migration # -initrd /tmp/tmp.gfDLa1EtWk
>>>>     qemu-system-aarch64: kvm_init_vcpu: kvm_arch_init_vcpu failed (0): Invalid argument
>>>>
>>>> Allow to specify extra properties for accelerators. With this, the
>>>> "its-migration" can be tested for the combination of KVM and dirty
>>>> ring.
>>>>
>>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>>
>>> Maybe get_qemu_accelerator could be renamed now, since it doesn't actually "get"
>>> anything, so maybe check_qemu_accelerator?
>>>
>>> In any case, I gave it a quick run on s390x with kvm and tcg and nothing seems
>>> to break, hence for the changes in s390x:
>>>
>>> Tested-by: Nico Boehr <nrb@linux.ibm.com>
>>> Acked-by: Nico Boehr <nrb@linux.ibm.com>
>>>
>>
>> Thanks for a quick try and comment for this. I guess it's fine to keep the
>> function name as get_qemu_accelator() because $ACCEL is split into $ACCEL
>> and $ACCEL_PROPS inside it, even it don't print the accelerator name at
>> return. However, I'm also fine with check_qemu_accelerator(). Lets see
>> what's Drew's comment on this and I can post v4 to have the modified
>> function name, or an followup patch to modify the function name.
> 
> I suggested naming it set_qemu_accelerator() in the v2 review.
> 

My bad, it will be renamed to set_qemu_accelerator() in v4 :)

Thanks,
Gavin

