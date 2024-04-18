Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CF854BCC
	for <linux-s390@vger.kernel.org>; Thu, 18 Apr 2024 05:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713419818; cv=none; b=EBRtDzdhmDQvbThwTFdSb2XiiaSE3rVLav4GVDizCpRqL2XRxbJkBo5fYwJJN1lxZ5YXGKNVyeY2Q45WdE/nU4RFsKT4gJ9PVqooEJXSOEYiGQdNrcAkDX+Xk3MtEy7gM8wMjrVuovDTxhm60Q8xnHfqt1LTpxJOT3ksLZ6Jl0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713419818; c=relaxed/simple;
	bh=RLDSVm8K87CdU8QKvkxypvN6+yIETdNq4qZlkYhiles=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nbb7tU0iq7RSg3VTIRWMjSuVq+9ubctda2yJiYMvVNcXGfxwYNtU7uBglLQPrQPuC8+Ry3p1rb2fGDwe/9b/9zMePvG8oxdCR0LulfplLAQfRkEaXsf2vURFxmnk1cdXwNCW7UjZhIM0HwRVqEWiOjQchSNzgs0oBsyAJGvSQOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UlHsP9kD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UlHsP9kD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713419815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8g2uuNxxiwYQyQPoW1yOkVCXoXx7/GQBe/aHyhjlL3E=;
	b=UlHsP9kDDD8/4E7L5Wj1FY9rSkHtox+CnF4mYB9SZ6TjOee2mcJmnxBd6hu3Amgsxp5Mbn
	zSx4aDubj3R6frLPQb1LELR1osK9D4kgXHnGY6LnS2NCKI4QJOajzWZaCem+qVDRXnHF2b
	W0HlUWXBt+y8CfnI7NY7Rcgg//js/4A=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-3CuPTdShPfy4Z9kNGW32Cw-1; Thu, 18 Apr 2024 01:56:54 -0400
X-MC-Unique: 3CuPTdShPfy4Z9kNGW32Cw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-346772358easo311925f8f.3
        for <linux-s390@vger.kernel.org>; Wed, 17 Apr 2024 22:56:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713419813; x=1714024613;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8g2uuNxxiwYQyQPoW1yOkVCXoXx7/GQBe/aHyhjlL3E=;
        b=lbH0kMwn4qgMfe2gNih1noGTrehIdpcov5AKsypSubJN9upzZASXZtMyYYQ1QGM0p2
         qdaSWS3hxItwodSgE1TeZF9qZj5hAqLqWDi1QqcsARzN2CtdzqqL49olj/+MX3HPPwIw
         Ut4s3CtYtjPRyaWfFtVHZBajrSQCCwJPH3QnRBAn8UgV2jr7QwHFc4TcFfQX1ep5awZ6
         6YdVgHcMCXYUfqQyz/idajx7/SQfJLGpwAkewjTz1tp+7Jf/N3utwA8A0qbTknkoOYye
         lroGqwuZDz/ehULEeaZ78WcbK7iKxLKh7UFX93ZSWSZS8mY81WlfhOQIgpgoN8RxTgf5
         7Yyg==
X-Forwarded-Encrypted: i=1; AJvYcCW/MN/qoGcmCMoArYHGw1sbHVnUI/7dwxoUIJSgpK8U+xdncJYC92OEoj7jNpYhYfS2HHGlVJTYH7zmIfub6CoNMHQYMYrpxEECHw==
X-Gm-Message-State: AOJu0YzEqppmhb+VMdEToIAQ4CaBCFo4FUUMvAwcB7+1L8G8Gw0p5pt0
	+t6Jy8me5HNJbEZkl+lo/+NQ8zBvWGt+Q/JbtvaLAr3glegYp7AG8kI0064e5JR8DwpmSJdGYm9
	vXTou2dR50PWpslZV+cqH3t/dPtsC5nwosaCaS700H168Itd9J5wojxiAcBQ=
X-Received: by 2002:adf:f352:0:b0:33e:78ca:e039 with SMTP id e18-20020adff352000000b0033e78cae039mr974828wrp.59.1713419813386;
        Wed, 17 Apr 2024 22:56:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHq6gP4Yb3ppbn7gdUi3KkDfZ8Xpf5YR62TOPtanGXmO5tiuo00HgVFIKwjTNDhOMe5uMNFxQ==
X-Received: by 2002:adf:f352:0:b0:33e:78ca:e039 with SMTP id e18-20020adff352000000b0033e78cae039mr974814wrp.59.1713419813022;
        Wed, 17 Apr 2024 22:56:53 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-177-117.web.vodafone.de. [109.43.177.117])
        by smtp.gmail.com with ESMTPSA id d9-20020a056000114900b003469e7f5c52sm898525wrx.80.2024.04.17.22.56.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 22:56:52 -0700 (PDT)
Message-ID: <3c7b0835-3e4e-4c86-ae71-288aea437ed0@redhat.com>
Date: Thu, 18 Apr 2024 07:56:51 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] s390/smsgiucv_app: Remove function pointer cast
To: Nathan Chancellor <nathan@kernel.org>, akpm@linux-foundation.org,
 arnd@arndb.de, hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, wintera@linux.ibm.com,
 twinkler@linux.ibm.com, linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 llvm@lists.linux.dev, patches@lists.linux.dev
References: <20240417-s390-drivers-fix-cast-function-type-v1-0-fd048c9903b0@kernel.org>
 <20240417-s390-drivers-fix-cast-function-type-v1-2-fd048c9903b0@kernel.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240417-s390-drivers-fix-cast-function-type-v1-2-fd048c9903b0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/04/2024 20.24, Nathan Chancellor wrote:
> Clang warns (or errors with CONFIG_WERROR) after enabling
> -Wcast-function-type-strict by default:
> 
>    drivers/s390/net/smsgiucv_app.c:176:26: error: cast from 'void (*)(const void *)' to 'void (*)(struct device *)' converts to incompatible function type [-Werror,-Wcast-function-type-strict]
>      176 |         smsg_app_dev->release = (void (*)(struct device *)) kfree;
>          |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    1 error generated.
> 
> Add a standalone function to fix the warning properly, which addresses
> the root of the warning that these casts are not safe for kCFI.
> 
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>   drivers/s390/net/smsgiucv_app.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


