Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02873BED6D
	for <linux-s390@vger.kernel.org>; Thu, 12 Mar 2026 12:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773320027; cv=none; b=asPpD2P3ppFTKmXQArgacqF+cc6SrCls1U8e00EPN/Rv9qMUtL0uc6GaTQVxYNYf+1ej9VO0acngb2m79MyaWrE0ixz4U3m0GlLQZHIbZHKaZqskqzdkFV9shMN1LE3VGwVeQTM2fnHdqSYztfhEfpUZ6nicb6wNqDVNbVvZpes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773320027; c=relaxed/simple;
	bh=C8Tmx+wVgPaQO3SA5g1GPxNl28HZYA6VUhyX4LUkXAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Veow7/0WmmfH8h5JceWpiLe0oqdBurva3ejl5FIsZ4llLa6FCPqtWd+y2ElXTCaw+XTUt/nthsV84fRBek7zA18pQSYkXczl5qRZasgBabmkxtEGJTYpTOp7BubLSwpGUVrbjAAQ8y31etwzpjsd/DlE08qMPFvSlhMoZZKAWNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=UWaXXe9a; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="UWaXXe9a"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-41576c5c01cso639092fac.3
        for <linux-s390@vger.kernel.org>; Thu, 12 Mar 2026 05:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1773320025; x=1773924825; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ky7U0hmCeNi6OyUrf2MxogfDAlaxZWXxIQIvc2Y9k8Y=;
        b=UWaXXe9adEBwkqjub/LuoTfvUOdMtLwqOb5VMi7pghKefO4kRJYbRFzW3il52lRgsF
         wT/prdPjuF3ji/qEyiOZWi7bhQ3brY0fwLj3M4QnxSa7mrenkj1GdacZLiTZ/v434s6H
         lzrrmZBrLBueK7sl/PyilVQ9SzDakighjUJPUBU9DTrtUiImewA6OHnXljmf5hThc/Gb
         fEhDaAhiSlfcBucXfE64hIvaGAcCY5XGYhdcc9WTivrxGOBJOwQ7L2oGTBCLV8Q+7t3X
         4Y+zA0QXzPgGr0vi7Y56TpplBbzuWOX0HG5WBfmkdlDUHeHv1I4ukRcWEFDg3az7fszM
         YWEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773320025; x=1773924825;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ky7U0hmCeNi6OyUrf2MxogfDAlaxZWXxIQIvc2Y9k8Y=;
        b=Vmttl/Kstu/f3lrsA0NZFnYLb4gsRuhdX9jkfPO1cJ2IAAOemjw3vAT3YgxGbScwe4
         k0qDSE9wELX/pM2d4pLHTkDVsvR0KeysvxtRMPNHDhVwlQkfxmyZiknXbv6sSB7W6RP6
         q4QfHTz7YdX0H7siTpb1dbSSnnMu+sk37a1D+N78/Iqg6HL3S9geyUmyvF1zt/hx0Q0C
         7xJUwzrt82aL/skeCxRmuAbhqnLh7NVWwt6npr87krNKeHplj5AgtDT7yayMawFyquK4
         g4W6VpAMn0Che4b/RclXmGxHA4/ezYBC1j1jZE1IMtI4VECcsqI/pJ3hcV2ItsbcJE1X
         Q8hQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9pO8T31pZF7YWzE7351chTSZpDTAA0ffW+FKGjYEtU7F9Ql4SHLbxrm5LOmgBERZyThh2sYVApMwz@vger.kernel.org
X-Gm-Message-State: AOJu0YyhXUQ6WhClph7w/yIBnKjSUQLOVWE/fwZV//uO9qqRkLFhOcA2
	1VQQiJPPdSJOOKq1qJDskTwV7vpWqcYtlZ6fviPwjVRA79fJ5aFLea7jAznBf3iooxw=
X-Gm-Gg: ATEYQzwaE2P0tVyKHz9SjZbO47f/+vVjtg4V72Q64EWL9W4s+QvBSZnpZxW+6Kvcp7e
	VkzWMEBqbIzYRESoLh3X4NBbLADYL/iJL1MtnUHumtJh3QPxtYQod3qoMvF/kpRjGdsis/NRaLo
	uYCRrBcPJNob0AuPOSkwdO6ihAC+UtZrpXdvLR7d73nryWGcsmY5dtEEeGtbx6r7/cUw4wYMQnF
	5bf31QKw4dbgxW/7XbrFUd793UQJAl21yzWoDC/V7wunef/gRowDuTRuYEatX+wylpAAVuIbdZh
	h+CVo3zCTuo4pbY95b6Wht5LdQa1TgOJQ5hyZwbRecJEavbzFRFUDEcg8oxGVgzoVkc7BXHFRvC
	d7Jo67vOG/1OUlAfO2Sedf1s36zGgLF+78wt5HZGv0LODJWJL3DpI/6HeYLq4Hu0UzC6AYsUd+F
	7QrXHb3NTqgu/tdLE+z1xuIs/YGPlkUrcDFL0+Ljs=
X-Received: by 2002:a05:6870:649f:b0:409:74c7:1cbb with SMTP id 586e51a60fabf-4177c6f1d08mr3392540fac.7.1773320024820;
        Thu, 12 Mar 2026 05:53:44 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.103.0])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41791432d87sm3765785fac.1.2026.03.12.05.53.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 05:53:44 -0700 (PDT)
Message-ID: <f7054184-dca2-4c7c-9e2e-4a5e3e1c81da@sifive.com>
Date: Thu, 12 Mar 2026 07:53:42 -0500
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 14/15] mm/kasan: add document into
 kernel-parameters.txt
To: Baoquan He <bhe@redhat.com>, kasan-dev@googlegroups.com
Cc: linux-mm@kvack.org, andreyknvl@gmail.com, ryabinin.a.a@gmail.com,
 glider@google.com, dvyukov@google.com, linux-kernel@vger.kernel.org,
 linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, x86@kernel.org, chris@zankel.net,
 jcmvbkbc@gmail.com, linux-s390@vger.kernel.org, hca@linux.ibm.com
References: <20260225081412.76502-1-bhe@redhat.com>
 <20260225081412.76502-15-bhe@redhat.com>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <20260225081412.76502-15-bhe@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Baoquan,

On 2026-02-25 2:14 AM, Baoquan He wrote:
> And also remove the relevant description in dev-tools/kasan.rst
> which is hw_tags specificially.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 4 ++++
>  Documentation/dev-tools/kasan.rst               | 2 --
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index cb850e5290c2..e0115fad9e60 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2899,6 +2899,10 @@ Kernel parameters
>  	js=		[HW,JOY] Analog joystick
>  			See Documentation/input/joydev/joystick.rst.
>  
> +	kasan=		[KNL] controls whether KASAN is enabled.
> +			Format: off | on
> +			default: on
> +
>  	kasan_multi_shot
>  			[KNL] Enforce KASAN (Kernel Address Sanitizer) to print
>  			report on every invalid memory access. Without this
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
> index a034700da7c4..eaae83fcb5e4 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -129,8 +129,6 @@ Hardware Tag-Based KASAN mode is intended for use in production as a security
>  mitigation. Therefore, it supports additional boot parameters that allow
>  disabling KASAN altogether or controlling its features:

The sentence above is now incorrect as well. I would recommend documenting the
parameter earlier in the "Boot parameters" section instead of removing it from
this document entirely.

Regards,
Samuel

>  
> -- ``kasan=off`` or ``=on`` controls whether KASAN is enabled (default: ``on``).
> -
>  - ``kasan.mode=sync``, ``=async`` or ``=asymm`` controls whether KASAN
>    is configured in synchronous, asynchronous or asymmetric mode of
>    execution (default: ``sync``).

