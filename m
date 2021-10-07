Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7985C433EF
	for <linux-s390@archiver.kernel.org>; Thu,  7 Oct 2021 09:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B176C610A0
	for <linux-s390@archiver.kernel.org>; Thu,  7 Oct 2021 09:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240468AbhJGJHu (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 7 Oct 2021 05:07:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41484 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240465AbhJGJHt (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 7 Oct 2021 05:07:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633597556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HzqoDdZtFIadIsYszcxk0Ygoju8EawYokFi2M+8ol2Q=;
        b=TK7oawQdZoKQ00eWIm7vRSPQRGlvD8iXTZXkxKzdqeJvf5qFf3WG8ijaGJc0+SNWg6SKEm
        KEtNZ5+JL19zwKi4qb/R1KV9pUO4t0PaCA9VQ6XEiLkhyomkUlGXUM6Lq4Z7u6qG6hVUDI
        7F9S0CIU2h22Sae2pSAwfqSfyFC6L+w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-545-6TIJKrlVPieD2kyHrXmj8g-1; Thu, 07 Oct 2021 05:05:44 -0400
X-MC-Unique: 6TIJKrlVPieD2kyHrXmj8g-1
Received: by mail-wr1-f71.google.com with SMTP id k2-20020adfc702000000b0016006b2da9bso4140144wrg.1
        for <linux-s390@vger.kernel.org>; Thu, 07 Oct 2021 02:05:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HzqoDdZtFIadIsYszcxk0Ygoju8EawYokFi2M+8ol2Q=;
        b=klvXU/HLJI55C/L6HqjINKA8u1vK2UysHtxVoYCW4ZoXOZ0su4vUmftadLV+LnklP+
         d7VWunDnHErfiYaMX7mIcpif6d079jLdIPB+g5FjF1qS1zJvI1xI9s+K7z//fd6diRY4
         h5sYZX83OZILNrHAqKasc59Wi+EluZhA9u87xy6o+G88nXWN+YWFQ9FkWQ+Gp6ZELluS
         eMQNg9u5R65pMSAv8vwf+i1FsLve1YHfqvFN+r/cRzq/HuN7dHaSveo82mg4oJ3D76Qe
         TWQYYz4N66/9pGJ9Ih7oYjZ0NtjSXbE8n41DxNtqM0T8661YIG5NQOXEAT87oGMVvz/v
         f7CA==
X-Gm-Message-State: AOAM533inTC9edzp5ApfLDbVl+db2ZiO2hgBijQPyVqAOtA4mgg9SAyc
        9Zm6W7bTTtT4v9cQH/h/C2o0uefQ52rI0tj5rOPDyAIBtDvEJoSHEXT7vmXjxhC6zGLaFRQT/3g
        LNPzkQOPdHrxrBzz3CqPumA==
X-Received: by 2002:a05:600c:1c10:: with SMTP id j16mr8165994wms.12.1633597543746;
        Thu, 07 Oct 2021 02:05:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzd3DCsusqH35cDn303a+aIucf43P85/jJEcSNRiyWcAv6Oa+pTdgfRwyTxK9Oo81P+mQUcQw==
X-Received: by 2002:a05:600c:1c10:: with SMTP id j16mr8165977wms.12.1633597543558;
        Thu, 07 Oct 2021 02:05:43 -0700 (PDT)
Received: from thuth.remote.csb (nat-pool-str-t.redhat.com. [149.14.88.106])
        by smtp.gmail.com with ESMTPSA id z5sm10588356wmp.26.2021.10.07.02.05.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Oct 2021 02:05:42 -0700 (PDT)
Subject: Re: [kvm-unit-tests PATCH v3 5/9] lib: s390x: Add access key argument
 to tprot
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        david@redhat.com, seiden@linux.ibm.com, scgl@linux.ibm.com
References: <20211007085027.13050-1-frankja@linux.ibm.com>
 <20211007085027.13050-6-frankja@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Message-ID: <7899f130-58b9-51ac-3d2b-8ddd7683e112@redhat.com>
Date:   Thu, 7 Oct 2021 11:05:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211007085027.13050-6-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 07/10/2021 10.50, Janosch Frank wrote:
> From: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> 
> Currently there is only one callee passing a non zero key,
> but having the argument will be useful in the future.
> 
> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> ---
>   lib/s390x/asm/arch_def.h | 6 +++---
>   lib/s390x/sclp.c         | 2 +-
>   s390x/skrf.c             | 3 +--
>   3 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
> index c8d2722a..b34aa792 100644
> --- a/lib/s390x/asm/arch_def.h
> +++ b/lib/s390x/asm/arch_def.h
> @@ -233,15 +233,15 @@ static inline uint16_t get_machine_id(void)
>   	return cpuid;
>   }
>   
> -static inline int tprot(unsigned long addr)
> +static inline int tprot(unsigned long addr, char access_key)
>   {
>   	int cc;
>   
>   	asm volatile(
> -		"	tprot	0(%1),0\n"
> +		"	tprot	0(%1),0(%2)\n"
>   		"	ipm	%0\n"
>   		"	srl	%0,28\n"
> -		: "=d" (cc) : "a" (addr) : "cc");
> +		: "=d" (cc) : "a" (addr), "a" (access_key << 4) : "cc");
>   	return cc;
>   }
>   
> diff --git a/lib/s390x/sclp.c b/lib/s390x/sclp.c
> index 9502d161..02722498 100644
> --- a/lib/s390x/sclp.c
> +++ b/lib/s390x/sclp.c
> @@ -217,7 +217,7 @@ void sclp_memory_setup(void)
>   	/* probe for r/w memory up to max memory size */
>   	while (ram_size < max_ram_size) {
>   		expect_pgm_int();
> -		cc = tprot(ram_size + storage_increment_size - 1);
> +		cc = tprot(ram_size + storage_increment_size - 1, 0);
>   		/* stop once we receive an exception or have protected memory */
>   		if (clear_pgm_int() || cc != 0)
>   			break;
> diff --git a/s390x/skrf.c b/s390x/skrf.c
> index 8ca7588c..ca4efbf1 100644
> --- a/s390x/skrf.c
> +++ b/s390x/skrf.c
> @@ -103,8 +103,7 @@ static void test_tprot(void)
>   {
>   	report_prefix_push("tprot");
>   	expect_pgm_int();
> -	asm volatile("tprot	%[addr],0xf0(0)\n"
> -		     : : [addr] "a" (pagebuf) : );
> +	tprot((unsigned long)pagebuf, 0xf);
>   	check_pgm_int_code(PGM_INT_CODE_SPECIAL_OPERATION);
>   	report_prefix_pop();
>   }
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>

