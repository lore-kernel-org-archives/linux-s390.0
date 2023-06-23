Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695F8C0015E
	for <linux-s390@archiver.kernel.org>; Fri, 23 Jun 2023 04:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjFWEXn (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 23 Jun 2023 00:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbjFWEXm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 23 Jun 2023 00:23:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C6A1FED
        for <linux-s390@vger.kernel.org>; Thu, 22 Jun 2023 21:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687494173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xrLmuzU0wgmsmESVz8DJ+4KiPPOxmR3Hg8y+61+QhWQ=;
        b=gupkgVlElm2mkloYyRtNWB8LYawjv97vMAq5/+oBXVE/sQCu7UVyEaE+zqLbrFchRBZFhR
        m1HCwN4KkV7/qrdkDOfVgtZfm1B3zN6133pu6ied+gj8tNK9O0SKltcVgMUdOKE47+ZYsZ
        FYfgmZ/fNtyBte43ZB4KPd1VhtKr1VY=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-7Viku-oENU-RMrhWCmnaJA-1; Fri, 23 Jun 2023 00:22:52 -0400
X-MC-Unique: 7Viku-oENU-RMrhWCmnaJA-1
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-55e33aca968so214903eaf.3
        for <linux-s390@vger.kernel.org>; Thu, 22 Jun 2023 21:22:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687494171; x=1690086171;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xrLmuzU0wgmsmESVz8DJ+4KiPPOxmR3Hg8y+61+QhWQ=;
        b=fucZZhKhmiH4aenZFQTkmCzWvAy9bxb4WXcHzCNu5HQu6O3hx73Ay8Q/Tg2WwEdohs
         YSINfPkC1priE5UNM1G1CiwVyK4RclzL/hdUwFfUUpLXXPv+Q22AcLMgGK8j57tRFfvu
         GOIchHztTwaEEmWBVRF8J3k0KBnS5CERl5ifPs8WgZ4ugax00dkhMKHhK2TeJImvs+Sj
         gdpo6gNNrkgYEUnG8inHUFPghmj/RHkgsZa20PQsv3N6KFUJXmOkYvmMy4OkdUHL+8Jo
         3k8xC9bSBp1G9+ca4eHg3M/7r5Y80tjw11yoY1cryVeToTQVbO7T09P4l5ENHrvq6o2w
         WZWA==
X-Gm-Message-State: AC+VfDz6uAaN6cHWYqwrc54PFIF+vaKz7asLGV5nHSRjY5n/ej9/7t86
        5O963asMh5XSLsSI97XH/YB2Ydqco5M+nrHVkGX/44rl2/75wDEwUc2v+ONxToqVNLehuO4HM9p
        Sp6XaNpfTZTBRyw+ul7T48A==
X-Received: by 2002:a05:6358:e98:b0:131:234:e2df with SMTP id 24-20020a0563580e9800b001310234e2dfmr8110243rwg.22.1687494171037;
        Thu, 22 Jun 2023 21:22:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7jwH4atVvU5CyVyC0U+ByGWibbm6EHgOxrRpCC3Xc/AQg/UmSpAEi2GZuztl8o4SkF0R2r0w==
X-Received: by 2002:a05:6358:e98:b0:131:234:e2df with SMTP id 24-20020a0563580e9800b001310234e2dfmr8110231rwg.22.1687494170712;
        Thu, 22 Jun 2023 21:22:50 -0700 (PDT)
Received: from ?IPV6:2001:8003:7475:6e00:1e1e:4135:2440:ee05? ([2001:8003:7475:6e00:1e1e:4135:2440:ee05])
        by smtp.gmail.com with ESMTPSA id d20-20020aa78154000000b00666a83bd544sm5206301pfn.23.2023.06.22.21.22.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 21:22:49 -0700 (PDT)
Message-ID: <7482963d-4312-dba1-e376-40f03d166f2c@redhat.com>
Date:   Fri, 23 Jun 2023 14:22:42 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [kvm-unit-tests PATCH v3] runtime: Allow to specify properties
 for accelerator
Content-Language: en-US
To:     Andrew Jones <andrew.jones@linux.dev>
Cc:     kvmarm@lists.linux.dev, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linux-s390@vger.kernel.org,
        lvivier@redhat.com, thuth@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, david@redhat.com, pbonzini@redhat.com,
        nrb@linux.ibm.com, shan.gavin@gmail.com
References: <20230615062148.19883-1-gshan@redhat.com>
 <20230619-339675e424da033000049f83@orel>
 <766a1dc4-a5ad-725a-b25e-438bf1387a4f@redhat.com>
 <20230620-f496c5f56a78acc5529762a4@orel>
From:   Gavin Shan <gshan@redhat.com>
In-Reply-To: <20230620-f496c5f56a78acc5529762a4@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Drew,

On 6/20/23 19:06, Andrew Jones wrote:
> On Tue, Jun 20, 2023 at 02:13:22PM +1000, Gavin Shan wrote:
>> On 6/19/23 18:45, Andrew Jones wrote:
>>> On Thu, Jun 15, 2023 at 04:21:48PM +1000, Gavin Shan wrote:
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
>>>> ---
>>>> v3: Split $ACCEL to $ACCEL and $ACCEL_PROPS in get_qemu_accelerator()
>>>>       and don't print them as output, suggested by Drew.
>>>> ---
>>>>    arm/run               | 12 ++++--------
>>>>    powerpc/run           |  5 ++---
>>>>    s390x/run             |  5 ++---
>>>>    scripts/arch-run.bash | 21 +++++++++++++--------
>>>>    x86/run               |  5 ++---
>>>>    5 files changed, 23 insertions(+), 25 deletions(-)
>>>>
>>>> diff --git a/arm/run b/arm/run
>>>> index c6f25b8..d9ebe59 100755
>>>> --- a/arm/run
>>>> +++ b/arm/run
>>>> @@ -10,10 +10,8 @@ if [ -z "$KUT_STANDALONE" ]; then
>>>>    fi
>>>>    processor="$PROCESSOR"
>>>> -accel=$(get_qemu_accelerator) ||
>>>> -	exit $?
>>>> -
>>>> -if [ "$accel" = "kvm" ]; then
>>>> +get_qemu_accelerator || exit $?
>>>> +if [ "$ACCEL" = "kvm" ]; then
>>>>    	QEMU_ARCH=$HOST
>>>>    fi
>>>> @@ -23,11 +21,9 @@ qemu=$(search_qemu_binary) ||
>>>>    if [ "$QEMU" ] && [ -z "$ACCEL" ] &&
>>>>       [ "$HOST" = "aarch64" ] && [ "$ARCH" = "arm" ] &&
>>>>       [ "$(basename $QEMU)" = "qemu-system-arm" ]; then
>>>> -	accel=tcg
>>>> +	ACCEL="tcg"
>>>>    fi
>>>
>>> As I pointed out in the v2 review we can't just s/accel/ACCEL/ without
>>> other changes. Now ACCEL will also be set when the above condition
>>> is checked, making it useless. Please ensure the test case that commit
>>> c7d6c7f00e7c ("arm/run: Use TCG with qemu-system-arm on arm64 systems")
>>> fixed still works with your patch.
>>>
>>
>> Sorry that I missed your comments for v2. In order to make the test case
>> in c7d6c7f00e7c working, we just need to call set_qemu_accelerator() after
>> the chunk of code, like below. When $ACCEL is set to "tcg" by the conditional
>> code, it won't be changed in the following set_qemu_accelerator().
>>
>> Could you Please confirm if it looks good to you so that I can integrate
>> the changes to v4 and post it.
>>
>> arm/run
>> --------
>>
>> processor="$PROCESSOR"
>>
>> if [ "$QEMU" ] && [ -z "$ACCEL" ] &&
>>     [ "$HOST" = "aarch64" ] && [ "$ARCH" = "arm" ] &&
>>     [ "$(basename $QEMU)" = "qemu-system-arm" ]; then
>>          ACCEL="tcg"
>> fi
>>
>> set_qemu_accelerator || exit $?
>> if [ "$ACCEL" = "kvm" ]; then
>>          QEMU_ARCH=$HOST
>> fi
>>
> 
> Looks fine, but please give it a test run.
> 

Thanks, Drew. v4 has been posted for further review. Since I don't have a 'arm'
host around, I adjust $ARCH to "arm64" for a simulation and the test case included
in commit c7d6c7f00e7c should be working fine: We eventually have "tcg" instead of
"kvm" accelerator for the combination, which is expected by commit c7d6c7f00e7c

v4: https://lore.kernel.org/kvmarm/20230623035750.312679-1-gshan@redhat.com/T/#u

Thanks,
Gavin

