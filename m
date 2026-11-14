Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794623720;
	b=CIOYu0a+eKjHgsyooGwXCkBPacoVriPt0QpMSeWdePR2xIEo4mXHNUYbLuViUbMOsSfx
	 yEKZE9lG11I+M4HDZx5XaFbJDGwq8hfl46d0FgoeIdUMkc4R1eW3U6j/fnoO54OiGM834
	 K/q4QgdC+y2Cyad6FC14LyusUlYkbc7jGGJDVMs9SdAwU4jNHtJ1t++Vy7LJjIOwLhklu
	 I7bFJBchSIbq00N2RrXQR98Fbvqyj456aW8P1FUnJusFf5v1QaG01qXow72EPzTl0xoB0
	 eB37/V7hfxF2eJHGgLvy7ddQMK9Yrj7DFpCD3vYZh4hWvAFZ1wApgPZPVoFLOwj9xUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794623720;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=BrzkgDtWmdDQLLKKJvsVZHgpBzkxi812kF2+E/CI8dg=;
	b=piHKZhUr3Ayph0xsJFvT0CYgUoAJ51PpvrdobanYjCLX7izsEb6fwTENMWoVYnwXNZb4
	 ScDb1tu/MNiBbK3hKrNXq4+nwHlykD6q1BLs9cT7NnvkDXOcIReJgLciEgp0gdkQ0tI1r
	 1PK1QF6Trz8xVCYpahkh4GVRVOzL0pSO9LTlJl5LdTrhK01WUkLxn8gY8VyEdTA/7Ctr0
	 94zmHWE4/zWYpFDJ/8xVGYRHK1eDbDVSPChl1XocNGAoIWf/KoJ2TiEXar1SYQwMtFk6C
	 Rwg77ZNEuNZcgWZzBtUaHotIych8EWfcMcz99R8QlXT2zSD/8xgT0I1N+DBJ7mgEHYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=mZnatXzY;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7645D606A330
	for <linux-s390@vger.kernel.org>; Sat, 14 Nov 2026 02:35:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7645D606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=mZnatXzY
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-37986eb6fa2so807052eec.0
        for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 18:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794623718; x=1795228518; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BrzkgDtWmdDQLLKKJvsVZHgpBzkxi812kF2+E/CI8dg=;
        b=mZnatXzYfihV+K0Xz6NKaEt/cKyKNB6tE0Mh+p4gUiVknyXCfxiaJm5+YxmIotuTtL
         jq0wW79xISRNi9F8rNtwaoq3Wl+ShSd0UA+S0XtqfJChyIgsEJiQrcsQ+dXJV1yJW0zn
         JC183XDBUJy//PIMZ1Zq4wHQ+iTCZl30Vw4tc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794623718; x=1795228518;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BrzkgDtWmdDQLLKKJvsVZHgpBzkxi812kF2+E/CI8dg=;
        b=csjap/mStYs5l/wjkb/XC8rc7wu/4B/mQ5DbEtne3Iqi3Otm8n9E4fJaylHDTIxTiu
         4s7r3iUiY6ERM378VgozTb672JUjWvS9k7/uRE23LhH8Hodt3OI3a3TGvA3Om6VmZrrC
         sWUjmRBfOTUolwEGlECR2BvQetJ9/jm+bgjq/Pqg0rKxH699DKWajzemHVQOhj0QVwL4
         Aqpl2PRqU1MFWlkHC0jLpDzd0t2yzBMeb5vcfUT4vD8bJpTSOY/c3f0vcBZ+LMKNBrNC
         euXDWnbtot3ngWeuWt3UAjDCfvJhyB18tmLci3lkVkskTg90NBVaejAu8rP7qfNb1AOY
         jS3g==
X-Forwarded-Encrypted: i=1; AL+hErGxTlF7etrsLFyPSN5en8g7DgC4XHKCMJX2ZK7X6Ue5r3VJbAIlUicAp7EQQFcahLczlHe8FST1aYXP@vger.kernel.org
X-Gm-Message-State: APuU4Z936nrNXnCwy/HzAA1XExR89eqDYN3AgdYbmEuOrksUdos0i7+s
	nR1jfLHloAESZ119JwLkIe5mwtBwb9wHwzhamFK/OcKeW2L7+PMf2qXKr7pWJjaJpw==
X-Gm-Gg: AYBFou3iNn3/8tVhYA76kcWvxZOBU3eBlOT4AF0pVUsvOUnj19CHDRYBStbbclg4RiU
	wRjAzXRhKm6cyGw1YKvBl8o7OmiswyytNyecAXK5kyuAiUnmSNJt7f7bOlLet5iB1l3F0otfJPa
	vLNdE5pJdHxU6p4uayLN1jvIgxCLQwkDaSvMY01dVH0oupZLvN8bhiM4iMU4WlLU8x5A5yCCH1h
	4Qqn4NLHLtlwoWTz6NMofXw7cTcNY3S5xJN6GKpcrsnpL61V27DOJqURjSCSTDJPopCMvlID2Jk
	HKBTEjEyhQAtqqg/MPA9B/cWYoBP1V4nR2RA5/mCSjkzeqwkfoDP9+okp975v3gPUjBolGZOeBi
	P/upVBcst7Wnvvmgc/wlD962KeaczGYyc0oSsvfBwlYp0dDcOJCDvu1WNk55sH6iRFMVCHWW4Oi
	NwNiFpPhTgLSw6q8Wu9E09t3jle/YUWYNCCXv4LqUQeDe3rJ+Dbbfy2kruiJUoD8en1ljqBFBf3
	Ibfdw31Jv2T31Zjd/9fDWZDRG/8bmDPUVHeG2MA3y05f4iVaJoesd+a00eaEGtM+ODNE0MhKOgK
	Xg0/lu0jyPR/FoS5FIVWn83j9I+zltkxFLGy3tCX4R8j7xSEv4U12f0f0O039NDkLQIwsA==
X-Received: by 2002:a05:7301:9e4c:b0:366:dbf9:32bd with SMTP id 5a478bee46e88-37965da96cdmr3175541eec.9.1794623718394;
        Fri, 13 Nov 2026 18:35:18 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:d97f:ef68:a8e1:6af5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379558231eesm11080880eec.12.2026.11.13.18.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 18:35:17 -0800 (PST)
Date: Sat, 14 Nov 2026 11:35:11 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Xueyuan Chen <xueyuan.chen21@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Minchan Kim <minchan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
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
Message-ID: <avfImwT4gmBYdNv3@google.com>
References: <20261111-zsmalloc_stat-v3-1-2d85ed51570e@gmail.com>
 <avZyo_hCRonuhXW6@google.com>
 <179457128804.2142163.14813125534208665209.b4-reply@b4>
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
In-Reply-To: <179457128804.2142163.14813125534208665209.b4-reply@b4>

On (26/11/13 20:01), Xueyuan Chen wrote:
[..]
> On 2026-11-13 11:19 +0900, Sergey Senozhatsky wrote:
> > On (26/11/11 20:41), Xueyuan Chen wrote:
> > [..]
> > > diff --git a/Documentation/mm/zsmalloc.rst b/Documentation/mm/zsmalloc.rst
> > > index d2bbecd78e14..4c0786378dc3 100644
> > > --- a/Documentation/mm/zsmalloc.rst
> > > +++ b/Documentation/mm/zsmalloc.rst
> > > @@ -33,8 +33,8 @@ proper handle-based APIs.
> > >  stat
> > >  ====
> > >  
> > > -With CONFIG_ZSMALLOC_STAT, we could see zsmalloc internal information via
> > > -``/sys/kernel/debug/zsmalloc/<user name>``. Here is a sample of stat output::
> > > +With CONFIG_DEBUG_FS, we could see zsmalloc internal information via
> > > +``/sys/kernel/debug/zsmalloc/<pool-name>``. Here is a sample of stat output::
> > 
> > While we are at it,
> > We use zramX throughout Documentation/admin-guide/blockdev/zram.rst
> > and in some other files as well.  So let's just replace user/pool name
> > with
> > 
> > 	/sys/kernel/debug/zsmalloc/zramX/classes
> Zswap has its own zsmalloc pool too. How about this?
> 
> 	/sys/kernel/debug/zsmalloc/{zramX,zswapX}/classes

Ahh... zswap.  Good point.  OK, feel free to keep it as is or
to use zramX/zswapX.   Up to you.
