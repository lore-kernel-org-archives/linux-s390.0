Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CEC6C6FD1D
	for <linux-s390@archiver.kernel.org>; Fri, 17 Mar 2023 14:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjCQOKU (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 17 Mar 2023 10:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjCQOKS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 17 Mar 2023 10:10:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35CA2943A
        for <linux-s390@vger.kernel.org>; Fri, 17 Mar 2023 07:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679062169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uK0/pTXr/F+lyO2sa6yT/NUjkjBpRjwT+MDqQ6YwpII=;
        b=A0J6+8ADvKf8nSiEbFKf88JAQM+6DSAiN/VMW6a+MdBRO7zIxLv/pqNaUBOFgmx5yBrYvO
        +7Yqrs4TNQDVpSZdC5WniCMB3M5apjhRt/MNaqCVQQ3XfWXTYGx1qWYVDd8PuoDdtikBoK
        gYEiHFf5y2t/Nz5nASAGw770yI8yGsE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633--lyd9XQrOOSQPgNVSgquQQ-1; Fri, 17 Mar 2023 10:09:28 -0400
X-MC-Unique: -lyd9XQrOOSQPgNVSgquQQ-1
Received: by mail-wm1-f69.google.com with SMTP id o31-20020a05600c511f00b003ed2ed2acb5so4358365wms.0
        for <linux-s390@vger.kernel.org>; Fri, 17 Mar 2023 07:09:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679062167;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uK0/pTXr/F+lyO2sa6yT/NUjkjBpRjwT+MDqQ6YwpII=;
        b=5qz2ozbU5o0UX3TdryngTqQwWbhdEaIKj6hvI+7YvMDBWJsACQvUxkLPElLU2ar62A
         DRkV0qkPaHhmgaHxUF4PdasV62AHU38xoiqlPFA17+grg6hF0quKRct9zbumDj9kCHML
         hPOpwU1rYlEaMJTsRCmFPS1aA+1/QhxYYs2CDoqdmKOL7NKS0lvU9jsZVpeOQ3mSsjzO
         1xdx4QkcFf96XdaNxXFIkAPn1nvxDkBNu2KxBvNwzHziNXGQWuLiH2ZsTQV4zHdpiwXV
         Pb/eECj5N9Bskx+UYGy389rOI8V+/uCOwFewPeDdrSD6+dXzrZgn0OiJlF8cR8CbKh7i
         GSGA==
X-Gm-Message-State: AO0yUKW1+cz7nplVGYcErL790x/b4uc3TchcwuSGEcJTiNfPeAwjfyXu
        R3LQSuzKiJhPHti7003LbJjh+ItKS+e8Wd8M9P3HOZXD8csRbr5MwLjvWYU9+1XMAiJw2427RK2
        4sSSMlzwqUMMAxpPCm7kT3w==
X-Received: by 2002:a7b:c315:0:b0:3ed:5eed:555d with SMTP id k21-20020a7bc315000000b003ed5eed555dmr4952379wmj.10.1679062166905;
        Fri, 17 Mar 2023 07:09:26 -0700 (PDT)
X-Google-Smtp-Source: AK7set/BtdC+zXTv9Q+tY4cGpGhLkVt0/QTyq85Qkl+yYpSHBhGLM7tZyptLAQJXwEbLtX0BGgfx9g==
X-Received: by 2002:a7b:c315:0:b0:3ed:5eed:555d with SMTP id k21-20020a7bc315000000b003ed5eed555dmr4952358wmj.10.1679062166645;
        Fri, 17 Mar 2023 07:09:26 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-176-33.web.vodafone.de. [109.43.176.33])
        by smtp.gmail.com with ESMTPSA id e8-20020adffd08000000b002c592535839sm2068597wrr.17.2023.03.17.07.09.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 07:09:25 -0700 (PDT)
Message-ID: <86aa2246-07ff-8fb9-ad97-3b68e8b8f109@redhat.com>
Date:   Fri, 17 Mar 2023 15:09:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [kvm-unit-tests PATCH v3 3/3] s390x/spec_ex: Add test of EXECUTE
 with odd target address
Content-Language: en-US
To:     Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>
References: <20230315155445.1688249-1-nsg@linux.ibm.com>
 <20230315155445.1688249-4-nsg@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230315155445.1688249-4-nsg@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 15/03/2023 16.54, Nina Schoetterl-Glausch wrote:
> The EXECUTE instruction executes the instruction at the given target
> address. This address must be halfword aligned, otherwise a
> specification exception occurs.
> Add a test for this.
> 
> Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> ---
>   s390x/spec_ex.c | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/s390x/spec_ex.c b/s390x/spec_ex.c
> index 83b8c58e..5fa05dba 100644
> --- a/s390x/spec_ex.c
> +++ b/s390x/spec_ex.c
> @@ -177,6 +177,30 @@ static int short_psw_bit_12_is_0(void)
>   	return 0;
>   }
>   
> +static int odd_ex_target(void)
> +{
> +	uint64_t pre_target_addr;
> +	int to = 0, from = 0x0dd;
> +
> +	asm volatile ( ".pushsection .text.ex_odd\n"
> +		"	.balign	2\n"
> +		"pre_odd_ex_target:\n"
> +		"	. = . + 1\n"
> +		"	lr	%[to],%[from]\n"
> +		"	.popsection\n"
> +
> +		"	larl	%[pre_target_addr],pre_odd_ex_target\n"
> +		"	ex	0,1(%[pre_target_addr])\n"
> +		: [pre_target_addr] "=&a" (pre_target_addr),
> +		  [to] "+d" (to)
> +		: [from] "d" (from)
> +	);
> +
> +	assert((pre_target_addr + 1) & 1);
> +	report(to != from, "did not perform ex with odd target");
> +	return 0;
> +}

Can this be triggered with KVM, or is this just a test for TCG?
In the latter case, Ilya also added a test for this to QEMU's TCG test suite:

  https://lists.gnu.org/archive/html/qemu-devel/2023-03/msg04872.html

... so if this is only about TCG, it should already be covered there.

  Thomas

