Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794289195;
	b=H+P3YbLktk7QT1ievK5F90kqDmdvItd5QTrkX7Wbw7LhOBuByQi5iLHYIAT7WgCR6p/E
	 7sMIKho4C+iw5jyWeCFVUg8kxxjpGPlGDTCmDRJSFPjItQIKzfdFwTiBR9o2RhIOPmE6S
	 ImyxXZM2pH6SY0V6rmQ1+uHcMSSFQ0UqUldfuuD0NNMnuuIlT9T397/RMu3p4VB0QKD8f
	 5Z9i0ElC65zzkfdEBeSzk99Q0o09M/GLd7lgU/THHJ0fOmb7GND01YEpM6c9ZO80hpWoB
	 WnpVDxmyF1jhX8ktjotB4QfHkjfBfx6KTKuiDedHkWipkzoKVWGd+N92mlqbHuNHs4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794289195;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Y4IpnFVFMm5fXSXAtzV8xsgRv9+hQP6OGl0+r2a9VT0=;
	b=EJCfo4ZhmBKpdTjq3b2U/LJ08fJpFMBZnySN0OWHtgArvIQd3y0kJ9Rq4vx/caeCmoUN
	 GPqmKjpZWjbFpeclSXh2RhDOnnRTWUDWLs42u+bXxqcHV9zhDQ1M/d/jY8xN+jzwtVfex
	 YSn/0vtDY2RTGPxLMGtp30Cj8lbeQizo+C3g5EIP+NmeILyXLOJ9w84tl7x1i0IyfxkAw
	 Wy+Y9E8Gl8Au+9oB9ggAeHyoUtPxuqoKdYDU35syH9t6zErT/Z56QNfF3YqzCGrnm42XG
	 Bz/P1Rn/EsctL7l382H+CdvST+2Nt7OBYwEOSK/vPvXuiXQvbsaNIO+RTOrvu0ldUeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=nYCjfLCg;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79C4606A330
	for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2026 05:39:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E79C4606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=nYCjfLCg
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ad787e0593so924263a91.3
        for <linux-s390@vger.kernel.org>; Mon, 09 Nov 2026 21:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794289194; x=1794893994; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Y4IpnFVFMm5fXSXAtzV8xsgRv9+hQP6OGl0+r2a9VT0=;
        b=nYCjfLCguMBjFt7Df/pwcAS/GPhBqgvi5e16XKr+oU3FTl4s7XEOa/w4lwVhENYNEy
         6HUfXInt0Qich4WYX2Rx0OD0rQnYQrTfrGD4byFmAPHBXNocTXgLKiro4pJRUUMPvCHC
         Ilr6Z8eXaJfgpRD2l9SSOO7VTdw3nLqZlt0Jw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794289194; x=1794893994;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y4IpnFVFMm5fXSXAtzV8xsgRv9+hQP6OGl0+r2a9VT0=;
        b=CZBCGQOpQLkVaLzjFe4h8Fx/rzK51NP1wwpWQBhe0XWJx37DhIScTL2+GCTpJwESlX
         U1pBXDOWE7fEVm+j96DSwA/okMaAkJdlUTwakL3xlna/Sjjcn0vbsZm9xCCczFkFiG13
         9kpJv3pZNL4ZrNovms4cGJ0FpskcrJCIr4S0CLBdrRLrmVdwYQUaaRRw9EKqChHb/2AP
         mCa9hNiBCmaFntyu73qjVlOnypQYJwFxrABwmdYtbPQ1kw+zXIlfsA7sX7pXCeqnDeTW
         VmEkr2C8svHr7Ahi+bJH4eQ6OshNopApf3TeM/P0daOTnYYkwy3SMU4VQop3yNrA2EO4
         bqDQ==
X-Forwarded-Encrypted: i=1; AL+hErH0i4TDkn2BmN34WGhJHrBGmYiH+57jqOK2kTt7bS9xhWJbwoL6e8xSWN3edccsZPb4KxDEz4xmFvy4@vger.kernel.org
X-Gm-Message-State: APuU4Z9PqNeSMmmsulAvlyYr5ncfdgdxZdCBTBbIk1Dz6kIsVb0vuiUR
	HgYcoU38W0qSerUQQScmMC2PkqLLf5fvMdSPmeE+IyCe/OCMaIEw7V17s/Ek7d1e3g==
X-Gm-Gg: AYBFou0wlsbmakh8/etP1C2Y4s8BOhe3DBl6M9qSHm/SNOAokgkg9MgoCFI3qcskY55
	m3VjlEPcVMppN046RsOLg+znwebAHYfZLULDQfpJewMR97pyBi5fv9q5++oNIg3u1op/pHS6/RW
	SQ8zr8VAjbYndCNxqRBgJAon/ML9cLvwUGf/PTuN1ZlCQUWUqC3jg6oX6Hnxt42lnf71BUFb+xf
	09kb11o/Fz+rk3JA374phv09wslfX/ulC0eAA+s+4j0X9F70bn4P8gj0iQ9l+4gOxB3Qx+KRPpR
	E+KMsFZz98vy7F4yGQK3A2tfgG0ftZy1UrW4jSQ5KTcf9ppU/H+UFyTjtGwZvmA0tQB+wlkbVvW
	LIskLAaaZhneAPrtVZHcOFavai7xXIVYgWvJSY4gO0uSK4KmoQGhNPFAWSrGQD+OzpIqU6/EsDY
	Vt1zbd3nynxHYlnLnbrtF54RuizShDIb5W0BaXSy4U/Tlixz1Q59AcCgt/1qQfa1ZB4j70uzasG
	9wZOaG90LjGHiPOKL36a1O0et6r+XjLEoaQfAoYcdcHnHIXwBG7IwX6YQqmaJHVApkpqoJqwkPB
	XwGnn/C1vjqBBe8bMWjDOhllb5VdFYrjVSrIinXvKDsXyzk19uVY7KlULxcMhF+ozLV0ar3TSlC
	EXCpGC4RR+GmHGJA=
X-Received: by 2002:a17:90b:380f:b0:3ac:9599:a689 with SMTP id 98e67ed59e1d1-3b166d02addmr1882552a91.34.1794289194303;
        Mon, 09 Nov 2026 21:39:54 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:e137:9384:7cd8:6e40])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b168ff86e7sm1041404a91.2.2026.11.09.21.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 21:39:53 -0800 (PST)
Date: Tue, 10 Nov 2026 14:39:43 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Russell King <linux@armlinux.org.uk>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	Helge Deller <deller@gmx.de>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-block@vger.kernel.org, Yann Collet <yann.collet.73@gmail.com>, 
	Nick Terrell <terrelln@meta.com>, Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, Eric Biggers <ebiggers@kernel.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Laight <david.laight.linux@gmail.com>, 
	Sungguk <sungguk.na@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, linux-erofs@lists.ozlabs.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 13/15] lib/lz4: switch the decompressor to the
 vendored sources
Message-ID: <avKtyCOOmK3AH0xy@google.com>
References: <20261106-lz4-vendor-upstream-v2-0-ee04c3f0d7dc@samsung.com>
 <CGME20261106144310eucas1p1d60fe5c2e0170c49f38a3142bb1d8f94@eucas1p1.samsung.com>
 <20261106-lz4-vendor-upstream-v2-13-ee04c3f0d7dc@samsung.com>
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
In-Reply-To: <20261106-lz4-vendor-upstream-v2-13-ee04c3f0d7dc@samsung.com>

On (26/11/06 15:42), Michal Wilczynski wrote:
[..]
> diff --git a/drivers/block/zram/backend_lz4.c b/drivers/block/zram/backend_lz4.c
> index 50265e3ce256490994cb6dae32a45da376e408e0..b9b8a5f678c155442fa3fd2c1984e45182e6fc38 100644
> --- a/drivers/block/zram/backend_lz4.c
> +++ b/drivers/block/zram/backend_lz4.c
> @@ -84,7 +84,7 @@ static int lz4_create(struct zcomp_params *params, struct zcomp_ctx *ctx)
>  		if (!zctx->mem)
>  			goto error;
>  	} else {
> -		zctx->dstrm = kzalloc_obj(*zctx->dstrm);
> +		zctx->dstrm = kzalloc(LZ4_MEM_DECOMPRESS, GFP_KERNEL);
>  		if (!zctx->dstrm)
>  			goto error;
>  
> diff --git a/drivers/block/zram/backend_lz4hc.c b/drivers/block/zram/backend_lz4hc.c
> index e7ee3740219852f079d1e0866da6b213a3f3a583..1e09c93016264259c149e2913b2819571b56fab6 100644
> --- a/drivers/block/zram/backend_lz4hc.c
> +++ b/drivers/block/zram/backend_lz4hc.c
> @@ -65,7 +65,7 @@ static int lz4hc_create(struct zcomp_params *params, struct zcomp_ctx *ctx)
>  		if (!zctx->mem)
>  			goto error;
>  	} else {
> -		zctx->dstrm = kzalloc_obj(*zctx->dstrm);
> +		zctx->dstrm = kzalloc(LZ4_MEM_DECOMPRESS, GFP_KERNEL);
>  		if (!zctx->dstrm)
>  			goto error;

Ditto, outdated zram code.

My ask would be to not squash zram changes with lz4 changes, when (iff)
possible.
