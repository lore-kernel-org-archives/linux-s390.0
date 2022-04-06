Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C42C433FE
	for <linux-s390@archiver.kernel.org>; Wed,  6 Apr 2022 10:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240224AbiDFKa6 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 6 Apr 2022 06:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354936AbiDFK2T (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 6 Apr 2022 06:28:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B1901DAFB2
        for <linux-s390@vger.kernel.org>; Tue,  5 Apr 2022 23:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649227828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=198kYOnNlSWatjSWDYkZaZqYlqwH7e8Coxt4+err8d4=;
        b=chWln8lVPRFkdhsQgsnSZCxnnL+aVzsjJariRZWAvC5e7zF7rxqeYHMe4/wsgOxpF70F2a
        ouaTJkSF6ebTPukOg7SxMgGCulu3LomaEqcqbJKAmrTgvFFRE9KWFeic+ceH5vMD/3f+Vb
        jEdPXxWvws6413EzBNZacwrKwvutrbM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-82-1jvdTSbGOsKGtM3TLPJD4Q-1; Wed, 06 Apr 2022 02:50:27 -0400
X-MC-Unique: 1jvdTSbGOsKGtM3TLPJD4Q-1
Received: by mail-wr1-f70.google.com with SMTP id g4-20020adfa484000000b002061151874eso158606wrb.21
        for <linux-s390@vger.kernel.org>; Tue, 05 Apr 2022 23:50:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=198kYOnNlSWatjSWDYkZaZqYlqwH7e8Coxt4+err8d4=;
        b=KTdHEns0gbw8r6EKAQd4eBpjSWwUuOpvXPSekTi8N5fSJrdtWUZvnlKTcWO42gE1VG
         fUP0H7MpfjiEjvohCUppOSJX/lppyFAAQKCsfnW109knE8dzNBROV3TFAAlQpDvS6eMP
         t63hXzSSAz2+5UC0vGGht7q1Riowd5wocQwCyottOhnP2dRjH12aCkg4JaJdQxsBzkEG
         L691aOwTrUummqecTzQSm8NbYKQiv3hCR1oYZrc4t1oJIBiH44C9WOnbY9AXIZFllnFf
         kmIS1UOXRUv0rtpKt7SZg/Eu1gIq8/LJGHU/yMlM3IEqTUYexB3GHyR1dQyvxb55NtYE
         umLg==
X-Gm-Message-State: AOAM533azQ+TjRT6kqSe2gWAqzWKgT0J08OKrJbPxeAPDFHRvQeDnQXO
        tvAvrS/TIZsUCuB6VEcCLDTNF40GIIjhjLyVAVkdBEZSXqRN9k5vW65BfOm5hfQI4Yg3VTkrs5j
        TlzPIWOiYsvzg/XD8Dwauqg==
X-Received: by 2002:adf:e104:0:b0:206:109a:c90f with SMTP id t4-20020adfe104000000b00206109ac90fmr5345450wrz.259.1649227826281;
        Tue, 05 Apr 2022 23:50:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwfOG1UAtZiCdUWJe2kav8TZU14vYZB6bEN6wUGN9uhrYTMYNd2vY7oaKmt5KqiVF2llkm6fA==
X-Received: by 2002:adf:e104:0:b0:206:109a:c90f with SMTP id t4-20020adfe104000000b00206109ac90fmr5345441wrz.259.1649227826101;
        Tue, 05 Apr 2022 23:50:26 -0700 (PDT)
Received: from [10.33.192.183] (nat-pool-str-t.redhat.com. [149.14.88.106])
        by smtp.gmail.com with ESMTPSA id n10-20020a5d588a000000b002052e4aaf89sm13896444wrf.80.2022.04.05.23.50.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 23:50:25 -0700 (PDT)
Message-ID: <bf27586e-4eb2-4392-1293-328c743eb8ec@redhat.com>
Date:   Wed, 6 Apr 2022 08:50:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [kvm-unit-tests PATCH 5/8] s390x: pv-diags: Cleanup includes
Content-Language: en-US
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        david@redhat.com, nrb@linux.ibm.com, seiden@linux.ibm.com
References: <20220405075225.15903-1-frankja@linux.ibm.com>
 <20220405075225.15903-6-frankja@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20220405075225.15903-6-frankja@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 05/04/2022 09.52, Janosch Frank wrote:
> This file has way too much includes. Time to remove some.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   s390x/pv-diags.c | 17 ++---------------
>   1 file changed, 2 insertions(+), 15 deletions(-)
> 
> diff --git a/s390x/pv-diags.c b/s390x/pv-diags.c
> index 6899b859..9ced68c7 100644
> --- a/s390x/pv-diags.c
> +++ b/s390x/pv-diags.c
> @@ -8,23 +8,10 @@
>    *  Janosch Frank <frankja@linux.ibm.com>
>    */
>   #include <libcflat.h>
> -#include <asm/asm-offsets.h>
> -#include <asm-generic/barrier.h>
> -#include <asm/interrupt.h>
> -#include <asm/pgtable.h>
> -#include <mmu.h>
> -#include <asm/page.h>
> -#include <asm/facility.h>
> -#include <asm/mem.h>
> -#include <asm/sigp.h>
> -#include <smp.h>
> -#include <alloc_page.h>
> -#include <vmalloc.h>
> -#include <sclp.h>
>   #include <snippet.h>
>   #include <sie.h>
> -#include <uv.h>
> -#include <asm/uv.h>
> +#include <sclp.h>
> +#include <asm/facility.h>

Wow, how did we end up with that huge list? Copy-n-paste from other files?

Reviewed-by: Thomas Huth <thuth@redhat.com>


