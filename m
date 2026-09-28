Received: from mail-pz2-f38.google.com (mail-pz2-f38.google.com [74.125.228.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0D237CD39
	for <linux-s390@vger.kernel.org>; Mon, 28 Sep 2026 05:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790572754; cv=none; b=J5MjdFaz+UJyMMYoas8KZbRTw3yq049SUd9xmE4C021AZcFPpRDzk2vw3j5feHrKo/+YCg1Mzg76HVdPMFmcSVIc7gyBV+r4uY91MxZlk/A4Sv+dy3WPWkxk7MPWvU3hWPwCcJCfKFK6r3I1J1WqpPjWExXJKoQ3IF+3LWLTaQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790572754; c=relaxed/simple;
	bh=If6eyZW189bAWCED7HJ77WUzjEmoh3HbC+AtCUG98As=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qoILKC9jqOqd4QWY4nJSLQcyCr2M/DBB2ViChyyTA+ePZM7qMKV1y/y+G4tzJFNaG+FWON1YSnQEa/5yVRrMOYvd80/3KDSqf5w9fYcSRJ+mQhglARZd8HjqhfFutLCdjxlkEfohYUTcnLTY0zjd4/1nLRiKbdbzsmflmRjfJXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VLsnHB05; arc=none smtp.client-ip=74.125.228.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VLsnHB05"
Received: by mail-pz2-f38.google.com with SMTP id 41be03b00d2f7-cc79c0d2bbbso596385a12.1
        for <linux-s390@vger.kernel.org>; Sun, 27 Sep 2026 22:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790572751; x=1791177551; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aE4CNeMPjoyGqhac0qEjC0MrhT1ea2sjSdxYtuXCv0E=;
        b=VLsnHB057PEqj83Cxn2yIfI+0MQoBNKmIded6dZ0nn1+ILxJUjWxutQUwC+y2sPiNA
         aI7sKbUXLH4zAqRUFKE7Jh67iQkWCvWPsKsZ4AQZlLlrBT68v5eADSnOMWla3s139WAC
         f50tjpI4WgqLGRh6nrmNJNv75RsAaiuO0tq8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790572751; x=1791177551;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aE4CNeMPjoyGqhac0qEjC0MrhT1ea2sjSdxYtuXCv0E=;
        b=fgjS9+TWJEPaValuGSB8NBymErRRLCTLrPV3jq4cgcWW0ra0e0v/WOIQAGXjsYXrua
         SSVpE8F/Kxl1a0lWROboc0dlH8q3QVeTt6l1JhR2EZhHlJqXJYcsWzAs0uAL50V0PbvT
         XOstrOW2Vmhda39vq9djmy4gtcqbjimJ92O0TlFLT4uXBGjc6vT1CoNvTnmbJBY8dqua
         s2pNBSg+8pZr1eoIkLJUh4C1P5NTuNGIBxBp6LTXaXMv2S3pKFHBVHbXGDC06iclX5Yb
         hYuYx6Y3ueVCg2eWhGheiTjrEvrMBDd1d9d5CdXJl0wx05TsSqIv0Zqkre+T+5gBtPB4
         54tQ==
X-Forwarded-Encrypted: i=1; AKwUvBy0emGeG7kVhl2DFptV4Bqj7g8nSREPzml2Fxk0wcj6AU4GZUxGctft4jSRx8RXhjFzo+/NTtCgzn2Q@vger.kernel.org
X-Gm-Message-State: AFq9FYIbVMClogR8AkBFVdvk7hrDpV0tCYWPp6u6jX4mCxeyKL1YWOCw
	mv3WC5Opy3IVKd3s+aSAzWWCexkbPTqiy1y/TaW7N4KiYCs7z8LU7g434uYf4sGB7A==
X-Gm-Gg: AYBFou2KPSahQ6m5K+BweLTsHxi7RH+H7o+TSn8kzWy28iY/PaQzXkgfkzZ/eyFh0TO
	k3GT5Ax+7UGWCjogcipazoyJhdkKOp12bxDACPAp0+g04vCIis0177YxPAVdHI8nkXYWi3VOu1O
	Em/Zc2jkHL6ksUsRPnELiOAwxa38jLA0YOxWMD00AjqSpQmQQ4F5TpB5GuVW4gX8ZgJEKqYksBb
	1LB7IL7OaxFSFw1uzN6eMUghfJK/hGOPCxAS0B74wJroL+9QJHijjzQOz5RxJkcBOUWHzK7w1Yb
	YC6cNtPZLhm8ryQcPSboUW935Op1Vli7VrvSh6/HazYSusIdF+clj4L/Hv5UzGmEy2XzGfGSKN0
	iy2i2t8dopzcxI1M/gkyY/DjHHfJc4Ls6fZtlU5fBYqka5tGzTs2ZrtEl+nt9rhoxBQkLKIb6QT
	V0pyx3d3Nlz/fLTrBr4NoYxga7SO0tNRTXrrFYRoUqKgzznf/sM6gZ/GokDJshXbgbvSbYaqZMQ
	PSMJAyNZ9fN9jd1OCbBoADIgizjLy+z0iNw1zg=
X-Received: by 2002:a17:90a:597:b0:3a0:a055:1759 with SMTP id 98e67ed59e1d1-3a0bb60e55amr5032133a91.40.1790572751469;
        Sun, 27 Sep 2026 22:19:11 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:fdbe:318b:98fe:bd96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b94936ddsm18408378a91.7.2026.09.27.22.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 22:19:10 -0700 (PDT)
Date: Mon, 28 Sep 2026 14:19:02 +0900
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
	Jaegeuk Kim <jaegeuk@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Phillip Lougher <phillip@squashfs.org.uk>, Sungguk <sungguk.na@samsung.com>, 
	Jaehoon Chung <jh80.chung@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	linux-erofs@lists.ozlabs.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-crypto@vger.kernel.org
Subject: Re: [PATCH RFC 1/9] lib/lz4: import upstream LZ4 sources verbatim
Message-ID: <arn3TC7BgjTXWmdG@google.com>
References: <20260925-lz4-vendor-upstream-v1-0-1c7ffbe21c4b@samsung.com>
 <CGME20260925113452eucas1p170bfdb34dfbf670a14a6f8f0c2f5094a@eucas1p1.samsung.com>
 <20260925-lz4-vendor-upstream-v1-1-1c7ffbe21c4b@samsung.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925-lz4-vendor-upstream-v1-1-1c7ffbe21c4b@samsung.com>

On (26/09/25 13:27), Michal Wilczynski wrote:
[..]
> +int LZ4_compress_fast_extState(void* state, const char* source, char* dest, int inputSize, int maxOutputSize, int acceleration)
> +{
> +    LZ4_stream_t_internal* const ctx = & LZ4_initStream(state, sizeof(LZ4_stream_t)) -> internal_donotuse;
> +    assert(ctx != NULL);

Probably in some other places as well:

LZ4_initStream() can return NULL, but the code immediately derefs
the pointer.  The assert() check seems to be misplaced, unless I'm
missing something.

I suppose those need to be decoupled.  First LZ4_initStream() call and
NULL check, then stream->internal_donotuse.
