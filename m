Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8BB35C680
	for <linux-s390@vger.kernel.org>; Mon, 28 Sep 2026 04:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790569565; cv=none; b=qW1xZTfXzCFnoNBdHKJ84WrFDcuGPpzrF22sMkmaxWuyigjs2csnnu8oopkCNx+PaQjqwk5eMkGQT0PkA5kG/5TFeXu2B3nLyqhM5Ooc6eFEG2qUAPE5+XDXn4txHBQzWNSObDQ+tz0uEMIDJNWiFjXI5ujNhiYEYKIep25MN6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790569565; c=relaxed/simple;
	bh=opiQtSW1lSKLQ7uVkYvsf1NhHRDdCKyKOTcUwYHrZf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwKAYygFH2004SCN+vR8eBe1yB/kvBwPAq2qz+Re9rlW9nOUxq4xjuNGhpTUZDiKJmBDeVgJswsaPsKDD5ECCoeULo3KNf7p1y9pGq2XTt0YN/g6kzPWJOnYXQqLY2vRXvH/lJdKhjvfFnObBFxmsG1itGzhxPBg9wrL8iDfmeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LKMgIHnr; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LKMgIHnr"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-398a147688bso1879693a91.1
        for <linux-s390@vger.kernel.org>; Sun, 27 Sep 2026 21:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790569563; x=1791174363; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FrMP4Ii/YMUEItMnNYi/9VayHYXB02wrW1zol6BNPjU=;
        b=LKMgIHnr5FzTPs2SdXG16+II6hjF95rjYl3jwx4dTV8mN8odn1Y7scYlAK0KhVAeBO
         GwvFnHHsIqIJoAOlnd/DxHnNLe8uw3hZeHASmHrtV/V4ESDWDtb1FPe+QkAsMWH/bU+F
         IKO+2sMGo/Sg7oKqcZzjtWiQm0c7aq3Wj/Ync=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790569563; x=1791174363;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FrMP4Ii/YMUEItMnNYi/9VayHYXB02wrW1zol6BNPjU=;
        b=2zYf2QSp4Wm9Csfv7sVs9qyZkzE37gLNZV3zjKxB6bIcPRJRqxeVjwU0UpCMbPRUQG
         6Hln9ncA2F+EU+9ZDPWfUeZkRJrITY9lpYQ7Ws8EozhlC1rl3PN22rQxcm5DVQltY3Wn
         utfo6teT0ghx17NTEyekjhlNpyQXCvkmbbzGq6BqWUcosPArcwGhgcfMVHYTtfqAPId/
         zkyTVCmHy4D0d6xIf7jb7xGTpzPVtTpaDOhCxpX1rBI6pjrsGFRoMFnR6RozC+G/CpC3
         1DRyxB7LMg9BRQdxboaoJRR90MQy9adtGegJxq7uIFyHe/QE9z7HGu4EW+ncW1BZadXh
         q7sw==
X-Forwarded-Encrypted: i=1; AKwUvBxYhURlMLLFE8JwPYQU2JL+fR4Wk45VO7bW5kAr9iOB248kniB25F+ZlsTD4+whEVJ6F57rYrHrUYNE@vger.kernel.org
X-Gm-Message-State: AFq9FYIqHbyarA+6Y9Kkt3J03FyJ5plpVXOfj5N8/jTX+VUJrGGmUk1W
	X8di6gNoIccEqnJbjwHyvkGn+tLP8/CvMF/NwtsGAzlF8qtpC0qNkBGWpiGAK3Auzg==
X-Gm-Gg: AYBFou0E/+NN69DXjPk8mx+lKxDpdBV8yhYcTipAp7TbFZdT4TSlo0xAH32D1Rrtbj+
	0QwmENvnud63TBxVXNN6DJOsVGpiNPhQGTwELbqq5Y/8+cqzb+XP7nWhEGBemMUGQbHEwgIiTLM
	xUYWTj0Qq/KbYdsYACfvwdwo3Z13VCFcl6qAiyIDm/YI2HFJZEFixrdsfLMpJ7Gn+oc/Plk85G0
	COzaF/bV67IpGxo5kwHE63jiZvfJSr9aLkvfTJzlWIQX1IzJibHICRoarxrklzEhWqdBchokj30
	NpOPf54GJykisdBWTgn8RfGVXxedvkkydyc17X8ton2vBMIpBPk01ZAXS3vcomPi8CQM8ODzrsp
	4gFiXakgDior4dHSSmlUhZXLXQ3gDVZAst47BzS1ob7CPOmynvIdMWIvCJzdBP7sCbk3WhTDs1U
	jF02iHlUjuIAfiWyfI2n97lr48LtGIg1k7cTZxI21SM5XVmsYIvZOQLj4v79DLRx9yUAsnloR2e
	hBFAHGOvD5CXK6taQ88Cpob8mbma0Fopfwblo4=
X-Received: by 2002:a17:90b:3b4b:b0:3a0:d2f3:fa80 with SMTP id 98e67ed59e1d1-3a0d2f40159mr5894433a91.6.1790569562955;
        Sun, 27 Sep 2026 21:26:02 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:fdbe:318b:98fe:bd96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b99917besm17891690a91.14.2026.09.27.21.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 21:26:02 -0700 (PDT)
Date: Mon, 28 Sep 2026 13:25:53 +0900
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
Subject: Re: [PATCH RFC 0/9] lib/lz4: stop forking upstream LZ4, vendor it
 instead
Message-ID: <arnr-Su0uJdK_rOb@google.com>
References: <CGME20260925113450eucas1p2fcf838f00f35e1bce0ca04a694cd0cd2@eucas1p2.samsung.com>
 <20260925-lz4-vendor-upstream-v1-0-1c7ffbe21c4b@samsung.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925-lz4-vendor-upstream-v1-0-1c7ffbe21c4b@samsung.com>

On (26/09/25 13:27), Michal Wilczynski wrote:
[..]
> Michal Wilczynski (9):
>       lib/lz4: import upstream LZ4 sources verbatim
>       lib/lz4: backport upstream's -Wmissing-prototypes fix
>       lib/lz4: add the build environment for the vendored sources
>       arch: boot: put the LZ4 freestanding headers on the decompressor path
>       lib/lz4: switch the compressor to the vendored sources
>       lib/lz4: switch the HC compressor to the vendored sources
>       lib/lz4: switch the decompressor to the vendored sources
>       lib/lz4: fold lz4_kernel_api.h into <linux/lz4.h>
>       MAINTAINERS: add an entry for the LZ4 compression library

On my x86_64 build .text size change seems to be quite significant:

 ./scripts/bloat-o-meter lib/lz4/lz4_compress-old.ko lib/lz4/lz4_compress.ko
add/remove: 0/2 grow/shrink: 5/1 up/down: 8022/-1755 (6267)
Function                                     old     new   delta
LZ4_compress_fast_continue                  6028   10486   +4458
LZ4_compress_destSize                        158    3112   +2954
LZ4_compress_fast_extState                  4078    4597    +519
LZ4_saveDict                                  82     153     +71
__UNIQUE_ID_modinfo_466                       52      72     +20
__pfx_LZ4_compress_destSize_generic           16       -     -16
LZ4_loadDict                                 261     204     -57
LZ4_compress_destSize_generic               1682       -   -1682
Total: Before=14756, After=21023, chg +42.47%
