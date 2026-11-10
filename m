Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794289020;
	b=K0PcJ0k8m/7Lr8kRCQQFd+wG7XJorW8gWvhBvV9CeBZHG3Pcx+fWk0VTcdoBAUW6GYIP
	 Xp1+MhyxjD0tcVlrobuICu6wnFa7HR1jjVO/cRRGPCFEVjjMlkpjd/AIGA6BS9iwozkUV
	 6nUkWPgqyEedkhLqVpPLKqRCIecf1DtxE3kJYWxAZjEzxmt3DsM9ZuJ+AFfQP+JpQH2bf
	 ZaPpONYocaM5ExWiEwIk7A8c2KuUrHiZwH7K23+CaS0wpD8m2riorJV1fIOXZhf4FELHX
	 3DwopWAZnmqBscB4BS0Ue68iUUNYxAeKbcQXHMhMRVGj1Yyt/P8yETbDFnoaF8JiRNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794289020;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=upBQHvhIXS9jA4rn/T2U6OyiZNi8Uwc76Ij6dQGz7TA=;
	b=aF54rTEj526P3dl7HhtVOTQJ8b1OirLtUqf5RaxWPJRU5gFXEZWuQfwnFXdruumYRImJ
	 dssfiHDqh59Mv2iL87WiLyJKh+0r7Jgc4msmqgP3Yw5PuBkAbRdF5le7jaZoNAe52PWvX
	 U4tpJ/yA99AzHGAW5/D3NhUZq0T6jiWGjIJP2ffGJTkxaV56EIgFeAQlApIyv09rQFmr8
	 HNTc60z85/g0+DKGbJrJVHO0R0m10IxH41d6n1MPhSufwgCbKzhrQTl8YrtqDWUlaq5hB
	 gXSyDSyMiRdzb/qC2ZoIL62bf0fj5oYZxIBaZ0fTZYnQxbmHFmxIwtzbddtLJFLOzXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=a20xVX7N;
	arc=none smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E494860A261F
	for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2026 05:36:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E494860A261F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=a20xVX7N
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8b3577deeb0so760831b3a.3
        for <linux-s390@vger.kernel.org>; Mon, 09 Nov 2026 21:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794289019; x=1794893819; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=upBQHvhIXS9jA4rn/T2U6OyiZNi8Uwc76Ij6dQGz7TA=;
        b=a20xVX7NeZjvXNyM41dYWvLkg80id1Mtm74DkyBWYfM0GGXgLb8i1+nApuqtrL8uLo
         zE4qrJ3gNwkeUVWkpUNiFHGrdIzZeRo9Bur+lQwMh5IboV/ahqD2hnLAdr9gSwVdEq52
         47ewJ4dnUp54hAJDfsvJlQHVaRbFtqFrQtWkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794289019; x=1794893819;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=upBQHvhIXS9jA4rn/T2U6OyiZNi8Uwc76Ij6dQGz7TA=;
        b=sWx6MiS11fYAq6IQtt1SmlqwF3k/n/foMAodCrea9QUI4RPva2EBxGIhkqhKcYDfkO
         E3cttfKABFrBqWymEbm/T/sqYJ6NIIawwG/mKXRCRfCmsxKdz2O8tvbdC4nSVl7Bg9uJ
         FELj0rD4hFsqSXbnK+pMnd7mfiq2hLReTKxUYqEdk8Ha+4EGxDzMaQZi/9Dlotf+04KI
         sKtoEPSptcZ9oMioXneBcRVWvNxrFmlRhkvdXGHRkNOCzoqq3+8ApjghrnEhxX7K4HmI
         A89qjxPyMSXfiPiPQnypyAQha8YSlxm97myXD1iPo268/op/+YCiikaNIkEvS/QrE2fn
         Go4Q==
X-Forwarded-Encrypted: i=1; AL+hErE6evOjsusZ9Xrx0NqaBOvVUWF9Dpf+sgN/qMlWaOhkmrZVMntYHAzDuLyda1yUmqV5+Zt5zvfEJGFR@vger.kernel.org
X-Gm-Message-State: APuU4Z8aMJSbGWeLY2Gp/D3yFJ4xfQwDuFpnWW+i+hZvVufJ1sZk/5vx
	TP/stIvdYMoNw2aw0iliFKTI7WMiUG+VcGAKXgI4WGejsDDmAeykUK1sbQSWwMEj5Q==
X-Gm-Gg: AYBFou2NHrd8Y+a0YZ9rH5sN4LqF+eY0X3WvUEA10+0bqjTVZVfKkmAxUPz6icFWdmk
	6hRJ5uR2RZb/CsD7K5bQ3lgDTRxSbuAaRaCZlcJGLl/1Q2KMqnnYtmWVUzBF5+bEfC+l0iOsaX3
	aMWLVrTY/UuGkzVmYdHvBKWcGi3HzNmejO20unaDAlrVT9cxTjuav1IIbn7FUGoxZKdWryx35dF
	ia5gZXvT9LvtB93DtEOS6i+eo974nkTNITpqCFbtzbWD6R9VAAWP2xQsj6xGHFsAQI9e3B62/6I
	JmxvwIbO/wnXQ2k94dG3lI7+xc3go0thDqh9JF42JcTRzp08zrAcU75e6SHdcyL5AHWYbB5Je1U
	ZvYO23infkqaj5maFlvPYBEJZSX6VjnubbTH7M0VxSwK8NfyX4GkitCWUbIipF0q3jI3CVtWrO1
	H2RDR+RYdWsRKGJXLawuCEXoPXYKiSbju+W6ULVJhrZ0nn4TPeEP5cARQsqwTeRQEf3LfeIANWL
	gZxjg9W8ut2eMidxZknbkDk64L8KmePRf60V4dJMRRJAIa1XxX5iUVbTVJNEk/+BwgvQFuPGY3l
	A793JcZDirIa7vlW5aEtxN+AqMXkO6DyDbfk91UKBRGTjLiyuZ7/BwagJf2BhYXVghOHDg==
X-Received: by 2002:a05:6a00:1492:b0:89f:5c84:46ec with SMTP id d2e1a72fcca58-8ba89661da0mr1558178b3a.40.1794289019108;
        Mon, 09 Nov 2026 21:36:59 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:e137:9384:7cd8:6e40])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baab8dccc7sm405355b3a.52.2026.11.09.21.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 21:36:58 -0800 (PST)
Date: Tue, 10 Nov 2026 14:36:48 +0900
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
Subject: Re: [PATCH v2 10/15] lib/lz4: switch the compressor to the vendored
 sources
Message-ID: <avKs4_S7r6EiUVgC@google.com>
References: <20261106-lz4-vendor-upstream-v2-0-ee04c3f0d7dc@samsung.com>
 <CGME20261106144305eucas1p17b3b27d403dc7d13b85cdd9a4bea83b9@eucas1p1.samsung.com>
 <20261106-lz4-vendor-upstream-v2-10-ee04c3f0d7dc@samsung.com>
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
In-Reply-To: <20261106-lz4-vendor-upstream-v2-10-ee04c3f0d7dc@samsung.com>

On (26/11/06 15:42), Michal Wilczynski wrote:
[..]
> diff --git a/drivers/block/zram/backend_lz4.c b/drivers/block/zram/backend_lz4.c
> index 1e4ad31d39a63f45b3bddd3d8a467d8d7d095beb..50265e3ce256490994cb6dae32a45da376e408e0 100644
> --- a/drivers/block/zram/backend_lz4.c
> +++ b/drivers/block/zram/backend_lz4.c
> @@ -42,7 +42,7 @@ static int lz4_setup_params(struct zcomp_params *params)
>  	if (!params->dict || !params->dict_sz)
>  		return 0;
>  
> -	dict_stream = kzalloc_obj(*dict_stream);
> +	dict_stream = kzalloc(LZ4_MEM_COMPRESS, GFP_KERNEL);
>  	if (!dict_stream)
>  		return -ENOMEM;
>  
> @@ -88,7 +88,7 @@ static int lz4_create(struct zcomp_params *params, struct zcomp_ctx *ctx)
>  		if (!zctx->dstrm)
>  			goto error;
>  
> -		zctx->cstrm = kzalloc_obj(*zctx->cstrm);
> +		zctx->cstrm = kzalloc(LZ4_MEM_COMPRESS, GFP_KERNEL);
>  		if (!zctx->cstrm)
>  			goto error;
>  	}
> @@ -112,7 +112,7 @@ static int lz4_compress(struct zcomp_params *params, struct zcomp_ctx *ctx,
>  					zctx->mem);
>  	} else {
>  		/* Cstrm needs to be reset */
> -		memcpy(zctx->cstrm, params->drv_data, sizeof(*zctx->cstrm));
> +		memcpy(zctx->cstrm, params->drv_data, LZ4_MEM_COMPRESS);
>  		ret = LZ4_compress_fast_continue(zctx->cstrm, req->src,
>  						 req->dst, req->src_len,
>  						 req->dst_len, params->level);

The zram code here is outdated, it has been reworked quite a bit
(patches are in linux-next and Andrew's trees).
