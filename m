Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D25C433EF
	for <linux-s390@archiver.kernel.org>; Fri, 17 Dec 2021 13:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236827AbhLQNrH (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 17 Dec 2021 08:47:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:35371 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236824AbhLQNrG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 17 Dec 2021 08:47:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639748826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mcgkakOKyThMrqn8rgzoaYc4Z8VMoPj4tSG9E7dWGCs=;
        b=HMDbnm7R5yCJTnAey55y2zFlIGhqxwpJkDV2Q6yWlN5ne0s6brgaP3WJamo9pf2hN2B43K
        76E8Wm/b8c40D7dRlYkZZSb41MvL2dM22eMlDz94R9JpW6kg79XsJ+ErnqZBASCRYwsPoJ
        9FjY5Ibno+IilXjXi8BiMwSSBbAltCY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-175-cymUJhEJPVuRUCdLXDieMg-1; Fri, 17 Dec 2021 08:47:05 -0500
X-MC-Unique: cymUJhEJPVuRUCdLXDieMg-1
Received: by mail-wm1-f71.google.com with SMTP id k25-20020a05600c1c9900b00332f798ba1dso2970498wms.4
        for <linux-s390@vger.kernel.org>; Fri, 17 Dec 2021 05:47:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mcgkakOKyThMrqn8rgzoaYc4Z8VMoPj4tSG9E7dWGCs=;
        b=Vw43DebQuvjmxq+XgAaIuK1Y7j0TojnyHnDlsa5Vmve5gHXMAszYK4IBNCNo/uE0Bn
         m1SVLhAAG9QtQnVLVjnGg5TVU5bK7IXUJq44pNm8D9m1RRvoHStwOJzXTb5bZgUo2Irv
         ty6oDMve8z0vyk6oCahxj9OLAP6MgVkmwB94f9vZ/a32QxMt6wHTdAoOnx4BO84QXe7q
         dvqLjxfBqhSVB6QD/FUzYn2qaE+uWB7uJaYJ1s9t9BTAk1csCnUw5rMVe85j5vn/ubg5
         uc8kXFYxy97eTuUBYrMu8EKJS1c/CfrSdFpWmyiq64u5KAc5vX7s8U8vYYlNnyvAZouf
         /D8Q==
X-Gm-Message-State: AOAM531phI+V1+EL5jTdIl/zGa/Z/OHPxG//AU+U5DzIfttH7bC+k8Vg
        nI/hsnTmW+RJBUCo5bJZBJjyqGjlYEh5KTJEC50pVsnePV+KzzZWgTTY6K7xEoasLMeUzCP1xCP
        hSSJG+1QN6UA84bO1ioZSOw==
X-Received: by 2002:a5d:460c:: with SMTP id t12mr2705835wrq.484.1639748823828;
        Fri, 17 Dec 2021 05:47:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw6BI7Ko1cjEUvdLQ7fA0fVlXkLWEnIr7gn+2V7NlGDXFN0+GvFKyKPUVLXtYZkPNlSgnydQw==
X-Received: by 2002:a5d:460c:: with SMTP id t12mr2705821wrq.484.1639748823589;
        Fri, 17 Dec 2021 05:47:03 -0800 (PST)
Received: from [192.168.2.110] (p54886ae3.dip0.t-ipconnect.de. [84.136.106.227])
        by smtp.gmail.com with ESMTPSA id k13sm7372552wri.6.2021.12.17.05.47.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 05:47:03 -0800 (PST)
Message-ID: <3e2035bd-0929-488c-28f3-d8256bec14a4@redhat.com>
Date:   Fri, 17 Dec 2021 14:47:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH kvm-unit-tests 1/2] s390x: diag288: Add missing clobber
Content-Language: en-US
To:     Nico Boehr <nrb@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        david@redhat.com, frankja@linux.ibm.com
References: <20211217103137.1293092-1-nrb@linux.ibm.com>
 <20211217103137.1293092-2-nrb@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20211217103137.1293092-2-nrb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 17/12/2021 11.31, Nico Boehr wrote:
> We clobber r0 and thus should let the compiler know we're doing so.
> 
> Because we change from basic to extended ASM, we need to change the
> register names, as %r0 will be interpreted as a token in the assembler
> template.
> 
> For consistency, we align with the common style in kvm-unit-tests which
> is just 0.
> 
> Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
> ---
>   s390x/diag288.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/s390x/diag288.c b/s390x/diag288.c
> index 072c04a5cbd6..da7b06c365bf 100644
> --- a/s390x/diag288.c
> +++ b/s390x/diag288.c
> @@ -94,11 +94,12 @@ static void test_bite(void)
>   	/* Arm watchdog */
>   	lc->restart_new_psw.mask = extract_psw_mask() & ~PSW_MASK_EXT;
>   	diag288(CODE_INIT, 15, ACTION_RESTART);
> -	asm volatile("		larl	%r0, 1f\n"
> -		     "		stg	%r0, 424\n"
> +	asm volatile("		larl	0, 1f\n"
> +		     "		stg	0, 424\n"

Would it work to use %%r0 instead?

>   		     "0:	nop\n"
>   		     "		j	0b\n"
> -		     "1:");
> +		     "1:"
> +		     : : : "0");
>   	report_pass("restart");
>   }

Anyway:
Reviewed-by: Thomas Huth <thuth@redhat.com>

