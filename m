Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745F6286A6
	for <linux-s390@vger.kernel.org>; Wed,  4 Sep 2024 06:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725430565; cv=none; b=kAkbp6ml+d2DJFvusXuRbsSPEEgldxJpj48VoUkslfX7TId7EIcQk0+bBmr6O/iOoiTUkusIH8AHbtDq/5h+Xy1ik1sLbdPMc0Q25xQX9+brsWV4hzeH1RPrOK/JmOhmXIRwiUbNljjBKvvj4VskdQKL5uwwhQ1fvw/gS2MdL3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725430565; c=relaxed/simple;
	bh=bwl7J8Ei0oLXUFycI7mAAA8XLCISgfFwAHSrsJFGlrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Aso5o/1pQYnfSSbaH6qt+MxwipxWzWWmniSg3EHNsdR5k6YLpt+OkHG9O7T3oPCqN246K1ffWqAWAmZ+SlY2bbzj3ucovGcvWMy7sqsZ6lyPsYXfDo9gzZtkTW2VGtoQN25r/0xHowKZe397Wg/+eziE7Kf68SftIbRrSyELp5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JOs91JMn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JOs91JMn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725430561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pFi+GvA472wwOZH0lUKoPWTzWmpUD/+iLOVkN6gRHFI=;
	b=JOs91JMnIfq1lzhmIDwCTX3wZqXPNmqFbSR/sBBa7vAv3wXzDMcdwGeCrmCxlNFm3oukDg
	xwPRFCPFNJ9SVS64UNjLUbnk0HQISE2vbZiYTuTEc1d3pst836v8vc4n0AuUw11lYWkZAR
	3lI90ncZKlQKv0i0AHGz5qxHFEhESHc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-Pe4OUvKLPGu-JN8k6lC5nA-1; Wed, 04 Sep 2024 02:12:29 -0400
X-MC-Unique: Pe4OUvKLPGu-JN8k6lC5nA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a8696019319so460549266b.1
        for <linux-s390@vger.kernel.org>; Tue, 03 Sep 2024 23:12:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725430348; x=1726035148;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pFi+GvA472wwOZH0lUKoPWTzWmpUD/+iLOVkN6gRHFI=;
        b=dtzuwrZ0llpQBfyCNcx+tAfjqWDVL2kpVbqeDekUb8i3aPC1K60ALPeHoL3JpjGgnT
         Jqm6s3BHxT58RzejVcX2UiPKW9HVUqJBRk0XcJ98hZMwznaWPYcOvokMuPGpxoSG5cOw
         DVgem7kuj5YFKwjtiLu+ntT5mIqzq0KZXwJXvCZI44jVGGQuTKox2jvLTNkhTzZ/ewBD
         qM2AfBmnfQBY1NOCFkKNHp8sAN94c1U1+DnrRdHcpFkv7wpz8RuBlovH6PYR5As8f/Nz
         DhN8oPMuj+w7ibB+rYdGMPlX+h+8QBSbqYi8M6xX8NFQpuEyV8RdgfTmWAuPAn+DsLRj
         n00w==
X-Forwarded-Encrypted: i=1; AJvYcCXfnM7SM+ZN1myodCvdxr6eC7UuZo1b1bUaBczBFiw5fMtjci1daamrzSbrVzZMIWJkUmAookLwmoc0@vger.kernel.org
X-Gm-Message-State: AOJu0YwMzN3gRaBiRxW/3lDWzXvjdsK1gSmevP37i0IUkzAf/+A6VN8W
	VNy8hm1PmfRJLqyuHonltRLxx0ntvQbXYAWriWVRLuu1dOuwk/x3xHaS5uU0eDwE6L7pJ4hrnjq
	89PSv05igmMukmZxyxc4cxCFK01bzcgoUOmbPplBjrNpP7Tz7iKIU3o8qHkM=
X-Received: by 2002:a17:907:968a:b0:a86:7b01:7dcc with SMTP id a640c23a62f3a-a89b94c72ddmr951639466b.18.1725430348605;
        Tue, 03 Sep 2024 23:12:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDGkN9s2Jmw7XcWlEqSmMDSJiOFB+htHItlggYvkQ9RraTtZHA1IDxBlv8WOsHPBd0lfuW2g==
X-Received: by 2002:a17:907:968a:b0:a86:7b01:7dcc with SMTP id a640c23a62f3a-a89b94c72ddmr951636566b.18.1725430348097;
        Tue, 03 Sep 2024 23:12:28 -0700 (PDT)
Received: from [192.168.0.6] (ip-109-43-176-181.web.vodafone.de. [109.43.176.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8988feb767sm773020966b.16.2024.09.03.23.12.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 23:12:27 -0700 (PDT)
Message-ID: <7ef4ee12-ce0b-41e6-904a-ff43ee571be1@redhat.com>
Date: Wed, 4 Sep 2024 08:12:25 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH 1/3] riscv: Drop mstrict-align
To: Andrew Jones <andrew.jones@linux.dev>, kvm@vger.kernel.org,
 kvm-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org
Cc: pbonzini@redhat.com, lvivier@redhat.com, frankja@linux.ibm.com,
 imbrenda@linux.ibm.com, nrb@linux.ibm.com, atishp@rivosinc.com,
 cade.richard@berkeley.edu, jamestiotio@gmail.com
References: <20240903163046.869262-5-andrew.jones@linux.dev>
 <20240903163046.869262-6-andrew.jones@linux.dev>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240903163046.869262-6-andrew.jones@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/09/2024 18.30, Andrew Jones wrote:
> The spec says unaligned accesses are supported, so this isn't required
> and clang doesn't support it. A platform might have slow unaligned
> accesses, but kvm-unit-tests isn't about speed anyway.
> 
> Signed-off-by: Andrew Jones <andrew.jones@linux.dev>
> ---
>   riscv/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/riscv/Makefile b/riscv/Makefile
> index 179a373dbacf..2ee7c5bb5ad8 100644
> --- a/riscv/Makefile
> +++ b/riscv/Makefile
> @@ -76,7 +76,7 @@ LDFLAGS += -melf32lriscv
>   endif
>   CFLAGS += -DCONFIG_RELOC
>   CFLAGS += -mcmodel=medany
> -CFLAGS += -mstrict-align
> +#CFLAGS += -mstrict-align
>   CFLAGS += -std=gnu99
>   CFLAGS += -ffreestanding
>   CFLAGS += -O2

Reviewed-by: Thomas Huth <thuth@redhat.com>

