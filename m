Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FAEEB64D8
	for <linux-s390@archiver.kernel.org>; Tue, 20 Jun 2023 04:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjFTEOe (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 20 Jun 2023 00:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbjFTEOc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 20 Jun 2023 00:14:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FC6E72
        for <linux-s390@vger.kernel.org>; Mon, 19 Jun 2023 21:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687234416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DgbqzAuPyAfpFUWhZFLJCOhBcWUc6MZhREMA0o9RDBs=;
        b=aZDAUbz1UKwCVBA/Sd+zZYYZeJc1d6Cmn+41ASMmZjY3ikGSq4NrDO1nKLp+I12mT0XlTM
        eyx1fJ9Kq81Aq18bKH6teQfu4AtcjJT0SrFEEPMdWkaf/0EMJi+hxDY6oMmvzrjrfMts15
        3o9MZGd+509IsWh6gO/Ru9ixEe79xdQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-MjnU-GjbP0eypWvWYcIzmw-1; Tue, 20 Jun 2023 00:13:34 -0400
X-MC-Unique: MjnU-GjbP0eypWvWYcIzmw-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-3ff2a4ea22aso5800341cf.1
        for <linux-s390@vger.kernel.org>; Mon, 19 Jun 2023 21:13:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687234413; x=1689826413;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DgbqzAuPyAfpFUWhZFLJCOhBcWUc6MZhREMA0o9RDBs=;
        b=TfEd6Qx5l2vnUQk6PNezHYeTbEHQJ2twoU4nzgeOlJwTq+nUAXAfTKWGnNMgt5+RVY
         0mrrZxz8imMA9dc/UUD2UyWD3cJ/4+8biGPMIj/uUh1TzMIZq9mpvZNtddTP3y/yPevz
         2ICEeypjUsXTvg7zRQzEP4YJNq3NYV6kTs6UBJpl6SubMI52Xx9gAgX7rN2CDnGeY1nn
         I5Y6GriaeePH4cH74I264LYtK/C/h1P8WdWLUNhr6NFtasDaKXgx8kACMewiYPmCFmsG
         VhBFGHWI1q5jjKHDbJXBLusFsq8LVlpTdewbyCPJuaN6tU0j4UC6VviwexhE2CCz1XzP
         p+Ag==
X-Gm-Message-State: AC+VfDyEPTos30w7eh41ny7ZjNwVolYNDaXeHyWD0q3I67DNNrVTgVzg
        nNTL3XSFqCXc62hvKjjgS4P8jiphXgmI+AA5l4kdPooEr3cAjmtsirLIpAAxM8v96jTNCWN/u64
        hXARY9qTStvrvXBRwLXsvOw==
X-Received: by 2002:a05:622a:11d3:b0:3ff:1f86:81be with SMTP id n19-20020a05622a11d300b003ff1f8681bemr4982727qtk.36.1687234413731;
        Mon, 19 Jun 2023 21:13:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4VikTMDxrm2lwtMxbVKAbjd6H2SzNCaieiXTnBw5q4yoNulJefaR1mHFOrWLlt3nZwLBBUow==
X-Received: by 2002:a05:622a:11d3:b0:3ff:1f86:81be with SMTP id n19-20020a05622a11d300b003ff1f8681bemr4982716qtk.36.1687234413489;
        Mon, 19 Jun 2023 21:13:33 -0700 (PDT)
Received: from ?IPV6:2001:8003:7475:6e00:1e1e:4135:2440:ee05? ([2001:8003:7475:6e00:1e1e:4135:2440:ee05])
        by smtp.gmail.com with ESMTPSA id j19-20020a62b613000000b00640f51801e6sm371313pff.159.2023.06.19.21.13.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 21:13:32 -0700 (PDT)
Message-ID: <766a1dc4-a5ad-725a-b25e-438bf1387a4f@redhat.com>
Date:   Tue, 20 Jun 2023 14:13:22 +1000
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
From:   Gavin Shan <gshan@redhat.com>
In-Reply-To: <20230619-339675e424da033000049f83@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Drew,

On 6/19/23 18:45, Andrew Jones wrote:
> On Thu, Jun 15, 2023 at 04:21:48PM +1000, Gavin Shan wrote:
>> There are extra properties for accelerators to enable the specific
>> features. For example, the dirty ring for KVM accelerator can be
>> enabled by "-accel kvm,dirty-ring-size=65536". Unfortuntely, the
>> extra properties for the accelerators aren't supported. It makes
>> it's impossible to test the combination of KVM and dirty ring
>> as the following error message indicates.
>>
>>    # cd /home/gavin/sandbox/kvm-unit-tests/tests
>>    # QEMU=/home/gavin/sandbox/qemu.main/build/qemu-system-aarch64 \
>>      ACCEL=kvm,dirty-ring-size=65536 ./its-migration
>>       :
>>    BUILD_HEAD=2fffb37e
>>    timeout -k 1s --foreground 90s /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64 \
>>    -nodefaults -machine virt -accel kvm,dirty-ring-size=65536 -cpu cortex-a57             \
>>    -device virtio-serial-device -device virtconsole,chardev=ctd -chardev testdev,id=ctd   \
>>    -device pci-testdev -display none -serial stdio -kernel _NO_FILE_4Uhere_ -smp 160      \
>>    -machine gic-version=3 -append its-pending-migration # -initrd /tmp/tmp.gfDLa1EtWk
>>    qemu-system-aarch64: kvm_init_vcpu: kvm_arch_init_vcpu failed (0): Invalid argument
>>
>> Allow to specify extra properties for accelerators. With this, the
>> "its-migration" can be tested for the combination of KVM and dirty
>> ring.
>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>> v3: Split $ACCEL to $ACCEL and $ACCEL_PROPS in get_qemu_accelerator()
>>      and don't print them as output, suggested by Drew.
>> ---
>>   arm/run               | 12 ++++--------
>>   powerpc/run           |  5 ++---
>>   s390x/run             |  5 ++---
>>   scripts/arch-run.bash | 21 +++++++++++++--------
>>   x86/run               |  5 ++---
>>   5 files changed, 23 insertions(+), 25 deletions(-)
>>
>> diff --git a/arm/run b/arm/run
>> index c6f25b8..d9ebe59 100755
>> --- a/arm/run
>> +++ b/arm/run
>> @@ -10,10 +10,8 @@ if [ -z "$KUT_STANDALONE" ]; then
>>   fi
>>   processor="$PROCESSOR"
>>   
>> -accel=$(get_qemu_accelerator) ||
>> -	exit $?
>> -
>> -if [ "$accel" = "kvm" ]; then
>> +get_qemu_accelerator || exit $?
>> +if [ "$ACCEL" = "kvm" ]; then
>>   	QEMU_ARCH=$HOST
>>   fi
>>   
>> @@ -23,11 +21,9 @@ qemu=$(search_qemu_binary) ||
>>   if [ "$QEMU" ] && [ -z "$ACCEL" ] &&
>>      [ "$HOST" = "aarch64" ] && [ "$ARCH" = "arm" ] &&
>>      [ "$(basename $QEMU)" = "qemu-system-arm" ]; then
>> -	accel=tcg
>> +	ACCEL="tcg"
>>   fi
>>   
> 
> As I pointed out in the v2 review we can't just s/accel/ACCEL/ without
> other changes. Now ACCEL will also be set when the above condition
> is checked, making it useless. Please ensure the test case that commit
> c7d6c7f00e7c ("arm/run: Use TCG with qemu-system-arm on arm64 systems")
> fixed still works with your patch.
> 

Sorry that I missed your comments for v2. In order to make the test case
in c7d6c7f00e7c working, we just need to call set_qemu_accelerator() after
the chunk of code, like below. When $ACCEL is set to "tcg" by the conditional
code, it won't be changed in the following set_qemu_accelerator().

Could you Please confirm if it looks good to you so that I can integrate
the changes to v4 and post it.

arm/run
--------

processor="$PROCESSOR"

if [ "$QEMU" ] && [ -z "$ACCEL" ] &&
    [ "$HOST" = "aarch64" ] && [ "$ARCH" = "arm" ] &&
    [ "$(basename $QEMU)" = "qemu-system-arm" ]; then
         ACCEL="tcg"
fi

set_qemu_accelerator || exit $?
if [ "$ACCEL" = "kvm" ]; then
         QEMU_ARCH=$HOST
fi


Thanks,
Gavin

