Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106C8C433EF
	for <linux-s390@archiver.kernel.org>; Wed, 29 Jun 2022 15:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbiF2PQS (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 29 Jun 2022 11:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbiF2PQS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 29 Jun 2022 11:16:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 35852262
        for <linux-s390@vger.kernel.org>; Wed, 29 Jun 2022 08:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656515776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+wuv2Q4SapFEU9YAsP/MbzK2Zmj8ccNhg61UhoKXdRY=;
        b=Rw56Y0+ZRCqoHYenVSpXslBxUxfVpZJ9w3C9J0Sfhm3XYA9GwwNA+4+X/X1JFP8/RWYDnB
        /Kx3Y2PSQVr0jMzxC7JMF4JWn+A9kte23v7ZLyIf3VjJAiQl+idvk3pKQ8lNXlGG7ipxKf
        eqQm6ZcuBGvJVdfFjEF2SIEJD0knL/Q=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-142-9N3IS_O9ODK0iaLLbE6fQg-1; Wed, 29 Jun 2022 11:16:15 -0400
X-MC-Unique: 9N3IS_O9ODK0iaLLbE6fQg-1
Received: by mail-qk1-f200.google.com with SMTP id k190-20020a37bac7000000b006af6d953751so3664603qkf.13
        for <linux-s390@vger.kernel.org>; Wed, 29 Jun 2022 08:16:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+wuv2Q4SapFEU9YAsP/MbzK2Zmj8ccNhg61UhoKXdRY=;
        b=tfGn6ZKLEi+mSA9GgJlF3k2SIMlXMDnUf1J4piFz+Vgz/rjVt07J3uQkTM1t+5lSgh
         KlcSsRrC+aY0jXx5/6d8mWKnGZoi0rHrfjESRhKxnhXIe2ZCdY/994/hIrTtbGq68Vby
         pFsNPG7Tqhn3SmrZty8yJSfeifxpEwx3yWlpcNlZxWGDTDjwvC8kc57RKdTiURnoCwxU
         6QnUYXkDNmW+DLn5ZMob5yAShN5vBGGzfmoQV8GjAp8rvr+xX3Zn5mP0Nu94qb1gwArX
         LTb7o0hd/Qz/C/2jKKo2ydJmzw9p//aBsehM5R9DqNBY1+lRTpstFV8tc2meorzGP+Br
         2HBQ==
X-Gm-Message-State: AJIora8B1ZCjq06uSMvgiuda8h/hRkT4VOH0yCcZ1dBV1I9kvxaJ2okX
        Nn3psomE5c4tJTf95uRhIWPEFNbaqR40p+8lHqP40pzIMUephQn+tlAwZVDvLjcVNqLk4dJaDl+
        kJHxpyw48xo6nKHRgE/+GtQ==
X-Received: by 2002:a05:620a:448a:b0:6af:39e9:c31 with SMTP id x10-20020a05620a448a00b006af39e90c31mr2478058qkp.9.1656515774370;
        Wed, 29 Jun 2022 08:16:14 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1utDyZu7vSMk4vpgIU4ljG9sMhYDfbT33tgD05fOPGbeD7Temlasyp8Dn/Nsd0fD8qv9w7DAQ==
X-Received: by 2002:a05:620a:448a:b0:6af:39e9:c31 with SMTP id x10-20020a05620a448a00b006af39e90c31mr2478019qkp.9.1656515774074;
        Wed, 29 Jun 2022 08:16:14 -0700 (PDT)
Received: from [192.168.1.9] (pool-68-163-101-245.bstnma.fios.verizon.net. [68.163.101.245])
        by smtp.gmail.com with ESMTPSA id a20-20020a05620a16d400b0069fe1dfbeffsm13269517qkn.92.2022.06.29.08.16.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 08:16:13 -0700 (PDT)
Subject: Re: s390/nospec: add an option to use thunk-extern
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-kbuild@vger.kernel.org, "C. Erastus Toe" <ctoe@redhat.com>
References: <8569429d-57f8-a0cf-8b17-1291f6973d32@redhat.com>
 <cover.thread-d13b6c.your-ad-here.call-01656331067-ext-4899@work.hours>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Message-ID: <ad6a926e-eed1-a5e2-9f8b-0ea1599bbaed@redhat.com>
Date:   Wed, 29 Jun 2022 11:16:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <cover.thread-d13b6c.your-ad-here.call-01656331067-ext-4899@work.hours>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 6/27/22 8:50 AM, Vasily Gorbik wrote:
> Hi Joe,
> 
> sorry for late reply.
> 
>> I couldn't find the upstream patch post for 1d2ad084800e ("s390/nospec:
>> add an option to use thunk-extern"), so replying off-list here.  Feel
>> free to cc the appropriate list.
>>
>> Regarding this change, as I understand it, when CONFIG_EXPOLINE_EXTERN=y
>> out-of-tree kernel modules will need to link against
>> arch/s390x/lib/expoline.o, right?
>>
>> And if so, shouldn't the top level 'prepare_modules' target create
>> expoline.o for this purpose?
> 
> Thanks for bringing this up. I definitely missed out-of-tree kernel modules
> build case without a prebuilt kernel. On the other hand this post-linking
> trick is a rip off from powerpc:
> 
> KBUILD_LDFLAGS_MODULE += arch/powerpc/lib/crtsavres.o
> 
> So, now I wonder why powerpc doesn't have crtsavres.o in 'prepare_modules'.
> 
> Anyhow, below is couple of patches to consider. The first one is
> meant to be backportable, as the second one requires 4efd417f298b.
> 
> I had to move expoline.S to a separate directory to be able to call into
> its Makefile for 'prepare_modules' and avoid warnings for other targets
> defined in the same Makefile. Not sure if there are better kbuild tricks
> I could use. Another option I thought about is to keep expoline.S where
> it is and add a condition into that Makefile:
> expoline_prepare: prepare0
> 	$(Q)$(MAKE) $(build)=arch/s390/lib expoline_prepare=1 arch/s390/lib/expoline.o
> 
> arch/s390/lib/Makefile:
> # first target defined
> obj-$(CONFIG_EXPOLINE_EXTERN) += expoline.o
> ifndef expoline_prepare
> # ...other targets...
> 
> Vasily Gorbik (2):
>   s390/nospec: build expoline.o for modules_prepare target
>   s390/nospec: remove unneeded header includes
> 
>  arch/s390/Makefile                      | 8 +++++++-
>  arch/s390/include/asm/nospec-insn.h     | 2 --
>  arch/s390/lib/Makefile                  | 3 ++-
>  arch/s390/lib/expoline/Makefile         | 3 +++
>  arch/s390/lib/{ => expoline}/expoline.S | 0
>  5 files changed, 12 insertions(+), 4 deletions(-)
>  create mode 100644 arch/s390/lib/expoline/Makefile
>  rename arch/s390/lib/{ => expoline}/expoline.S (100%)
> 

Thanks, Vasily.  We'll test these with OOT and the original gitlab
pipeline where we spotted potential issue with packaging and report back.

-- 
Joe

