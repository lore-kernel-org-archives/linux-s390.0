Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B9E26A092
	for <linux-s390@vger.kernel.org>; Wed, 28 May 2025 08:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748421631; cv=none; b=u5GejBWJSL2tbRBfUqXhEJlVIhhx/DbelULvQpG7Dsk71WEJnYKLwfzJ1yuwzhlyhZKt2NzfdEbmteiBI3KLYPWtUIF26+5rFv98cpkmwwuurNBaTHyZzXDjLXcNYaWANbmNJErwk4mU67wxNPRh9Bx4M7y6Dk8WITbi5r8Uch4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748421631; c=relaxed/simple;
	bh=kOYgxBQ+W9YBQlbDfJxZWISizVFAJVzuLdaup+JArFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uA/nP7y8HixZK7Mpq+y2jCurFpvRHO/+uIEMGybXqINEj454ChF1ZgHW+15M1NOGh+J1nQtwUVRnaJK6SaBAnnrZ46WowFLntPZs8gjYP+yblQYTlqbEKIeae6lBKHalwrHfpqYhX6iDMFkPa+9MoStYW2JabZdGPseGJeClqV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ckv6Mhdq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ckv6Mhdq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748421628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=INjMFoNZHli30THsJWwrfUpqbZL3EPutJNE/DS1WKGo=;
	b=ckv6MhdqdHnBPi0/g6+qJZ8OPh3G7uH/nZYP3mSnxnXo+leP587dsIVjXTT8WK0aX6a1L6
	v3UT15GZBdorqx47XN6al3U8h1iuRf59bGAJ3UgD7rPcmuyx/meNwyTKv8AfKoDjN404fJ
	qwC78e6bZM19b9KwY0q1XHQRZyJFMcA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-XZAUlkphPCW8zDCa6Auj-Q-1; Wed, 28 May 2025 04:40:24 -0400
X-MC-Unique: XZAUlkphPCW8zDCa6Auj-Q-1
X-Mimecast-MFC-AGG-ID: XZAUlkphPCW8zDCa6Auj-Q_1748421621
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43d209dc2d3so26007425e9.3
        for <linux-s390@vger.kernel.org>; Wed, 28 May 2025 01:40:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748421621; x=1749026421;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=INjMFoNZHli30THsJWwrfUpqbZL3EPutJNE/DS1WKGo=;
        b=OzLrC7PpcbwUFd0Ar5p6jW8ky7s2qNDjjh4Awu4I8ZnIyHhfJD6jPUd0U+uQZl6olQ
         VZUh7MBW36hlpRXD3bbXqtT1k1d/A+wJYrqgVWXY7PcnkieSPX1pSmvjgiaOido7AJ+9
         GQbVjlQrI1Mf8oh9PehSkc7GJLXf5+r5xhWdtLKoqGnlr8TiBhIHZl1/lXdSobe+ecgi
         hYYJQBEE/cjTnJgpU60M8pf2TgFdC4uNBbAwRPkdi1+UVz1V7gsp8B8wJ9tS4VC107PT
         jHWsoF15y32K3HhMOt/PF65X9ea8xyvHUk+xRNS1IazjbUxAWcLggjV0pgVrhIpgjo8o
         p+3A==
X-Forwarded-Encrypted: i=1; AJvYcCUYHJL+TNWmj5s1h9XQD0ktjUpDHmgqWy0g39eJBZ/5Xq76VeE9ob/FPp/d4KmdMUHOCioMaIPxSi9T@vger.kernel.org
X-Gm-Message-State: AOJu0YwimNgBzQ7NVn0Fl50XgyZ2xUMAhwApxIkXoIejAZrdi0A+eEBR
	vd5qqZlimVrA75rpJ79pIIYD5SdlOQzT7t73j0NJ/gESw12AnByLNhc6IFXGDtxiqpE3vhvT00/
	7khaO/DlzPwk7NtuaEVSAI/sxvBrCIoo3XBAACUPahZTJKJ4uBG+3wgT0sTS/efk=
X-Gm-Gg: ASbGncsWpGAuPU1H7ZyJO50TPxuT13dpKNZZgqMmeHwQI05e8tzyL39QK/qLYR4vyAJ
	3BikAxVxwto187qgLyJ1RIuVuFY5TC7DQLwYaTjvVU8GqukVu7OvuCwBwGVeAzgSq1QIS9UEegu
	DKdpj5s2JUziTskZQ2/E8kh6hQdSWPptDkxihTvVK7ib8M+lQ/esrvSvt/CmqM/2GRDxqhAvp/7
	T9GYV68H62VmyrDix5BmrNt8GTkwbkF2pxahvnYBTxh6GeWGbBqDPe0w1GrdJzqupP7GrASkggk
	8SsqFDMQBJeDe2syWEE5labYW1uOBdkaXBcJG1f/U2qgaIYC8Twy
X-Received: by 2002:a05:600c:4f52:b0:43d:42b:e186 with SMTP id 5b1f17b1804b1-44c919e1860mr138715265e9.8.1748421621379;
        Wed, 28 May 2025 01:40:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhh35eLWa25sJGBNJ3wzugUQ+UJpuEvv/sKuwgl1VLRBK6qEuCU7qUOJpDXND7/xuAILpFkg==
X-Received: by 2002:a05:600c:4f52:b0:43d:42b:e186 with SMTP id 5b1f17b1804b1-44c919e1860mr138715055e9.8.1748421620993;
        Wed, 28 May 2025 01:40:20 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-112-237.pools.arcor-ip.net. [47.64.112.237])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4507253bbe8sm10680335e9.7.2025.05.28.01.40.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 01:40:20 -0700 (PDT)
Message-ID: <73092561-2878-4251-a54e-2b81d1bb9e45@redhat.com>
Date: Wed, 28 May 2025 10:40:19 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] s390/crypto: Select crypto engine in Kconfig when PAES
 is chosen
To: Harald Freudenberger <freude@linux.ibm.com>, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com
Cc: linux390-list@tuxmaker.boeblingen.de.ibm.com, dengler@linux.ibm.com,
 linux-s390@vger.kernel.org
References: <20250528083032.224430-1-freude@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250528083032.224430-1-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/05/2025 10.30, Harald Freudenberger wrote:
> The s390 PAES crypto algorithm has a dependency to the
> crypto engine. So enable the crypto engine via
> SELECT CRYPTO_ENGINE in drivers/crypto/Kconfig when
> CRYPTO_PAES_S390 is chosen.
> 
> Fixes: 6cd87cb5ef6c ("s390/crypto: Rework protected key AES for true asynch support")
> Reported-by: Thomas Huth <thuth@redhat.com>
> Closes: https://lore.kernel.org/linux-s390/f958f869-8da3-48d9-a118-f3cf9a9ea75c@redhat.com/
> Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> ---
>   drivers/crypto/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
> index 47082782008a..226fdaaa2efa 100644
> --- a/drivers/crypto/Kconfig
> +++ b/drivers/crypto/Kconfig
> @@ -180,6 +180,7 @@ config CRYPTO_PAES_S390
>   	depends on PKEY
>   	select CRYPTO_ALGAPI
>   	select CRYPTO_SKCIPHER
> +	select CRYPTO_ENGINE
>   	help
>   	  This is the s390 hardware accelerated implementation of the
>   	  AES cipher algorithms for use with protected key.

Reviewed-by: Thomas Huth <thuth@redhat.com>

