Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD3525EFBD;
	Wed,  9 Apr 2025 14:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744207903; cv=none; b=oKcDtcJ++IBdIF+BppGnJe/eHuxaMZEs3tek6iNtfQpgwWD3gcs9bAlKIfAyrh5nGVLHtVCf4l5MT84psbFS1uEJoxBT+H0qX9SiCavFULqh2UC12jWxkBauOLs3+EaqMr+5PgE9JzsW2tPSfZ/bnSZwfkARXo6M1AmDg5cBkZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744207903; c=relaxed/simple;
	bh=7PQYfFfvCRNIX65tpI4QKa4NR1Ha1vaEAgebWu62+kg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YhSi8HEbz9sVU8kjVnQaY01/+Wr8X9FUAmXXZpkT6HeeXXth1TFvUejqlmNg4uRsNBHOvgZrD+Q82ub08CYrmT6KCXJhW6ajYPxmUWw0dFnCbvbaxyY57fJsHrSrwO8TCs2A5EZMDAoSeBmmwtvLoC/5b+5aDqx6EYhjRAxMx2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CzeTAKDj; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzeTAKDj"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3978ef9a778so885558f8f.0;
        Wed, 09 Apr 2025 07:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744207900; x=1744812700; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=79dRAhMX6hAzgdIihnfQk7TyjpU16Gt/P7A1hHpHnDM=;
        b=CzeTAKDjUeS3wEk4TaNTVDH99uciL+p9pgX7aGcuwFO0tSjrBUuBeNxyfymwojZmS8
         gC0T4b0ZfJ0hafkkWnQpGsNWcG345oqC1riNRWHM/FHYkUeEChE7bi0aOrbdt1jIvZiP
         zxy0gpcttnriL2mWLGsHV8l3LQkE78869C/jxtazgPrfWpmOBh+w6MDpWvAAtsc6+m+F
         mwt57J/39FR/WzDJDDgU0bVS6+N6abOUCfiwCK2PrDHBAVF0hdV1r53yZoMvcPyCRWnH
         TZLkHLOWIuWcF9EaibKyDf2nUGTLEmHfA5V5zOWNbdMg00L0Gz5JvEdD2OVM+WLsoyTl
         FcjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744207900; x=1744812700;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=79dRAhMX6hAzgdIihnfQk7TyjpU16Gt/P7A1hHpHnDM=;
        b=kXhEGkLlzcCVz/1n57qQOMNXR7kvrKjE7TMavFfCvrdOsA4+d76M5/dar57xF5UOee
         l4Pf2VX9YWOEi/OqQ/thjH45b/dZrLo3cvspo+xOuoBiCkJl3v0ZGjOdfkyfZdBvPjzT
         Iv0aHPHONQI509HEjLeubz9+O9aq8k0CjgsoLv6+i5aaeODtrRnGydwFvSxajjwR4k4E
         c4WdU80zo676z9DWzZGrDsfK9Vu1Sf50I5UN7JRg1C83aR9rPppwOln6YJmoJEbkn2UP
         iVg90pkix2lfNq3r02G8TnP1KCnyQraXSX41D26NVkPTh3YmTlulIHmuxyvDeckl+mun
         Ssgw==
X-Forwarded-Encrypted: i=1; AJvYcCU+yKtiqpET5uS5TYlIzFQvfd6ml3nGGTHwRqMk18nK8G5VO4Hvo6wmwgccGMKBNHTpkDmqZSPfA4R8WmU=@vger.kernel.org, AJvYcCVSZq/Qx7pf/7zRvK70jY2HxNVtjokQFgVxC2bCKetZYFA1bRuW5gQnd4/nx8qWzjx26Pq6IHGMz5kHwQ==@vger.kernel.org, AJvYcCXZ1TjP9sq8eIAK3RGpqnPzlWtRxlHFgwtoMqRecBu5mYndVWok2cqyrIiXATa4XT91COP35s3X0/nyIQ==@vger.kernel.org, AJvYcCXg7SENH0cjSZ/ZHXjZyL3C4GumODf8xpgHSKLcx2IIB0wMGrcQQ5Ucbsb6Yy0GlRirYWclxfMx@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2WgB1faCCydZT6OcPJ+LUSFY6FxSAmHk+9XX7Rs8/R8qANtZz
	lsUSPzX6hzwRWhYPpE3V3kEzrHzLzO83/1zB4zgor+JKeTth/+XF
X-Gm-Gg: ASbGncvLeiLm6VF/j43LxXiVeinmCUu+Dwu4HrzHQzMpzvluAkbnHuG6tpsopfo+xp3
	nXMdaiP6Tv0oao0fBjvZ6GQea6UlapD4YbibQg3K9QSxIOq9Pjj+SU8CFhh2ufw0SxHBeRCQW+J
	y+JK64O1Qm6IsbCYN4QDwi68Sg5VjWpq7HagCDd0frNGEgtaR2y7c3E1R+fQu5zpgvZRvHqRGaK
	4RG5u+Tk/chLtf0uHvGFpCShYfORsg7MC7HahkdiI7vViNTRg4u1Nio2oqkQIZcfOCupK2wM249
	bIRNGbNJHE8DVyAa1X2DF9jOB7FPBikeDEJusaTf04kIRKW4nWUgP+QSUtb4NSdOZLWhSA==
X-Google-Smtp-Source: AGHT+IHSANHfnsI22VvG7U6Add3MtuqdkHlNUqXmc+ZOIvDB4qPCFfsNQQmWuYIJe4cIBvlXQ9bdkg==
X-Received: by 2002:a05:6000:2901:b0:391:2acc:aadf with SMTP id ffacd0b85a97d-39d87ab626emr1029141f8f.6.1744207899192;
        Wed, 09 Apr 2025 07:11:39 -0700 (PDT)
Received: from [172.27.52.232] (auburn-lo423.yndx.net. [93.158.190.104])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f235a5d31sm17305755e9.35.2025.04.09.07.11.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 07:11:38 -0700 (PDT)
Message-ID: <3e245617-81a5-4ea3-843f-b86261cf8599@gmail.com>
Date: Wed, 9 Apr 2025 16:10:58 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] kasan: Avoid sleepable page allocation from atomic
 context
To: Alexander Gordeev <agordeev@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Hugh Dickins <hughd@google.com>, Nicholas Piggin <npiggin@gmail.com>,
 Guenter Roeck <linux@roeck-us.net>, Juergen Gross <jgross@suse.com>,
 Jeremy Fitzhardinge <jeremy@goop.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, kasan-dev@googlegroups.com, sparclinux@vger.kernel.org,
 xen-devel@lists.xenproject.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, stable@vger.kernel.org
References: <cover.1744128123.git.agordeev@linux.ibm.com>
 <2d9f4ac4528701b59d511a379a60107fa608ad30.1744128123.git.agordeev@linux.ibm.com>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <2d9f4ac4528701b59d511a379a60107fa608ad30.1744128123.git.agordeev@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/8/25 6:07 PM, Alexander Gordeev wrote:
> apply_to_page_range() enters lazy MMU mode and then invokes
> kasan_populate_vmalloc_pte() callback on each page table walk
> iteration. The lazy MMU mode may only be entered only under
> protection of the page table lock. However, the callback can
> go into sleep when trying to allocate a single page.
> 
> Change __get_free_page() allocation mode from GFP_KERNEL to
> GFP_ATOMIC to avoid scheduling out while in atomic context.
> 
> Cc: stable@vger.kernel.org
> Fixes: 3c5c3cfb9ef4 ("kasan: support backing vmalloc space with real shadow memory")
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
>  mm/kasan/shadow.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
> index 88d1c9dcb507..edfa77959474 100644
> --- a/mm/kasan/shadow.c
> +++ b/mm/kasan/shadow.c
> @@ -301,7 +301,7 @@ static int kasan_populate_vmalloc_pte(pte_t *ptep, unsigned long addr,
>  	if (likely(!pte_none(ptep_get(ptep))))
>  		return 0;
>  
> -	page = __get_free_page(GFP_KERNEL);
> +	page = __get_free_page(GFP_ATOMIC);
>  	if (!page)
>  		return -ENOMEM;
>  

I think a better way to fix this would be moving out allocation from atomic context. Allocate page prior
to apply_to_page_range() call and pass it down to kasan_populate_vmalloc_pte().

Whenever kasan_populate_vmalloc_pte() will require additional page we could bail out with -EAGAIN,
and allocate another one.
