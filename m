Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F06C47082
	for <linux-s390@archiver.kernel.org>; Mon, 31 May 2021 11:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5693960E08
	for <linux-s390@archiver.kernel.org>; Mon, 31 May 2021 11:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbhEaLRD (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 31 May 2021 07:17:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44278 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230521AbhEaLRD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 31 May 2021 07:17:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622459723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HbVQVF2Oxhjo1ML89s9a3cuayWvFHjuQHqPKwdseAmY=;
        b=dUQ2R1CAsIzHJ2Abh6BZ09qcwkYyV/V/D3AmnI2PeeDxwAMfS+o74wGMHr48ualKES1D2L
        RRudy2WQzIS9GDGSftDw5gbTowPfvXydSRkV9avr8pHaQJwzr8ZsKEVq19lwT9ODbQ62wt
        FfdjO2fh/mfAELEOaMbuYaO6DxQEgPQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-ijGRnOdZOqmK0A86EwiM5A-1; Mon, 31 May 2021 07:15:21 -0400
X-MC-Unique: ijGRnOdZOqmK0A86EwiM5A-1
Received: by mail-wr1-f72.google.com with SMTP id t5-20020adfb7c50000b029010dd0bb24cfso3851939wre.2
        for <linux-s390@vger.kernel.org>; Mon, 31 May 2021 04:15:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=HbVQVF2Oxhjo1ML89s9a3cuayWvFHjuQHqPKwdseAmY=;
        b=jEWW0y1ypx+LNIAYyVB7CVSQTzK3FIgcCHmH4x1XR0o0XxYzNV33w8VMp+gBaBgDtZ
         7p+Q3vBrtD+z9C71ZA8IUIMrSaqEoeTjwIBwur8vHSXirZpAcdGre7gfU7u1xqGnqeg0
         syO85o0gjVv3BPutff9MQIswRqdqq9d0ZEyaxoMBgCcouE1KJ9F7/pHqiwGf0iue+cDz
         yhStOVArECiYjZD8a1/fRVuSf6RLjr/BAVdfUZFNJxOJwsfGyRL7KXtFE6s4UduMX14k
         e1cNyFVSreQUDl8S0D6tXSA8bc592hnH/mXJfazGtTcVSs1GMSgDwfsr+kCcVEcbwBj4
         j4uw==
X-Gm-Message-State: AOAM531Ct9QDu24anYdn4K44Qh74U29E4CJ3Hu0/LeeSyo6YF7UdmMn8
        GC34zO4kLbau10yz9zckBnBM84gqv+EBYo0Mh2BjScO1YVvxUwc3oan8yePDz6dRiNvx5PronYA
        sU7NKF2tGHLYD+xV5cttERw==
X-Received: by 2002:a1c:98c7:: with SMTP id a190mr1261168wme.77.1622459720359;
        Mon, 31 May 2021 04:15:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwmIMZAUU4FULPo1/tg519tmgeOBZl4HC1m1a7zYeTUqKsNpyLXP2/Z2AVWVzUGCi4Leh5TpA==
X-Received: by 2002:a1c:98c7:: with SMTP id a190mr1261143wme.77.1622459720086;
        Mon, 31 May 2021 04:15:20 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6a6f.dip0.t-ipconnect.de. [91.12.106.111])
        by smtp.gmail.com with ESMTPSA id d9sm16694626wrx.11.2021.05.31.04.15.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 04:15:19 -0700 (PDT)
Subject: Re: [kvm-unit-tests PATCH] s390x: selftest: Fix report output
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        thuth@redhat.com, cohuck@redhat.com
References: <20210531105003.44737-1-frankja@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <53383a4f-8841-ae12-3fd0-14bda08801e2@redhat.com>
Date:   Mon, 31 May 2021 13:15:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210531105003.44737-1-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 31.05.21 12:50, Janosch Frank wrote:
> To make our TAP parser (and me) happy we don't want to have to reports
> with exactly the same wording.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   s390x/selftest.c | 18 +++++++++++++-----
>   1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/s390x/selftest.c b/s390x/selftest.c
> index b2fe2e7b..c2ca9896 100644
> --- a/s390x/selftest.c
> +++ b/s390x/selftest.c
> @@ -47,12 +47,19 @@ static void test_malloc(void)
>   	*tmp2 = 123456789;
>   	mb();
>   
> -	report((uintptr_t)tmp & 0xf000000000000000ul, "malloc: got vaddr");
> -	report(*tmp == 123456789, "malloc: access works");
> +	report_prefix_push("malloc");
> +	report_prefix_push("ptr_0");

instead of this "ptr_0" vs. "ptr_1" I'd just use

"allocated 1st page"
"wrote to 1st page"
"allocated 2nd page"
"wrote to 2nd page"
"1st and 2nd page differ"

Avoids one hierarchy of prefix_push ...

> +	report((uintptr_t)tmp & 0xf000000000000000ul, "allocated memory");
> +	report(*tmp == 123456789, "wrote allocated memory");
> +	report_prefix_pop();
> +
> +	report_prefix_push("ptr_1");
>   	report((uintptr_t)tmp2 & 0xf000000000000000ul,
> -	       "malloc: got 2nd vaddr");
> -	report((*tmp2 == 123456789), "malloc: access works");
> -	report(tmp != tmp2, "malloc: addresses differ");
> +	       "allocated memory");
> +	report((*tmp2 == 123456789), "wrote allocated memory");
> +	report_prefix_pop();
> +
> +	report(tmp != tmp2, "allocated memory addresses differ");
>   
>   	expect_pgm_int();
>   	configure_dat(0);
> @@ -62,6 +69,7 @@ static void test_malloc(void)
>   
>   	free(tmp);
>   	free(tmp2);
> +	report_prefix_pop();
>   }
>   
>   int main(int argc, char**argv)
> 


-- 
Thanks,

David / dhildenb

