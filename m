Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEC834C141
	for <linux-s390@vger.kernel.org>; Mon, 28 Sep 2026 04:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790568755; cv=none; b=ThhxHcOkrhR+BUwFvp43QP/grDZz3RiAzZ09ph5RodZFGAMnUJMPUc3ei+YuD+YIXNJRETq09GmOtGwOeJgFu25XYn6Xj+V0TICY3+7FHwNIYu1h3gGcJw8edXM4LJU2R9OPmsAyFqlbi9kPNCOgBjMuYA91tvFTWd7DI4Xng8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790568755; c=relaxed/simple;
	bh=/sOtv+Jy0VfC/zdAlOtrQTC1fDfCRtKdJKUcnFIpFsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q+Vnfym3aMztj/Kq6KRPLIzS6dH9ZiRNuXU8tbep9PC8izyH4UamFd3h1cr45Rky33WAmPnsbIMoAjbqUU4zEYWO72qw3j3FoCzaUtHMBeGGGwc3ZqhhReIGwpKNUK3Ns4mgrBP5vG9sNAbjVhYhhZcnItfMw0IrF6cDYQqnyfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KEIR3m9W; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KEIR3m9W"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2db1ca06a25so10898155ad.2
        for <linux-s390@vger.kernel.org>; Sun, 27 Sep 2026 21:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790568753; x=1791173553; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bXDScwdKbt28kFhjEDV73RhbSo3l7UPBxj8GidcV6Ck=;
        b=KEIR3m9WIJGGxbDxu5WT7d1D8pdjysg2u6EOJPP2gwFE4OJjvQnJ287pxIflD0w4Cg
         3KRo1HxvqGoz0UssGc+2rSuTUyOtycuRzbtmoCDu1UD7mwkHfhAOWZum2XbziBA9oVWv
         jJBljzLhKQzGV32PJczj1FgBrq2QfJL1amKgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790568753; x=1791173553;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bXDScwdKbt28kFhjEDV73RhbSo3l7UPBxj8GidcV6Ck=;
        b=cFfYaSmkRn79AB9mEa3ert6lfADO5teW5qZPsNYW1KN8cDv47cWALwOVxip3S7PYKU
         EoooIlCnvugMtpFb/v4aQdK10BRYwNAzjjKPWt7GX3gqb/mWyfbBHqvdw2TC9kBzJPzl
         b5EqHZ1zHHCIxhCO+1HCvt7K/g4htY9/dnv+7zs5Pqhit7k21rZaBjTDvGmbiR9yf1Ue
         YFpJqc8ME9xWqZOmBdYRVXtEGXfRXxvWAcha1Wu7HnS54xcg9HwKAhu9l3+knGrO5jsu
         iBAJ9IEvbmbZEMCHQfQ8dp566qyS69QppRoNhjMqRBZQQ15e/Wxo3tu8N3hXLitz5p1e
         GW2g==
X-Forwarded-Encrypted: i=1; AKwUvBz94VqxyzfFmFz6R9zOHhQ6lC2+FcFOfrMkSbbCBSkU8GH2n0rDkuIKL00MOGn6B5WCMe1PJN/09CZ5@vger.kernel.org
X-Gm-Message-State: AFq9FYIJ3TQKrrasfmfBMK+rFeWrJbWnw3JA9PoBSNRsTEiJgjhHJzIh
	zz7hlfl0+MUtD6vyEB5CKtUuTWnrKDCRsFL1hwvuTg8z/mRO7pI3gU7TNtV/pEhWkw==
X-Gm-Gg: AYBFou0QGZNjDCWawTrXr1ATu4o0A5WV3OY7FfWDNgr8jb4Sc8R08aVb/XX367aEEB5
	waCShNOuuUxI2+haZGvnmh4K3BJgr7BKpUaKDejy1oOK4cZfW2/LGtJccEl7+MgH/L1ExaFpEwk
	xTzR/qXCyQ5sB2IJjkK1FVn+give1fftDTyIxvQaoT288Fva2nwsz+qEPBrJEw8ytbJOFfk+322
	eVNUpjq6ib7CdLDv/fqXzGfRIaBm9zrG1lB1lOw7wTnRq9+/BYIN63mNrwAa9GFgsOlPPandh5z
	CBGFtE2960zXODXAJ3l3d1O/jOBB3cq2ni8z0NaQS3POaD7LvoP3ZiqpM+zm8inKz1laoZxLIPl
	WgfSE5EdghW5m61pleZMz+Bf4ZdG8GHgqX25b9zUgc5/rRNvyY+3HNnnlII7k0fMz5PToAWaCk2
	7V922JhV5k0eEnyMeXNMY5ztfX8OiAwi/EKv3wIHeBh680ur//FnEbsXUdewyehNI4RDfITKMfx
	wC/qMvZh7Hlc610dyuaveEgn8ubtX7Igl007xE=
X-Received: by 2002:a17:90b:1c82:b0:3a0:7d97:37c1 with SMTP id 98e67ed59e1d1-3a098aaba1dmr10891588a91.59.1790568752817;
        Sun, 27 Sep 2026 21:12:32 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:fdbe:318b:98fe:bd96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0bec30aaasm17381254a91.15.2026.09.27.21.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 21:12:32 -0700 (PDT)
Date: Mon, 28 Sep 2026 13:12:24 +0900
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
Message-ID: <arnosKlQYVIdmTR7@google.com>
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
> +#ifndef LZ4_FAST_DEC_LOOP
> +#  if defined __i386__ || defined _M_IX86 || defined __x86_64__ || defined _M_X64
> +#    define LZ4_FAST_DEC_LOOP 1
> +#  elif defined(__aarch64__) && defined(__APPLE__)
> +#    define LZ4_FAST_DEC_LOOP 1
> +#  elif defined(__aarch64__) && !defined(__clang__)
> +     /* On non-Apple aarch64, we disable this optimization for clang because
> +      * on certain mobile chipsets, performance is reduced with clang. For
> +      * more information refer to https://github.com/lz4/lz4/pull/707 */
> +#    define LZ4_FAST_DEC_LOOP 1
> +#  else
> +#    define LZ4_FAST_DEC_LOOP 0
> +#  endif
> +#endif

I just checked https://github.com/lz4/lz4/pull/707 and it seems that
LZ4_FAST_DEC_LOOP is enabled on aarch64 now, but we still disable it.
Am I missing something?
