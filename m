Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AD7EB64D9
	for <linux-s390@archiver.kernel.org>; Thu,  6 Jul 2023 10:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjGFKuG (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 6 Jul 2023 06:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbjGFKtp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 6 Jul 2023 06:49:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C351BF3
        for <linux-s390@vger.kernel.org>; Thu,  6 Jul 2023 03:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688640536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fILFizqa3mOZ2MONz3RieRKOc0s5FEVPoEVIOXL4bps=;
        b=Wyuflz5ApBP+c6NM0RtgU9fHTECauG/ceJfgI2e4OXbe5ovYza+ljis8LsNqY6cgseTYAM
        V6n/Be9mlJ12D0kA9J6W1BAlo87I/pOoRb+UGvJqTqKt9yp0gngc4ji+62rgX3yffooTNN
        KG5udFy2IMYqvFH2qujfnrL/gcHQxto=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-qFAre38DM3SeK7xLUBH9Dg-1; Thu, 06 Jul 2023 06:48:55 -0400
X-MC-Unique: qFAre38DM3SeK7xLUBH9Dg-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7659c6caeaeso84356985a.3
        for <linux-s390@vger.kernel.org>; Thu, 06 Jul 2023 03:48:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688640534; x=1691232534;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fILFizqa3mOZ2MONz3RieRKOc0s5FEVPoEVIOXL4bps=;
        b=MWXgNBwtB8/756DNBuTFYC0lyd1yaAE024aT14OkI6mfwxtoAMRLTxP7epXAhW6NDj
         x6E7Gn0G1B9//TgQmogO/Wcgbwos+YdlHerqhUpbmVWI5yN5oC3D+ndh1xlCgtMlk5NF
         pSs9/uou/qtOPnX9INniO6wbLk1fxZBa0M+j0ip1WQeCWY3hI3iEqzVsb0JFNTZJdRdJ
         xEAIM6QxDsL3mLhSrHcCllFCTnl5m3gMhzZMg9gY9rbbuSZzgaO0A6uF0Od3LFbQr2vn
         W75Rsq3ayirFafwnZUdLN3O8wgAXoTJqBuwx734YrtlZNVKCfprXJzVPk12ZmDyGJOKR
         Fujg==
X-Gm-Message-State: ABy/qLYrkyykBEltGHm1+IM3J6l3lGT8wNnmuRVcuWFWqHuelJmBoZf6
        5F+qapfQHnfLL5mmMesoHwwJuGrXbhZIZanrV0a5jG+0Bo/7Mg2ywFsMrHpvmXN6SlwxiKrKlES
        qk7oacUrMKvMd4/h4lC0t3A==
X-Received: by 2002:a37:b407:0:b0:763:e407:4eec with SMTP id d7-20020a37b407000000b00763e4074eecmr1424984qkf.50.1688640534798;
        Thu, 06 Jul 2023 03:48:54 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEvcim9m3gxXGvb3OLQEio9UsinQQTF4Y+qtEnmb8XHNUyS6/HWIv+OQk2vbnLPCpsVCL3Ytg==
X-Received: by 2002:a37:b407:0:b0:763:e407:4eec with SMTP id d7-20020a37b407000000b00763e4074eecmr1424968qkf.50.1688640534582;
        Thu, 06 Jul 2023 03:48:54 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-114.web.vodafone.de. [109.43.176.114])
        by smtp.gmail.com with ESMTPSA id j28-20020a05620a147c00b00767410d18c3sm623369qkl.36.2023.07.06.03.48.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 03:48:53 -0700 (PDT)
Message-ID: <ffc48a06-52b2-fc65-e12d-58603d13b3e6@redhat.com>
Date:   Thu, 6 Jul 2023 12:48:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org
Cc:     frankja@linux.ibm.com, kvm@vger.kernel.org, imbrenda@linux.ibm.com,
        david@redhat.com, nrb@linux.ibm.com, nsg@linux.ibm.com
References: <20230627082155.6375-1-pmorel@linux.ibm.com>
 <20230627082155.6375-3-pmorel@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v10 2/2] s390x: topology: Checking
 Configuration Topology Information
In-Reply-To: <20230627082155.6375-3-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 27/06/2023 10.21, Pierre Morel wrote:
> STSI with function code 15 is used to store the CPU configuration
> topology.
> 
> We retrieve the maximum nested level with SCLP and use the
> topology tree provided by sockets and cores only to stay
> compatible with qemu topology before topology extension with

"before checking ..." ?

> drawers and books.
> arguments.
> 
> We check :
> - if the topology stored is coherent between the QEMU -smp
>    parameters and kernel parameters.
> - the number of CPUs
> - the maximum number of CPUs
> - the number of containers of each levels for every STSI(15.1.x)
>    instruction allowed by the machine.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>   lib/s390x/sclp.c    |   6 +
>   lib/s390x/sclp.h    |   4 +-
>   lib/s390x/stsi.h    |  36 +++++
>   s390x/topology.c    | 326 ++++++++++++++++++++++++++++++++++++++++++++
>   s390x/unittests.cfg |   4 +
>   5 files changed, 375 insertions(+), 1 deletion(-)

Does this patch series depend on some other patches that are not upstream 
yet? I just tried to run the test, but I'm only getting:

  lib/s390x/sclp.c:122: assert failed: read_info

Any ideas what could be wrong?

  Thomas

