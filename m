Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3B62F5E
	for <linux-s390@vger.kernel.org>; Sun,  2 Nov 2025 23:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762124717; cv=none; b=Zr2hf0lvljjoWJL1IScgidTx5OnsMtvUG21ClzyiN+2nz9RgundD8v3KmEvUTZ+wDInZwxh3/oQcrrGFZH23Ju8s9tENiNmvlDXumsHqIspRxeKXohJWJiouWG07EO+E95r2QlJmkUXzNv7rN+MFyndMrIg1LTP4736hfF4vLnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762124717; c=relaxed/simple;
	bh=wG/TB/yBUOa5PfKMTvyXFGJg1zEUMEZaOs6dpKyYV7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jmmP/UBWsfG9u/NjUDbkHF8iHf/A0bkUKR2J0rOXmESG9H8X0wbED5GItLT6yLKJfsBP+etwU9B7tP0SU/s9fgMyTN54UvPsqBLDcadGONMIwfzAz/Y0I82ESQl/Ran6RnHs8S/JETEl78/KO9o6lcgUoTyJW18OUjPJntLzCcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aLkdI3On; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLkdI3On"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-781206cce18so4099409b3a.0
        for <linux-s390@vger.kernel.org>; Sun, 02 Nov 2025 15:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762124715; x=1762729515; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=G9e650DG6U+kXqpscGtLd6L6xEiKmB25aynSmc10qEE=;
        b=aLkdI3OnCtFO0HXjkzM6imiwinX3OSIMU9W7MD233HjHOQzdmKhFOtyFsBOWXmh0li
         7snj5gN9mpKhfq4eot96hmrO85CDmaFFVZnBRVdq8sa1aDVBX8Pe5bUDAMrJ/j0uwjzI
         4/Miq1eknCSpiDcV+9pufXRVDUSouDqr6iNmAjB0wSjvsInUFT7zV9gJW1sNgquen1lG
         +nh5DjooAOZCIjkcMafdCiBWgeOo7P2q8M3x8UgE9OxzUVjFO89iShnI398MWOANyiiv
         D+lBfXeAslxj39DN8GBKx8X9gKTMFe0rFxl59mHm5e+t1e+ai+qkMGBkPeWs13LAiOxT
         tzog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762124715; x=1762729515;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G9e650DG6U+kXqpscGtLd6L6xEiKmB25aynSmc10qEE=;
        b=dS1tSwsVFy8k4+AsDDkTJal7X8mUIdd4sFVacxrOsdIgQfrzfJXsWla0x0Yc2Bt71Y
         kXg9PTaeUCVc4gssvmiLpJtJhBKgJ5WYMq04FQYeMP/G1Q/xXg4nxYDDXm3SEm/Qtbs9
         GsdP/8gTn6rXH2P08aLsymy8FK6DUPRCihfQy5e+8Q0fkd4M5ddQ2TRwQXsKNxK4ZhJu
         12X4wfcJweTa95chib70s3H35GAoBV9HmHvbWjUIT3GnI2yo8f0XjAR05XJANV2R4z5I
         Wctx6rGiAA/ItUKc+M7pLcoeOdenl8Pmoo+nXXz/7lvA+vnKKaB2KP8Z2ul5krX5KPqZ
         3VfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRdah5zTq6axEMjegIN7DMO7E/9FmrhUAp9fHSbHdahKPz7G7cuK+0cmzPQK30zYmckabZaw8JqI3S@vger.kernel.org
X-Gm-Message-State: AOJu0YwJsc1duWGtZQzF+Oa+8qaLRlGSXb6P4EhNnFuD4/6kFBKTnBzn
	xVqqp3WdV/ckTTpS39Xg1a4HgmNnvusV624xhfFATv2JWPEY/MGye4P3
X-Gm-Gg: ASbGncsFj+/GV0cOJWAtuTqH7kd8qSi22g7N6VrwcMutWlcaSlAjZhd9Hj57NMog+Y8
	gidbLbn1QRDvNL/gpWv/BG7h3ZnRoM2pstCbjV0eZHjP3pbSfFE2mOmhxNgsnANd2qq+mttQz+g
	V8pFujBUjsQLfWjGEXvc3mKNxCYXD8+4GO4mrZwrNPoFCfTwM9nuccr40on9mXVITuoFgF5/hiS
	BzL+N++/ciODFAyGLwdy9LwPxogwcpOeYXJTnzuJRQfCcEvaAW5kLigynlgoxS+GE0Hz9oKLQxY
	7tPIN0J6C8RfXHTzSXJwcFN4RsUXxBnvjjS+eN3u8vM69TymwrcqkuAqXPhoifAFIOQ//iLQO70
	9FZxpXNr3qN0QBG8n8cla1s9QQPJ52NlYDKPqPC8Z9Sw6+faDLvaKbRSfpF4OYycMUU9urNNBqk
	IBr+tHLbMDAahIVyMMcENAq3iSaQbAYE4MnnKrYE66C+Jj8EsCE8Rkl8cs5+w=
X-Google-Smtp-Source: AGHT+IGlJTgyGSsMQo9sCsFMIGOIdR99/zS9ytPFEE1UNZomlcRHBMl9rppbeMpOnObIopGkj8r8XQ==
X-Received: by 2002:a05:6a00:2d11:b0:7aa:1e36:207 with SMTP id d2e1a72fcca58-7aa1e3610efmr3976233b3a.15.1762124714851;
        Sun, 02 Nov 2025 15:05:14 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7d897e764sm9005578b3a.3.2025.11.02.15.05.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Nov 2025 15:05:14 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4a11992c-023e-4d8d-859f-9abb659ed4c1@roeck-us.net>
Date: Sun, 2 Nov 2025 15:05:13 -0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] watchdog/diag288: Fix module comment typos
To: Zoe Gates <zoe.blair.gates@icloud.com>, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
 svens@linux.ibm.com, wim@linux-watchdog.org, linux-s390@vger.kernel.org,
 linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <fe09cb336dca5f277769b115dae55b9639dc92a7.camel@icloud.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <fe09cb336dca5f277769b115dae55b9639dc92a7.camel@icloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/27/25 21:01, Zoe Gates wrote:
>  From ebec904b22077c3ebd0a18956397a9b0540a2714 Mon Sep 17 00:00:00 2001
> From: Zoe Gates <zoe@zeocities.dev>
> Date: Mon, 27 Oct 2025 22:14:50 -0500
> Subject: [PATCH 2/3] watchdog/diag288: Fix module comment typos
> 
> Correct spelling and capitalizaion in the header comment so the
> documentation reads cleanly.
> 
> Signed-off-by: Zoe Gates <zoe@zeocities.dev>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/diag288_wdt.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/watchdog/diag288_wdt.c
> b/drivers/watchdog/diag288_wdt.c
> index 887d5a6c155b..656b937f7653 100644
> --- a/drivers/watchdog/diag288_wdt.c
> +++ b/drivers/watchdog/diag288_wdt.c
> @@ -6,10 +6,10 @@
>    * to CP.
>    *
>    * The command can be altered using the module parameter "cmd". This
> is
> - * not recommended because it's only supported on z/VM but not whith
> LPAR.
> + * not recommended because it's only supported on z/VM but not with
> LPAR.
>    *
> - * On LPAR, the watchdog will always trigger a system restart. the
> module
> - * paramter cmd is meaningless here.
> + * On LPAR, the watchdog will always trigger a system restart. The
> module
> + * parameter cmd is meaningless here.
>    *
>    *
>    * Copyright IBM Corp. 2004, 2013

