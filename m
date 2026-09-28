Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E81F47A87B
	for <linux-s390@vger.kernel.org>; Mon, 28 Sep 2026 08:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790584055; cv=none; b=Ale7DXZRi/NzSuVSl6Jt735fPPP4OCvoCm9q37aj1EFx7OFtzkRAsbUX7iDT3UMuqs4jzE5pm0dudlyZCJ2z3rSXbP7bm4CMs4S3owe7ZVZBhcjX/cf6NqoTM2VfzTZ6pMEJVzBuJ/1f2wTCyTqxY+ySglF8WG7VHz0OO2fHfSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790584055; c=relaxed/simple;
	bh=qAKPddpqFgfHmTQw4mD4LolSxZQhiX47J3WLDmhJNXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uxQprENDGhRw3xk1KOQpNe/ujPfJ+VsDZw0VgI6dqagRk0yMMYOU7y6qLVwcMsTOLJmI5Cv3cvkhyqzx+ZX8jW60u335sD5utoWEiJ9cp2sniCOVYeOhrilY9XsL3b/slMQZK4ufpzUu1kwPbZMpC7MxHkcp3Qi4MLjIY1uq2Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JcRCzfEr; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JcRCzfEr"
Received: by mail-pz2-f40.google.com with SMTP id d2e1a72fcca58-8805988a200so1643168b3a.3
        for <linux-s390@vger.kernel.org>; Mon, 28 Sep 2026 01:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790584054; x=1791188854; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XfTNwTEf8cXEoiVJjaR2wzaM0AVgLL//fGyHvTOkwQs=;
        b=JcRCzfErgVnrnW3HUokCKg8lXPciOB/jfvRnEGSanZoKcgsWxqzHlMClhV2Wxj+iTh
         HORA8F97dmAVIQab4y+hYMEzf3FON3sym2qgjsojRYDxoOvSTva65KhFI2COTJSK724P
         Rh7bJki16pz0KEQ2GN8crKod8DZ7ieZ34XeDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790584054; x=1791188854;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XfTNwTEf8cXEoiVJjaR2wzaM0AVgLL//fGyHvTOkwQs=;
        b=lJuy6H35b39PuwMTWa3VT4JlIUGSn9bZbr0nXNC6OnIe5EJndzHEK/tB3Y7y4C7Uz5
         dYXJOijIhhNCUPvC6JaSsGSVpB11uGReV7IVOhcOYdEfn7Jaei3YpGgMhR5yjYhkkLR8
         vg09rDtbbEWnbkh+WB8oT+IJhXhlyEnOHVDIMZFCd7HPPhnwXAHOmNy7qj6V8PNVw7qT
         bb7YIlZitsAe8hN+hVmS6sg6mreo/4/D9h1pRFV4OHvOTX3eZi6D9L6vm/U/DOLpFvn8
         iQ6JWPlK9FvuD9+Mu9g3E1EbKTvgmDOvcpTceO1o3rPk8IBUh+XGsqa14WeGQwgAwuLb
         zUuA==
X-Forwarded-Encrypted: i=1; AKwUvBzM8ezEPYz24SLRVse0jWOn8NqNSa97fDjRoRY7g3vsGWsQ3hcvVe5bX6BNrO87n1j281CiFxLMwUoi@vger.kernel.org
X-Gm-Message-State: AFuF++lnaiLKpKxsDs+jCMiQaJQRXDdgdjG4L8OTmcTgXD0E8d0rfLin
	PQSKdpop0gzqbkxuo10j9M87GaLYG+OCgjL8CBH+45c905b2GBBQ5jB6cTP+ylwQ/w==
X-Gm-Gg: AYBFou3ylb1zaCJMGHpA4X/LdwMnM14vMkRQR+oFzjYxhGZ1yQQzhOqG7KK0zBNhYbO
	t4L6yE2YHydhMbBHkpxDWylnwvDdXJ1bSp5m1WjWr481soda9umLvIr8eyz9RvTcWH60Pex6ODG
	C9SPDWAAHug8XHd2ZIIur88ITsHLb+IiLnT6J0MeQZDtgNYnlmHHytcz2s44VTZBW4ST+tbX1XN
	4BCfdZvCKzZ6aC/PNN1AInr9do3YMkJjSZkJvDLsro/QFDLRKiGccpafU6MDZ+sq/40vaY8fphP
	EgnrFUgT9g/K/kgeISR9v0hio6h5NGoP13VxpGC8gLuIuqc9uwnjOuBBavVG9tLcRUM853AnY+y
	dIVFKOJqjNyOR8dt/UJDfqxtvZnfANN/78biIq16uGzTzhy4HCdppU60aIrergm9XwbPeIw5EF1
	NyGSk6eDTRoWIPq6pdoFPFhR07osheLcbtcFOXSpYcbAtaVLmOwDNVd0z/PQ82xy7u/BG20KwlV
	8Jd091Xol8jl+8NjxBYE5Bqa3R2cpWBrq89i44=
X-Received: by 2002:a05:6a00:7619:b0:880:8fe8:a3ea with SMTP id d2e1a72fcca58-8808fe8a798mr3659738b3a.45.1790584053122;
        Mon, 28 Sep 2026 01:27:33 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:fdbe:318b:98fe:bd96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87feae8d827sm3676965b3a.36.2026.09.28.01.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 01:27:32 -0700 (PDT)
Date: Mon, 28 Sep 2026 17:27:23 +0900
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
	Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-block@vger.kernel.org, 
	Yann Collet <yann.collet.73@gmail.com>, Nick Terrell <terrelln@meta.com>, Gao Xiang <xiang@kernel.org>, 
	Chao Yu <chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Phillip Lougher <phillip@squashfs.org.uk>, 
	Sungguk <sungguk.na@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, linux-erofs@lists.ozlabs.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-crypto@vger.kernel.org, 
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH RFC 0/9] lib/lz4: stop forking upstream LZ4, vendor it
 instead
Message-ID: <arokqo4gVQVglkBa@google.com>
References: <CGME20260925113450eucas1p2fcf838f00f35e1bce0ca04a694cd0cd2@eucas1p2.samsung.com>
 <20260925-lz4-vendor-upstream-v1-0-1c7ffbe21c4b@samsung.com>
 <arnr-Su0uJdK_rOb@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arnr-Su0uJdK_rOb@google.com>

On (26/09/28 13:25), Sergey Senozhatsky wrote:
> On my x86_64 build .text size change seems to be quite significant:
> 
>  ./scripts/bloat-o-meter lib/lz4/lz4_compress-old.ko lib/lz4/lz4_compress.ko
> add/remove: 0/2 grow/shrink: 5/1 up/down: 8022/-1755 (6267)
> Function                                     old     new   delta
> LZ4_compress_fast_continue                  6028   10486   +4458
> LZ4_compress_destSize                        158    3112   +2954
> LZ4_compress_fast_extState                  4078    4597    +519
> LZ4_saveDict                                  82     153     +71
> __UNIQUE_ID_modinfo_466                       52      72     +20
> __pfx_LZ4_compress_destSize_generic           16       -     -16
> LZ4_loadDict                                 261     204     -57
> LZ4_compress_destSize_generic               1682       -   -1682
> Total: Before=14756, After=21023, chg +42.47%

D'oh you actually point that out in the commit message, sorry for the noise.
