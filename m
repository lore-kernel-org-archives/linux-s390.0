Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308F5C433EF
	for <linux-s390@archiver.kernel.org>; Tue, 24 May 2022 09:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235799AbiEXJmt (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 24 May 2022 05:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235818AbiEXJmp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 24 May 2022 05:42:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D311560A80
        for <linux-s390@vger.kernel.org>; Tue, 24 May 2022 02:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653385359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zFo5wCOAm0pgrR3mlKlJ9zjKOLJ6nCkOz288AuApEU8=;
        b=FadSuFBBISl1ysKvd4kls4F3e7VoD+B/C+0as56jmX9AvaTWqMhAhXUhmVM9v7NwYigmG2
        BrpbD8RsWMva9RTeAVC5by3YiYQKcApESsnTUj+CaU+qnBNL1qwMcSIZT85M41Rhfr/b9k
        mYDUIKuhuDNrJ2yuBkL7yiri0hmSP70=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-187-b80r0E_rO_SFtuvIgyE6Ug-1; Tue, 24 May 2022 05:42:38 -0400
X-MC-Unique: b80r0E_rO_SFtuvIgyE6Ug-1
Received: by mail-ej1-f69.google.com with SMTP id i14-20020a17090639ce00b006dabe6a112fso7412716eje.13
        for <linux-s390@vger.kernel.org>; Tue, 24 May 2022 02:42:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zFo5wCOAm0pgrR3mlKlJ9zjKOLJ6nCkOz288AuApEU8=;
        b=cU6A3TlIqcNmYkQWIRKI2clUuWFego+Fi+yqn7h6++TmQRlx0MUO/7ZMyuaH+zozLc
         XT+KAp0nBUaeG0Jhpeuj1s3afaY7QQlxuHSRsL/KmJd0LA5bOx9A5JiAYYTqbQVa/YS8
         Ote17W9c7uGXVZ2Xrnb1Z2OYrA+j8diPLafAv0ziOpFiFaD4txL+oWkgra7C4Aws5SWJ
         20nNe1Tmj4UVnzgR4Ot1bpU73TGqANsW51ahy+CrV/SU015ht6nX6XBh336aHi3BFeE5
         5rbjEe9sSl/WkmbGg9k/pGNCr/CaDdZsJlPqHwdKqKTV5XK/XA+QFYGQPMwsanFV8P4I
         y0+A==
X-Gm-Message-State: AOAM530r7dCkgNvjMPlKKktojQld+X0+BLhbrnSV4V8nCOG+PG+F6wlo
        ZK5z4Lg/HCgTrs8uPLlK6PfW7Ken4FPG8XjhVQAEL7o6nRvXXydOCTqDbRb3oRJY4BcK/x256Mv
        XDawm3aeO+meMwTaPvEKFUg==
X-Received: by 2002:a17:907:7b95:b0:6f4:ff03:981a with SMTP id ne21-20020a1709077b9500b006f4ff03981amr23817497ejc.653.1653385354823;
        Tue, 24 May 2022 02:42:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyz1c8JZ5OgT7BSYJ7GMI1ZrbV0ucv3Jm2MDi5bXDEPX/pxgf5WI1Tr1nVK1/8YFWI1DdgwYw==
X-Received: by 2002:a17:907:7b95:b0:6f4:ff03:981a with SMTP id ne21-20020a1709077b9500b006f4ff03981amr23817486ejc.653.1653385354641;
        Tue, 24 May 2022 02:42:34 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id 16-20020a17090601d000b006f3ef214db3sm7086985ejj.25.2022.05.24.02.42.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 02:42:33 -0700 (PDT)
Message-ID: <43bba413-030e-578b-a7d0-e81aed4e67b4@redhat.com>
Date:   Tue, 24 May 2022 11:42:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] s390/uv_uapi: depend on CONFIG_S390
Content-Language: en-US
To:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org
References: <20220523192420.151184-1-pbonzini@redhat.com>
 <78b9cc09-caef-94c7-8bff-30544098603f@linux.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <78b9cc09-caef-94c7-8bff-30544098603f@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 5/24/22 09:01, Christian Borntraeger wrote:
> Am 23.05.22 um 21:24 schrieb Paolo Bonzini:
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   drivers/s390/char/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/s390/char/Kconfig b/drivers/s390/char/Kconfig
>> index ef8f41833c1a..108e8eb06249 100644
>> --- a/drivers/s390/char/Kconfig
>> +++ b/drivers/s390/char/Kconfig
>> @@ -103,6 +103,7 @@ config SCLP_OFB
>>   config S390_UV_UAPI
>>       def_tristate m
>>       prompt "Ultravisor userspace API"
>> +        depends on S390
>>       help
>>         Selecting exposes parts of the UV interface to userspace
>>         by providing a misc character device at /dev/uv.
> 
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> 
> with the whitespace as outlined.

Yes, that needs to be a tab.

> Can you pick it yourself?

Sure, thanks.

Paolo

