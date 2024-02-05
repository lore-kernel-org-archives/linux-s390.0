Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7313FB14
	for <linux-s390@vger.kernel.org>; Mon,  5 Feb 2024 17:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707152429; cv=none; b=FUPeFVpm+KAGBR9C7pSmmgvaAb/v3Z9g5SjP2R9z/CpKs+94xXdutj+HLtXf0I4UrXcYMpoeRdOjo1M5u6iXrxpfyCAAkrLSZXkIYZ4XO3Nb3d/FxtjfDdvh9nqssSQzmNvHdl5vEfJkmYaCsil+fhI+aEtDos0ythdn8Got+WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707152429; c=relaxed/simple;
	bh=zEM6y9s8BbR8XRJHbaoi3sMf03qVbeWQkkl11uaApJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JslEihY94mFk7gd47kQ2B8rhKqcan54wypBW4cksiuMSuwQrZofJtg7kQ9wXdw+zb5Rn5td1KRWYB+wiNrBuUhbCW+u0iaD5VbBxYoO6G5Ka6DnsUx+JXO/7elFI+rH4WXif1Vd2Ast/706FKPts+GBkTujVo2rdXBOzpjtOiNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=b6RfWoT+; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b6RfWoT+"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d7431e702dso38531055ad.1
        for <linux-s390@vger.kernel.org>; Mon, 05 Feb 2024 09:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707152427; x=1707757227; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e9qumCkS9Vaow3wOaVfmAi8pFVbLHaYf52+hCKrgfXU=;
        b=b6RfWoT+VGTxTpYeFKoI+ikzRXjy8vsT6IXLxwd3yrAlu+D3Ip0PfGQA10c0Nd0grB
         MgFbyxR6bk+9j/E6IexEiiojJlQAnzcc0PPQzrc+MQJRQQQQujiN7kefOLC+WwUXXo8u
         GeNU2sid+b/6JH7G2nvaAQFEfsRhVw4HYf3L8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707152427; x=1707757227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e9qumCkS9Vaow3wOaVfmAi8pFVbLHaYf52+hCKrgfXU=;
        b=ZnDXtZNLSYpD0ngd8G8vAiu45Kdk5Xld9dIsH2/e4Vxy/s74XNv2cYK/lCwEAI4ivT
         6RVKFwMFVcXYZeYb7F0WeIv1uJrlFiwU21H+W6Cv5mPpz04WKGkg06R/J20KrFQC3NkN
         3WIVZ8Z/HmlsBt95ZwGHaMyNk1CTCz7nJxCVakHW2H2JPMdcYsdIL1OYGOnhKIRgBipM
         9AEsARvibkd3iETGgFoqK6V06BoCSLsYJu2NmdYoI2bcusQMgu1kGdP70TssGqrxs2HC
         OXraME/DZRcKgKZIFz545+TuZ8Th7cBjby3g18P9LRthe8fcWPUK6rptoYUdCW5UPLMk
         71ZQ==
X-Gm-Message-State: AOJu0Yz7GCwgVUx3iAyeTfOpbyvMU7QNmBb3xVxHBGaDJiBa9SWCuqou
	Yabo4IV2L/ewkHN5kJ3xbDAwiHPtuZSRIPp6Y4JO9CUB+/BH0H6tv2N6QFWtVQ==
X-Google-Smtp-Source: AGHT+IHXdXLGaYmwWvHSY9QLcuifaoHNt6WTe5J7FWe8+V0QiD18C3DPDMauneliSS345/5z2UsoYQ==
X-Received: by 2002:a17:902:6b03:b0:1d9:a5ec:30c6 with SMTP id o3-20020a1709026b0300b001d9a5ec30c6mr64131plk.44.1707152427589;
        Mon, 05 Feb 2024 09:00:27 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV4YQfd/TEYPIfgORFmrVlwaxg/O0hDOQS0YpCS2Cwp1/m4ECv2aqR8i1YvbqcOguq/hJhy+vuKKu8hHpiIM7ctaoArhymvml8UqgpcaFP+cKw7aGWMVhbCsWKVHf4nN+gHgAb4Xibx6DfcxhTiE8lCG0EJp6Q+2rtmRHW+3RnzGlTA3rOcX3Rp1jle5wo0i84grYjKQ0LbYGm7keAdygwJgj2zf16yJ7tW+0Rp
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l14-20020a170902f68e00b001d9aa663282sm78347plg.266.2024.02.05.09.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 09:00:27 -0800 (PST)
Date: Mon, 5 Feb 2024 09:00:25 -0800
From: Kees Cook <keescook@chromium.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH 2/2] s390/fpu: make use of __uninitialized macro
Message-ID: <202402050858.55421826E@keescook>
References: <20240205154844.3757121-1-hca@linux.ibm.com>
 <20240205154844.3757121-3-hca@linux.ibm.com>
 <202402050822.E6E6E978@keescook>
 <20240205163529.8558-A-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205163529.8558-A-hca@linux.ibm.com>

On Mon, Feb 05, 2024 at 05:35:29PM +0100, Heiko Carstens wrote:
> On Mon, Feb 05, 2024 at 08:26:32AM -0800, Kees Cook wrote:
> > > +#define DECLARE_KERNEL_FPU_ONSTACK(name)	\
> > > +	struct kernel_fpu name __uninitialized
> > 
> > Are there cases when struct kernel_fpu should be initialized? e.g.
> > should the attribute just be added to the struct definition instead of
> > marking each use?
> 
> I tried that, but failed:
> 
> ./arch/s390/include/asm/fpu/types.h:36:3: warning: '__uninitialized__' attribute only applies to local variables [-Wignored-attributes]
>    36 | } __uninitialized;
>       |   ^

Oh. That's extremely disappointing. I think we may want to consider
opening bug reports with GCC and Clang for this. Not that it'll help us
now, since it needs to actually work today. Bummer!

In that case:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
