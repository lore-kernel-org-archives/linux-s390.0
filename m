Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E45BC001B0
	for <linux-s390@archiver.kernel.org>; Sun, 13 Aug 2023 09:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjHMJuv (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sun, 13 Aug 2023 05:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjHMJuv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 13 Aug 2023 05:50:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D94A1700
        for <linux-s390@vger.kernel.org>; Sun, 13 Aug 2023 02:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691920206;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vBzH8DX3gC9E1Jmln+XcFwun/a5hLI5hdLYcEoW5X28=;
        b=O18MmOHXJeNawinBy7TmPHIMUR+Aql3oETD96lcDeHRtHg39qD5tx1zpXvom/dl1poQi9Z
        FrSR6ysTipthYW/gZ9WG8jaJm5Scw8iew+bOD7RVjqf4jmovECFVon/ovmTZX8dSr8WEeh
        PeCeBx5289xLqOSpBp3PMtY2tv19KQY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-EaMe-hymPv-x7kH8tBR_1Q-1; Sun, 13 Aug 2023 05:50:04 -0400
X-MC-Unique: EaMe-hymPv-x7kH8tBR_1Q-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3197608e8f0so54867f8f.2
        for <linux-s390@vger.kernel.org>; Sun, 13 Aug 2023 02:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691920204; x=1692525004;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vBzH8DX3gC9E1Jmln+XcFwun/a5hLI5hdLYcEoW5X28=;
        b=WQCobT9GMdx0Xm2rc0n+aacxKOQPeYeA3t4qZfiixQ6DpblSqvBVWufcaM6R39APID
         DxFZRFFVOErKkXFN7Lwvg3IJ5OVUpih2bhf2nYcL5zJfF6F0aX6J4uAYvsxKL27P4zkg
         3zVCSBG50rdkssC2G/McaJ9jZsdFcP/Cxrc0LUdWF+29/z+apjzMRPzzgcV+ma6IthmG
         yGnAo33/+ElXER0kQjVFQEt+w/h+omEhAnHeRBUhrB71B6kVGJ5Dm7ukibbbuFRnvYLy
         nZe6eYZsdUqj/gXu9owQBK94yzaIaDkZ5H/GkYHrg4DOdzLHY0vANf5k5z19n2LpOl69
         jKkw==
X-Gm-Message-State: AOJu0Yzbjor5PJYEjF1G+h4DsEw2zE49H+PARrSzTKQe/LQphn/PawA6
        a2KwiMaxz6sQ8ZSwgTfsmETXnNWbFLCnWxGpsnuzcjXrsmmZ7eJ2yYQaRrjKBgKlA4P4caeszPx
        WR4avtLMYvRyfTskRs/XLtA==
X-Received: by 2002:adf:dec2:0:b0:317:5a99:4549 with SMTP id i2-20020adfdec2000000b003175a994549mr4575279wrn.0.1691920203198;
        Sun, 13 Aug 2023 02:50:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnfuzkqCoVq8jy6EOVpp+9RneCX6vcEypZHDYoMLweq1/d7QPLQzBD+n4h+KFAZCkbhPdgSQ==
X-Received: by 2002:adf:dec2:0:b0:317:5a99:4549 with SMTP id i2-20020adfdec2000000b003175a994549mr4575272wrn.0.1691920202897;
        Sun, 13 Aug 2023 02:50:02 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-177-246.web.vodafone.de. [109.43.177.246])
        by smtp.gmail.com with ESMTPSA id j4-20020adfff84000000b003142ea7a661sm11038784wrr.21.2023.08.13.02.50.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Aug 2023 02:50:02 -0700 (PDT)
Message-ID: <981405ed-060f-de0b-8125-29099ba8791a@redhat.com>
Date:   Sun, 13 Aug 2023 11:50:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [kvm-unit-tests PATCH v1] s390x: explicitly mark stack as not
 executable
To:     Nico Boehr <nrb@linux.ibm.com>, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <20230809091717.1549-1-nrb@linux.ibm.com>
Content-Language: en-US
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230809091717.1549-1-nrb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 09/08/2023 11.17, Nico Boehr wrote:
> With somewhat recent GCC versions, we get this warning on s390x:
> 
>    /usr/bin/ld: warning: s390x/cpu.o: missing .note.GNU-stack section implies executable stack
>    /usr/bin/ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
> 
> We don't really care whether stack is executable or not since we set it
> up ourselves and we're running DAT off mostly anyways.
> 
> Silence the warning by explicitly marking the stack as not executable.
> 
> Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
> ---
>   s390x/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/s390x/Makefile b/s390x/Makefile
> index 706be7920406..afa47ccbeb93 100644
> --- a/s390x/Makefile
> +++ b/s390x/Makefile
> @@ -79,7 +79,7 @@ CFLAGS += -O2
>   CFLAGS += -march=zEC12
>   CFLAGS += -mbackchain
>   CFLAGS += -fno-delete-null-pointer-checks
> -LDFLAGS += -nostdlib -Wl,--build-id=none
> +LDFLAGS += -nostdlib -Wl,--build-id=none -z noexecstack

I already did a similar patch some weeks ago:

  https://lore.kernel.org/kvm/20230623125416.481755-1-thuth@redhat.com/

... we need it for x86, too, so I guess I should go ahead and commit it - 
and ask Sean to respin his conflicting series.

  Thomas


