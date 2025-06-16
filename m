Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4352BEFE1
	for <linux-s390@vger.kernel.org>; Mon, 16 Jun 2025 13:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750080984; cv=none; b=RSSFJ6hvIwLKQT91DMprGaQD3bHJlNZxTCN1NFPLxiRvhkvF8pDDnIsPyBdsbuvseVAseTL7blN7PDbVnibcL/Q3O81bm3Vp81vvTlSMdSFQnXGxx063J8FCF5ycVzmpyDwOhgBQ1sl142p7ySDSbHwRIQ52hDyhlXg2sKBMZrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750080984; c=relaxed/simple;
	bh=/+idoE/lxLeCl2JtJe6gPh2aQ6s2yMmO2sp39/Hq4LQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X6KHiwTEL+evxr4ZZUNILAaJTz0dKKWmbIv2RSH/XEFlGF730RvlurINdep4t20Y3TaEiOOuBfklHvkQ6RtQ7ZppCc2cphPnj4Dm8O3yBKvcvzcQduWOT0pbe6/wpQZSgrW9U9Ss3SAUcWT8KA9QsKsilAoDRph36U5YICxwMa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iVILKn9A; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iVILKn9A"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-87ec5e1cd4aso1242084241.0
        for <linux-s390@vger.kernel.org>; Mon, 16 Jun 2025 06:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750080981; x=1750685781; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VAKYpzBXefjsewghnaRDPZDlVtldMHNII6S2fBTACcE=;
        b=iVILKn9AQ/dZUNFI063dd/soQHSha96vssLcOTd1XDwqmtholXpWXIY9bj97tfzNEk
         Q88niN1qwuRaZHvsj5jfPrwERihMQweZjXrHD+qXjKk8i/26fysDWpQxWqgsM79MBsZa
         RYf0unc03ksZXHHkKmxx8FBEQn1pyIRrMoVphFn+aQ/9OtImChKtV+A099zyrvDv6842
         Kv7uaoY94w1ihVh0UL+LVcUQ0MK9/hJ3QzN3p/8kt43NQ4VID2yzAbLO7e7tk2wJpi2u
         N2vukvFT/YFUTy4XmjYxlHLhW6Zi8HM432v2ymaNC44wyS1kxYBK9ekxStlNd+kVqZQQ
         DEpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750080981; x=1750685781;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VAKYpzBXefjsewghnaRDPZDlVtldMHNII6S2fBTACcE=;
        b=S4uNRl+U7HtQKWyF0mWrPJnjTAaQqPVlwEeG0foLhAinu5j9X55R2mZhoPwQATY33S
         u6L0buBwXvFPL100/kPD32ZoUuVraFKU5be40jqzPxCFJkLuBLJDsliqm/YmgDQfqfiy
         iM2+fpJVafniuyPNm5fx2q+xT14Csw+olV4L6ww8ojkERptWy6vd5g97H5Eh33/aJ/Dz
         YXobetT6SfKA0Lp/HbE4dE0TFb4ntqxOQB2T2tx4JWSrezWnVHGOw774eWzAKW4iHvnK
         0q2a/erNRht5BqGd4Olc5uyVnr1M3todtxWoIVSzxNx8QvT2iK1h+PjaSqe5EoQZh7V9
         WTRg==
X-Forwarded-Encrypted: i=1; AJvYcCXfG8cJqio5eXQjyu9ESjOk1/+whbLsQvI95b301PMugT4L+VSEYO/OvtA7S8qS4/EBsBqc7KgWISLM@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9sozVd7ZLe5xyqH0aAgGej5Mf1chu8qP3U/PZYNFbABDr3HBX
	vqtk+VmDaFK5X8BjZBwGHVjml0VHGmkMFIjIZYYr1O/Jv1kss1/VdAJRnc+xRVUPENLrhho7QCp
	9NqhfixZcqssrIWEIP/yejsNdnCR86rckTvZ/Rcq6zvQV1NPZvX/c9Bs6ig==
X-Gm-Gg: ASbGncshTLkPH2SEjKUvMySNoQnmZXkQu7VTvtCB5L+3oOQott3zxMVC1pTxw4ueXuJ
	+0PFPeW/7WLPFlTwZyVize7938eNIqYdm4vQGSq2FYaiymkSrWlQFsSyMBc+c4i5EbnWYHu3gdY
	0SgYzJMV6CqFQHEsc50lkYnE6iZL17YnWnjvsA5SBqukG06UDFqCJVBjHH6k2MPaj/5IxjqdtSD
	Ptv
X-Google-Smtp-Source: AGHT+IFjLddFL80fWZC8vtshfMJbUrfVgeQJ3XiDOZyHT7t6Zgm568hBaOqMVNU/MkIqnSqDCwMMu8ds8ugaE3rTBR8=
X-Received: by 2002:a05:6102:26c2:b0:4c5:1c2e:79f5 with SMTP id
 ada2fe7eead31-4e7f61c6ecfmr4938693137.16.1750080981324; Mon, 16 Jun 2025
 06:36:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYuDOnN6TrcVYcMZT5UPNc34mOHQZsfyFvpq+Ndhz8p48w@mail.gmail.com>
In-Reply-To: <CA+G9fYuDOnN6TrcVYcMZT5UPNc34mOHQZsfyFvpq+Ndhz8p48w@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 16 Jun 2025 19:06:10 +0530
X-Gm-Features: AX0GCFv0xdxpPep8RlLL46Klw14koqqEINGKyWY-3_14LVoll_HdAqjvhj2iHm0
Message-ID: <CA+G9fYuu5r34=bndUYWNxe_yLgBaPGXmK9WP3WTtoXMs_2LX-Q@mail.gmail.com>
Subject: Re: next-20250616: S390 gcc-8 allnoconfig mm mempool.c In function remove_element
To: open list <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, 
	Anders Roxell <anders.roxell@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Jun 2025 at 17:36, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> Regression while building S390 with the Linux next-20250616
> with gcc-8 the following kernel warnings found.
>
> Regressions found on S390
>  -  build/gcc-8-lkftconfig-allnoconfig
>  -  build/gcc-8-lkftconfig-hardening
>
> Regression Analysis:
>  - New regression? Yes
>  - Reproducibility? Yes
>
> First seen on the next-20250616
> Good: next-20250613
> Bad:  next-20250616
>
> Build regression: S390 gcc-8 allnoconfig mm mempool.c In function remove_element
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> ## Build errors
> mm/mempool.c: In function 'remove_element':
> include/linux/compiler_types.h:497:20: warning: asm operand 0 probably
> doesn't match constraints
>  #define asm_inline asm __inline
>                     ^~~
> arch/s390/include/asm/bug.h:12:2: note: in expansion of macro 'asm_inline'
>   asm_inline volatile(     \
>   ^~~~~~~~~~
> arch/s390/include/asm/bug.h:43:2: note: in expansion of macro '__EMIT_BUG'
>   __EMIT_BUG("", 0);    \
>   ^~~~~~~~~~
> include/asm-generic/bug.h:77:57: note: in expansion of macro 'BUG'
>  #define BUG_ON(condition) do { if (unlikely(condition)) BUG(); } while (0)
>                                                          ^~~
> mm/mempool.c:149:2: note: in expansion of macro 'BUG_ON'
>   BUG_ON(pool->curr_nr < 0);
>   ^~~~~~
> include/linux/compiler_types.h:497:20: error: impossible constraint in 'asm'
>  #define asm_inline asm __inline
>                     ^~~

Anders bisect this build regressions and found,

 # first bad commit:
    [45c79ca947c936085c94b716be92eaf9a1bdc8bb]
    bugs/s390: Use 'cond_str' in __EMIT_BUG()


> ## Source
> * Kernel version: 6.16.0-rc2
> * Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
> * Git sha: 050f8ad7b58d9079455af171ac279c4b9b828c11
> * Git describe: next-20250616
> * Project details:
> https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250616/
> * Architectures: S390
> * Toolchains: gcc-8
> * Kconfigs: allnoconfig
>
> ## Build S390
> * Build log: https://qa-reports.linaro.org/api/testruns/28763376/log_file/
> * Build details:
> https://regressions.linaro.org/lkft/linux-next-master/next-20250616/build/gcc-8-allnoconfig/
> * Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2ya0wQbvgatYAbcvC2OTZls5D91/
> * Kernel config:
> https://storage.tuxsuite.com/public/linaro/lkft/builds/2ya0wQbvgatYAbcvC2OTZls5D91/config
>
> ## Steps to reproduce on S390
>  - tuxmake --runtime podman --target-arch s390 --toolchain gcc-8
> --kconfig allnoconfig
>
> --
> Linaro LKFT
> https://lkft.linaro.org

- Naresh
