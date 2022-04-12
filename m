Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C18DC433F5
	for <linux-s390@archiver.kernel.org>; Tue, 12 Apr 2022 10:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240797AbiDLKlr (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 12 Apr 2022 06:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355846AbiDLKdp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 12 Apr 2022 06:33:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7A10617074
        for <linux-s390@vger.kernel.org>; Tue, 12 Apr 2022 02:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649756077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xnxDli1btAgXsk0W1CxQfR+KJ5XVP6RYmZ4+xnhZLt0=;
        b=jFPfNZxhEhmwRfVibkE0Ulmf+lcwdGiWVZK7gGpxhEHylQt1bIFjjy4NrPnXg05ov4cppu
        9aRL9P97wmDfPWfmYJxv//C3ewuAoYDRQQXMtiHiTJ5wHKEEvqZfVEc0z+0gnGUneMPNWK
        F/N6qYmIH3qLxyDSWd9vPJaP9Uvbztc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-620-MOvjpZzcNTSd6l1rvCuwOQ-1; Tue, 12 Apr 2022 05:34:36 -0400
X-MC-Unique: MOvjpZzcNTSd6l1rvCuwOQ-1
Received: by mail-wm1-f72.google.com with SMTP id y11-20020a7bc18b000000b0038eac019fc0so1014165wmi.9
        for <linux-s390@vger.kernel.org>; Tue, 12 Apr 2022 02:34:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xnxDli1btAgXsk0W1CxQfR+KJ5XVP6RYmZ4+xnhZLt0=;
        b=Jstqv+uQ/S2Rjw/VwZ6RCmsYO+mdv4GORPXBn+D9TwcQNPvuu2UsyVpEppidokryI9
         wiWpg1kqiK1+7xeycSITj640kiacOsvCbUtS90Sd9gqDDGDJMP0eMveV3vw3fDKjAuHt
         CaqMr0VyeC8lkMuZi90gJ+/mGZ6bLO+2+kxDcBpMBoJdV4rptzQg9cmq/4Osn3Vy1+tV
         T6wtBjpWusqqpIRugtC3jCFkqRx1RGHLWFrRvPEWCNyCAnpfB9xaoeF/pi21bCENsI8j
         xyDO6Oz6egBUGcgd0Y6hqL6DW5UE9aOIhbjxKDfLo6onM5X2MeRRkSFjCnPbgkeIawSn
         jxNw==
X-Gm-Message-State: AOAM532oEsKQFuBJOGYRDmVdAvHv0rerLDDRp9senY0LVQd8uJ3cAdf0
        P9wSOgYUJhdH1jrorX3q/awSmTSR5eA5alGsFejSHWRcOxS1gjam5mVjsYTmtAZ/+Nbo2R+TwPc
        exiKfx5gMaH7Z25t3GgTrPg==
X-Received: by 2002:a5d:6f02:0:b0:207:a746:dc8 with SMTP id ay2-20020a5d6f02000000b00207a7460dc8mr6771715wrb.11.1649756075279;
        Tue, 12 Apr 2022 02:34:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzXTkimYPKXc/REfwMVbD9Mt28s60yF/2ettpqwl3Pocb++IITJeleOL+JH9b39wGeWZ2DiSg==
X-Received: by 2002:a5d:6f02:0:b0:207:a746:dc8 with SMTP id ay2-20020a5d6f02000000b00207a7460dc8mr6771701wrb.11.1649756075041;
        Tue, 12 Apr 2022 02:34:35 -0700 (PDT)
Received: from [10.33.192.183] (nat-pool-str-t.redhat.com. [149.14.88.106])
        by smtp.gmail.com with ESMTPSA id l15-20020a05600c4f0f00b0038cbdf5221dsm2039714wmq.41.2022.04.12.02.34.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 02:34:34 -0700 (PDT)
Message-ID: <cb6d8f0b-3fb4-670c-f05e-5755d8352cdf@redhat.com>
Date:   Tue, 12 Apr 2022 11:34:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [kvm-unit-tests PATCH v1 2/3] s390x: tprot: use system include
 for mmu.h
Content-Language: en-US
To:     Nico Boehr <nrb@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc:     frankja@linux.ibm.com, imbrenda@linux.ibm.com
References: <20220412092941.20742-1-nrb@linux.ibm.com>
 <20220412092941.20742-2-nrb@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20220412092941.20742-2-nrb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 12/04/2022 11.29, Nico Boehr wrote:
> mmu.h should come from the system includes

Maybe: s/system/lib/

> 
> Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
> ---
>   s390x/tprot.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/s390x/tprot.c b/s390x/tprot.c
> index 460a0db7ffcf..760e7ecdf914 100644
> --- a/s390x/tprot.c
> +++ b/s390x/tprot.c
> @@ -12,7 +12,7 @@
>   #include <bitops.h>
>   #include <asm/pgtable.h>
>   #include <asm/interrupt.h>
> -#include "mmu.h"
> +#include <mmu.h>
>   #include <vmalloc.h>
>   #include <sclp.h>
>   

Reviewed-by: Thomas Huth <thuth@redhat.com>

