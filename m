Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12882C3A589
	for <linux-s390@archiver.kernel.org>; Tue,  5 Apr 2022 10:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354013AbiDEKKq (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 5 Apr 2022 06:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236290AbiDEJbP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 Apr 2022 05:31:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E451F6472
        for <linux-s390@vger.kernel.org>; Tue,  5 Apr 2022 02:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649150334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9RDMdu4wcD4gzH6Neye1FPwe05BU/8cy6KWjgiXkUBI=;
        b=a+Q2ZsmwhB1xLk0+PRA6FSwGfrmAdesn7dWyNQqxRqMs2AgTwZuqmdbkBpqXBEap72/z/f
        049M8DURE3EZUASZGAhhhEJbMJcYGHa/vDrfd30SqeBC76Kx6zDFReXcwhEZha0/ZvTWzL
        O7v6KaOFoVjrVo3bB3shCCl7Pb2O4b0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-370-eviSHwF1O827fJRz8y6_Lw-1; Tue, 05 Apr 2022 05:18:53 -0400
X-MC-Unique: eviSHwF1O827fJRz8y6_Lw-1
Received: by mail-wm1-f70.google.com with SMTP id 189-20020a1c02c6000000b0038e6c4c6472so1052981wmc.1
        for <linux-s390@vger.kernel.org>; Tue, 05 Apr 2022 02:18:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9RDMdu4wcD4gzH6Neye1FPwe05BU/8cy6KWjgiXkUBI=;
        b=EQIpuvV4Fs1G7+vO743mzHSE1H4JE9FOgw6FzQsdJOcB2p/UAC02C2Zt5L6l2dJt63
         BxF1aZZEL2Ad6CN+Z73C8UMK78QAPN5IOo/00MDScyiN48CSKLpawlh17ARuHoCezb0J
         DKhNb2MuV+8OAjkranlp+daCf/8fojXfq/KXH4dJ1wNfDlxVc6qmkFTDtMmCLKEdYTdB
         xtfh3IPa9RYqV5OAeKVAcutCZG94WIX/+Wl47vUc0z9SMbWEuCUSoYySvkc4iW/0+F0H
         9A0qOveGKzVJH9MdHITquWRXkPrH0J0SwEA2V3LojBpdqvhE8dYuCw/AngpqLo+KCO02
         SEVg==
X-Gm-Message-State: AOAM533JUUa7aa3TINPuxsriqA9THBmNBM1IcskDD33iBPSEZ6SXXVtJ
        cCSLMExEaQpn3sP45SfNS6SZ0+83lgFi/2+hTGsb1UcHFQ45/x5H61Vn6ynHOpvSa5tyf+OOiLg
        d0Y4M0aJynXeVCLEV41nhpw==
X-Received: by 2002:adf:efcf:0:b0:206:1c7d:4bd with SMTP id i15-20020adfefcf000000b002061c7d04bdmr1851133wrp.483.1649150332085;
        Tue, 05 Apr 2022 02:18:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZh+BmBEuk6JXDFWa3Q5iylHHlbpaN8TmP2/oWWh6MB5D/+t9r3vDZwZuAvgOXeBf5vFarnw==
X-Received: by 2002:adf:efcf:0:b0:206:1c7d:4bd with SMTP id i15-20020adfefcf000000b002061c7d04bdmr1851121wrp.483.1649150331845;
        Tue, 05 Apr 2022 02:18:51 -0700 (PDT)
Received: from [10.33.192.183] (nat-pool-str-t.redhat.com. [149.14.88.106])
        by smtp.gmail.com with ESMTPSA id k23-20020a05600c1c9700b0038e71072376sm1611884wms.19.2022.04.05.02.18.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 02:18:51 -0700 (PDT)
Message-ID: <16c254ac-c3ed-6174-5eef-5f309e7a7585@redhat.com>
Date:   Tue, 5 Apr 2022 11:18:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [kvm-unit-tests PATCH 2/8] s390x: diag308: Only test subcode 2
 under QEMU
Content-Language: en-US
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        david@redhat.com, nrb@linux.ibm.com, seiden@linux.ibm.com
References: <20220405075225.15903-1-frankja@linux.ibm.com>
 <20220405075225.15903-3-frankja@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20220405075225.15903-3-frankja@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 05/04/2022 09.52, Janosch Frank wrote:
> Other hypervisors might implement it and therefore not send a
> specification exception.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   s390x/diag308.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/s390x/diag308.c b/s390x/diag308.c
> index c9d6c499..9614f9a9 100644
> --- a/s390x/diag308.c
> +++ b/s390x/diag308.c
> @@ -8,6 +8,7 @@
>   #include <libcflat.h>
>   #include <asm/asm-offsets.h>
>   #include <asm/interrupt.h>
> +#include <hardware.h>
>   
>   /* The diagnose calls should be blocked in problem state */
>   static void test_priv(void)
> @@ -75,7 +76,7 @@ static void test_subcode6(void)
>   /* Unsupported subcodes should generate a specification exception */
>   static void test_unsupported_subcode(void)
>   {
> -	int subcodes[] = { 2, 0x101, 0xffff, 0x10001, -1 };
> +	int subcodes[] = { 0x101, 0xffff, 0x10001, -1 };
>   	int idx;
>   
>   	for (idx = 0; idx < ARRAY_SIZE(subcodes); idx++) {
> @@ -85,6 +86,18 @@ static void test_unsupported_subcode(void)
>   		check_pgm_int_code(PGM_INT_CODE_SPECIFICATION);
>   		report_prefix_pop();
>   	}
> +
> +	/*
> +	 * Subcode 2 is not available under QEMU but might be on other
> +	 * hypervisors.
> +	 */
> +	if (detect_host() != HOST_IS_TCG && detect_host() != HOST_IS_KVM) {

Shouldn't this be rather the other way round instead?

	if (detect_host() == HOST_IS_TCG || detect_host() == HOST_IS_KVM)

?

... anyway, since you already used a similar if-clause in your first patch, 
it might make sense to add a helper function a la host_is_qemu() to check 
whether we're running on QEMU or not.

> +		report_prefix_pushf("0x%04x", 2);

	report_prefix_pushf("0x02") ?

> +		expect_pgm_int();
> +		asm volatile ("diag %0,%1,0x308" :: "d"(0), "d"(2));
> +		check_pgm_int_code(PGM_INT_CODE_SPECIFICATION);
> +		report_prefix_pop();
> +	}
>   }

  Thomas

