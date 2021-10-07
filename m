Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D827C433F5
	for <linux-s390@archiver.kernel.org>; Thu,  7 Oct 2021 08:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 380C4610C8
	for <linux-s390@archiver.kernel.org>; Thu,  7 Oct 2021 08:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240212AbhJGJA1 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 7 Oct 2021 05:00:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36058 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232573AbhJGJA1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 7 Oct 2021 05:00:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633597113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y9ZGcWQ70cNIWMeA6AJTTGD4KbeGSTC1fkbkvYxMV8g=;
        b=HUm2UyDO55A1sy2iVqR7vMFw8jg9fG+S3nmjZDFVmSj+VVSC1xV8/Y9RDwMYlBu8Y2rReq
        xUemmoC6LXDl2+3gJoh3lSYZsD1mNELhgD56hXZp0B+HskHetjPdrFNHkts9+Hzehmhffz
        l1gRjhJebYzGgFVDYf7h9lkcOikAPYY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-neuGi4qENL2EXZp4R5zW8w-1; Thu, 07 Oct 2021 04:58:32 -0400
X-MC-Unique: neuGi4qENL2EXZp4R5zW8w-1
Received: by mail-wr1-f72.google.com with SMTP id k16-20020a5d6290000000b00160753b430fso4146274wru.11
        for <linux-s390@vger.kernel.org>; Thu, 07 Oct 2021 01:58:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y9ZGcWQ70cNIWMeA6AJTTGD4KbeGSTC1fkbkvYxMV8g=;
        b=sm/4y2jf64Pr5S0wf9Uzp8bumF11LkdGWuuMuQcelcc0j9S7PRHzU0DigcEMRMtHSb
         levFAqfDsQRNmmpNbTf5ICdKOnAmJedYtAhMc+0wNBkTuXjxbpDcgIjunL+/LKtU8hV5
         z1SgZvYMafAZUt3lnQxwSjuYBwKYjKQlroU4Zl1dcii3e63UVWfhnNCCzawmPfZzvX2y
         8k+wlGCJKv9cOmumJCKWGQ2NL76vsXhYotIhux//4aCVk4Fckc/cr7WegR/hGQ/aYaiY
         lNM4DHz2sSvmuiC49bA9cFdtJtoyF1vCxiPPqL8r0BsT6C+0AJVBYWuX0/E+uq8aBlcJ
         vk6A==
X-Gm-Message-State: AOAM5324Ssn1HTVN70LaRB0eu8GrH9SoZRKOLtQ5MiTR1Nnq8rKawpN2
        ScVlJ1H249s0TUnkhj5+jx0nIrYfQKy7ETidYab5Uxm+5djpcA3sS5ukiyT3EZAoF2nNndjcFlX
        bdtvypi1I+qjnyeS146S8ag==
X-Received: by 2002:a05:6000:18a2:: with SMTP id b2mr3826627wri.155.1633597110844;
        Thu, 07 Oct 2021 01:58:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6rHEwZT7LLjuRF0PqdY5tjZpr3pCYbJFPi9DeIHxwKz12ysk9I48QfAPxDZo+pqn7sQxggQ==
X-Received: by 2002:a05:6000:18a2:: with SMTP id b2mr3826614wri.155.1633597110688;
        Thu, 07 Oct 2021 01:58:30 -0700 (PDT)
Received: from thuth.remote.csb (nat-pool-str-t.redhat.com. [149.14.88.106])
        by smtp.gmail.com with ESMTPSA id z18sm16954811wro.25.2021.10.07.01.58.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Oct 2021 01:58:30 -0700 (PDT)
Subject: Re: [kvm-unit-tests PATCH v3 1/9] s390x: uv: Tolerate 0x100 query
 return code
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        david@redhat.com, seiden@linux.ibm.com, scgl@linux.ibm.com
References: <20211007085027.13050-1-frankja@linux.ibm.com>
 <20211007085027.13050-2-frankja@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Message-ID: <6e061173-d3bc-4a65-3278-048fb6e426ce@redhat.com>
Date:   Thu, 7 Oct 2021 10:58:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211007085027.13050-2-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 07/10/2021 10.50, Janosch Frank wrote:
> RC 0x100 is not an error but a notice that we could have gotten more
> data from the Ultravisor if we had asked for it. So let's tolerate
> them in our tests.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   s390x/uv-guest.c | 4 +++-
>   s390x/uv-host.c  | 8 +++++---
>   2 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/s390x/uv-guest.c b/s390x/uv-guest.c
> index f05ae4c3..44ad2154 100644
> --- a/s390x/uv-guest.c
> +++ b/s390x/uv-guest.c
> @@ -71,7 +71,9 @@ static void test_query(void)
>   
>   	uvcb.header.len = sizeof(uvcb);
>   	cc = uv_call(0, (u64)&uvcb);
> -	report(cc == 0 && uvcb.header.rc == UVC_RC_EXECUTED, "successful query");
> +	report((!cc && uvcb.header.rc == UVC_RC_EXECUTED) ||
> +	       (cc == 1 && uvcb.header.rc == 0x100),
> +		"successful query");
>   
>   	/*
>   	 * These bits have been introduced with the very first
> diff --git a/s390x/uv-host.c b/s390x/uv-host.c
> index 28035707..4b72c24d 100644
> --- a/s390x/uv-host.c
> +++ b/s390x/uv-host.c
> @@ -385,7 +385,7 @@ static void test_init(void)
>   
>   static void test_query(void)
>   {
> -	int i = 0;
> +	int i = 0, cc;
>   
>   	uvcb_qui.header.cmd = UVC_CMD_QUI;
>   	uvcb_qui.header.len = sizeof(uvcb_qui);
> @@ -400,8 +400,10 @@ static void test_query(void)
>   	report(uvcb_qui.header.rc == 0x100, "insf length");
>   
>   	uvcb_qui.header.len = sizeof(uvcb_qui);
> -	uv_call(0, (uint64_t)&uvcb_qui);
> -	report(uvcb_qui.header.rc == UVC_RC_EXECUTED, "successful query");
> +	cc = uv_call(0, (uint64_t)&uvcb_qui);
> +	report((!cc && uvcb_qui.header.rc == UVC_RC_EXECUTED) ||
> +	       (cc == 1 && uvcb_qui.header.rc == 0x100),
> +		"successful query");
>   
>   	for (i = 0; cmds[i].name; i++)
>   		report(uv_query_test_call(cmds[i].call_bit), "%s", cmds[i].name);
> 

Acked-by: Thomas Huth <thuth@redhat.com>

