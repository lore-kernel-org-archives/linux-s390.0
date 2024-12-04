Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC99A20A5C8
	for <linux-s390@vger.kernel.org>; Wed,  4 Dec 2024 14:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733323177; cv=none; b=jRV8Lzobc6axraF9K7ivhL5yh66hZboi1CWsYpUUE1gPwNdO7P7+S8hUoWK4jH4Y94Q2WWALCTiJDIEnxUyHKDnKjlxkhrsUx4+94w69IdAMw2jQpfCiYVa+KWIn2ldSBeuzz2v9onUAJ98XwoALQlu24+gQ75MywOSRTecndDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733323177; c=relaxed/simple;
	bh=7vm+GgU7IzYoJVoPQmQEkbgSGw3DdebIEtgOIlj7sr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=enEMiVYD/JzK9vuZanw22WT+ig2w8WR2hGREwYAvmu5xyjTVgaxnZw+OmXHlNybSyhE+EVvGouCeToHIfLoCdgd0YlBs82mIvMD3tYEv8q/fkrIAwJVzIfna1BXvn3E2E7n4RZoK1jTWheu/m6fNnief6DFulJ+y8aeS0UpcoUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q6l0doVf; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q6l0doVf"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-434a8b94fb5so6281255e9.0
        for <linux-s390@vger.kernel.org>; Wed, 04 Dec 2024 06:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733323173; x=1733927973; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u7Deb6ozPBCd5HaUFhdz6hCVVIOvpic/u3v2HTGhW9U=;
        b=q6l0doVfthszIGrrzjjOf+4PrPTNF2YKj8VPyhcjxIkXjY2BXcpn+1zK4No3MOd7DE
         eA6Urr0lz9isJYDloS+E71oJYyULmvpICeKNH/pmS8GfhZI7k9DVznEWnRWELKjHDEFF
         lGLrfp6RYfo9oFyacfthTbLHHhHshRSMmGmeyPKU4MoDCt9YGRe4sHjML9r1ypD/9dwa
         +mfOO1wJn3P5F1dBe6J7M7MUAdNJ3zlLuF9nA+wMs5ds9+rNeIHQ65ppKteUSsWxrymP
         5Ap3/aYcLbM7HK/E+aYtteo+fikcxVyWJOBkHUm274EhKrLNty3y430RgFNMRyJjKD4p
         e1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733323173; x=1733927973;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u7Deb6ozPBCd5HaUFhdz6hCVVIOvpic/u3v2HTGhW9U=;
        b=VB8MX+IpvXSCQw2uPPbevhs8gbL7EGifeaizCJiZvHI+QCK1V6cbjFHi+T7ezTpTcP
         ugZ1mwUx6wBr8wE+AV+dsZm968GW//bIAGUOoDIdfkqLWeXFRApcD624eBvcpjFJM69l
         otmXG4ZJVLY/wjvHbtj5X6OKdKhkkV7W9FmU2EV8GX0/y5E6M26XnjFw8EgNPLa38aqG
         dUhQGzGH9EhyF/Uw5jwQXePBcgmDkqM82556mILEqG0LTQVJx80ZWHcFToJnXr2SsFWV
         ErFr1vu3bd78uW6XPtkVPYqPe0giO4oHGwQLFRNGxJW+OJFoUJ2+X5wpUSGPOUXVk6Oe
         vVqw==
X-Gm-Message-State: AOJu0Yw426DdAuwAH2DDgB+gtUnhZQlTahmeXMyL53vdl4N/0MlCzWIJ
	uSWe7BHNhxPpcfv/jDF5VZhPjw5FisWg8iW+KISVYzSvpnsbrKvc0Wrdd60t3j8=
X-Gm-Gg: ASbGncuAyF4V68oJmMvvKB7E6l1IaA2bKIVVv0MIaae0z5rvYeYhrGIh8Zff1cNJ4Np
	PfePtIkqEwaRYG1lSc21s7C8/wDhyPVQ8uND1QqPQFHzbIB+l/Trh2t/jPIeMykElgc9vJLM+NY
	hbj5NHIdpcFytdrf3i3a6kH7KjrP/F10/5MDMIZVodQbG+F1tyNueg6/17D/RPd1c5FY65I+EKX
	goYestRnbKk6wYV54nALR7LvE4WYUjN0VWkCZvmhlX/3CzjBY/Jdow=
X-Google-Smtp-Source: AGHT+IFgNAhlHmTZM9dIRgErvl8+0lGzD3UNMNEnIcEA1d5Rnbb0Ap2o8TKx3zX6wtjKyR3FwkoocA==
X-Received: by 2002:a05:600c:198e:b0:434:9cf6:a2a5 with SMTP id 5b1f17b1804b1-434afb9ecc7mr229792735e9.8.1733323173202;
        Wed, 04 Dec 2024 06:39:33 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d528ab4esm26074105e9.26.2024.12.04.06.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 06:39:32 -0800 (PST)
Date: Wed, 4 Dec 2024 17:39:29 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
	David Laight <David.Laight@aculab.com>
Cc: linux-s390@vger.kernel.org, clang-built-linux <llvm@lists.linux.dev>,
	linux-block <linux-block@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	Anders Roxell <anders.roxell@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: Re: s390: block/blk-iocost.c:1101:11: error: call to
 '__compiletime_assert_557' declared with 'error' attribute: clamp() low
 limit 1 greater than high limit active
Message-ID: <5ffa868f-cbf0-42ae-ae10-5c39b0de05e7@stanley.mountain>
References: <CA+G9fYsD7mw13wredcZn0L-KBA3yeoVSTuxnss-AEWMN3ha0cA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYsD7mw13wredcZn0L-KBA3yeoVSTuxnss-AEWMN3ha0cA@mail.gmail.com>

Let's add David to the Cc list because he's the expert on clamp().

regards,
dan carpenter

On Wed, Dec 04, 2024 at 04:01:09PM +0530, Naresh Kamboju wrote:
> The s390 builds failed with clang-19 with defconfig on the
> Linux next-20241203 tag due to following build warnings / errors.
> Build pass with gcc-13 defconfig for s390.
> 
> First seen on Linux next-20241203 tag
> GOOD: Linux next-20241128 tag
> BAD: Linux next-20241203 tag
> 
> List of arch and toolchains :
>   s390 defconfig with clang-19
> 
> s390:
>   build:
>     * clang-19-defconfig
>     * korg-clang-19-lkftconfig-lto-full
>     * korg-clang-19-lkftconfig-hardening
>     * korg-clang-19-lkftconfig-lto-thing
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Build log:
> ===========
> block/blk-iocost.c:1101:11: error: call to '__compiletime_assert_557'
> declared with 'error' attribute: clamp() low limit 1 greater than high
> limit active
>  1101 |                 inuse = clamp_t(u32, inuse, 1, active);
>       |                         ^
> include/linux/minmax.h:218:36: note: expanded from macro 'clamp_t'
>   218 | #define clamp_t(type, val, lo, hi) __careful_clamp(type, val, lo, hi)
>       |                                    ^
> include/linux/minmax.h:195:2: note: expanded from macro '__careful_clamp'
>   195 |         __clamp_once(type, val, lo, hi, __UNIQUE_ID(v_),
> __UNIQUE_ID(l_), __UNIQUE_ID(h_))
>       |         ^
> include/linux/minmax.h:188:2: note: expanded from macro '__clamp_once'
>   188 |         BUILD_BUG_ON_MSG(statically_true(ulo > uhi),
>                  \
>       |         ^
> note: (skipping 2 expansions in backtrace; use
> -fmacro-backtrace-limit=0 to see all)
> include/linux/compiler_types.h:530:2: note: expanded from macro
> '_compiletime_assert'
>   530 |         __compiletime_assert(condition, msg, prefix, suffix)
>       |         ^
> include/linux/compiler_types.h:523:4: note: expanded from macro
> '__compiletime_assert'
>   523 |                         prefix ## suffix();
>          \
>       |                         ^
> <scratch space>:38:1: note: expanded from here
>    38 | __compiletime_assert_557
>       | ^
> block/blk-iocost.c:1101:11: error: call to '__compiletime_assert_557'
> declared with 'error' attribute: clamp() low limit 1 greater than high
> limit active
> include/linux/minmax.h:218:36: note: expanded from macro 'clamp_t'
>   218 | #define clamp_t(type, val, lo, hi) __careful_clamp(type, val, lo, hi)
>       |                                    ^
> include/linux/minmax.h:195:2: note: expanded from macro '__careful_clamp'
>   195 |         __clamp_once(type, val, lo, hi, __UNIQUE_ID(v_),
> __UNIQUE_ID(l_), __UNIQUE_ID(h_))
>       |         ^
> include/linux/minmax.h:188:2: note: expanded from macro '__clamp_once'
>   188 |         BUILD_BUG_ON_MSG(statically_true(ulo > uhi),
>                  \
>       |         ^
> note: (skipping 2 expansions in backtrace; use
> -fmacro-backtrace-limit=0 to see all)
> include/linux/compiler_types.h:530:2: note: expanded from macro
> '_compiletime_assert'
>   530 |         __compiletime_assert(condition, msg, prefix, suffix)
>       |         ^
> include/linux/compiler_types.h:523:4: note: expanded from macro
> '__compiletime_assert'
>   523 |                         prefix ## suffix();
>          \
>       |                         ^
> <scratch space>:38:1: note: expanded from here
>    38 | __compiletime_assert_557
>       | ^
> 2 errors generated.
> 
> Links:
> ---
> - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241203/testrun/26188938/suite/build/test/clang-19-defconfig/log
> - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241203/testrun/26188938/suite/build/test/clang-19-defconfig/history/
> - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241203/testrun/26188938/suite/build/test/clang-19-defconfig/details/
> 
> Steps to reproduce:
> ------------
> # tuxmake --runtime podman --target-arch s390 --toolchain clang-19
> --kconfig defconfig LLVM_IAS=1
> 
> metadata:
> ----
>   git describe: next-20241203
>   git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>   git sha: c245a7a79602ccbee780c004c1e4abcda66aec32
>   kernel config:
> https://storage.tuxsuite.com/public/linaro/lkft/builds/2pjAPS9UrJkbAKFHktQei7eqW4Y/config
>   build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2pjAPS9UrJkbAKFHktQei7eqW4Y/
>   toolchain: clang-19
>   config: clang-19-defconfig
>   arch: s390
> 
> --
> Linaro LKFT
> https://lkft.linaro.org
