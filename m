Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D803B2D0B
	for <linux-s390@vger.kernel.org>; Mon, 28 Sep 2026 05:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790574511; cv=none; b=Yge2XqsWjCCIPJCGhuEAqt8/xNoM8VjvHZ+vzr3dyRmlL/7nYxfF4xzXFYiOt2sA6JVnE6slEAtFJAB62s+P9kbCrTfXCiI1SPJsnCJIaVUlD8li1aTmFxBYw2poMQWBZkxtRg2ARvQUeInEvg+aEARYyM+s/j9HKeEi5aMMjew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790574511; c=relaxed/simple;
	bh=iMYszCd2Q2GkfRGunaTTlbLJABOPePOXot6uhYku9yA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lFo/a9k1Frn9Zxi2TdmCUkKBFbRYCm4PNwCCVU/xOEN9oy0yHCASbc8uWS/orUM/NP9fvdNkTOnuwYcrdMGLjOFaMzCE4XJUHfxJUMsBXNwF00X0i9uJdqeZ0LBYnf0L9SB2QD+AflMTeZ98myiyeJ7pP/rOSdlaYCUN0SJYSQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bxSu473o; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bxSu473o"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccd5cf02so1329180a91.3
        for <linux-s390@vger.kernel.org>; Sun, 27 Sep 2026 22:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790574505; x=1791179305; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kWV/wHWLQfhp6L6mSocYwp2pbMQ9zmUarPxSrrFDYg8=;
        b=bxSu473ocLXfE6sENO6UDQCfPbZYu9DTkKv7SzG0U2ent1wE55DvXVZrKbPwgxoTSi
         HFx73BSqIiVKSUS7gxUnPTz/Kkc68NvdKaga6clGtTJ/PFcrNDAoFOz9HrToRPEuY7JB
         w5SzVZBiHKy3ICHS569p+1/EZqyvkGv23nnzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790574505; x=1791179305;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kWV/wHWLQfhp6L6mSocYwp2pbMQ9zmUarPxSrrFDYg8=;
        b=sdJpq+I7CKfBehElM1kaYbvlJV4h7ZB7c6CxXo/UwXXRkbfS4ccDrTmgchnTZEAnZY
         fOJplKy1ZWndLfHjiiYDUlf/ipZPqQxy4u55MT2pSdEaIYR+1aVII5/36WqmY3trvSz1
         M2cZ9PbZx24osdlIBraADXYji0qIcwYzzLpoHGB+IUIzoZFMG29kmfB3+o4SEqJKXVTo
         DWPLdzTmxvRvx5WTsJxJtyzxG2tQHoZBGuF2khaEVpHOvd6Z5olKhWp7nPq/KVEq8ykl
         USejhlMjBSWY0RS+wespO1PLiPiv4iDVOlFJYXpXd3FlLitQJb/ivztwf4yFaM78Davb
         5nBw==
X-Forwarded-Encrypted: i=1; AKwUvBy8EqFvbU+QJBNNJhfWNHXPt8s6bRRoaC67zTyvEi1cdMu6xrXYziYJEXFVM7bHaaVrnfzM7PO8MiOO@vger.kernel.org
X-Gm-Message-State: AFq9FYILwCsGtAYWxEzyv0qiI3JpmeMz2WEeHzpIImqwYbJ189aLdZSy
	JOwGCc5ay24T+xzl0nX0cF6iAvn/oxheaurBLbT3HXGYrlRQ0v2lEaauFDNCOJ/EPQ==
X-Gm-Gg: AYBFou05F7zIFg0Qubs6j/brefy+12JpXBX8bikvgdpN8z6A5otHnad0f0gmxNRrR7Y
	Xias5yjeGVBGOeQeXpcQ2qJUEWinvJaRaRIfSOhlMqEexc1pSH7HXVVG+hjVDHN3cadGjR7UU0g
	WoU0bLBI82uOIwbhi6iHOSr/izXWIUIa9sv+Lq5nNug40XP2kh9Fpbu2A14VO4eCKFRynxSqak9
	/7DifetPH82C2f+7Pi8vCjOVPlWlYt5EMLh9vOIwadzt2AqbftkCbdAjwTCPVNIh7Pz4L91lyfP
	AGBXitoHbag8XwEhe9RVbHJAJnHGcuvWVtQMcIaW0QuaKCzB1D8mLXx+OYgVO8OfZEe9KjQDswk
	euBQ1Q/HTlHbYxQX3VCMjLD9DTe1bD5DVWb447Lbzr/UMIKHmmULCOnG3N7rcsGqyS7eKpyJ5r+
	t1HoBJ8JvDAeBBcazNncRH+hur2AEOPOqYCi30P5oDzX4opMjuh+4pKYBYv4849w5pjSJJ6xLfl
	bv29Ckf3OUWJAr1a/CLu502ZQ8DZo9o58yCvjEWQUY3na8ePQ==
X-Received: by 2002:a17:90b:3888:b0:3a0:cc33:2287 with SMTP id 98e67ed59e1d1-3a0cc3324ccmr6256726a91.6.1790574505299;
        Sun, 27 Sep 2026 22:48:25 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:fdbe:318b:98fe:bd96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0bec30aaasm17853889a91.15.2026.09.27.22.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 22:48:24 -0700 (PDT)
Date: Mon, 28 Sep 2026 14:48:15 +0900
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
Subject: Re: [PATCH RFC 3/9] lib/lz4: add the build environment for the
 vendored sources
Message-ID: <arn9tK5MxxxfH7OW@google.com>
References: <20260925-lz4-vendor-upstream-v1-0-1c7ffbe21c4b@samsung.com>
 <CGME20260925113456eucas1p136c3cd1f08be7201ad6b3f7b0e8ff02d@eucas1p1.samsung.com>
 <20260925-lz4-vendor-upstream-v1-3-1c7ffbe21c4b@samsung.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925-lz4-vendor-upstream-v1-3-1c7ffbe21c4b@samsung.com>

On (26/09/25 13:27), Michal Wilczynski wrote:
[..]
> +
> +/* LZ4_decompress_fast() and LZ4_resetStream() are still kernel API. */
> +#define LZ4_DISABLE_DEPRECATE_WARNINGS 1

Is this upstream code?  As far as I understand it, LZ4_decompress_fast*()
deprecated upstream and are strongly discouraged.  Do we want to suppress
deprecation warnings?
