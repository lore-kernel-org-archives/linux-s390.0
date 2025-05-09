Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515AE208AD
	for <linux-s390@vger.kernel.org>; Fri,  9 May 2025 01:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746754701; cv=none; b=GqsXxgsMtG1CDosJo1XXMltpzp+wJNSY/LCAoh9eawgCUB4vpvtCrbIKeSwAhSPK8wgToJMZPChDMWWHVovzxB1pHRIaPqxh0KJwvjk0cLtWUdHg9Ec4DI5XJSGPn1gm4n22oNASim4kcGNZv+8MdrRGL1STK139tRyOQs1FPcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746754701; c=relaxed/simple;
	bh=9usjLUr32ZxLro9cjrGBZHFD0yVa51/PNmixGpgHEkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nfFJlw2ftjVchJtLvP+ciWQJ3WVuEMCoEV4GT7FbJpVdzhhlS7sBLO4+YniuCqlZhbgt9E4ELf15yeCU95DtSn30m2IMsJ/rpeTby+gw/c8cFXZZTvzOKZb363eO+9CDu7Y0jbmC2eCIUtc7/+zHI1ybrI6LPQaNnh1dZ1V0CUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eHnPL9TG; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eHnPL9TG"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22fa414c565so10456675ad.2
        for <linux-s390@vger.kernel.org>; Thu, 08 May 2025 18:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1746754699; x=1747359499; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q1ZcdHivvNbREwW8KHlFJoP7qz78WcmPAGgzmVjdBy8=;
        b=eHnPL9TGAMg15ELV4jb5dXzRzcXss9/mruTqWrjhRidqeglrWLqDqksFkHCSlns/Z/
         czWhqM5Ll0UMrKmQj5TO6Hnby7lcukAnvOS9ppl2kLnICsinNJPc+Azvqvmn7y8DKUVu
         i4URvOYBSH6ILqyMiZbMEvWMmRnkMHbsxyyZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746754699; x=1747359499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q1ZcdHivvNbREwW8KHlFJoP7qz78WcmPAGgzmVjdBy8=;
        b=o+kKNFRQr0xzritvgRZvBg6xlcSQRoXQj+veaWBl32gfccMes/ZPRvsyGTN87ksphM
         Kyk7g2UNGKoSRVhCauE2ZmWYGXcIlLfwZNYX4sLLDpko4itY7G2+1lO0ydZkuy6Mh5XV
         olMf+aY+Ap+PJRysK1m3Od9OsZXGRH3PQsLSUGwmWd3iu7oAMOHLLCvVpNHchfdhcC9z
         MLwNQnJ8ZA00Qt5jwlrFbg1y9KuBfV5FAJ3zwv1u95biCwi8S6OFtJR4AUCQIdWhbqBB
         yxMCkukNPnLAyxxAe7nY0vqIhOAfjeT5B/7QBnhJ8BzO4Ip5064ilYG1R2M5AQnKDWhu
         zF8g==
X-Forwarded-Encrypted: i=1; AJvYcCUZ5Jxb2kELrEKTNbNF1f5YzYwzYjmZAdiessw/SbtSQLPE1pbrw1l6UA4TTDj8YJ6I6RySe3AQSemc@vger.kernel.org
X-Gm-Message-State: AOJu0YzCvBSERYkq2/cthEgMyv8ZdnQba7Q9U+zgWoNUcrNE0SRSgam4
	Q1QNWK510N6wNXFdG6Dp/UspXhK/XHaFj7g3X43JV8z75Jea9UtB1lFM7DuYow==
X-Gm-Gg: ASbGncu76NwVS/iClc+XzHNdNkuwuMNxHK4YyF5Z+STFBWjKA72Rf4viVMtfQUlR3Nw
	uThWXQKQx6SDk/hknHL03fUxGPJ8FjaXXbwMNlddlWAWfu57uvsDutK1JGGk8X7VC7h2JRzJt4Y
	WTLjrMy0fuMNrp0VO4L/2Xw5okyPdquChn6Yj5xYDcHXy0Vgz9BACUNiqrGwy1CcvU5pY5wTBAo
	DZOwNfCulOwpvkVCsFZUEbH7+Z2CCm8DoDw5itXz0QLvHWM0Hpu+0+6V9zMscvm05oGpSa7V3m0
	0g2mPpTzWAEBADSC1OgI3qU3Lo3SIFWXgcFPRHlmVTd3
X-Google-Smtp-Source: AGHT+IFi530B2sRlz6o2F/z+hAqK2/FbwxnukCcHQ1nZH/APjuWe/i1i5zKAQV7eV8o/m5e/WA5XFQ==
X-Received: by 2002:a17:903:2349:b0:224:10a2:cae7 with SMTP id d9443c01a7336-22fc8e95bf0mr23837955ad.40.1746754699453;
        Thu, 08 May 2025 18:38:19 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:c794:38be:3be8:4c26])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc7743b8esm6432555ad.101.2025.05.08.18.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 18:38:18 -0700 (PDT)
Date: Fri, 9 May 2025 10:38:14 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Zaslonko Mikhail <zaslonko@linux.ibm.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Ilya Leoshkevich <iii@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCHv7 10/24] zram: add zlib compression backend support
Message-ID: <gekqwhcpombpm2u3b4xl7zladuyzbxybeq5wcwt47k7tsgo4bh@rfrxaeqwzypi>
References: <20240902105656.1383858-1-senozhatsky@chromium.org>
 <20240902105656.1383858-11-senozhatsky@chromium.org>
 <6046d139-2a46-4824-bdfc-687750c1ee5b@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6046d139-2a46-4824-bdfc-687750c1ee5b@linux.ibm.com>

Hello,

On (25/05/08 16:19), Zaslonko Mikhail wrote:
[..]
> > +#include "backend_deflate.h"
> > +
> > +/* Use the same value as crypto API */
> > +#define DEFLATE_DEF_WINBITS		11
> > +#define DEFLATE_DEF_MEMLEVEL		MAX_MEM_LEVEL
> > +
[..]
> The comment line says 'Use the same value as crypto API'...
> could you please clarify here? Are there some memory constraints?

When zram transitioned from Crypto API (scomp) to custom compression
API I picked the CryptoAPI deflate DEFLATE_DEF_WINBITS value:

crypto/deflate.c: DEFLATE_DEF_WINBITS	11

which is then passed to zlib_deflateInit2() and zlib_inflateInit2().

> I tried to build the kernel with DEFLATE_DEF_WINBITS set to 15 and
> verified that s390 hardware deflate acceleration works for zram devices
> with a deflate compression.

If we define it as 15 on non-s390 machines, will there be any
consequences?  Increased memory usage?  By how much?
