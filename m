Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1260C48BDF
	for <linux-s390@archiver.kernel.org>; Tue, 22 Jun 2021 07:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D9F061350
	for <linux-s390@archiver.kernel.org>; Tue, 22 Jun 2021 07:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhFVHiy (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 22 Jun 2021 03:38:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36003 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229628AbhFVHix (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 22 Jun 2021 03:38:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624347398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=78AoyZGEww4eX5wQlfZVTd7MSU26Lj9OFW0KxEtUtQE=;
        b=TzhGF+PmQvsIGHSU3c3cOWM4zNq7mqZcD11PjCVCKizIV3lmEKhRVEjic1Hu8HWyFU98Vy
        PQ2uvqiY4xbWSRHvyqZ5untOswLxVcfcJnqRy6hHmgvuAUzcLv1Zbq9bQegBmOi5TkTYKs
        H0Rt+akkEzR3S5zOSBrU0lefplGNCY0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-I4SvLXb6NES8vNrO8aS4aw-1; Tue, 22 Jun 2021 03:36:35 -0400
X-MC-Unique: I4SvLXb6NES8vNrO8aS4aw-1
Received: by mail-wm1-f69.google.com with SMTP id w186-20020a1cdfc30000b02901ced88b501dso406418wmg.2
        for <linux-s390@vger.kernel.org>; Tue, 22 Jun 2021 00:36:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=78AoyZGEww4eX5wQlfZVTd7MSU26Lj9OFW0KxEtUtQE=;
        b=B1LULycS5XvSd7WB2WlTqUi7LFj1L9fUHmrXeHlwoZbujQj/IW6/+RiDqqhBUHl9vY
         ygpwb/R5fajb7oEiQgpJZcU6YDTFQBmjDoV9n9jvw+jYEPmLs4cNddJXnbcA5xvnz2Q4
         GXTMQs4rtx9Cf+2XRQS09PX5dYzH4RLQ/6CuMkOxhFGpJe1+sPPJ03UUSHdkgdZggt2n
         feKjKf0YTUByTWkdQUaRleGWGV0dx2ZYA27X0Aa3fPALf75It+2zY0ulH6310Xm7+SmL
         C/G3DKnRlVo5HJVcQk9OUvIK+OgVrYM5OPTWVr3nNqRQ96F1bCuNgJQrzXFTRSIg1NSG
         wDpg==
X-Gm-Message-State: AOAM531ikVc7WtRppCPrMXvtTLyAIxLL6KgCoqYDVhVXUWy4CUA5ay0K
        J3WqVdjrBt56yDf1jlZSB9SLUJKKkLb5yYRfv7crmnGRaDWLKddfrZFPYvQdwcx7d0EiAPlA6Su
        OPZrDLtH4gVMINkEnYKglSofSSf7HyQTCKqdhDhtFwZX8YQ/rTXbOxXuxbwDldLbskN8RfA==
X-Received: by 2002:adf:eb82:: with SMTP id t2mr2972082wrn.337.1624347394741;
        Tue, 22 Jun 2021 00:36:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxoJfk+r77PGl9RauhygLIUoORvlmYjxRTavo4pfmYHwGkkYTTwPzciyLPGKqOafwCbcG6JMQ==
X-Received: by 2002:adf:eb82:: with SMTP id t2mr2972065wrn.337.1624347394545;
        Tue, 22 Jun 2021 00:36:34 -0700 (PDT)
Received: from thuth.remote.csb (pd9575f2f.dip0.t-ipconnect.de. [217.87.95.47])
        by smtp.gmail.com with ESMTPSA id u18sm1355827wmj.15.2021.06.22.00.36.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 00:36:33 -0700 (PDT)
Subject: Re: [PATCH] KVM: s390: get rid of register asm usage
To:     Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.vnet.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20210621140356.1210771-1-hca@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Message-ID: <7edaf85c-810b-e0f9-5977-6e89270f0709@redhat.com>
Date:   Tue, 22 Jun 2021 09:36:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210621140356.1210771-1-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 21/06/2021 16.03, Heiko Carstens wrote:
> Using register asm statements has been proven to be very error prone,
> especially when using code instrumentation where gcc may add function
> calls, which clobbers register contents in an unexpected way.
> 
> Therefore get rid of register asm statements in kvm code, even though
> there is currently nothing wrong with them. This way we know for sure
> that this bug class won't be introduced here.
> 
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>   arch/s390/kvm/kvm-s390.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 1296fc10f80c..4b7b24f07790 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -329,31 +329,31 @@ static void allow_cpu_feat(unsigned long nr)
>   
>   static inline int plo_test_bit(unsigned char nr)
>   {
> -	register unsigned long r0 asm("0") = (unsigned long) nr | 0x100;
> +	unsigned long function = (unsigned long) nr | 0x100;
>   	int cc;
>   
>   	asm volatile(
> +		"	lgr	0,%[function]\n"
>   		/* Parameter registers are ignored for "test bit" */
>   		"	plo	0,0,0,0(0)\n"
>   		"	ipm	%0\n"
>   		"	srl	%0,28\n"
>   		: "=d" (cc)
> -		: "d" (r0)
> -		: "cc");
> +		: [function] "d" (function)
> +		: "cc", "0");
>   	return cc == 0;
>   }
>   
>   static __always_inline void __insn32_query(unsigned int opcode, u8 *query)
>   {
> -	register unsigned long r0 asm("0") = 0;	/* query function */
> -	register unsigned long r1 asm("1") = (unsigned long) query;
> -
>   	asm volatile(
> -		/* Parameter regs are ignored */
> +		"	lghi	0,0\n"
> +		"	lgr	1,%[query]\n"
> +		/* Parameter registers are ignored */
>   		"	.insn	rrf,%[opc] << 16,2,4,6,0\n"
>   		:
> -		: "d" (r0), "a" (r1), [opc] "i" (opcode)
> -		: "cc", "memory");
> +		: [query] "d" ((unsigned long)query), [opc] "i" (opcode)

Wouldn't it be better to keep the "a" constraint instead of "d" to avoid 
that the compiler ever passes the "query" value in r0 ?
Otherwise the query value might get trashed if it is passed in r0...

> +		: "cc", "memory", "0", "1");
>   }

With "a" instead of "d":

Reviewed-by: Thomas Huth <thuth@redhat.com>

