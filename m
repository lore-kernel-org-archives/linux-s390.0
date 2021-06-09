Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7D8C48BDF
	for <linux-s390@archiver.kernel.org>; Wed,  9 Jun 2021 14:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 872DD613B6
	for <linux-s390@archiver.kernel.org>; Wed,  9 Jun 2021 14:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238228AbhFIOtH (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 9 Jun 2021 10:49:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60635 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238212AbhFIOtG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 9 Jun 2021 10:49:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623250031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r7p3iSSBeE9IsLDvewBcO4q2lNyiQ1LDLULJ0BkngOw=;
        b=RgIarz+RAQ9YTJfm8/fZvoXdZ6Fh5rF3zZkMdiCjvmcPNOMzUvJPYSCmonTsegTRLksQDD
        IO6HTqNl+U98+P7saKIrwU8+as6OzdKqG6ye8X1wCyAqpx9S5XzkAX594M6CnL+yhOFnpA
        cPgUBZ8KCpAZ4PteCoFgk+aDV7wnu9U=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-akOkJMkuMTm7uRwMHlAkaw-1; Wed, 09 Jun 2021 10:47:09 -0400
X-MC-Unique: akOkJMkuMTm7uRwMHlAkaw-1
Received: by mail-wr1-f69.google.com with SMTP id h104-20020adf90710000b029010de8455a3aso10880525wrh.12
        for <linux-s390@vger.kernel.org>; Wed, 09 Jun 2021 07:47:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=r7p3iSSBeE9IsLDvewBcO4q2lNyiQ1LDLULJ0BkngOw=;
        b=e7gX2CL+3SGuYf+jKZ4p2DjJa1lJ80sOAKxzaTrB+XEPVhqW+Ch3YXRua1HfRdftwP
         t0HInlnKV4gGXadaafPf7DlJaYmexLaYrF+nbW6a2zrv4bnDzAENMAKI9q4BPkd6s8hm
         g9HUMqHdeeax02fI4ImN6gp8NNeY2XB+5Absj9V2WbtzvlqFgxytFZNarinGp5cH8fPy
         Fs+84oNnWeUa1Jv6m4Rm1UL88Nlzu5i2bL8z6Ik8ijBCv7bPLH0aAxvZK//IBCvS7m3u
         FV0glRd3LT4hvbUWonjXKcwCwjiAJieImOcafVAAyhnV5Qw5xKcMR2To2V6Y/4WKmQ+D
         0huQ==
X-Gm-Message-State: AOAM531BsnIrxoIsV49ALFnSfllkQQlkZ5WaEEN1TiztO3sDAUn9QbIl
        5gp4ar2RHNnnGaYeRA5Bl7Cp9tFDqcanIlX7ynLi1812hC3nzS0957pWuQek7vVp1ifWe35Syfw
        xaTcSGzUUmwtA/CENZ7qxKKAx8RdXyCodzAmu8W5ptEmdKkp9QMo5N1Mvxn9my12klBHyXA==
X-Received: by 2002:adf:a195:: with SMTP id u21mr137241wru.367.1623250028784;
        Wed, 09 Jun 2021 07:47:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJweqEQec2chpibdCqZRkKANHtLLkFIjRh58mELPpwoK9PTJW2sYNOXC6gBVGIEq5Mnyq5WnhA==
X-Received: by 2002:adf:a195:: with SMTP id u21mr137211wru.367.1623250028562;
        Wed, 09 Jun 2021 07:47:08 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c611d.dip0.t-ipconnect.de. [91.12.97.29])
        by smtp.gmail.com with ESMTPSA id l16sm6741263wmj.47.2021.06.09.07.47.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 07:47:08 -0700 (PDT)
Subject: Re: [kvm-unit-tests PATCH v2 5/7] powerpc: unify header guards
To:     Cornelia Huck <cohuck@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Huth <thuth@redhat.com>,
        Andrew Jones <drjones@redhat.com>
Cc:     kvm@vger.kernel.org, Laurent Vivier <lvivier@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        kvmarm@lists.cs.columbia.edu, kvm-ppc@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20210609143712.60933-1-cohuck@redhat.com>
 <20210609143712.60933-6-cohuck@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <2eefe369-2eeb-17dc-0aec-cc262485c4e3@redhat.com>
Date:   Wed, 9 Jun 2021 16:47:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210609143712.60933-6-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 09.06.21 16:37, Cornelia Huck wrote:
> Only spapr.h needed a tweak.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>   powerpc/spapr.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/powerpc/spapr.h b/powerpc/spapr.h
> index b41aece07968..3a29598be44f 100644
> --- a/powerpc/spapr.h
> +++ b/powerpc/spapr.h
> @@ -1,6 +1,6 @@
> -#ifndef _ASMPOWERPC_SPAPR_H_
> -#define _ASMPOWERPC_SPAPR_H_
> +#ifndef POWERPC_SPAPR_H
> +#define POWERPC_SPAPR_H
>   
>   #define SPAPR_KERNEL_LOAD_ADDR 0x400000
>   
> -#endif /* _ASMPOWERPC_SPAPR_H_ */
> +#endif /* POWERPC_SPAPR_H */
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

