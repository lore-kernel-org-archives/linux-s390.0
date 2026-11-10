Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794288727;
	b=AYpldkGq8M01WxbJizZGvkZIxG2hxS/n7ounqn0BEicLbkavYGKU26DshYKXD9j9VCdG
	 VR4R601A7Wb+pPXUS8VQlygwkoHKntE5g/hvicp0yAMFgzNpgAcFSNkHgCwZyzj7XVEQ/
	 qvUvyu3lwEyeSoYFkNm872pVJSncF51wblKR1Xt4dhQtaEdXAk64lRMBpPi9usO3UXFxk
	 ne7EtDaKC85mMgrxLtQCt0r4n5bbPdN3M3aoNxcXtK0Iayc5uZPtLPYL/Cb1SYQZ/cdER
	 DEwlIOW/MIlFvdmruL5QImQy8vbWXZ5eDfGkRgxXuhtKsj0MHBTgaujJ7fL2SbdkMxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794288727;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=xnocq1WZWdoAPVGSUgOgkKPWt/rTa6IdAGYk7ooAxeo=;
	b=ezz+Bu36BkaTiHUs01jLSB6WZBYpdMoyXOnD4VEUmdv/DkbbGnC12niyZYYgI2K7tmYn
	 QmFVf1M9W9opK4LUnpNCtA1KMyRSJphdDkil2vvuKOMGcxPygp0gnNym4MyZL+/k6pMN4
	 sAiniATa8VTzyGLI73ujSBOpbVhIGzp+bU8txYVqj6BXvR0Z8peK8DfG5DgRLJpadZlmJ
	 LjjStF9WtPepWEB9+HRr/8n93jFmyBMnU29HNsbqAukkLKJcOtG4quPexUaT3AW50RIHs
	 OFT2g43KS2V+SwhDOqZmmvflENBSM6kUzt+55S+RyEsk5ZxsN2N1IbpNnEVcPGEStww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=NKD7nBqu;
	arc=none smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC01606A321
	for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2026 05:32:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEC01606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=NKD7nBqu
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8a05b210703so806365b3a.0
        for <linux-s390@vger.kernel.org>; Mon, 09 Nov 2026 21:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794288726; x=1794893526; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xnocq1WZWdoAPVGSUgOgkKPWt/rTa6IdAGYk7ooAxeo=;
        b=NKD7nBquVIBNB4qaaYR2zKW+bAMipyhfH6k5oIss7pvhTr5H9DNDivmA6LyFBlYTaI
         4uw1kRx4aPbJe3bz/4M6KlZJDaZ3OEIvYm9wlTKWLh2MiMoqB2GfrySxaqYj3Idv/ftJ
         aGTK7fjoiU34fH/KaVYzyLEfPizBt75JslG4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794288726; x=1794893526;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xnocq1WZWdoAPVGSUgOgkKPWt/rTa6IdAGYk7ooAxeo=;
        b=slEJxDlwx/dAZlfJI6ugADG/u7CLObgXkhoK8FFfdf1gjiArh5smMdpH/eEeOdOxTx
         dX0VNhM/SIy5XdF+OvX3k/332AaeHsrtkvhSMm4N6skLz4p+DIVs0frM6jCRPO9DK5Xk
         P90lOka7p/TfSHjCfxDAHIOuLI32MzFelUC+Yb02SGMNARbPL1vSOVCEYuuo5b/8iCqf
         fPf/WXyGt3DLI/jDqroETYXvOR1453bef8myISV7+tTWJY0bZXjqhivw1AlRGiX+xjkI
         f4EBeatyRgvfxQFigRT3PyFa3lDJiyqFsGwOH52+nRKBjl8cS5ijqsDIsXkyYdcBzJqw
         Ke3g==
X-Forwarded-Encrypted: i=1; AL+hErGUy2byoJ7NfX2LiNdxDf4Fn2u4Fp2YBhUuiV996zjjzFceZmc0IRD3Ry5PL4jjuHxWsnRbwXxosoxZ@vger.kernel.org
X-Gm-Message-State: APuU4Z+k+c1Zq5vaP6Dpg6S3BcfVV7WwXmKMn7EFbT97fvFGSI6slzK0
	DhKQx7JVuqPAtixPQC5JJzzXCdC3RlYCMTNpynlMOnrFluZHv0KuFHWdkruprxeing==
X-Gm-Gg: AYBFou0E+VFu8XePMWFU4ar0Itc+axSvAN+2OtDGy5CXbSQYy+1GGs6Pn6V/+X+qotU
	ZHDtx1T59/edZe7OkqgY0MAyewWZPTdPx2Hkv5QK26PsqNXlA+luUvJSAbh/GG+heFEzVSWiJIA
	DLfz2SoLy/0d3xhrOuTdu3rZOe3di2uqYX2JabkapKFfN/1dF6OTn5SBpnytAThEy0X4nKEyWeH
	YtMq4Kx5dAkjYwR6USDCuoeOk3EoXeH5zDZD5rqEHsXePomS82y3Q3u5ePmtGSgkbY3hnI+dfMP
	mE4eH42yBbmIdiH7NgvWkzeHlMDjj92zSI4HCWy/AaN6oWNc1Ua7RFmm/mg5Y5n0lVplTjGWJRo
	Wq7euxgrPgqNeGS0vdYztqs81EhzuCfBLci/mCGo/wwmCqr3nG78qJQnVQU42eTIif4J/ucI8HF
	iOVGks6V1Rt6/Ch0Rz2JRRqq6xJkApVCecBNcAGfVaQwA0GsicvLXnBWZeGxwfkho/oCxQU3FXb
	JSW0Yk5VZWxHHIsC+Igj/o49ArNN9lll5mp5o52JcAkYOInM8LpraPEe+/gJRRFe6vXVEKk0cto
	MwYHZCnQHX6HO1+kXEIs1eZqyoN20l4OgvcqvXjWyjB3cDUyahsv2gCaVefvpJvbpamMew==
X-Received: by 2002:a05:6a00:408b:b0:8b5:f9b1:a8cf with SMTP id d2e1a72fcca58-8ba87550f4fmr1854484b3a.51.1794288726218;
        Mon, 09 Nov 2026 21:32:06 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:e137:9384:7cd8:6e40])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baab8dccc7sm400979b3a.52.2026.11.09.21.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 21:32:00 -0800 (PST)
Date: Tue, 10 Nov 2026 14:31:51 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: sashiko-reviews@lists.linux.dev
Cc: Michal Wilczynski <m.wilczynski@samsung.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Russell King <linux@armlinux.org.uk>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-s390@vger.kernel.org, Yann Collet <yann.collet.73@gmail.com>, 
	Nick Terrell <terrelln@meta.com>, Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, Eric Biggers <ebiggers@kernel.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Laight <david.laight.linux@gmail.com>, 
	Sungguk <sungguk.na@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 03/15] zram: lz4hc: reset the dictionary stream once,
 not per page
Message-ID: <avKrj0h8fBNSrfCi@google.com>
References: <20261106-lz4-vendor-upstream-v2-0-ee04c3f0d7dc@samsung.com>
 <CGME20261106144252eucas1p272c9e37d66ad385db070f941879aecb1@eucas1p2.samsung.com>
 <20261106-lz4-vendor-upstream-v2-3-ee04c3f0d7dc@samsung.com>
 <sashiko-outbox-201613@kernel.org>
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
In-Reply-To: <sashiko-outbox-201613@kernel.org>

On (26/11/06 14:49), sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found no new issues
> in this patch, but noticed 1 related pre-existing issue it does not
> introduce:
> - [Medium] zram: high-order memory allocation using kzalloc in
>   lz4hc_create() [1]
> --
> 
> commit 2f51683dc7418bdcd0730283cb7003d8754fcd5f
> Author: Michal Wilczynski <m.wilczynski@samsung.com>
> 
> zram: lz4hc: reset the dictionary stream once, not per page
> 
> This commit moves the LZ4_resetStreamHC() call for dictionary-backed
> streams from lz4hc_compress() to lz4hc_create() so that the stream state is
> only reset once at creation time rather than on every compressed page.
> 
> > diff --git a/drivers/block/zram/backend_lz4hc.c b/drivers/block/zram/backend_lz4hc.c
> > index d8aa01bb258fe..06286c805cf7c 100644
> > --- a/drivers/block/zram/backend_lz4hc.c
> > +++ b/drivers/block/zram/backend_lz4hc.c
> > @@ -72,6 +72,7 @@ static int lz4hc_create(struct zcomp_params *params, struct zcomp_ctx *ctx)
> >  		zctx->cstrm = kzalloc_obj(*zctx->cstrm);
> >  		if (!zctx->cstrm)
> >  			goto error;
> > +		LZ4_resetStreamHC(zctx->cstrm, params->level);
> >  	}
> 
> [Severity: Medium]
> This problem wasn't introduced by this patch, but should zctx->cstrm be
> allocated with vmalloc() or kvzalloc() instead of kzalloc_obj() [1]?

That's how I have it in my local tree - vmalloc(LZ4HC_MEM_COMPRESS).
Michal, I suppose you don't base the series on top of linux-next or
Andrew's tree?

We reset the stream when we setup params, so I don't think we need
to do anything in lz4hc_create().
