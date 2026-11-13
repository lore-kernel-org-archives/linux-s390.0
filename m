Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794536376;
	b=WMpTIyW7DRe77UdsoDYtCAbQXRpoM/wTC6BMRCx7DQ5x0/JD0hTdl2h5P27nzkbBenJZ
	 tyoheI7O1/zTSR6HXlHKDrT+ihvTJPfLCtf9ihT7qFEUdsU0DUGKJ8aUJcki45MFjnhBZ
	 3a/9YL6Qp4B7jCa9NpErvhHbuhd7lpyMbcj6xnSuiIzH/ftrVge9yV7aNHsuptD7mDDVG
	 eckLQI2XZXFZZsdkebiADGz7Hf4RjP/C2jtCNgdYbktPxtjk6lvtCv75f6YEn2o8WPDWK
	 PZsq+EfYjzgo5LO+J85NPTQZS2sW6wAgBAyQWqeWyoeYYVPb+/0yI1WGZmIg3FeGfnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794536376;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=ebdv6ZUT/HH0C8QcvPGAmiBNBGZr0ii2abVsK2I4hFY=;
	b=pEdIoONRDtcmURiWpT0rMbCAeDKj6ej6+kcbdtsS5vBK6sdgcCEx0un9pZyqXxY53YMU
	 ZHlqEXw4XIIALGnGmKTF/w0Yz9rnD816zjncN86I10goDGIalwwWftMA0GFdTb7aeaEQ8
	 +xKNb6aiZKvpv0kfiOCGUBziil/HCPzFBhpwb3VzvV83xm5ewCCyrbeS/xVTVuzeAEs2s
	 q825Bzq5dw3WqOnbwGKtcPsB0TLY6nsWZIqbyl+nNRM9g/WiNS/9ZTptsriLwLcKm5pZ4
	 hy0y+3eB1GFSZP1LHuffmYgWP/rqEtYpz8HUwFWpLrN7edU3jB5E5Q3qXk4AhB3HsqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=SgnUgJjv;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1030E606A321
	for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 02:19:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1030E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=SgnUgJjv
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-14394530ec6so545626c88.1
        for <linux-s390@vger.kernel.org>; Thu, 12 Nov 2026 18:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794536375; x=1795141175; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ebdv6ZUT/HH0C8QcvPGAmiBNBGZr0ii2abVsK2I4hFY=;
        b=SgnUgJjvj3E/rYqpDsR5uHPvfoQtiJeGLe/Y0bcRfg1YSm2buL5B+cGqTAldTFoH55
         Wu7FA/dZ2BRZX+8op8v5YsnEiEdM287W1mpZwduE4hrQZBfAArR06Zrc88ay+k98IjU+
         piekQuO2cQ4uLY58UvrawIEaCvIUEDVaA8v6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794536375; x=1795141175;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ebdv6ZUT/HH0C8QcvPGAmiBNBGZr0ii2abVsK2I4hFY=;
        b=w47m2XnKsroOq0ZhXF1goGSgb7rsiLH+O/nonRkVYQKm9HPjA59fagLhse3JWii8ba
         6P2ZyzHUTEDqYM58RJ4pQKmbdEjOPkgRLuq+Cb9ubzdVyz+YJlmWeS2Ijlkk31m+KG4T
         RpPW6lyjZpJmf58VKcs3L+o5xuft386H8bbyzsn5YJVWzY4y7dNV5pOue85t45qNu8LW
         Qd8HTnwsZyHDczasLcduORWP5pYlqJhCXVQasbMfYPHoMVtcQFyHVlPvXNiwnMlkAQ6I
         7vg5KAQt5WvGZnG/7AhHuUzTQ1wtOzd5snD8qBBHD+0b+CBbt6HWjaiMA9VEyzuecRNE
         fXZw==
X-Forwarded-Encrypted: i=1; AL+hErFaDj84aUNa3M2X0PqLVU6VjmK2JoLu93CTQgMIJXZvN3luvYb4ZEp+QpjAyRP8/l2+FTUJFU69IGXL@vger.kernel.org
X-Gm-Message-State: APuU4Z8PAYkcgP36XDv+MpTm2HuiqRJwSKZcVn9aaG0PwbxEVOHKlvme
	2oSAQ16nscrY9q4L2OmTRM2QwG1Alrn8EnSEXPQoYyGYK1o/30iU/uFqNfP63Ct9mg==
X-Gm-Gg: AYBFou17fnHCVUDAEH1yqOrj5Z9bLVhpQQ34ZCf4n169tldiYZYSTMPhAiipXpn29Sh
	Zty0phj1G3Wrq2lNkVg6VH6DCy2xmCL5tWDpRUhu38r38D5Omp7slBv9CcPB07qTRMC/u+Mczyx
	3pHNhx+YFa9aPJQQ8XF3AdGn5Q2GBnLIOESCC/azcq6pQu/Up5C0tMPLMAi/ZR8gYEtlmEVnYsC
	tprmP9UkP53oLOGX+ZDg8Zo1WXH2TKqzdFBK3VF9Y/n0moBCnmhfgA/pNG4nMpFv/e60yIr2yoc
	W8k6HytOqRZoqZD9/Vbqgv3/FAMZQ6PgwFss4AUnXhc6amQ8JGtfyo2fLhYP6VnmiKvyImNBnOF
	8M93s1m2Zxdgymy2GnGPuW2C7mVLJ6/CUD1O8LgzVXjMvL423hfl1dKItqGIbEkHuH8uPm/nwgX
	D+61nylADdww3nuyY5fgZ6sr83dWfrEJVOytgGH9UgUPL3kXXXDjO4PPvlKQ5YujmanAzGQ0DNS
	DPvXVJQaotpCjlIXIQ+/59TpyJRU5IK7J7b5tJVHQ0Idl+2VYeGfRAzjYORqnILzvraI0xcckoH
	CYTBkFLMyd5YTlI92AJi2FsHFZULQ4orUDme2mHZnqEVGWJyzcpYL3E9e8r9mRFpqxDO6A==
X-Received: by 2002:a05:7022:3a03:b0:1a4:9eaa:d01d with SMTP id a92af1059eb24-1b50315d8e2mr1234175c88.45.1794536375046;
        Thu, 12 Nov 2026 18:19:35 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:3f2c:d0f6:e2f1:e609])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379565d269asm2477887eec.23.2026.11.12.18.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 18:19:31 -0800 (PST)
Date: Fri, 13 Nov 2026 11:19:23 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Xueyuan Chen <xueyuan.chen21@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Alex Shi <alexs@kernel.org>, Yanteng Si <si.yanteng@linux.dev>, 
	Dongliang Mu <dzm91@hust.edu.cn>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Helen Koike <helen.fornazier@gmail.com>, Vignesh Raman <vignesh.raman@collabora.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Nhat Pham <nphamcs@gmail.com>
Subject: Re: [PATCH v3] mm/zsmalloc: remove CONFIG_ZSMALLOC_STAT
Message-ID: <avZyo_hCRonuhXW6@google.com>
References: <20261111-zsmalloc_stat-v3-1-2d85ed51570e@gmail.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111-zsmalloc_stat-v3-1-2d85ed51570e@gmail.com>

On (26/11/11 20:41), Xueyuan Chen wrote:
[..]
> diff --git a/Documentation/mm/zsmalloc.rst b/Documentation/mm/zsmalloc.rst
> index d2bbecd78e14..4c0786378dc3 100644
> --- a/Documentation/mm/zsmalloc.rst
> +++ b/Documentation/mm/zsmalloc.rst
> @@ -33,8 +33,8 @@ proper handle-based APIs.
>  stat
>  ====
>  
> -With CONFIG_ZSMALLOC_STAT, we could see zsmalloc internal information via
> -``/sys/kernel/debug/zsmalloc/<user name>``. Here is a sample of stat output::
> +With CONFIG_DEBUG_FS, we could see zsmalloc internal information via
> +``/sys/kernel/debug/zsmalloc/<pool-name>``. Here is a sample of stat output::

While we are at it,
We use zramX throughout Documentation/admin-guide/blockdev/zram.rst
and in some other files as well.  So let's just replace user/pool name
with

	/sys/kernel/debug/zsmalloc/zramX/classes

Here and in the Chinese translation.
